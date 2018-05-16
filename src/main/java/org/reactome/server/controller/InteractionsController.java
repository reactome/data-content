package org.reactome.server.controller;

import org.reactome.server.graph.domain.model.DatabaseObject;
import org.reactome.server.graph.domain.model.ReferenceEntity;
import org.reactome.server.graph.exception.CustomQueryException;
import org.reactome.server.graph.service.AdvancedDatabaseObjectService;
import org.reactome.server.result.CustomInteraction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.noDetailsFound;

/**
 * @author Antonio Fabregat (fabregat@ebi.ac.uk)
 */
@Controller
public class InteractionsController {
    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String RE = "referenceEntity";
    private static final String RE_SYNONYMS = "referenceEntitySynonym";
    private static final String RE_TYPE = "referenceEntityType";
    private static final String RE_TITLE = "title";
    private static final String INTERACTIONS = "interactions";
    private static final String SEARCH = "search";

    private AdvancedDatabaseObjectService advancedDatabaseObjectService;

    @RequestMapping(value = "/detail/interactor/{id:.*}", method = RequestMethod.GET)
    public String interactorDetail(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Collection<CustomInteraction> customInteractions = getCustomInteractions(id);
        if (customInteractions != null && !customInteractions.isEmpty()) {
            model.addAttribute(INTERACTIONS, customInteractions);
            ReferenceEntity re = getReferenceEntity(id);
            if (re != null) {
                // ReferenceEntity is the INTERACTOR we are searching for ...
                model.addAttribute(RE, re);
                model.addAttribute(RE_TITLE, re.getDisplayName());
                model.addAttribute(RE_SYNONYMS, getSynonym(re));
                model.addAttribute(RE_TYPE, getType(re));
            }
            infoLogger.info("Search request for id: {} was found", id);
            return "graph/interactors";
        } else {
            autoFillDetailsPage(model, id);
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    /**
     * Retrieve interactions of a given accession that are NOT in Reactome
     * but interacts with something in Reactome
     */
    private Collection<CustomInteraction> getCustomInteractions(String accession) {
        Collection<CustomInteraction> rtn;

        String query = "" +
                "MATCH (s:ReferenceEntity)<-[:interactor]-(it:Interaction), " +
                "      (it)-[ir:interactor]->(in:ReferenceEntity)<-[re:referenceEntity]-(pe:PhysicalEntity), " +
                "      (:ReactionLikeEvent)-[:input|output|catalystActivity|entityFunctionalStatus|physicalEntity|regulatedBy|regulator*]->(pe) " +
                "WHERE s.variantIdentifier = {accession} OR (s.variantIdentifier IS NULL AND s.identifier = {accession}) " +
//                "      AND NOT ()-[:referenceEntity]->(s) " +
                "RETURN DISTINCT it.score AS score, in.identifier AS accession, in.url AS accessionURL, " +
                "                COLLECT(DISTINCT{ " +
                "                         dbId: pe.dbId, " +
                "                         stId: pe.stId, " +
                "                         displayName: pe.displayName, " +
                "                         schemaClass: pe.schemaClass " +
                "                }) AS physicalEntity, " +
                "                SIZE(it.accession) AS evidences, " +
                "                it.url AS url " +
                "ORDER BY score DESC, accession";

        Map<String, Object> param = new HashMap<>();
        param.put("accession", accession);

        try {
            rtn = advancedDatabaseObjectService.getCustomQueryResults(CustomInteraction.class, query, param);
        } catch (CustomQueryException e) {
            errorLogger.error(e.getMessage(), e);
            rtn = new ArrayList<>();
        }

        return rtn;
    }

    private ReferenceEntity getReferenceEntity(String id) {
        String query = "" +
                "MATCH (s:ReferenceEntity)<-[:interactor]-() " +
                "WHERE s.variantIdentifier = {accession} OR (s.variantIdentifier IS NULL AND s.identifier = {accession}) " +
                "RETURN s";
        Map<String, Object> params = new HashMap<>();
        params.put("accession", id);
        ReferenceEntity re = null;
        try {
            re = advancedDatabaseObjectService.getCustomQueryResult(ReferenceEntity.class, query, params);
        } catch (CustomQueryException e) {
            errorLogger.error(e.getMessage(), e);
        }
        return re;
    }

    @SuppressWarnings("unchecked")
    private List<String> getSynonym(DatabaseObject databaseObject) {
        try {
            // even though we are getting synonyms (alternative names in Uniprot), this field is called SecondaryIdentifier in the domain model.
            List<String> secIds = (List<String>)databaseObject.getClass().getMethod("getSecondaryIdentifier").invoke(databaseObject);
            return secIds.stream().distinct().collect(Collectors.toList());
        } catch (NullPointerException | NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            // Nothing here
        }
        return null;
    }

    private String getType(ReferenceEntity re) {
        switch (re.getSchemaClass()) {
            case ("ReferenceGeneProduct"):
            case ("ReferenceIsoform"):
                return "Protein";
            case ("ReferenceDNASequence"):
                return "DNA Sequence";
            case ("ReferenceRNASequence"):
                return "RNA Sequence";
            case ("ReferenceMolecule"):
                return "Chemical Compound";
            default:
                return re.getSchemaClass();
        }
    }

    private void autoFillDetailsPage(ModelMap model, String search) {
        model.addAttribute(SEARCH, search);
        model.addAttribute(RE_TITLE, "No details found for " + search);
    }

    @Autowired
    public void setAdvancedDatabaseObjectService(AdvancedDatabaseObjectService advancedDatabaseObjectService) {
        this.advancedDatabaseObjectService = advancedDatabaseObjectService;
    }
}
