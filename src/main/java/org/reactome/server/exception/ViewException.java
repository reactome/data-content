package org.reactome.server.exception;

/**
 * RuntimeException for details page and instance browser page
 *
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
public class ViewException extends RuntimeException {
    public ViewException(Throwable cause) {
        super(cause);
    }
}
