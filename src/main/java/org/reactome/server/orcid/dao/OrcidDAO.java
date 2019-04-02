package org.reactome.server.orcid.dao;

import org.apache.commons.io.IOUtils;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.reactome.server.orcid.domain.*;
import org.reactome.server.orcid.util.OrcidClaimRecord;
import org.reactome.server.orcid.util.OrcidHelper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static org.reactome.server.orcid.util.OrcidHelper.unmarshaller;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

@Component
public class OrcidDAO {

    @Value("${report.user:default}")
    private String reportUser;
    @Value("${report.password:default}")
    private String reportPassword;

    private static final String REPORT_ENDPOINT      = "http://localhost:5050/report/orcid/";
    private static final String REPORT_ORCIDREGISTER = "register";
    private static final String REPORT_ORCIDLOAD     = "load/%s";

    public void asyncPersistResponse(OrcidToken tokenSession, WorkBulkResponse workBulkResponse) {
        String orcid = tokenSession.getOrcid();
        List<OrcidClaimRecord> list = new ArrayList<>();
        for (WorkResponse ss : workBulkResponse.getBulk()) {
            if (ss.getWork() != null) {
                String stId = "";
                for (ExternalId eid : ss.getWork().getExternalIds().getExternalId()) {
                    if (eid.getType().equalsIgnoreCase(ExternalIdType.OTHERID.getName())) stId = eid.getValue();
                }
                String createdDate = (ss.getWork().getCreatedDate() != null) ? ss.getWork().getCreatedDate().getContent() : "";
                String lastModifiedDate = (ss.getWork().getLastModifiedDate() != null) ? ss.getWork().getLastModifiedDate().getContent() : "";
                list.add(new OrcidClaimRecord(stId, orcid, ss.getWork().getPutCode(), createdDate, lastModifiedDate));
            }
        }
        new Thread(() -> persistResponse(list), "ReportOrcidThread").start();
    }

    private void persistResponse(List<OrcidClaimRecord> list) {
        try {
            CloseableHttpClient client = getHttpClient();
            HttpPost httpPost = new HttpPost(REPORT_ENDPOINT + REPORT_ORCIDREGISTER);
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setHeader("Accept", "application/json");
            httpPost.setEntity(new StringEntity(unmarshaller(list)));
            CloseableHttpResponse response = client.execute(httpPost);
            int statusCode = response.getStatusLine().getStatusCode();
            if (statusCode != 200) {
                // what to show ?
            }
        } catch (IOException e) {
            // something here maybe
        }
    }

    private List<OrcidClaimRecord> load(String orcid) {
        try {
            CloseableHttpClient client = getHttpClient();
            HttpGet httpGet = new HttpGet(REPORT_ENDPOINT + String.format(REPORT_ORCIDLOAD, orcid));
            httpGet.setHeader("Content-Type", "application/json");
            httpGet.setHeader("Accept", "application/json");
            CloseableHttpResponse response = client.execute(httpGet);
            int statusCode = response.getStatusLine().getStatusCode();
            if (statusCode != 200) {
                String json = IOUtils.toString(response.getEntity().getContent());
                return OrcidHelper.marshaller(json);
            }
        } catch (IOException e) {
            // something here maybe
        }
        return null;
    }

    private CloseableHttpClient getHttpClient() {
        CredentialsProvider provider = new BasicCredentialsProvider();
        UsernamePasswordCredentials credentials = new UsernamePasswordCredentials(this.reportUser, this.reportPassword);
        provider.setCredentials(AuthScope.ANY, credentials);
        return HttpClients.custom().setDefaultCredentialsProvider(provider).build();
    }
}
