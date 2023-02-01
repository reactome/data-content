package org.reactome.server.captcha;

public class InvalidHCaptchaTokenException extends RuntimeException {
    public InvalidHCaptchaTokenException(String s) {
        super(s);
    }
}
