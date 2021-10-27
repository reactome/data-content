package org.reactome.server.util.tags;

import org.reactome.server.graph.domain.model.Event;
import org.reactome.server.graph.domain.model.PhysicalEntity;
import org.reactome.server.graph.domain.result.DatabaseObjectLike;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class DbObjectLink extends SimpleTagSupport {
    protected DatabaseObjectLike object;
    private String detailRequestPrefix;
    private String getParameters = "";
    private int amount = 1;
    private boolean displayStId = false;
    private boolean displaySpecies = true;
    private boolean displayIcon = true;

    public void setObject(DatabaseObjectLike object) {
        this.object = object;
    }

    public void setDetailRequestPrefix(String detailRequestPrefix) {
        this.detailRequestPrefix = detailRequestPrefix;
    }

    public void setGetParameters(String getParameters) {
        this.getParameters = getParameters;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public void setDisplayStId(boolean displayStId) {
        this.displayStId = displayStId;
    }

    public void setDisplaySpecies(boolean displaySpecies) {
        this.displaySpecies = displaySpecies;
    }

    public void setDisplayIcon(boolean displayIcon) {
        this.displayIcon = displayIcon;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (object == null) return; //throw new JspException("Entity must not be null");
        JspWriter out = getJspContext().getOut();

        out.print(String.format("%s <a href=\"%s\" title=\"Show %s\">%s</a>",
                getIcon(),
                getURL(),
                object.getStId(),
                getDisplay()
        ));
    }

    protected String getIcon() {
        if (!displayIcon) return "";
        return String.format("<i class=\"sprite sprite-resize sprite-%s sprite-position\" title=\"%s\"></i> %s ",
                object.getSchemaClass(),
                object.getSchemaClass(),
                amount > 1 ? "x " + amount : ""
        );
    }

    protected String getURL() {
        String url = detailRequestPrefix + object.getStId();
        if (!getParameters.isEmpty()) {
            if (!getParameters.startsWith("?")) url += "?";
            url += getParameters;
        }
        return url;
    }

    protected String getDisplay() {
        String specification = null;

        if (displayStId) {
            specification = object.getStId();
        } else if (displaySpecies) {
            if (object instanceof PhysicalEntity) {
                PhysicalEntity entity = (PhysicalEntity) this.object;
                if (entity.getSpeciesName() != null && !entity.getSpeciesName().isEmpty())
                    specification = entity.getSpeciesName();
            } else if (object instanceof Event) {
                Event event = (Event) this.object;
                if (event.getSpecies() != null && !event.getSpecies().isEmpty())
                    specification = event.getSpeciesName();
            }
        }

        specification = specification == null ? "" : " <span>(" + specification + ")</span>";
        return object.getDisplayName() + specification;
    }
}
