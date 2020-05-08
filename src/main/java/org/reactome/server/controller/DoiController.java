package org.reactome.server.controller;


import org.reactome.server.graph.exception.CustomQueryException;
import org.reactome.server.graph.service.*;
import org.reactome.server.result.PathwayResult;
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

    private AdvancedDatabaseObjectService advancedDatabaseObjectService;


    @Autowired
    public void setAdvancedDatabaseObjectService(AdvancedDatabaseObjectService advancedDatabaseObjectService) {
        this.advancedDatabaseObjectService = advancedDatabaseObjectService;
    }

    public DoiController() {

    }

    @RequestMapping(value = "/doi", method = RequestMethod.GET)
    public String doiTable(ModelMap model) {

        Collection<PathwayResult> doiPathways = getAllDoiPathways();

        model.addAttribute(TITLE, "DOI Table");
        model.addAttribute(DOIPATHWAYS, doiPathways);
        return "graph/doi";
    }


    @RequestMapping(value = "/toc", method = RequestMethod.GET)
    public String tocTable(ModelMap model) {

        Collection<PathwayResult> tocPathways = getAllTocPathways();
        model.addAttribute(TITLE, "Table of Contens");
        model.addAttribute(TOCPATHWAYS, tocPathways);
        return "graph/toc";
    }

    /**
     * Retrieve all pathways which the doi value is not null, and all the authors, reviewers, editors are
     * related to this pathway, sub pathway and reactions.
     */
    public Collection<PathwayResult> getAllDoiPathways() {
        Collection<PathwayResult> rtn;

        String query = "MATCH (p:Pathway)" +
                "WHERE EXISTS(p.doi)" +
                "OPTIONAL MATCH (p)<-[:revised]-(re:InstanceEdit)" +
                "OPTIONAL MATCH (p)-[:reviewed]-(:InstanceEdit)" +
                "OPTIONAL MATCH (p)-[:hasEvent*]->(rle:ReactionLikeEvent)" +
                "OPTIONAL MATCH (rle)<-[:authored]-(:InstanceEdit)<-[:author]-(rlea:Person)" +
                "OPTIONAL MATCH (rle)<-[:reviewed]-(:InstanceEdit)<-[:author]-(rler:Person)" +
                "OPTIONAL MATCH (rle)<-[:edited]-(:InstanceEdit)<-[:author]-(rlee:Person)" +
                "RETURN p.displayName AS displayName, " +
                "p.doi AS doi, " +
                "p.stId AS stId, " +
                "p.speciesName AS species, " +
                "p.releaseDate AS releaseDate, " +
                "p.releaseStatus AS releaseStatus, " +
                "max(re.dateTime) AS reviseDate, " +
                "collect(distinct rlea) AS authors, " +
                "collect(distinct rler) AS reviewers, " +
                "collect(distinct rlee) AS editors " +
                "ORDER BY toLower(p.displayName)";

        try {
            rtn = advancedDatabaseObjectService.getCustomQueryResults(PathwayResult.class, query);
        } catch (CustomQueryException e) {
            errorLogger.error(e.getMessage(), e);
            rtn = new ArrayList<>();
        }
        return rtn;
    }

    /**
     * Retrieve all top level pathways and child pathways,  all the authors,reviewers, editors are
     * related  to this pathway, sub pathway and reactions.
     */
    public Collection<PathwayResult> getAllTocPathways() {
        Collection<PathwayResult> rtn;

        String query = "MATCH (p:TopLevelPathway)" +
                "OPTIONAL MATCH (p)<-[:revised]-(re:InstanceEdit)" +
                "OPTIONAL MATCH (p)-[:reviewed]-(:InstanceEdit)" +
                "OPTIONAL MATCH (p)-[:hasEvent*]->(rle:ReactionLikeEvent)" +
                "OPTIONAL MATCH (p)-[:hasEvent]->(pa:Pathway{hasDiagram:True})" +
                "OPTIONAL MATCH (rle)<-[:authored]-(:InstanceEdit)<-[:author]-(rlea:Person)" +
                "OPTIONAL MATCH (rle)<-[:reviewed]-(:InstanceEdit)<-[:author]-(rler:Person)" +
                "OPTIONAL MATCH (rle)<-[:edited]-(:InstanceEdit)<-[:author]-(rlee:Person)" +
                "WITH  size(collect(distinct rlea.displayName)) AS authorsCollect, " +
                "p, " +
                "collect(distinct rlea) AS authors, " +
                "max(re.dateTime) AS revised, " +
                "collect(distinct rler) AS reviewers, " +
                "collect(distinct rlee) AS editors, " +
                "collect(distinct pa) AS subPathway " +
                "WHERE authorsCollect > 0 " +
                "RETURN p.displayName AS displayName, " +
                "p.doi AS doi, " +
                "p.releaseDate AS releaseDate, " +
                "p.releaseStatus AS releaseStatus, " +
                "p.speciesName AS species, " +
                "p.stId AS stId, " +
                "authors AS authors, " +
                "reviewers AS reviewers, " +
                "subPathway AS subPathway, " +
                "editors AS editors, " +
                "revised AS reviseDate " +
                "ORDER BY toLower(p.displayName)";

        try {
            rtn = advancedDatabaseObjectService.getCustomQueryResults(PathwayResult.class, query);
        } catch (CustomQueryException e) {
            errorLogger.error(e.getMessage(), e);
            rtn = new ArrayList<>();
        }
        return rtn;
    }
}