package org.reactome.server.util;

import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.graph.service.DatabaseObjectService;
import org.reactome.server.graph.service.PathwaysService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

@Component
public class BibTexExporter {
    private PathwaysService pathwaysService;
    private DatabaseObjectService databaseObjectService;

    public String run(String personDbId, String pathwayStId) {
        Pathway ppp = databaseObjectService.findById(pathwayStId);
//        ppp.getCreated().getAuthor()
        return "<bibtex>";
    }

    @Autowired
    public void setPathwaysService(PathwaysService pathwaysService) {
        this.pathwaysService = pathwaysService;
    }
}
