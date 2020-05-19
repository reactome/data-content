package org.reactome.server.util;

import org.reactome.server.graph.domain.result.PathwayResult;
import org.reactome.server.graph.service.TocService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collection;

@Component
public class TocPathwayCache {

    private TocService tocService;

    private Collection<PathwayResult> tocPathways;

    @Autowired
    public void setTocService(TocService tocService) {
        this.tocService = tocService;
    }

    @PostConstruct
    public void getTocPathwayResult() {
        if (tocPathways == null) {
            tocPathways = tocService.getAllTocPathway();
        }
    }

    public Collection<PathwayResult> getTocPathwayCache() {
        return tocPathways;
    }
}
