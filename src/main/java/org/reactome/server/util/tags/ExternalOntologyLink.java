package org.reactome.server.util.tags;

import org.reactome.server.graph.domain.model.ExternalOntology;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class ExternalOntologyLink extends SimpleTagSupport {
    protected ExternalOntology ontology;


    public void setOntology(ExternalOntology ontology) {
        this.ontology = ontology;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (ontology == null) return; //throw new JspException("Entity must not be null");
        JspWriter out = getJspContext().getOut();
        //language=html
        out.print(String.format("%s <a href=\"%s\" title=\"Show definition\" target=\"_blank\">%s</a>",
                ontology.getDisplayName(),
                getURL(),
                getDisplay()
        ));
    }

    private String getDisplay() {
        //language=html
        return String.format("(%s:%s)",
                ontology.getDatabaseName(),
                ontology.getIdentifier());
    }

    private String getURL() {
        return ontology.getUrl();
    }


}
