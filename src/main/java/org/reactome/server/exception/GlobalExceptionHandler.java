package org.reactome.server.exception;

import org.reactome.server.search.exception.SolrSearcherException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

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
}
