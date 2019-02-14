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
import org.reactome.server.orcid.domain.LoggedInMetadata;
import org.reactome.server.orcid.domain.OrcidToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
@Controller
public class OrcidAuthorizationFlow {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String ORCID_TOKEN = "orcidToken";
    private final String CALLBACK_PATH = "/orcid/callback"; // host has to be registered in Orcid systems. reactome.org and localhost:8484 is already registered. Must be https in prod

    @Value("${orcid.client.id}")
    private String clientId;
    @Value("${orcid.client.secret}")
    private String clientSecret;
    @Value("${orcid.baseurl}")
    private String orcidBaseUrl;

    @RequestMapping(value = "/orcid/login", method = RequestMethod.GET)
    public ModelAndView login() {
        String redirectUri = getHostname() + CALLBACK_PATH;
        String orcidLoginUrl = String.format("%s/authorize?client_id=%s&response_type=code&scope=/activities/update%%20/read-limited&redirect_uri=%s", orcidBaseUrl, clientId, redirectUri);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setView(new RedirectView(orcidLoginUrl, true, false));
        return modelAndView;
    }

    @RequestMapping(value = "/orcid/callback", method = RequestMethod.GET)
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

    @RequestMapping(value = "/orcid/token", method = RequestMethod.GET)
    public @ResponseBody Boolean authorize(@RequestParam String code, HttpServletRequest request) {
        try {
            HttpClient client = HttpClientBuilder.create().build();
            List<NameValuePair> params = new ArrayList<>();
            params.add(new BasicNameValuePair("client_id", clientId));
            params.add(new BasicNameValuePair("client_secret", clientSecret));
            params.add(new BasicNameValuePair("redirect_uri", getHostname() + CALLBACK_PATH));
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

            LoggedInMetadata lim = new LoggedInMetadata(orcidToken);
            request.getSession().setAttribute("METADATA", objectMapper.writeValueAsString(lim));

            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    private String getHostname(){
        String ret;
        try {
            ret = "https://" + InetAddress.getLocalHost().getHostName();
            if(!ret.contains("reactome")){
                ret = "http://localhost:8484";
            }
        } catch (UnknownHostException e) {
            e.printStackTrace();
            ret = null;
        }
        return ret;
    }

    @RequestMapping(value = "/orcid/signout", method = RequestMethod.GET)
    public @ResponseBody String signOut(HttpServletRequest request) {
        request.getSession().removeAttribute(ORCID_TOKEN);
        request.getSession().invalidate();
        return "success";
    }

    @RequestMapping(value = "/orcid/authenticated", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody Boolean authorize(HttpServletRequest request) {
        OrcidToken orcidToken = (OrcidToken)request.getSession().getAttribute(ORCID_TOKEN);
        return orcidToken != null;
    }
}