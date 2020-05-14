package org.reactome.server.controller;


import org.reactome.server.graph.domain.result.PathwayResult;

import org.reactome.server.graph.service.TocService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Collection;


@SuppressWarnings("unused")
@Controller
class TocController {


    private static final String TITLE = "title";
    private static final String TOCPATHWAYS = "tocPathways";

    private TocService tocService;

    @Autowired
    public void setTocService(TocService tocService) {
        this.tocService = tocService;
    }

    public TocController() {
    }

    @RequestMapping(value = "/toc", method = RequestMethod.GET)
    public String tocTable(ModelMap model) {

        Collection<PathwayResult> tocPathways = tocService.getAllTocPathway();

        model.addAttribute(TITLE, "Table of Contents");
        model.addAttribute(TOCPATHWAYS, tocPathways);
        return "graph/toc";
    }
}