package org.reactome.server.controller;

import org.reactome.server.graph.exception.CustomQueryException;
import org.reactome.server.graph.service.AdvancedDatabaseObjectService;
import org.reactome.server.result.CustomInteraction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
@Controller
public class InteractionsController {

    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");


    @Autowired
    private AdvancedDatabaseObjectService advancedDatabaseObjectService;

    public Collection<CustomInteraction> getCustomInteractions(String accession){
        Collection<CustomInteraction> rtn;

        String query = "" +
                "MATCH (:ReferenceEntity{identifier:{accession}})<-[:interactor]-(it:Interaction), " +
                "      (it)-[ir:interactor]->(in:ReferenceEntity)<-[re:referenceEntity]-(pe:PhysicalEntity) " +
                "RETURN DISTINCT it.score AS score, in.identifier AS accession, " +
                "                COLLECT({dbId: pe.dbId, " +
                "                         stId: pe.stId, " +
                "                         displayName: pe.displayName, " +
                "                         schemaClass: pe.schemaClass}) AS physicalEntity, " +
                "                SIZE(it.accession) AS evidences, " +
                "                it.url AS url " +
                "ORDER BY Score DESC";
        Map<String, Object> param = new HashMap<>();
        param.put("accession", accession);

        try {
            rtn = advancedDatabaseObjectService.customQueryForObjects(CustomInteraction.class, query, param);
        } catch (CustomQueryException e) {
            errorLogger.error(e.getMessage(), e);
            rtn = new ArrayList<>();
        }

        return rtn;
    }


}
