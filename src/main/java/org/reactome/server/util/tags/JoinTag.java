package org.reactome.server.util.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.Collection;

public class JoinTag extends SimpleTagSupport {

    private Collection<String> elements;
    private String separator;

    public void setElements(Collection<String> elements) {
        this.elements = elements;
    }

    public void setSeparator(String separator) {
        this.separator = separator;
    }

    @Override
    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();
        out.print(String.join(separator, elements.toArray(new String[0])));
    }
}
