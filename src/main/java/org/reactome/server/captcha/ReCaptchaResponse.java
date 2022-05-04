package org.reactome.server.captcha;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Arrays;
import java.util.Objects;

public class ReCaptchaResponse {
    private boolean success;
    private String hostname;
    private String action;
    private float score;
    private String challenge_ts;
    @JsonProperty("error-codes")
    private String[] errorCodes;

    public ReCaptchaResponse() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReCaptchaResponse that = (ReCaptchaResponse) o;
        return isSuccess() == that.isSuccess() && Float.compare(that.getScore(), getScore()) == 0 && Objects.equals(getHostname(), that.getHostname()) && Objects.equals(getAction(), that.getAction()) && Objects.equals(getChallenge_ts(), that.getChallenge_ts()) && Arrays.equals(getErrorCodes(), that.getErrorCodes());
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(isSuccess(), getHostname(), getAction(), getScore(), getChallenge_ts());
        result = 31 * result + Arrays.hashCode(getErrorCodes());
        return result;
    }

    @Override
    public String toString() {
        return "ReCaptchaResponse{" +
                "success=" + success +
                ", hostname='" + hostname + '\'' +
                ", action='" + action + '\'' +
                ", score=" + score +
                ", challenge_ts='" + challenge_ts + '\'' +
                ", errorCodes=" + Arrays.toString(errorCodes) +
                '}';
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getHostname() {
        return hostname;
    }

    public void setHostname(String hostname) {
        this.hostname = hostname;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public String getChallenge_ts() {
        return challenge_ts;
    }

    public void setChallenge_ts(String challenge_ts) {
        this.challenge_ts = challenge_ts;
    }

    public String[] getErrorCodes() {
        return errorCodes;
    }

    public void setErrorCodes(String[] errorCodes) {
        this.errorCodes = errorCodes;
    }
}
