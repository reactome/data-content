package org.reactome.server.captcha;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Component
@PropertySource("classpath:core.properties")
public class ReCaptchaResponseV3Handler {
    @Value("${captcha.secret.key}")
    private String secretKey;
    private String serverAddress = "https://www.google.com/recaptcha/api/siteverify";

    public float verify(String recaptchaFormResponse) throws InvalidReCaptchaTokenException {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("secret", secretKey);
        map.add("response", recaptchaFormResponse);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        RestTemplate restTemplate = new RestTemplate();
        ReCaptchaResponse response = restTemplate.postForObject(serverAddress, request, ReCaptchaResponse.class);
        if (response == null) throw new InvalidReCaptchaTokenException("Invalid ReCaptha. Please check site");

        if (response.getErrorCodes() != null) {
            System.out.println("Error codes: ");
            for (String errorCode : response.getErrorCodes()) {
                System.out.println("\t" + errorCode);
            }
        }

        if (!response.isSuccess()) {
            throw new InvalidReCaptchaTokenException("Invalid ReCaptha. Please check site");
        }
        // return 0.4f;
        return response.getScore();
    }
}