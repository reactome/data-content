package org.reactome.server.exception;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.reactome.server.orcid.domain.ResponseError;
import org.reactome.server.orcid.exception.OrcidAuthorisationException;
import org.reactome.server.orcid.exception.OrcidOAuthException;
import org.reactome.server.orcid.exception.WorkClaimException;
import org.reactome.server.search.exception.SolrSearcherException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.UnknownHostException;

/**
 * Global exception handler controller
 * This controller will deal with all exceptions thrown by the other controllers if they don't treat them individually
 *
 * @author Florian Korninger (fkorn@ebi.ac.uk)
 * @version 1.0
 */
@SuppressWarnings("SameReturnValue")
@ControllerAdvice
class GlobalExceptionHandler {

    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String EXCEPTION = "exception";
    private static final String URL = "url";
    private static final String SUBJECT = "subject";
    private static final String MESSAGE = "message";
    private static final String TITLE = "title";

    private static final String PAGE = "common/errorPage";

    @ExceptionHandler(SolrSearcherException.class)
    public ModelAndView handleSolrSearcherException(HttpServletRequest request, SolrSearcherException e) {
        return buildModelView(request, e);
    }

    @ExceptionHandler(ViewException.class)
    public ModelAndView handleViewException(HttpServletRequest request, ViewException e) {
        return buildModelView(request, e);
    }

    @ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "IOException occurred")
    @ExceptionHandler(IOException.class)
    public void handleIOException(IOException e) {
        errorLogger.error("IOException handler executed", e);  //returning 404 error code
    }

    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR, reason = "Unknown host")
    @ExceptionHandler(UnknownHostException.class)
    public void handleUnknownHostException(UnknownHostException e) {
        errorLogger.warn("UnknownHostException handler executed", e.getMessage());
    }

    @ResponseStatus(value = HttpStatus.UNAUTHORIZED, reason = "Not Authorised")
    @ExceptionHandler(OrcidAuthorisationException.class)
    public void handleOrcidAuthorisationException(OrcidAuthorisationException e) {
        errorLogger.warn("User not authorized to claim work", e);
    }

    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(WorkClaimException.class)
    public @ResponseBody ResponseEntity<String> handleWorkClaimException(WorkClaimException e) {
        return toJsonResponse(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
    }

    @ResponseStatus(value = HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(OrcidOAuthException.class)
    public @ResponseBody ResponseEntity<String> handleOrcidOAuthException(OrcidOAuthException e, HttpServletRequest request) {
        request.getSession().removeAttribute("orcidToken");
        request.getSession().invalidate();
        return toJsonResponse(HttpStatus.UNAUTHORIZED, e.getOrcidToken().getErrorDescription());
    }

    private ModelAndView buildModelView(HttpServletRequest request, Exception e) {
        String finalUrl = (request.getQueryString() != null) ? String.join("", request.getRequestURL(),"?" , request.getQueryString()) : request.getRequestURL().toString();

        errorLogger.error("Exception occurred when requesting the URL [" + finalUrl + "]", e);

        ModelAndView model = new ModelAndView(PAGE);
        model.addObject(EXCEPTION, e);
        model.addObject(URL, finalUrl);
        model.addObject(SUBJECT, "Unexpected error occurred.");

        @SuppressWarnings("StringBufferReplaceableByString")
        StringBuilder sb = new StringBuilder();
        sb.append("Dear help desk,");
        sb.append("\n\n");
        sb.append("An unexpected error has occurred");
        sb.append("\n\n");
        sb.append("<< Please add more information >>");
        sb.append("\n\n");
        sb.append("Thank you");
        sb.append("\n\n");

        model.addObject(MESSAGE, sb.toString());

        model.addObject(TITLE, "Unexpected error occurred");

        return model;
    }

    /*
     * Adding a JSON String manually to the response.
     *
     * Some services return a binary file or text/plain, etc. Then an ErrorInfo instance is manually converted
     * to JSON and written down in the response body.
     */
    private ResponseEntity<String> toJsonResponse(HttpStatus status, String exceptionMessage) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "application/json");
        try {
            ObjectMapper mapper = new ObjectMapper();
            return ResponseEntity.status(status)
                    .headers(responseHeaders)
                    .body(mapper.writeValueAsString(new ResponseError(exceptionMessage)));
        } catch (JsonProcessingException e1) {
            return ResponseEntity.status(status).headers(responseHeaders).body("");
        }
    }
}
