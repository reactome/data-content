package org.reactome.server.util.tags;

import org.reactome.server.util.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class ParticipantOfTypeTag extends SimpleTagSupport {
    private static final List<Character> anChars = Arrays.asList(
            'a', 'e', 'i', 'o',
            'A', 'E', 'I', 'O');
    private String type;

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (type == null) throw new JspException("Type must not be null");
        if (type.isEmpty()) return;

        if (type.startsWith("has")) {
            type = type.substring(3);
        }

        String article = anChars.contains(type.charAt(0)) ? "an " : "a ";

        JspWriter out = getJspContext().getOut();
        out.print("as " + article + StringUtils.camelCaseToSpaces(type, String::toLowerCase) + " of");
    }
}
