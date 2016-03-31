package org.reactome.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import uk.ac.ebi.reactome.domain.model.DatabaseObject;
import uk.ac.ebi.reactome.service.DatabaseObjectService;
import uk.ac.ebi.reactome.service.GenericService;
import uk.ac.ebi.reactome.service.helper.Node;
import uk.ac.ebi.reactome.service.util.DatabaseObjectUtils;

/**
 * Created by:
 *
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @since 10.02.16.
 */
@Controller
@RequestMapping("")
class GraphController {

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
                                           @RequestParam(required = true) Integer page,
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

}