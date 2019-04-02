package org.reactome.server.orcid.controller;

import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.graph.domain.model.Person;
import org.reactome.server.graph.domain.model.ReactionLikeEvent;
import org.reactome.server.graph.service.PersonService;
import org.reactome.server.orcid.dao.OrcidDAO;
import org.reactome.server.orcid.domain.ClaimingSummary;
import org.reactome.server.orcid.domain.OrcidToken;
import org.reactome.server.orcid.domain.WorkBulkResponse;
import org.reactome.server.orcid.exception.WorkClaimException;
import org.reactome.server.orcid.util.OrcidHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import static org.reactome.server.orcid.util.OrcidHelper.*;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
@Controller
public class OrcidController {

    private PersonService personService;
    private OrcidDAO orcidDAO;

    @RequestMapping(value = "/orcid/claim/all", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimAll(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if (orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<Pathway> authoredPathways = personService.getAuthoredPathways(personId);
        Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(personId);
        Collection<Pathway> reviewedPathways = personService.getReviewedPathways(personId);
        Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(personId);

        // Some users are author and reviewer in certain pathways or reaction. We claim it once.
        List<Pathway> authoredAndReviewedPathways = authoredPathways.stream().filter(reviewedPathways::contains).collect(Collectors.toList());
        List<ReactionLikeEvent> authoredAndReviewedReactions = authoredReactions.stream().filter(reviewedReactions::contains).collect(Collectors.toList());
        if (!authoredAndReviewedPathways.isEmpty()) {
            authoredPathways.removeAll(authoredAndReviewedPathways);
            reviewedPathways.removeAll(authoredAndReviewedPathways);
        }
        if (!authoredAndReviewedReactions.isEmpty()) {
            authoredReactions.removeAll(authoredAndReviewedReactions);
            reviewedReactions.removeAll(authoredAndReviewedReactions);
        }

        int totalExecuted = 0;
        totalExecuted += bulkPostWork(tokenSession, authoredPathways, OrcidHelper.ContributionRole.AUTHORED, workBulkResponse);
        totalExecuted += bulkPostWork(tokenSession, authoredReactions, ContributionRole.AUTHORED, workBulkResponse);
        totalExecuted += bulkPostWork(tokenSession, reviewedPathways, ContributionRole.REVIEWED, workBulkResponse);
        totalExecuted += bulkPostWork(tokenSession, reviewedReactions, ContributionRole.REVIEWED, workBulkResponse);
        totalExecuted += bulkPostWork(tokenSession, authoredAndReviewedPathways, ContributionRole.BOTH, workBulkResponse);
        totalExecuted += bulkPostWork(tokenSession, authoredAndReviewedReactions, ContributionRole.BOTH, workBulkResponse);

        orcidDAO.asyncPersistResponse(tokenSession, workBulkResponse);

        int total = authoredPathways.size() + reviewedPathways.size() + authoredReactions.size() + reviewedReactions.size() + authoredAndReviewedPathways.size() + authoredAndReviewedReactions.size();
        return new ClaimingSummary(total, totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/pa", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimPathwayAuthored(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if (orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<Pathway> authoredPathways = personService.getAuthoredPathways(personId);

        orcidDAO.asyncPersistResponse(tokenSession, workBulkResponse);

        int totalExecuted = bulkPostWork(tokenSession, authoredPathways, ContributionRole.AUTHORED, workBulkResponse);
        return new ClaimingSummary(authoredPathways.size(), totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/pr", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimReviewedPathway(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if (orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<Pathway> reviewedPathways = personService.getReviewedPathways(personId);

        orcidDAO.asyncPersistResponse(tokenSession, workBulkResponse);

        int totalExecuted = bulkPostWork(tokenSession, reviewedPathways, ContributionRole.REVIEWED, workBulkResponse);
        return new ClaimingSummary(reviewedPathways.size(), totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/ra", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimAuthoredReaction(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if (orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(personId);

        orcidDAO.asyncPersistResponse(tokenSession, workBulkResponse);

        int totalExecuted = bulkPostWork(tokenSession, authoredReactions, ContributionRole.AUTHORED, workBulkResponse);
        return new ClaimingSummary(authoredReactions.size(), totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/rr", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimReviewedReaction(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if (orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(personId);

        orcidDAO.asyncPersistResponse(tokenSession, workBulkResponse);

        int totalExecuted = bulkPostWork(tokenSession, reviewedReactions, ContributionRole.REVIEWED, workBulkResponse);
        return new ClaimingSummary(reviewedReactions.size(), totalExecuted, workBulkResponse);
    }


    /**
     * Checking if the given person matches the authorized person in Orcid.
     * Server side security to avoid one person claiming works of another Person.
     *
     * @param tokenSession authorised user in Orcid
     * @param personId     person page in reactome
     */
    private void validatePerson(OrcidToken tokenSession, String personId) throws WorkClaimException {
        Person person = personService.findPerson(personId); //dbId or orcid
        if (person == null) throw new WorkClaimException("Person not found! RequestBody is " + personId);
        if (person.getOrcidId() == null) throw new WorkClaimException("Person doesn't have registered Orcid ID in Reactome");
        if (!person.getOrcidId().equalsIgnoreCase(tokenSession.getOrcid())) throw new WorkClaimException(String.format("Claiming not allowed. Person Orcid [%s] doesn't match authorised Orcid [%s] ", person.getOrcidId(), tokenSession.getOrcid()));
    }

    @Autowired
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

    @Autowired
    public void setOrcidDAO(OrcidDAO orcidDAO) {
        this.orcidDAO = orcidDAO;
    }
}
