package org.reactome.server.orcid.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.reactome.server.graph.domain.model.Event;
import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.graph.domain.model.Person;
import org.reactome.server.graph.domain.model.ReactionLikeEvent;
import org.reactome.server.graph.service.PersonService;
import org.reactome.server.orcid.domain.*;
import org.reactome.server.orcid.exception.OrcidAuthorisationException;
import org.reactome.server.orcid.exception.WorkClaimException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
@Controller
public class OrcidController {
    private static final Integer MAX_BULK_POST = 100; // Orcid API won't accept more than 100 per call
    private static final String ORCID_TOKEN = "orcidToken";
    private static final String ORCID_WORKS = "https://api.sandbox.orcid.org/v2.1/##ORCID##/works";
    private static final String DETAILS_URL = "https://reactome.org/content/detail/##ID##";
    private static final String PWB_URL = "https://reactome.org/PathwayBrowser/#/##ID##";
    private static final String DOI_URL = "http://doi.org/##ID##";

    private PersonService personService;

    @RequestMapping(value = "/orcid/claim/all", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimAll(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if(orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);


        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        int totalExecuted = 0;
        Collection<Pathway> authoredPathways = personService.getAuthoredPathways(personId);
        totalExecuted += postWork(tokenSession, authoredPathways, ContributionRole.AUTHORED, workBulkResponse);

        Collection<Pathway> reviewedPathways = personService.getReviewedPathways(personId);
        totalExecuted += postWork(tokenSession, reviewedPathways, ContributionRole.REVIEWED, workBulkResponse);

        Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(personId);
        totalExecuted += postWork(tokenSession, authoredReactions, ContributionRole.AUTHORED, workBulkResponse);

        Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(personId);
        totalExecuted += postWork(tokenSession, reviewedReactions, ContributionRole.REVIEWED, workBulkResponse);

        int total = authoredPathways.size() + reviewedPathways.size() + authoredReactions.size() + reviewedReactions.size();
        return new ClaimingSummary(total, totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/pa", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimPathwayAuthored(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if(orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<Pathway> authoredPathways = personService.getAuthoredPathways(personId);
        int totalExecuted = postWork(tokenSession, authoredPathways, ContributionRole.AUTHORED, workBulkResponse);
        return new ClaimingSummary(authoredPathways.size(), totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/pr", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimReviewedPathway(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if(orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<Pathway> reviewedPathways = personService.getReviewedPathways(personId);
        int totalExecuted = postWork(tokenSession, reviewedPathways, ContributionRole.REVIEWED, workBulkResponse);
        return new ClaimingSummary(reviewedPathways.size(), totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/ra", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimAuthoredReaction(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if(orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(personId);
        int totalExecuted = postWork(tokenSession, authoredReactions, ContributionRole.AUTHORED, workBulkResponse);
        return new ClaimingSummary(authoredReactions.size(), totalExecuted, workBulkResponse);
    }

    @RequestMapping(value = "/orcid/claim/rr", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimReviewedReaction(@RequestBody String personId, @RequestParam(name = "orcidtest", required = false) String orcidTestParam, HttpServletRequest request) throws IOException, WorkClaimException {
        OrcidToken tokenSession = getAuthorisedOrcidUser(request);

        // TODO REMOVE THIS AND THE REQUEST PARAM
        if(orcidTestParam != null) tokenSession.setOrcid(orcidTestParam);
        else validatePerson(tokenSession, personId);

        WorkBulkResponse workBulkResponse = new WorkBulkResponse();
        Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(personId);
        int totalExecuted = postWork(tokenSession, reviewedReactions, ContributionRole.REVIEWED, workBulkResponse);
        int total = reviewedReactions.size();
        return new ClaimingSummary(total, totalExecuted, workBulkResponse);
    }

    private int postWork(OrcidToken tokenSession, Collection<? extends Event> events, ContributionRole contributionRole, WorkBulkResponse workBulkResponse) throws IOException, WorkClaimException {
        int totalExecuted = 0;
        WorkBulk workBulk = new WorkBulk();
        List<Work> bulkWork = new ArrayList<>(MAX_BULK_POST);
        for (Event event : events) {
            Work work = createWork(event, contributionRole);
            bulkWork.add(work);

            if (bulkWork.size() == MAX_BULK_POST) {
                totalExecuted += bulkWork.size();
                workBulk.setBulk(bulkWork);
                execute(tokenSession, workBulk, workBulkResponse);
                bulkWork = new ArrayList<>(MAX_BULK_POST);
            }
        }

        // execute the remaining works
        if (bulkWork.size() > 0) {
            totalExecuted += bulkWork.size();
            workBulk.setBulk(bulkWork);
            execute(tokenSession, workBulk, workBulkResponse);
        }

        return totalExecuted;
    }

    private void execute(OrcidToken tokenSession, WorkBulk workBulk, WorkBulkResponse workBulkResponse) throws IOException, WorkClaimException {
        HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
        HttpPost httpPost = new HttpPost(ORCID_WORKS.replace("##ORCID##", tokenSession.getOrcid()));
        httpPost.setHeader("Content-Type", "application/orcid+json; qs=4");
        httpPost.setHeader("Accept", "application/json");
        httpPost.addHeader("Authorization", "Bearer " + tokenSession.getAccessToken()); // add the authorization header to the request

        httpPost.setEntity(new StringEntity(getBulkWorkJson(workBulk)));
        HttpResponse response = httpclient.execute(httpPost); // the client executes the request and gets a response
        if (response.getStatusLine().getStatusCode() == 200) {
            ObjectMapper mm = new ObjectMapper();
            String output = IOUtils.toString(response.getEntity().getContent());
            WorkBulkResponse wbr = mm.readValue(output, WorkBulkResponse.class);
            workBulkResponse.getBulk().addAll(wbr.getBulk());
            workBulkResponse.getErrors().addAll(wbr.getErrors());
        } else {
            ObjectMapper mapper = new ObjectMapper();
            String output = IOUtils.toString(response.getEntity().getContent());
            ResponseError responseError = mapper.readValue(output, ResponseError.class);
            throw new WorkClaimException("", responseError);
        }
    }

    private String getBulkWorkJson(WorkBulk workBulk) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        return mapper.writeValueAsString(workBulk);
    }

    @SuppressWarnings("all")
    private Work createWork(Event event, ContributionRole contributionRole) {
        Work work = new Work();
        work.setWorkTitle(new WorkTitle(event.getDisplayName()));
        work.setShortDescription((event instanceof Pathway ? "Pathway" : "Reaction") + " [" + contributionRole.name() + "]");
        work.setType("DATA_SET");
        work.setPublicationDate(new PublicationDate(event.getCreated().getDateTime()));
        work.setUrl(DETAILS_URL.replace("##ID##", event.getStId()));
        boolean hasDOI = false;
        if (event instanceof Pathway) {
            Pathway pathway = (Pathway) event;
            if (pathway.getDoi() != null) {
                work.addExternalId(new ExternalId("doi", pathway.getDoi(), DOI_URL.replace("##ID##", pathway.getDoi()), "SELF"));
                hasDOI = true;
            }
        }
        if (!hasDOI) {
            work.addExternalId(new ExternalId("other-id", event.getStId(), PWB_URL.replace("##ID##", event.getStId()), "SELF"));
        }

        if (contributionRole == ContributionRole.AUTHORED) {
            work.addContributor(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.FIRST, ContributorAttributes.ContributorRole.AUTHOR)));
        } else {
            work.addContributor(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.ADDITIONAL, ContributorAttributes.ContributorRole.ASSIGNEE)));
        }
        return work;
    }

    /**
     * Checking if the given person matches the authorized person in Orcid.
     * Server side security to avoid one person claiming works of another Person.
     *
     * @param tokenSession  authorised user in Orcid
     * @param personId person page in reactome
     */
    private void validatePerson(OrcidToken tokenSession, String personId) throws WorkClaimException {
        Person person = personService.findPerson(personId); //dbId or orcid
        if (person == null) throw new WorkClaimException("Person not found ?! RequestBody is " + personId);
        if (person.getOrcidId() == null) throw new WorkClaimException("Person doesn't have Orcid ID registered in Reactome");
        if (!person.getOrcidId().equalsIgnoreCase(tokenSession.getOrcid())) throw new WorkClaimException(String.format("Claiming not allowed. Person Orcid [%s] doesn't match authorised Orcid [%s] ", person.getOrcidId(), tokenSession.getOrcid()));
    }

    @SuppressWarnings("all")
    private OrcidToken getAuthorisedOrcidUser(HttpServletRequest request) throws OrcidAuthorisationException {
        OrcidToken tokenSession = (OrcidToken) request.getSession().getAttribute(ORCID_TOKEN);
        if (tokenSession == null) throw new OrcidAuthorisationException("Not authorised");
        return tokenSession;
    }

    @Autowired
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

    private enum ContributionRole {
        AUTHORED, REVIEWED
    }

}
