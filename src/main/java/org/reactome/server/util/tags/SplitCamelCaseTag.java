package org.reactome.server.util.tags;

import org.reactome.server.util.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class SplitCamelCaseTag extends SimpleTagSupport {
    private String value;
    private boolean capitalizeFirst = false;
    private boolean capitalizeAll = true;

    public void setValue(String value) {
        this.value = value;
    }

    public void setCapitalizeFirst(boolean capitalizeFirst) {
        this.capitalizeFirst = capitalizeFirst;
    }

    public void setCapitalizeAll(boolean capitalizeAll) {
        this.capitalizeAll = capitalizeAll;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (value == null) throw new JspException("Type must not be null");
        if (value.isEmpty()) return;

        JspWriter out = getJspContext().getOut();

        if (capitalizeAll) {
            out.print(StringUtils.camelCaseToSpaces(value, StringUtils::capitalize));
        } else if (capitalizeFirst) {
            out.print(StringUtils.camelCaseToSpaces(value, StringUtils::capitalize, String::toLowerCase));
        } else {
            out.print(StringUtils.camelCaseToSpaces(value));
        }
    }
}
