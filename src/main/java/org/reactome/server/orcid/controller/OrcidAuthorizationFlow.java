package org.reactome.server.orcid.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.reactome.server.orcid.dao.OrcidReportDAO;
import org.reactome.server.orcid.domain.LoggedInMetadata;
import org.reactome.server.orcid.domain.OrcidToken;
import org.reactome.server.orcid.exception.OrcidOAuthException;
import org.reactome.server.orcid.util.OrcidHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
@Controller
@RequestMapping("/orcid")
public class OrcidAuthorizationFlow {
    private static final String ORCID_TOKEN = "orcidToken";
    private final String CALLBACK_PATH = "/content/orcid/callback"; // host has to be registered in Orcid systems. reactome.org and localhost:8484 is already registered. Must be https in prod

    @Value("${orcid.client.id}")
    private String clientId;
    @Value("${orcid.client.secret}")
    private String clientSecret;
    @Value("${orcid.auth.baseurl}")
    private String orcidAuthBaseUrl;

    private OrcidHelper orcidHelper;
    private OrcidReportDAO orcidReportDAO;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login() {
        String redirectUri = orcidHelper.getHostname() + CALLBACK_PATH;
        String orcidLoginUrl = String.format("%s/authorize?client_id=%s&response_type=code&scope=/activities/update&redirect_uri=%s", orcidAuthBaseUrl, clientId, redirectUri);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setView(new RedirectView(orcidLoginUrl, true, false));
        return modelAndView;
    }

    @RequestMapping(value = "/callback", method = RequestMethod.GET)
    public String callback(@RequestParam(required = false) String code, @RequestParam(required = false) String error, @RequestParam(name = "error_description", required = false) String errorDescription, ModelMap model) {
        if (StringUtils.isNotEmpty(code)) {
            model.addAttribute("code", code);
            return "orcid/token";
        }
        // an unknown error or user denied
        model.addAttribute("error", error);
        model.addAttribute("errorDescription", errorDescription);
        return "orcid/error";
    }

    @RequestMapping(value = "/token", method = RequestMethod.GET)
    public @ResponseBody Boolean authorize(@RequestParam String code, HttpServletRequest request) throws OrcidOAuthException {
        try {
            HttpClient client = HttpClientBuilder.create().build();
            List<NameValuePair> params = new ArrayList<>();
            params.add(new BasicNameValuePair("client_id", clientId));
            params.add(new BasicNameValuePair("client_secret", clientSecret));
            params.add(new BasicNameValuePair("redirect_uri", orcidHelper.getHostname() + CALLBACK_PATH));
            params.add(new BasicNameValuePair("scope", "/activities/update"));
            params.add(new BasicNameValuePair("grant_type", "authorization_code"));
            params.add(new BasicNameValuePair("code", code));

            HttpPost httpPost = new HttpPost(String.format("%s/token", orcidAuthBaseUrl));
            httpPost.addHeader("Accept", "application/json");
            httpPost.addHeader("Content-type", "application/x-www-form-urlencoded");
            httpPost.setEntity(new UrlEncodedFormEntity(params));
            HttpResponse httpResponse = client.execute(httpPost);
            String responseString = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
            ObjectMapper objectMapper = new ObjectMapper();
            OrcidToken orcidToken = objectMapper.readValue(responseString, OrcidToken.class);
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            if (statusCode == 200) {
                request.getSession().setAttribute(ORCID_TOKEN, orcidToken);
                orcidReportDAO.asyncPersistOrcidToken(orcidToken);
                LoggedInMetadata lim = new LoggedInMetadata(orcidToken);
                request.getSession().setAttribute("METADATA", objectMapper.writeValueAsString(lim));
                return true;
            } else if (statusCode == 401) {
                throw new OrcidOAuthException("401 Not Authorized.", orcidToken);
            } else {
                throw new OrcidOAuthException("Authentication has failed [Status code: " + statusCode + "]", orcidToken);
            }
        } catch (Exception e) {
            throw new OrcidOAuthException("Couldn't proceed to Orcid Authentication");
        }
    }

    @RequestMapping(value = "/signout", method = RequestMethod.GET)
    public @ResponseBody String signOut(HttpServletRequest request) {
        request.getSession().removeAttribute(ORCID_TOKEN);
        request.getSession().invalidate();
        return "success";
    }

    @RequestMapping(value = "/authenticated", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody Boolean authorize(HttpServletRequest request) {
        OrcidToken orcidToken = (OrcidToken) request.getSession().getAttribute(ORCID_TOKEN);
        return orcidToken != null;
    }

    @Autowired
    public void setOrcidHelper(OrcidHelper orcidHelper) {
        this.orcidHelper = orcidHelper;
    }

    @Autowired
    public void setOrcidReportDAO(OrcidReportDAO orcidReportDAO) {
        this.orcidReportDAO = orcidReportDAO;
    }
}