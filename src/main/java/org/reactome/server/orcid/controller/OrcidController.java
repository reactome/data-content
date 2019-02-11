package org.reactome.server.orcid.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

    @RequestMapping(value = "/orcid/claiming/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ClaimingSummary claimWork(@RequestBody String personId,  ModelMap model, HttpServletRequest request) throws IOException, WorkClaimException {
        WorkBulkResponse workBulkResponse = new WorkBulkResponse();

        OrcidToken tokenSession = (OrcidToken) request.getSession().getAttribute(ORCID_TOKEN);
        if (tokenSession == null) {
            throw new OrcidAuthorisationException("Not authorised");
        }

//        String id = tokenSession.getOrcid(); i am gonna use this soon

        Person person = personService.findPerson(personId); //dbId or orcid
        if (person != null) {
//            if (person.getOrcidId() == null) throw new WorkException("not the same");
//            if (person.getOrcidId().equalsIgnoreCase(tokenSession.getOrcid())) throw new OrcidClaimingWorkException("not the same");


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

        } else {
            // TODO alert helpdesk ... alert user, do sth!
            System.out.println("USER CLAIMED BUT NO ORCID, WE CAN'T CHECK IDENTITY");
            throw new WorkClaimException("Person not found ?! RequestBody is " + personId);
        }
    }

    private int postWork(OrcidToken tokenSession, Collection<? extends  Event> events, ContributionRole contributionRole, WorkBulkResponse workBulkResponse) throws IOException, WorkClaimException {
        int total = events.size();
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

        System.out.println(total);
        System.out.println(totalExecuted);

        return totalExecuted;
    }

    private void execute(OrcidToken tokenSession, WorkBulk workBulk, WorkBulkResponse workBulkResponse) throws IOException, WorkClaimException {
        String guiOrcidTestTestTest = "0000-0002-5910-2066";

        HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
        HttpPost httpPost = new HttpPost(ORCID_WORKS.replace("##ORCID##", guiOrcidTestTestTest));
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
        work.setShortDescription( (event instanceof Pathway ? "Pathway" : "Reaction") + " [" + contributionRole.name() + "]");
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


    @SuppressWarnings("all")
    private String createWorkJSONString(Collection<? extends Event> events, ContributionRole contributionRole) throws JsonProcessingException {
        String json;
        WorkBulk workBulk = new WorkBulk();
        List<Work> bulkWork = new ArrayList<>(events.size());
        int i = 0;
        for (Event event : events) {
            Work work = new Work();
            work.setWorkTitle(new WorkTitle(event.getDisplayName()));
            work.setShortDescription(event instanceof Pathway ? "Pathway [" + contributionRole.name() + "]" : "Reaction [" + contributionRole.name() + "]");
            work.setType("DATA_SET");
            work.setPublicationDate(new PublicationDate(event.getCreated().getDateTime()));

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

            work.setUrl(DETAILS_URL.replace("##ID##", event.getStId()));

            if (contributionRole == ContributionRole.AUTHORED) {
                work.addContributor(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.FIRST, ContributorAttributes.ContributorRole.AUTHOR)));
            } else {
                work.addContributor(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.ADDITIONAL, ContributorAttributes.ContributorRole.ASSIGNEE)));
            }

            bulkWork.add(work);
        }

        workBulk.setBulk(bulkWork);

        ObjectMapper mapper = new ObjectMapper();
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        json = mapper.writeValueAsString(workBulk);

        System.out.println(json);
        return json;
    }

    @RequestMapping(value = "/orcid/record/{id:.*}", method = RequestMethod.GET)
    public String getRecord(@PathVariable String id, ModelMap model, HttpServletRequest request) throws IOException {
        System.out.println("OrcidAuthorizationFlow.getOrcidDetails");
        HttpSession session = request.getSession();
        OrcidToken token = (OrcidToken) session.getAttribute(ORCID_TOKEN);

        // curl -i -H "Accept: application/vnd.orcid+xml" -H 'Authorization: Bearer 7e1646b1-370a-4a6f-9046-f1ff708b045c' 'https://api.sandbox.orcid.org/v2.0/0000-0002-5910-2066/record'

        HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
        HttpGet httpGet = new HttpGet("https://api.sandbox.orcid.org/v2.0/0000-0002-5910-2066/record");   // the http GET request
        httpGet.addHeader("Authorization", "Bearer " + token.getAccessToken()); // add the authorization header to the request
        httpGet.setHeader("Content-Type", "application/orcid+json; qs=4");
        httpGet.setHeader("Accept", "application/json");

        HttpResponse response = httpclient.execute(httpGet); // the client executes the request and gets a response
        int responseCode = response.getStatusLine().getStatusCode();  // check the response code
        switch (responseCode) {
            case 200: {
                // everything is fine, handle the response
                String stringResponse = EntityUtils.toString(response.getEntity());  // now you have the response as String, which you can convert to a JSONObject or do other stuff
                System.out.println(stringResponse);
                break;
            }
            case 500: {
                // server problems ?
                break;
            }
            case 403: {
                // you have no authorization to access that resource
                break;
            }
        }

        return "";
    }

    @RequestMapping(value = "/orcid/works/{id:.*}", method = RequestMethod.GET)
    public String getWorks(@PathVariable String id, ModelMap model, HttpServletRequest request) throws IOException {
        System.out.println("OrcidAuthorizationFlow.getOrcidDetails");
        HttpSession session = request.getSession();
        OrcidToken token = (OrcidToken) session.getAttribute(ORCID_TOKEN);

        // curl -i -H "Accept: application/vnd.orcid+xml" -H 'Authorization: Bearer 7e1646b1-370a-4a6f-9046-f1ff708b045c' 'https://api.sandbox.orcid.org/v2.0/0000-0002-5910-2066/record'

        HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
        HttpGet httpGet = new HttpGet("https://api.sandbox.orcid.org/v2.0/0000-0002-5910-2066/works");   // the http GET request
        httpGet.addHeader("Authorization", "Bearer " + token.getAccessToken()); // add the authorization header to the request
        httpGet.setHeader("Content-Type", "application/orcid+json; qs=4");
        httpGet.setHeader("Accept", "application/json");

        HttpResponse response = httpclient.execute(httpGet); // the client executes the request and gets a response
        int responseCode = response.getStatusLine().getStatusCode();  // check the response code
        switch (responseCode) {
            case 200: {
                // everything is fine, handle the response
                String stringResponse = EntityUtils.toString(response.getEntity());  // now you have the response as String, which you can convert to a JSONObject or do other stuff
                System.out.println(stringResponse);
                break;
            }
            case 500: {
                // server problems ?
                break;
            }
            case 403: {
                // you have no authorization to access that resource
                break;
            }
        }

        return "";
    }

    @Autowired
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

    private enum ContributionRole {
        AUTHORED, REVIEWED
    }

}
