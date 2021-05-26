package org.reactome.server.controller;


import org.reactome.server.graph.domain.result.DoiPathwayDTO;
import org.reactome.server.util.DoiPathwayCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Collection;


@SuppressWarnings("unused")
@Controller
class DoiController {

    private static final String TITLE = "title";
    private static final String DOIPATHWAYS = "doiPathways";

    private DoiPathwayCache doiPathwayCache;

    @Autowired
    public void setDoiCache(DoiPathwayCache doiPathwayCache) {
        this.doiPathwayCache = doiPathwayCache;
    }

    public DoiController() {
    }

    @RequestMapping(value = "/doi", method = RequestMethod.GET)
    public String doiTable(ModelMap model) {
        Collection<DoiPathwayDTO> doiPathways = doiPathwayCache.getDoiPathwayCache();
        model.addAttribute(TITLE, "DOI Table");
        model.addAttribute(DOIPATHWAYS, doiPathways);
        return "graph/doi";
    }
}