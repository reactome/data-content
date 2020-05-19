package org.reactome.server.util;

import org.reactome.server.graph.domain.result.PathwayResult;
import org.reactome.server.graph.service.TocService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collection;

@Component
public class TocPathwayCache {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");

    private TocService tocService;

    private Collection<PathwayResult> tocPathways;

    @Autowired
    public void setTocService(TocService tocService) {
        this.tocService = tocService;
    }

    @PostConstruct
    public void getTocPathwayResult() {

        try {
            if (tocPathways == null) {
                tocPathways = tocService.getAllTocPathway();
            }
        } catch (NullPointerException e) {
            infoLogger.warn("Could not cache the TOC pathways which is used in the TOC page on the Reactome Website.");
        }
    }

    public Collection<PathwayResult> getTocPathwayCache() {
        return tocPathways;
    }
}
