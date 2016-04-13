package org.reactome.server.controller;

import org.reactome.server.tools.domain.model.DatabaseObject;
import org.reactome.server.tools.domain.model.EntityWithAccessionedSequence;
import org.reactome.server.tools.domain.model.Event;
import org.reactome.server.tools.domain.model.PhysicalEntity;
import org.reactome.server.tools.interactors.model.Interaction;
import org.reactome.server.tools.interactors.model.InteractorResource;
import org.reactome.server.tools.interactors.service.InteractionService;
import org.reactome.server.tools.interactors.service.InteractorResourceService;
import org.reactome.server.tools.interactors.util.InteractorConstant;
import org.reactome.server.tools.search.exception.EnricherException;
import org.reactome.server.tools.search.exception.SolrSearcherException;
import org.reactome.server.tools.service.DatabaseObjectService;
import org.reactome.server.tools.service.GenericService;
import org.reactome.server.tools.service.helper.PBNode;
import org.reactome.server.tools.service.helper.SchemaNode;
import org.reactome.server.tools.service.util.DatabaseObjectUtils;
import org.reactome.server.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by:
 *
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @since 10.02.16.
 */
@Controller
@RequestMapping("")
class GraphController {

    private static final String TITLE = "title";
    private static final String ENTRY = "entry";
    private static final String INTERACTOR_RESOURCES_MAP = "interactorResourceMap";
    private static final String EVIDENCES_URL_MAP = "evidencesUrlMap";


    private static final int OFFSET = 25;

    @Autowired
    private DatabaseObjectService databaseObjectService;

    @Autowired
    private GenericService genericService;

    @Autowired
    private InteractionService interactionService;

    private SchemaNode classBrowserCache;

    private Map<Long, InteractorResource> interactorResourceMap = new HashMap<>();




    @Autowired
    public GraphController(InteractorResourceService interactorResourceService) {
        try {
            /**
             * These resources are the same all the time.
             * In order to speed up the query result and less memory usage, I decided to keep the resource out of the query
             * and keep a cache with them. Thus we avoid having the same information for all results.
             */
            interactorResourceMap = interactorResourceService.getAllMappedById();
        } catch (SQLException e) {
//            logger.error("An error has occurred while querying InteractorResource: " + e.getMessage(), e);
        }
    }


    @RequestMapping(value = "/detail/object/{id:.*}", method = RequestMethod.GET)
    public String getInstance (@PathVariable String id, ModelMap model) {
        model.addAttribute("map", DatabaseObjectUtils.getAllFields(databaseObjectService.findById(id)));
        return "graph/schemaDetail";
    }

    @RequestMapping(value = "/details/{className:.*}", method = RequestMethod.GET)
    public String getClassBrowserInstances(@PathVariable String className,
                                           @RequestParam Integer page,
                                           ModelMap model) throws ClassNotFoundException {
        if (classBrowserCache == null) {
            classBrowserCache = DatabaseObjectUtils.getGraphModelTree(databaseObjectService.getLabelsCount());
        }
        model.addAttribute("node", classBrowserCache);
        model.addAttribute("className", className);
        model.addAttribute("page", page);
        model.addAttribute("maxpage", classBrowserCache.findMaxPage(className, OFFSET));
        model.addAttribute("objects", genericService.getObjectsByClassName(className,page,OFFSET));
        return "graph/schema";
    }

    @RequestMapping(value = "/schema/{className:.*}", method = RequestMethod.GET)
    public String getClassBrowserDetails(@PathVariable String className, ModelMap model) throws ClassNotFoundException {
        if (classBrowserCache == null) {
            classBrowserCache = DatabaseObjectUtils.getGraphModelTree(databaseObjectService.getLabelsCount());
        }
        model.addAttribute("node", classBrowserCache);
        model.addAttribute("properties", DatabaseObjectUtils.getAttributeTable(className));
        model.addAttribute("className", className);
        return "graph/schema";
    }

    @RequestMapping(value = "/schema", method = RequestMethod.GET)
    public String getClassBrowser(ModelMap model) throws ClassNotFoundException {
        return getClassBrowserDetails(DatabaseObject.class.getSimpleName(), model);
    }


    /**
     * Shows detailed information of an entry
     *
     * @param id    StId or DbId
     *              //     * @param q,species,types,compartments,keywords parameters to save existing query and facets
     * @param model SpringModel
     * @return Detailed page
     * @throws EnricherException
     * @throws SolrSearcherException
     */
    @RequestMapping(value = "/detail/{id:.*}", method = RequestMethod.GET)
    public String detail(@PathVariable String id, ModelMap model) throws Exception {

        DatabaseObject databaseObject = databaseObjectService.findById(id);
        if (databaseObject!=null) {
            model.addAttribute(TITLE, databaseObject.getDisplayName());
            model.addAttribute("databaseObject", databaseObject);
            model.addAttribute("clazz", getClazz(databaseObject));

            Set<PBNode> topLevelNodes = genericService.getLocationsInPathwayBrowser(databaseObject);


            model.addAttribute("topLevelNodes", topLevelNodes);
            model.addAttribute("availableSpecies", DatabaseObjectUtils.getAvailableSpecies(topLevelNodes));
//            model.addAttribute("", InstanceTypeExplanation.getExplanation());
//            model.addAttribute("", SchemaClass.getSchemaClass(databaseObject.getSchemaClass()));
//
//            databaseObject.getReferencetype
        if (databaseObject instanceof EntityWithAccessionedSequence) {
            EntityWithAccessionedSequence ewas = (EntityWithAccessionedSequence) databaseObject;
            List<Interaction> interactions = interactionService.getInteractions(ewas.getReferenceEntity().getIdentifier(),InteractorConstant.STATIC);
            model.addAttribute("interactors", interactions);
            model.addAttribute(INTERACTOR_RESOURCES_MAP, interactorResourceMap); // interactor URL
            model.addAttribute(EVIDENCES_URL_MAP, WebUtils.prepareEvidencesURLs(interactions)); // evidencesURL
        }

            return "graph/detail";
        }
        return "noResultsFound";
    }


    private String getClazz(DatabaseObject databaseObject) throws Exception {
        String clazz;
        if (databaseObject instanceof Event) {
            clazz = Event.class.getSimpleName();
        } else if (databaseObject instanceof PhysicalEntity) {
            clazz = PhysicalEntity.class.getSimpleName();
        } else {
            //todo change exception
            throw new Exception();
        }
        return clazz;
    }

    /**
     * Shows detailed information of an entry
     *
     * @param id    StId or DbId
     *              //     * @param q,species,types,compartments,keywords parameters to save existing query and facets
     * @param model SpringModel
     * @return Detailed page
     * @throws EnricherException
     * @throws SolrSearcherException
     */
//    @RequestMapping(value = "/detail/{id:.*}", method = RequestMethod.GET)
//    public String detail(@PathVariable String id, ModelMap model) throws EnricherException, SolrSearcherException {
//
//        EnrichedEntry entry = searchService.getEntryById(id);
//        DatabaseObject databaseObject = new Pathway();
//        databaseObject.setStableIdentifier(entry.getStId());
//        databaseObject.setDisplayName(entry.getName());
//        databaseObject.setSpeciesName(entry.getSpecies());
//        entry.setLocationsPathwayBrowser(genericService.getLocationsInPathwayBrowser(databaseObject));
//        if (entry != null) {
//            model.addAttribute(ENTRY, entry);
//            model.addAttribute(TITLE, entry.getName());
//            model.addAttribute(INTERACTOR_RESOURCES_MAP, interactorResourceMap); // interactor URL
//            model.addAttribute(EVIDENCES_URL_MAP, prepareEvidencesURLs(entry.getInteractionList())); // evidencesURL
//            return PAGE_DETAIL;
//        } else {
//            autoFillDetailsPage(model, id);
//            return PAGE_NO_DETAILS_FOUND;
//        }
//    }

    /**
     * These resources are the same all the time.
     * In order to speed up the query result and less memory usage, I decided to keep the resource out of the query
     * and keep a cache with them. Thus we avoid having the same information for all result.
     *
     * This method set the map class attribute.
     */
//    private void cacheResources(){
//        cacheInteractionResources();
//        cacheInteractorResources();
//    }
//
//    private void cacheInteractorResources(){
//        try {
//            interactorResourceMap = interactorResourceService.getAllMappedById();
//        } catch (SQLException e) {
//            logger.error("An error has occurred while querying InteractorResource: " + e.getMessage(), e);
//        }
//    }
//
//    private void cacheInteractionResources(){
//        try {
//            interactionResourceMap = interactionResourceService.getAllMappedById();
//        } catch (SQLException e) {
//            logger.error("An error has occurred while querying InteractionResource: " + e.getMessage(), e);
//        }
//    }
}