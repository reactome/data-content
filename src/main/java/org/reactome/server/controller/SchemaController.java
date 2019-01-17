package org.reactome.server.controller;

import org.apache.commons.lang.StringUtils;
import org.reactome.server.exception.ViewException;
import org.reactome.server.graph.domain.model.DatabaseObject;
import org.reactome.server.graph.domain.model.Event;
import org.reactome.server.graph.domain.model.PhysicalEntity;
import org.reactome.server.graph.domain.model.SimpleEntity;
import org.reactome.server.graph.service.*;
import org.reactome.server.graph.service.helper.SchemaNode;
import org.reactome.server.graph.service.util.DatabaseObjectUtils;
import org.reactome.server.util.DataSchemaCache;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import static org.reactome.server.util.WebUtils.noDetailsFound;

/**
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @author Guilherme Viteri (gviteri@ebi.ac.uk)
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
@SuppressWarnings("unused")
@Controller
class SchemaController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String TITLE = "title";

    private static final int OFFSET = 55;
    private final Set<String> ehlds = new HashSet<>();
    private GeneralService generalService;
    private AdvancedDatabaseObjectService advancedDatabaseObjectService;
    private SchemaService schemaService;
    private SpeciesService speciesService;
    private AdvancedLinkageService advancedLinkageService;
    private SchemaNode classBrowserCache;

    @RequestMapping(value = "/schema/instance/browser/{id}", method = RequestMethod.GET)
    public String objectDetail(@PathVariable String id,
                               ModelMap model,
                               HttpServletResponse response) throws ViewException {
        try {
            DatabaseObject databaseObject = advancedDatabaseObjectService.findById(id, 1000);
            if (databaseObject == null) {
                infoLogger.info("DatabaseObject for id: {} was not found", id);
                return noDetailsFound(model, response, id);
            }
            model.addAttribute(TITLE, databaseObject.getDisplayName());
            model.addAttribute("breadcrumbSchemaClass", databaseObject.getSchemaClass());
            model.addAttribute("map", DatabaseObjectUtils.getAllFields(databaseObject));
            model.addAttribute("referrals", advancedLinkageService.getReferralsTo(id));

            if (databaseObject instanceof PhysicalEntity || databaseObject instanceof Event) {
                model.addAttribute("linkToDetailsPage", true);
                model.addAttribute("id", StringUtils.isNotEmpty(databaseObject.getStId()) ? databaseObject.getStId() : databaseObject.getDbId());
            }

            infoLogger.info("DatabaseObject for id: {} was found", id);
            return "graph/instanceBrowser";
        } catch (Throwable t) {
            // Catch any exception that could happen in the schema page and pass it to the GlobalExceptionHandler
            throw new ViewException(t);
        }
    }

    @RequestMapping(value = "/schema/objects/{className}", method = RequestMethod.GET)
    public String getClassBrowserInstances(@PathVariable String className,
                                           @RequestParam(defaultValue = "9606") String speciesTaxId, //default Human
                                           @RequestParam(defaultValue = "1") Integer page,
                                           ModelMap model,
                                           HttpServletResponse response) throws ViewException {

        try {
            classBrowserCache = DataSchemaCache.getClassBrowserCache();
            if (classBrowserCache == null) {
                classBrowserCache = DatabaseObjectUtils.getGraphModelTree(generalService.getSchemaClassCounts());
            }
            model.addAttribute(TITLE, className);
            model.addAttribute("type", "list");
            model.addAttribute("node", classBrowserCache);
            model.addAttribute("className", className);
            model.addAttribute("page", page);

            Class clazz = DatabaseObjectUtils.getClassForName(className);
            Collection<DatabaseObject> databaseObjects;
            try {
                if (clazz.equals(SimpleEntity.class)) throw new Exception("No species available for simple entity");
                //noinspection unchecked,unused
                Method m = clazz.getMethod("getSpecies");
                databaseObjects = schemaService.getByClassName(className, speciesTaxId, page, OFFSET);
                Integer num = schemaService.countByClassAndSpecies(className, speciesTaxId);
                model.addAttribute("maxpage", (int) Math.ceil(num / (double) OFFSET));

                //Only keep information related to species when it makes sense
                model.addAttribute("speciesList", speciesService.getSpecies());
                if (!speciesTaxId.equals("9606")) {
                    model.addAttribute("selectedSpecies", speciesTaxId);
                }
            } catch (Exception e) {
                databaseObjects = schemaService.getByClassName(className, page, OFFSET);
                model.addAttribute("maxpage", classBrowserCache.findMaxPage(className, OFFSET));
            }

            if (databaseObjects == null) { // || databaseObjects.isEmpty()) {
                infoLogger.info("DatabaseObjects for class: {} were not found", className);
                return noDetailsFound(model, response, className);
            }

            model.addAttribute("objects", databaseObjects);
            infoLogger.info("DatabaseObjects for class: {} were found", className);
            return "graph/schema";
        } catch (ClassNotFoundException ex) {
            return noDetailsFound(model, response, className);
        } catch (Throwable t) {
            // Catch any exception that could happen in the schema page and pass it to the GlobalExceptionHandler
            throw new ViewException(t);
        }
    }

    @RequestMapping(value = "/schema/{className}", method = RequestMethod.GET)
    public String getClassBrowserDetails(@PathVariable String className,
                                         ModelMap model,
                                         HttpServletResponse response) {
        try {
            classBrowserCache = DataSchemaCache.getClassBrowserCache();
            if (classBrowserCache == null) {
                classBrowserCache = DatabaseObjectUtils.getGraphModelTree(generalService.getSchemaClassCounts());
            }
            model.addAttribute(TITLE, className);
            model.addAttribute("node", classBrowserCache);
            model.addAttribute("properties", DatabaseObjectUtils.getAttributeTable(className));
            model.addAttribute("referrals", DatabaseObjectUtils.getReferrals(className));
            model.addAttribute("className", className);
            return "graph/schema";
        } catch (ClassNotFoundException ex) {
            return noDetailsFound(model, response, className);
        } catch (Throwable t) {
            // Catch any exception that could happen in the schema page and pass it to the GlobalExceptionHandler
            throw new ViewException(t);
        }
    }

    @RequestMapping(value = "/schema", method = RequestMethod.GET)
    public String getClassBrowser() {
        // When we load the schema page, DatabaseObject is loaded by default, then we redirect to it
        return "redirect:/schema/DatabaseObject";
    }

    @Autowired
    public void setGeneralService(GeneralService generalService) {
        this.generalService = generalService;
    }

    @Autowired
    public void setAdvancedDatabaseObjectService(AdvancedDatabaseObjectService advancedDatabaseObjectService) {
        this.advancedDatabaseObjectService = advancedDatabaseObjectService;
    }

    @Autowired
    public void setSchemaService(SchemaService schemaService) {
        this.schemaService = schemaService;
    }

    @Autowired
    public void setSpeciesService(SpeciesService speciesService) {
        this.speciesService = speciesService;
    }

    @Autowired
    public void setAdvancedLinkageService(AdvancedLinkageService advancedLinkageService) {
        this.advancedLinkageService = advancedLinkageService;
    }
}