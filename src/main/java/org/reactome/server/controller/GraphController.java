package org.reactome.server.controller;

import org.apache.commons.lang.StringUtils;
import org.reactome.server.graph.domain.model.*;
import org.reactome.server.graph.service.*;
import org.reactome.server.graph.service.helper.ContentDetails;
import org.reactome.server.graph.service.helper.PathwayBrowserNode;
import org.reactome.server.graph.service.helper.RelationshipDirection;
import org.reactome.server.graph.service.helper.SchemaNode;
import org.reactome.server.graph.service.util.DatabaseObjectUtils;
import org.reactome.server.graph.service.util.PathwayBrowserLocationsUtils;
import org.reactome.server.interactors.model.Interaction;
import org.reactome.server.interactors.model.InteractorResource;
import org.reactome.server.interactors.service.InteractionService;
import org.reactome.server.interactors.service.InteractorResourceService;
import org.reactome.server.interactors.util.InteractorConstant;
import org.reactome.server.search.exception.EnricherException;
import org.reactome.server.search.exception.SolrSearcherException;
import org.reactome.server.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLException;
import java.util.*;

/**
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @author Guilherme Viteri (gviteri@ebi.ac.uk)
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
@Controller
class GraphController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String TITLE = "title";
    private static final String INTERACTOR_RESOURCES_MAP = "interactorResourceMap";
    private static final String EVIDENCES_URL_MAP = "evidencesUrlMap";

    private static final int OFFSET = 25;

    @Autowired
    private GeneralService generalService;

    @Autowired
    private AdvancedDatabaseObjectService advancedDatabaseObjectService;

    @Autowired
    private InteractionService interactionService;

    @Autowired
    private DetailsService detailsService;

    @Autowired
    private SchemaService schemaService;

    @Autowired
    private AdvancedLinkageService advancedLinkageService;

    private SchemaNode classBrowserCache;

    private Map<Long, InteractorResource> interactorResourceMap = new HashMap<>();

    /**
     * These resources are the same all the time.
     * In order to speed up the query result and less memory usage, I decided to keep the resource out of the query
     * and keep a cache with them. Thus we avoid having the same information for all results.
     */
    @Autowired
    public GraphController(InteractorResourceService interactorResourceService) {
        try {
            interactorResourceMap = interactorResourceService.getAllMappedById();
        } catch (SQLException e) {
            errorLogger.error("An error has occurred while querying InteractorResource: " + e.getMessage(), e);
        }
    }

    @RequestMapping(value = "/schema/instance/browser/{id}", method = RequestMethod.GET)
    public String objectDetail(@PathVariable String id, ModelMap model) {

        DatabaseObject databaseObject = advancedDatabaseObjectService.findById(id, 1000);
        if (databaseObject == null) {
            infoLogger.info("DatabaseObject for id: {} was {}", id, "not found");
            return "search/noDetailsFound";
        }
        model.addAttribute(TITLE, databaseObject.getDisplayName());
        model.addAttribute("breadcrumbSchemaClass", databaseObject.getSchemaClass());
        model.addAttribute("map", DatabaseObjectUtils.getAllFields(databaseObject));
        model.addAttribute("referrals", advancedLinkageService.getReferralsTo(id));

        if (databaseObject instanceof PhysicalEntity || databaseObject instanceof Event || databaseObject instanceof Regulation) {
            model.addAttribute("linkToDetailsPage", true);
            model.addAttribute("id", StringUtils.isNotEmpty(databaseObject.getStId()) ? databaseObject.getStId() : databaseObject.getDbId());
        }

        infoLogger.info("DatabaseObject for id: {} was {}", id, "found");
        return "graph/instanceBrowser";
    }

    @RequestMapping(value = "/schema/objects/{className}", method = RequestMethod.GET)
    public String getClassBrowserInstances(@PathVariable String className,
                                           @RequestParam Integer page,
                                           ModelMap model) throws ClassNotFoundException {
        if (classBrowserCache == null) {
            classBrowserCache = DatabaseObjectUtils.getGraphModelTree(generalService.getSchemaClassCounts());
        }
        model.addAttribute(TITLE, className);
        model.addAttribute("node", classBrowserCache);
        model.addAttribute("className", className);
        model.addAttribute("page", page);
        model.addAttribute("maxpage", classBrowserCache.findMaxPage(className, OFFSET));
        Collection<DatabaseObject> databaseObjects = schemaService.getByClassName(className,page,OFFSET);
        if (databaseObjects == null || databaseObjects.isEmpty()) {
            infoLogger.info("DatabaseObjects for class: {} were {}", className, "not found");
            return "search/noDetailsFound";
        }
        model.addAttribute("objects", databaseObjects);
        infoLogger.info("DatabaseObjects for class: {} were {}", className, "fFound");
        return "graph/schema";
    }

    @RequestMapping(value = "/schema/{className}", method = RequestMethod.GET)
    public String getClassBrowserDetails(@PathVariable String className, ModelMap model) throws ClassNotFoundException {
        if (classBrowserCache == null) {
            classBrowserCache = DatabaseObjectUtils.getGraphModelTree(generalService.getSchemaClassCounts());
        }
        model.addAttribute(TITLE, className);
        model.addAttribute("node", classBrowserCache);
        model.addAttribute("properties", DatabaseObjectUtils.getAttributeTable(className));
        model.addAttribute("referrals", DatabaseObjectUtils.getReferrals(className));
        model.addAttribute("className", className);
        return "graph/schema";
    }

    @RequestMapping(value = "/schema", method = RequestMethod.GET)
    public String getClassBrowser() throws ClassNotFoundException {
        // When we load the schema page, DatabaseObject is loaded by default, then we redirect to it
        return "redirect:/schema/DatabaseObject";
    }

    /**
     * Shows detailed information of an entry
     *
     * @param id    StId or DbId
     * @param model SpringModel
     * @return Detailed page
     * @throws EnricherException
     * @throws SolrSearcherException
     */
    @RequestMapping(value = "/detail/{id:.*}", method = RequestMethod.GET)
    public String detail(@PathVariable String id,
                         @RequestParam(required = false, defaultValue = "") String interactor,
                         ModelMap model) throws Exception {

            boolean interactorPage = StringUtils.isNotEmpty(interactor);

            ContentDetails contentDetails = detailsService.getContentDetails(id, interactorPage);

            if (contentDetails != null && contentDetails.getDatabaseObject() != null) {
            DatabaseObject databaseObject = contentDetails.getDatabaseObject();
            String superClass = getClazz(databaseObject);
            if (superClass == null) {
                /*
                 * The database object contains already all outgoing relationships.
                 * To complete the object for the instance/browser view all incoming relationships have to be loaded.
                 * The Mapping will be done automatically by Spring.
                 */
                advancedDatabaseObjectService.findById(databaseObject.getDbId(), RelationshipDirection.INCOMING);
                model.addAttribute("map", DatabaseObjectUtils.getAllFields(databaseObject));
                return "redirect:/schema/instance/browser/" + id;
            } else {
                Set<PathwayBrowserNode> topLevelNodes = contentDetails.getNodes();

                model.addAttribute(TITLE, databaseObject.getDisplayName());
                model.addAttribute("databaseObject", databaseObject);
                model.addAttribute("clazz", superClass);
                model.addAttribute("topLevelNodes", topLevelNodes);
                model.addAttribute("availableSpecies", PathwayBrowserLocationsUtils.getAvailableSpecies(topLevelNodes));
                model.addAttribute("componentOf", contentDetails.getComponentOf());
                model.addAttribute("otherFormsOfThisMolecule", contentDetails.getOtherFormsOfThisMolecule());
                List<DatabaseIdentifier> crossReferences = new ArrayList<>();
                crossReferences.addAll(getCrossReference(databaseObject));
                setClassAttributes(databaseObject, model);

                if (databaseObject instanceof EntityWithAccessionedSequence) {
                    EntityWithAccessionedSequence ewas = (EntityWithAccessionedSequence) databaseObject;
                    List<Interaction> interactions = interactionService.getInteractions(ewas.getReferenceEntity().getIdentifier(), InteractorConstant.STATIC);
                    model.addAttribute("interactions", interactions);
                    model.addAttribute(INTERACTOR_RESOURCES_MAP, interactorResourceMap); // interactor URL
                    model.addAttribute(EVIDENCES_URL_MAP, WebUtils.prepareEvidencesURLs(interactions)); // evidencesURL
                    crossReferences.addAll(getCrossReference(ewas.getReferenceEntity()));
                    if (ewas.getReferenceEntity() instanceof ReferenceSequence) {
                        model.addAttribute("isReferenceSequence", true);
                    }
                }
                model.addAttribute("crossReferences", groupCrossReferences(crossReferences));
                infoLogger.info("DatabaseObject for id: {} was {}", id, "found");
                return "graph/detail";
            }
        }
        infoLogger.info("DatabaseObject for id: {} was {}", id, "notFound");
        return "search/noDetailsFound";
    }


    private void setClassAttributes (DatabaseObject databaseObject, ModelMap model) {
        if (databaseObject instanceof ReactionLikeEvent) {
            model.addAttribute("isReactionLikeEvent", true);
        }
        else if (databaseObject instanceof EntitySet) {
            model.addAttribute("isEntitySet", true);
        }
        // Cant explain why warning appears here, should be correct
        else //noinspection ConstantConditions
            if(databaseObject instanceof OpenSet || databaseObject instanceof EntityWithAccessionedSequence || databaseObject instanceof SimpleEntity) {
            model.addAttribute("hasReferenceEntity", true);
        }
    }

    private Map<String, List<DatabaseIdentifier>> groupCrossReferences(List<DatabaseIdentifier> databaseIdentifiers) {
        if (databaseIdentifiers == null) return null;
        Map<String, List<DatabaseIdentifier>> groupedCrossReferences = new HashMap<>();
        for (DatabaseIdentifier databaseIdentifier : databaseIdentifiers) {
            groupedCrossReferences.computeIfAbsent(databaseIdentifier.getDatabaseName(), crossRef -> new ArrayList<>()).add(databaseIdentifier);
        }
        return groupedCrossReferences;
    }

    private List<DatabaseIdentifier> getCrossReference(DatabaseObject databaseObject) {
        List<DatabaseIdentifier> crossReferences = null;
        if (databaseObject instanceof PhysicalEntity) {
            crossReferences = ((PhysicalEntity) databaseObject).getCrossReference();
        } else if (databaseObject instanceof Event) {
            crossReferences = ((Event) databaseObject).getCrossReference();
        } else if (databaseObject instanceof ReferenceEntity) {
            crossReferences = ((ReferenceEntity) databaseObject).getCrossReference();
        }
        return crossReferences != null ? crossReferences : Collections.EMPTY_LIST;
    }

    private String getClazz(DatabaseObject databaseObject) {
        if (databaseObject != null) {
            if (databaseObject instanceof Event) {
                return Event.class.getSimpleName();
            } else if (databaseObject instanceof PhysicalEntity) {
                return PhysicalEntity.class.getSimpleName();
            } else if (databaseObject instanceof Regulation) {
                return Regulation.class.getSimpleName();
            }
        }
        return null;
    }
}