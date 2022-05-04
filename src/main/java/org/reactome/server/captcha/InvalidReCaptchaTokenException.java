package org.reactome.server.captcha;

public class InvalidReCaptchaTokenException extends RuntimeException {
    public InvalidReCaptchaTokenException(String s) {
        super(s);
    }
}
