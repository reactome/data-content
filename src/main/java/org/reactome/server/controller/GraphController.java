package org.reactome.server.controller;

import org.reactome.server.tools.search.domain.EnrichedEntry;
import org.reactome.server.tools.search.exception.EnricherException;
import org.reactome.server.tools.search.exception.SolrSearcherException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.reactome.server.tools.domain.model.DatabaseObject;
import org.reactome.server.tools.service.DatabaseObjectService;
import org.reactome.server.tools.service.GenericService;
import org.reactome.server.tools.service.helper.Node;
import org.reactome.server.tools.service.util.DatabaseObjectUtils;

import static org.reactome.server.util.WebUtils.prepareEvidencesURLs;

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

    private static final int OFFSET = 25;

    @Autowired
    private DatabaseObjectService databaseObjectService;

    @Autowired
    private GenericService genericService;

    private Node classBrowserCache;


    @RequestMapping(value = "/detail/object/{id:.*}", method = RequestMethod.GET)
    public String getInstance (@PathVariable String id, ModelMap model) {
        model.addAttribute("map", DatabaseObjectUtils.getAllFields(databaseObjectService.findById(id)));
        return "graph/object-detail";
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
    public String detail(@PathVariable String id, ModelMap model) throws EnricherException, SolrSearcherException {

        DatabaseObject databaseObject = databaseObjectService.findById(id);
        if (databaseObject!=null) {
            model.addAttribute(TITLE, databaseObject.getDisplayName());
            model.addAttribute(ENTRY, databaseObject);
            return "details";
        }
        return "noResultsFound";
    }



}