package org.reactome.server.controller;

import io.swagger.annotations.ApiParam;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.reactome.server.graph.service.DetailsService;
import org.reactome.server.graph.service.helper.PathwayBrowserNode;
import org.reactome.server.search.domain.*;
import org.reactome.server.search.exception.SolrSearcherException;
import org.reactome.server.search.service.SearchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.cleanReceivedParameter;

@Controller
class IconLibraryController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");

    // PAGE VARIABLES
    private static final String TITLE = "title";
    private static final String ENTRY = "entry";
    private static final String ICONS = "icons";
    private static final String TOTAL_ICONS = "totalIcons";
    private static final String ENTRIES = "entries";
    private static final String FOLDER = "folder";
    private static final String GROUP = "group";
    private static final String REFERENCES = "references";
    private static final String PWB_TREE = "pwbTree";
    private static final String URL_MAPPING = "urlMapping";
    private static final String ICON_SEARCH = "iconsSearch";

    private static final int ROW_COUNT = 28;

    // PAGES
    private static final String ICONS_FOLDER_PAGE = "icon/folders";
    private static final String ICONS_PAGE = "icon/icons";
    private static final String ICONS_DETAILS = "icon/details";
    private static final String PAGE_NO_ICON_FOUND = "search/noIconFound";
    private static final String PAGE = "page";
    private static final String MAX_PAGE = "maxpage";
    private static Map<String, String> urlMapping = new HashMap<>();

    static {
        urlMapping.put("UNIPROT", "http://www.uniprot.org/entry/###ID###");
        urlMapping.put("UNIPROTKB", "http://www.uniprot.org/entry/###ID###");
        urlMapping.put("CHEBI", "http://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:###ID###");
        urlMapping.put("ENSEMBL", "http://www.ensembl.org/Homo_sapiens/geneview?gene=###ID###");
        urlMapping.put("GO", "http://www.ebi.ac.uk/ego/QuickGO?mode=display&entry=GO:###ID###");
    }

    private SearchService searchService;
    private DetailsService detailsService;
    @Value("${icons.lib.dir}")
    private String iconLibDir; // E

    @RequestMapping(value = "/icon-lib", method = RequestMethod.GET)
    public String iconsHomePage(ModelMap model) throws SolrSearcherException {
        FacetMapping aa = searchService.getIconFacetingInformation();
        List<FacetContainer> ff = aa.getIconGroupFacet().getAvailable();
        for (FacetContainer facetContainer : ff) {
            facetContainer.setName(StringUtils.capitalize(facetContainer.getName()).replaceAll("_", " "));
        }
        ff.sort(Comparator.comparing(FacetContainer::getName));
        model.addAttribute(TITLE, "Icon Library");
        model.addAttribute(ICONS, aa.getIconGroupFacet());
        model.addAttribute(TOTAL_ICONS, aa.getTotalNumFount());
        model.addAttribute(ICON_SEARCH, true);
        return ICONS_FOLDER_PAGE;
    }

    @RequestMapping(value = "/icon-lib/{folder}", method = RequestMethod.GET)
    public String listIcons(@PathVariable(name = "folder") String folder,
                            @RequestParam(required = false) Integer page,
                            ModelMap model,
                            HttpServletResponse response) throws SolrSearcherException {

        if (page == null || page == 0) page = 1;

        String cleanFolder = cleanReceivedParameter(folder);

        if (StringUtils.isNotEmpty(cleanFolder)) {
            cleanFolder = cleanFolder.toLowerCase().replaceAll("\\s+", "_");
            String group = StringUtils.capitalize(cleanFolder).replaceAll("_", " ");

            Query queryObject = new Query("{!term f=iconGroup}" + cleanFolder, null, null, null, null);
            Result result = searchService.getIconsResult(queryObject, ROW_COUNT, page);

            model.addAttribute(TITLE, group);
            model.addAttribute(FOLDER, cleanFolder);
            model.addAttribute(GROUP, group);
            model.addAttribute(TOTAL_ICONS, result.getEntriesCount());
            model.addAttribute(ENTRIES, result.getEntries().stream().sorted((e1, e2) -> e1.getName().compareToIgnoreCase(e2.getName())).collect(Collectors.toList()));
            model.addAttribute(ICON_SEARCH, true);
            model.addAttribute(PAGE, page);
            model.addAttribute(MAX_PAGE, (int) Math.ceil((double) result.getEntriesCount() / ROW_COUNT));

            return ICONS_PAGE;
        }

        infoLogger.info("Icon group {} doesn't exist", folder);
        model.addAttribute("q", folder);
        model.addAttribute(TITLE, "Icon group not found");
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return PAGE_NO_ICON_FOUND;
    }

    @RequestMapping(value = "/detail/icon/{name}", method = RequestMethod.GET)
    public String iconDetails(@PathVariable(name = "name") String name,
                              ModelMap model,
                              HttpServletResponse response) throws SolrSearcherException {
        String query = cleanReceivedParameter(name);
        if (StringUtils.isNotEmpty(query)) {
            Query queryObject = new Query(query, null, null, null, null);
            Entry iconEntry = searchService.getIcon(queryObject);
            if (iconEntry != null) {
                model.addAttribute(URL_MAPPING, urlMapping);
                model.addAttribute(TITLE, iconEntry.getIconName());
                model.addAttribute(ENTRY, iconEntry);
                model.addAttribute(GROUP, StringUtils.capitalize(iconEntry.getIconGroup().replaceAll("_", " ")));

                if (iconEntry.getIconReferences() != null) {
                    model.addAttribute(REFERENCES, prepareReferences(iconEntry));
                }

                List<Set<PathwayBrowserNode>> ehldPwbTree = new ArrayList<>();
                if (iconEntry.getIconEhlds() != null && !iconEntry.getIconGroup().equalsIgnoreCase("arrows")) {
                    Set<PathwayBrowserNode> nodes = detailsService.getLocationInPathwayBrowserForPathways(iconEntry.getIconEhlds());
                    ehldPwbTree.add(nodes.stream().sorted().collect(Collectors.toCollection(LinkedHashSet::new)));
                }
                model.addAttribute(PWB_TREE, ehldPwbTree);
                return ICONS_DETAILS;
            }
        }

        infoLogger.info("Icon {} was NOT found", query);
        model.addAttribute("q", query);
        model.addAttribute(TITLE, "Icon not found");
        model.addAttribute(ICON_SEARCH, true);
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return PAGE_NO_ICON_FOUND;
    }

    private Map<String, Set<String>> prepareReferences(Entry iconEntry) {
        Map<String, Set<String>> ret = new HashMap<>();

        List<String> crossRefs = iconEntry.getIconReferences();
        for (String xref : crossRefs) {
            if (xref.contains(":")) {
                String db = xref.split(":")[0];
                String identifier = xref.split(":")[1];
                if (!ret.containsKey(db)) {
                    ret.put(db, new HashSet<>());
                }
                ret.get(db).add(identifier);
            }
        }
        return ret;
    }

    @RequestMapping(value = "/icon-lib/download/{name}.{ext:.*}", method = RequestMethod.GET)
    @ResponseBody
    public String downloadIcon(@PathVariable String name,
                               @ApiParam(value = "File extension (defines the image format)", required = true, defaultValue = "svg", allowableValues = "png,svg,emf")
                               @PathVariable String ext,
                               ModelMap model,
                               HttpServletResponse response) throws SolrSearcherException, IOException {

        Entry iconEntry = null;
        String query = cleanReceivedParameter(name);
        if (StringUtils.isNotEmpty(query)) {
            Query queryObject = new Query(name, null, null, null, null);
            iconEntry = searchService.getIcon(queryObject);
        }

        if (iconEntry == null) {
            // Generating spell check suggestions if no faceting information was found, while using no filters
            model.addAttribute("suggestions", searchService.getSpellcheckSuggestions(name));
            return "search/noResultsFound";
        }

        String type;
        switch (ext) {
            case "svg":
                type = "application/svg";
                break;
            case "emf":
                type = "application/emf";
                break;
            case "png":
                type = "image/png";
                break;
            default:
                throw new IllegalArgumentException("Invalid extension");
        }

        String iconFullPath = iconLibDir + "/" + iconEntry.getIconGroup() + "/" + iconEntry.getIconName() + "." + ext;
        File iconFile = new File(iconFullPath);
        if (!iconFile.exists()) return "";

        response.setContentType(type);
        response.setStatus(HttpServletResponse.SC_OK);
        response.addHeader("Cache-Control", "public"); // needed for internet explorer
        response.addHeader("Content-Encoding", "none");
        response.addHeader("Content-Disposition", "attachment; filename=" + iconEntry.getIconName() + "." + ext);

        OutputStream out = response.getOutputStream();
        FileInputStream in = new FileInputStream(iconFile);
        IOUtils.copy(in, out);
        out.flush();
        out.close();
        in.close();

        return "";
    }

    @Autowired
    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }

    @Autowired
    public void setDetailsService(DetailsService detailsService) {
        this.detailsService = detailsService;
    }
}
