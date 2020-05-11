package org.reactome.server.controller;


import org.reactome.server.result.PathwayResult;
import org.reactome.server.util.TocDoiService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.*;


@SuppressWarnings("unused")
@Controller
class DoiController {

    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String TITLE = "title";
    private static final String DOIPATHWAYS = "doiPathways";
    private static final String TOCPATHWAYS = "tocPathways";


    private TocDoiService tocDoiService;

    @Autowired
    public void setTocDoiService(TocDoiService tocDoiService) {
        this.tocDoiService = tocDoiService;
    }

    public DoiController() {
    }

    @RequestMapping(value = "/doi", method = RequestMethod.GET)
    public String doiTable(ModelMap model) {

        Collection<PathwayResult> doiPathways = tocDoiService.getAllDoiPathways();

        model.addAttribute(TITLE, "DOI Table");
        model.addAttribute(DOIPATHWAYS, doiPathways);
        return "graph/doi";
    }


    @RequestMapping(value = "/toc", method = RequestMethod.GET)
    public String tocTable(ModelMap model) {

        Collection<PathwayResult> tocPathways = tocDoiService.getAllTocPathways();

        model.addAttribute(TITLE, "Table of Contents");
        model.addAttribute(TOCPATHWAYS, tocPathways);
        return "graph/toc";
    }
}