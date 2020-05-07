package org.reactome.server.controller;


import org.reactome.server.graph.exception.CustomQueryException;
import org.reactome.server.graph.service.*;
import org.reactome.server.result.CustomPathway;
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

    private AdvancedDatabaseObjectService advancedDatabaseObjectService;


    @Autowired
    public void setAdvancedDatabaseObjectService(AdvancedDatabaseObjectService advancedDatabaseObjectService) {
        this.advancedDatabaseObjectService = advancedDatabaseObjectService;
    }

    public DoiController() {

    }

    @RequestMapping(value = "/doi", method = RequestMethod.GET)
    public String doiTable(ModelMap model) {

        Collection<CustomPathway> doiPathways = getAllDoiPathways();

        model.addAttribute(TITLE, "DOI Table");
        model.addAttribute(DOIPATHWAYS, doiPathways);
        return "graph/doi";
    }

    /**
     * Retrieve all pathway which the doi value is not null, and all the authors,reviewers, editors are
     * related  to this pathway, subpathway and reactions.
     */
    public Collection<CustomPathway> getAllDoiPathways() {
        Collection<CustomPathway> rtn;

        String query = "MATCH (p:Pathway)" +
                "WHERE EXISTS(p.doi)" +
                "OPTIONAL MATCH (p)<-[:revised]-(re:InstanceEdit)" +
                "OPTIONAL MATCH (p)-[:reviewed]-(:InstanceEdit)" +
                "OPTIONAL MATCH (p)-[:hasEvent*]->(rle:ReactionLikeEvent)" +
                "OPTIONAL MATCH (rle)<-[:authored]-(:InstanceEdit)<-[:author]-(rlea:Person)" +
                "OPTIONAL MATCH (rle)<-[:reviewed]-(:InstanceEdit)<-[:author]-(rler:Person)" +
                "OPTIONAL MATCH (rle)<-[:edited]-(:InstanceEdit)<-[:author]-(rlee:Person)" +
                "RETURN p.displayName AS displayName, " +
                "p.doi as doi, " +
                "p.speciesName AS species, " +
                "collect(distinct rlea) as authors, " +
                "p.releaseDate As releaseDate, " +
                "max(re.dateTime) As reviseDate, " +
                "collect(distinct rler) AS reviewers," +
                "collect(distinct rlee) AS editors," +
                "p.releaseStatus AS releaseStatus " +
                "ORDER BY toLower(p.displayName)";

        try {
            rtn = advancedDatabaseObjectService.getCustomQueryResults(CustomPathway.class, query);
        } catch (CustomQueryException e) {
            errorLogger.error(e.getMessage(), e);
            rtn = new ArrayList<>();
        }
        return rtn;
    }
}