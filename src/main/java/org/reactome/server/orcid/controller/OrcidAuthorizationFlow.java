package org.reactome.server.orcid.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.graph.domain.model.Person;
import org.reactome.server.graph.service.PersonService;
import org.reactome.server.orcid.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

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
public class OrcidAuthorizationFlow {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String ORCID_TOKEN = "orcidToken";
    private final String REDIRECT_URI = "http://localhost:8484/orcid/callback"; // host has to be registered in Orcid systems. reactome.org and localhost:8484 is already registered. Must be https in prod
    private PersonService personService;
    @Value("${orcid.client.id}")
    private String clientId;
    @Value("${orcid.client.secret}")
    private String clientSecret;
    @Value("${orcid.baseurl}")
    private String orcidBaseUrl;

    @RequestMapping(value = "/orcid/login", method = RequestMethod.GET)
    public ModelAndView login() {
        System.out.println("OrcidAuthorizationFlow.login");
        String orcidLoginUrl = String.format("%s/authorize?client_id=%s&response_type=code&scope=/activities/update%%20/read-limited&redirect_uri=%s", orcidBaseUrl, clientId, REDIRECT_URI);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setView(new RedirectView(orcidLoginUrl, true, false));
        return modelAndView;
    }

    @RequestMapping(value = "/orcid/callback", method = RequestMethod.GET)
    public String callback(@RequestParam(required = false) String code, @RequestParam(required = false) String error, @RequestParam(name = "error_description", required = false) String errorDescription, HttpServletRequest request, ModelMap model) {
        System.out.println("OrcidAuthorizationFlow.callback code --> " + code);
        if (StringUtils.isNotEmpty(code)) {
            model.addAttribute("code", code);
            return "orcid/token";
        }
        // an unknown error or user denied
        model.addAttribute("error", error);
        model.addAttribute("errorDescription", errorDescription);
        return "orcid/error";
    }

    @RequestMapping(value = "/orcid/token", method = RequestMethod.GET)
    public @ResponseBody
    String authorize(@RequestParam String code, HttpServletRequest request) {
        System.out.println("OrcidAuthorizationFlow.authorize --> code: " + code);

        try {
            HttpClient client = HttpClientBuilder.create().build();
            List<NameValuePair> params = new ArrayList<>();
            params.add(new BasicNameValuePair("client_id", clientId));
            params.add(new BasicNameValuePair("client_secret", clientSecret));
            params.add(new BasicNameValuePair("redirect_uri", REDIRECT_URI));
            params.add(new BasicNameValuePair("scope", "/activities/update"));
            params.add(new BasicNameValuePair("grant_type", "authorization_code"));
            params.add(new BasicNameValuePair("code", code));

            HttpPost httpPost = new HttpPost(String.format("%s/token", orcidBaseUrl));
            httpPost.addHeader("Accept", "application/json");
            httpPost.addHeader("Content-type", "application/x-www-form-urlencoded");
            httpPost.setEntity(new UrlEncodedFormEntity(params));

            HttpResponse response = client.execute(httpPost);
            String responseString = EntityUtils.toString(response.getEntity(), "UTF-8");

            ObjectMapper objectMapper = new ObjectMapper();
            OrcidToken orcidToken = objectMapper.readValue(responseString, OrcidToken.class);

            request.getSession().setAttribute(ORCID_TOKEN, orcidToken);

            return "success";
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "error";
    }

    @RequestMapping(value = "/orcid/claiming/{id:.*}", method = RequestMethod.GET)
    public String claimWork(@PathVariable String id, ModelMap model, HttpServletRequest request) throws IOException {
        System.out.println("id = [" + id + "], model = [" + model + "]");
        OrcidToken tokenSession = (OrcidToken) request.getSession().getAttribute(ORCID_TOKEN);

        if (tokenSession == null) {
            return "fail";
        }

        Person person = personService.findPerson(id);
        if (person != null) { // ORCID is present!
            //if (person.getOrcidId().equalsIgnoreCase(tokenSession.getOrcid())) { // User is claiming his work
//            Set
            Collection<Pathway> sss = personService.getAuthoredPathways(id);
//            Collection<Pathway> sss = personService.getReviewedPathways(id);
//            Collection<Pathway> sss = personService.getAuthoredReactions(id);
//            Collection<Pathway> sss = personService.getReviewedReactions(id);

            String dataAuthored = createWork(sss);

            HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
            String guiOrcid = "0000-0002-5910-2066";
            HttpPost httpPost = new HttpPost("https://api.sandbox.orcid.org/v2.1/" + guiOrcid + "/works");   // the http GET request

            httpPost.setHeader("Content-Type", "application/orcid+json; qs=4");
            httpPost.setHeader("Accept", "application/json");
            httpPost.addHeader("Authorization", "Bearer " + tokenSession.getAccessToken()); // add the authorization header to the request

            httpPost.setEntity(new StringEntity(dataAuthored));
            HttpResponse response = httpclient.execute(httpPost); // the client executes the request and gets a response

            System.out.println(response.getStatusLine().getStatusCode());
            System.out.println();

            if (response.getStatusLine().getStatusCode() == 400) {
                ObjectMapper mapper = new ObjectMapper();
                String output = IOUtils.toString(response.getEntity().getContent());
                System.out.println(output);
                ResponseError responseError = mapper.readValue(output, ResponseError.class);
                System.out.println(responseError);
            } else {
                ObjectMapper mm = new ObjectMapper();
                String output = IOUtils.toString(response.getEntity().getContent());
                System.out.println(output);
                WorkBulkResponse workBulk = mm.readValue(output, WorkBulkResponse.class);
                System.out.println(workBulk);
            }

//            } else {
            // todo show message that something didn't work
//                System.out.println("PAGE AND LOGGED ARE NOT THE SAME");
//            }
        } else {
            // TODO alert helpdesk ... alert user, do sth!
            System.out.println("USER CLAIMED BUT NO ORCID, WE CAN'T CHECK IDENTITY");
        }


        return "success";
    }

    private String createWork(Collection<Pathway> sss) throws JsonProcessingException {
        String json;
        WorkBulk a = new WorkBulk();
        List<Work> ret = new ArrayList<>(sss.size());
        int i = 0;
        for (Pathway pathway : sss) {
            if(i == 2) {break;}
            i++;
            Work work = new Work();
            work.setWorkTitle(new WorkTitle(pathway.getDisplayName()));
            work.setType("DATA_SET");

            System.out.println(pathway.getCreated().getDateTime());
            work.setPublicationDate(new PublicationDate(pathway.getCreated().getDateTime()));

            ExternalIds externalIds = new ExternalIds();
            if (pathway.getDoi() != null) {
                externalIds.getExternalId().add(new ExternalId("doi", pathway.getDoi(), "http://doi.org/" + pathway.getDoi(), "SELF"));
            } else {
                externalIds.getExternalId().add(new ExternalId("other-id", pathway.getStId(), "https://reactome.org/PathwayBrowser/#/" + pathway.getStId(), "SELF"));
            }

            work.setExternalIds(externalIds);
            work.setUrl("http://reactome.org/content/detail/" + pathway.getStId());

            WorkContributors contributors = new WorkContributors();
            contributors.getContributors().add(new WorkContributor(new ContributorAttributes(ContributorAttributes.ContributorSequence.FIRST, ContributorAttributes.ContributorRole.AUTHOR)));
            work.setContributors(contributors);

            ret.add(work);
        }
        a.setBulk(ret);

        ObjectMapper mapper = new ObjectMapper();
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        json = mapper.writeValueAsString(a);

        System.out.println(json);
        return json;
    }

    @RequestMapping(value = "/orcid/record/{id:.*}", method = RequestMethod.GET)
    public String getOrcidDetails(@PathVariable String id, ModelMap model, HttpServletRequest request) throws IOException {
        System.out.println("OrcidAuthorizationFlow.getOrcidDetails");
        HttpSession session = request.getSession();
        OrcidToken token = (OrcidToken) session.getAttribute(ORCID_TOKEN);

        // curl -i -H "Accept: application/vnd.orcid+xml" -H 'Authorization: Bearer 7e1646b1-370a-4a6f-9046-f1ff708b045c' 'https://api.sandbox.orcid.org/v2.0/0000-0002-5910-2066/record'

        HttpClient httpclient = HttpClientBuilder.create().build();  // the http-client, that will send the request
        HttpGet httpGet = new HttpGet("https://api.sandbox.orcid.org/v2.0/0000-0002-5910-2066/record");   // the http GET request
        httpGet.addHeader("Authorization", "Bearer " + token.getAccessToken()); // add the authorization header to the request
        HttpResponse response = httpclient.execute(httpGet); // the client executes the request and gets a response
        int responseCode = response.getStatusLine().getStatusCode();  // check the response code
        switch (responseCode) {
            case 200: {
                // everything is fine, handle the response
                String stringResponse = EntityUtils.toString(response.getEntity());  // now you have the response as String, which you can convert to a JSONObject or do other stuff
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
}
