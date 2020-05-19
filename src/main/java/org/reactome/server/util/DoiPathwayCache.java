package org.reactome.server.util;

import org.reactome.server.graph.domain.result.PathwayResult;
import org.reactome.server.graph.service.DoiService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collection;

@Component
public class DoiPathwayCache {
    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");

    private DoiService doiService;

    private Collection<PathwayResult> doiPathways;

    @Autowired
    public void setDoiService(DoiService doiService) {
        this.doiService = doiService;
    }

    @PostConstruct
    public void getDoiPathwayResult() {

        try {
            if (doiPathways == null) {
                doiPathways = doiService.getAllDoiPathway();
            }
        } catch (NullPointerException e) {
            infoLogger.warn("Could not cache the DOI pathways which is used in the DOI page on the Reactome Website.");
        }
    }

    public Collection<PathwayResult> getDoiPathwayCache() {
        return doiPathways;
    }
}
