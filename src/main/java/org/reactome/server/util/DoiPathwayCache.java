package org.reactome.server.util;

import org.reactome.server.graph.domain.result.DoiPathwayDTO;
import org.reactome.server.graph.service.DoiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collection;

@Component
public class DoiPathwayCache {

    private DoiService doiService;

    private Collection<DoiPathwayDTO> doiPathways;

    @Autowired
    public void setDoiService(DoiService doiService) {
        this.doiService = doiService;
    }

    @PostConstruct
    public void getDoiPathwayResult() {
        if (doiPathways == null) {
            doiPathways = doiService.getAllDoiPathway();
        }
    }

    public Collection<DoiPathwayDTO> getDoiPathwayCache() {
        return doiPathways;
    }
}
