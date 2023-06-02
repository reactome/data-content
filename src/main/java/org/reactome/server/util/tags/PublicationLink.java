package org.reactome.server.util.tags;

import org.reactome.server.graph.domain.model.ExternalOntology;
import org.reactome.server.graph.domain.model.LiteratureReference;
import org.reactome.server.graph.domain.model.Person;
import org.reactome.server.graph.domain.model.Publication;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class PublicationLink extends SimpleTagSupport {
    protected Publication publication;
    private LiteratureReference ref;

    public void setPublication(Publication publication) {
        this.publication = publication;
        if (publication instanceof LiteratureReference) this.ref = (LiteratureReference) publication;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (publication == null) return; //throw new JspException("Entity must not be null");
        JspWriter out = getJspContext().getOut();
        //language=html
        out.print(String.format(
                "<div class='citation'>" +
                        "<span class='line'>%s</span>" +
                        "<span class='line authors'>%s</span>" +
                        "</div>",
                getFirstLine(),
                getAuthors()
        ));

    }

    private String getFirstLine() {
        //language=html
        if (ref == null) return String.format("<span class='title'>%s.</span>", publication.getTitle());
        //language=html
        return String.format(
                "<span class='title'><a href='%s' title=\"Open publication\" target=\"_blank\">%s.</a></span>" +
                        "<span class='journal'>%s</span>" +
                        "<span class='volume'>%s,</span>" +
                        "<span class='page'>%s</span>" +
                        "<span class='year'>(%s)</span>",
                ref.getUrl(), ref.getTitle(),
                ref.getJournal(),
                ref.getVolume(),
                ref.getPages(),
                ref.getYear()
        );

    }

    private String getAuthors() {
        return this.ref.getAuthor().stream().map(this::getAuthor).collect(Collectors.joining(", "));
    }

    private String getAuthor(Person author) {
        //language=HTML
        if (author.getOrcidId() != null) return String.format(
                "<a href='https://orcid.org/%s' target='_blank'> %s. <img id=\"orcid-id-icon\" class='small' alt=\"ORCID logo\" src=\"/content/resources/images/orcid_16x16.png\"></a>",
                author.getOrcidId(),
                author.getDisplayName()
        );
        return author.getDisplayName() + ".";
    }


}
