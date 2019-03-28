package org.reactome.server.orcid.util;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.reactome.server.graph.domain.model.Event;
import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.orcid.domain.*;
import org.reactome.server.orcid.exception.OrcidAuthorisationException;
import org.reactome.server.orcid.exception.WorkClaimException;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

public class OrcidHelper {
    private static final String ORCID_TOKEN = "orcidToken";
    private static final Integer MAX_BULK_POST = 100; // Orcid API won't accept more than 100 per call
    private static final String ORCID_WORKS = "https://api.sandbox.orcid.org/v2.1/##ORCID##/works";
    private static final String DETAILS_URL = "https://reactome.org/content/detail/##ID##";
    private static final String PWB_URL = "https://reactome.org/PathwayBrowser/#/##ID##";

    public enum ContributionRole {
        AUTHORED, REVIEWED
    }

    private static Work createWork(Event event, ContributionRole contributionRole) {
        Work work = new Work();
        work.setWorkTitle(new WorkTitle(event.getDisplayName()));
        work.setShortDescription((event instanceof Pathway ? "Pathway" : "Reaction") + " [" + contributionRole.name() + "]");
        work.setType("DATA_SET");
        work.setPublicationDate(new PublicationDate(event.getCreated().getDateTime()));
        work.setUrl(DETAILS_URL.replace("##ID##", event.getStId()));
        work.addExternalId(new ExternalId(ExternalIdType.OTHERID.getName(), event.getStId(), PWB_URL.replace("##ID##", event.getStId()), "SELF"));
        if (contributionRole == ContributionRole.AUTHORED) {
            work.addContributor(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.FIRST, ContributorAttributes.ContributorRole.AUTHOR)));
        } else {
            work.addContributor(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.ADDITIONAL, ContributorAttributes.ContributorRole.ASSIGNEE)));
        }
        return work;
    }

    private static void execute(OrcidToken tokenSession, WorkBulk workBulk, WorkBulkResponse workBulkResponse) throws IOException, WorkClaimException {
        HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
        HttpPost httpPost = new HttpPost(ORCID_WORKS.replace("##ORCID##", tokenSession.getOrcid()));
        httpPost.setHeader("Content-Type", "application/orcid+json; qs=4");
        httpPost.setHeader("Accept", "application/json");
        httpPost.addHeader("Authorization", "Bearer " + tokenSession.getAccessToken()); // add the authorization header to the request

        httpPost.setEntity(new StringEntity(unmarshaller(workBulk)));
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

    public static int postWork(OrcidToken tokenSession, Collection<? extends Event> events, ContributionRole contributionRole, WorkBulkResponse workBulkResponse) throws IOException, WorkClaimException {
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

    public static OrcidToken getAuthorisedOrcidUser(HttpServletRequest request) throws OrcidAuthorisationException {
        OrcidToken tokenSession = (OrcidToken) request.getSession().getAttribute(ORCID_TOKEN);
        if (tokenSession == null) throw new OrcidAuthorisationException("Not authorised");
        return tokenSession;
    }

    public static String unmarshaller(Object obj) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        return mapper.writeValueAsString(obj);
    }

    public static <T> List<T> marshaller(String json) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(json, new TypeReference<List<T>>(){});
    }

    /**
     * Hostname is used in the redirect_uri on the authorisation flow.
     * Our servers must be registered in Orcid API.
     */
    public static String getHostname(){
        String ret;
        try {
            ret = "https://" + InetAddress.getLocalHost().getHostName();
            if(!ret.contains("reactome")){
                ret = "http://localhost:8484";
            }
        } catch (UnknownHostException e) {
            ret = null;
        }
        return ret;
    }
}
