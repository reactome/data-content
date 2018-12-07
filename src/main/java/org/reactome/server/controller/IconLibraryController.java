package org.reactome.server.controller;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
import org.reactome.server.graph.service.DetailsService;
import org.reactome.server.graph.service.helper.PathwayBrowserNode;
import org.reactome.server.search.domain.*;
import org.reactome.server.search.exception.SolrSearcherException;
import org.reactome.server.search.service.SearchService;
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
    private static final String CATEGORY = "category";
    private static final String CATEGORIES = "categories";
    private static final String REFERENCES = "references";
    private static final String PWB_TREE = "pwbTree";
    private static final String URL_MAPPING = "urlMapping";
    private static final String ICON_SEARCH = "iconsSearch";

    private static final int ICONS_PER_PAGE = 28;

    // PAGES
    private static final String ICONS_LIBRARY_ENTRY_PAGE = "icon/library";
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
        urlMapping.put("UBERON", "https://www.ebi.ac.uk/ols/ontologies/uberon/terms?iri=http://purl.obolibrary.org/obo/UBERON_###ID###");
        urlMapping.put("RFAM", "http://rfam.org/family/###ID###");
        urlMapping.put("PFAM", "http://pfam.xfam.org/family/###ID###");
        urlMapping.put("CL", "http://purl.obolibrary.org/obo/CL_###ID###");
        urlMapping.put("MESH", "https://www.ncbi.nlm.nih.gov/mesh/###ID###");
        urlMapping.put("PUBCHEM", "https://pubchem.ncbi.nlm.nih.gov/compound/###ID###");
        urlMapping.put("OMIT", "https://www.ebi.ac.uk/ols/ontologies/omit/terms?iri=http://purl.obolibrary.org/obo/OMIT_###ID###");
        urlMapping.put("INTERPRO", "https://www.ebi.ac.uk/interpro/entry/###ID###");
        urlMapping.put("KEGG", "https://www.kegg.jp/entry/###ID###");
        urlMapping.put("ENA", "https://www.ebi.ac.uk/ena/data/view/###ID###");
        urlMapping.put("SO", "http://www.sequenceontology.org/browser/current_svn/term/SO:###ID###");
        urlMapping.put("BTO", "http://purl.obolibrary.org/obo/BTO_###ID###");
    }

    private SearchService searchService;
    private DetailsService detailsService;

    @RequestMapping(value = "/icon-lib", method = RequestMethod.GET)
    public String iconsHomePage(ModelMap model) throws SolrSearcherException {
        FacetMapping facetMapping = searchService.getIconFacetingInformation();
        List<FacetContainer> available = facetMapping.getIconCategoriesFacet().getAvailable();
        for (FacetContainer facetContainer : available) {
            facetContainer.setName(StringUtils.capitalize(facetContainer.getName()).replaceAll("_", " "));
        }
        available.sort(Comparator.comparing(FacetContainer::getName));
        model.addAttribute(TITLE, "Icon Library");
        model.addAttribute(ICONS, facetMapping.getIconCategoriesFacet());
        model.addAttribute(TOTAL_ICONS, facetMapping.getTotalNumFount());
        model.addAttribute(ICON_SEARCH, true);
        return ICONS_LIBRARY_ENTRY_PAGE;
    }

    @RequestMapping(value = "/icon-lib/{category}", method = RequestMethod.GET)
    public String listCategories(@PathVariable(name = "category") String categoryParam,
                                 @RequestParam(required = false) Integer page,
                                 ModelMap model,
                                 HttpServletResponse response) throws SolrSearcherException {

        if (page == null || page == 0) page = 1;

        String cleanCategoryParam = cleanReceivedParameter(categoryParam);
        if (StringUtils.isNotEmpty(cleanCategoryParam)) {
            cleanCategoryParam = cleanCategoryParam.toLowerCase().replaceAll("\\s+", "_");
            String formattedCategory = StringUtils.capitalize(cleanCategoryParam).replaceAll("_", " ");

            Query queryObject = new Query("{!term f=iconCategories}" + cleanCategoryParam, null, null, null, null);
            Result result = searchService.getIconsResult(queryObject, ICONS_PER_PAGE, page);

            model.addAttribute(TITLE, formattedCategory);
            model.addAttribute(CATEGORY, formattedCategory);
            model.addAttribute(TOTAL_ICONS, result.getEntriesCount());
            model.addAttribute(ENTRIES, result.getEntries().stream().sorted((e1, e2) -> e1.getName().compareToIgnoreCase(e2.getName())).collect(Collectors.toList()));
            model.addAttribute(ICON_SEARCH, true);
            model.addAttribute(PAGE, page);
            model.addAttribute(MAX_PAGE, (int) Math.ceil((double) result.getEntriesCount() / ICONS_PER_PAGE));

            return ICONS_PAGE;
        }

        infoLogger.info("Icon group {} doesn't exist", cleanCategoryParam);
        model.addAttribute("q", cleanCategoryParam);
        model.addAttribute(TITLE, "Icon category not found");
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return PAGE_NO_ICON_FOUND;
    }

    /**
     * This method is called in the Details Controller directly. Same RequestMapping has to be used to map the icons.
     */
    String iconDetails(String identifier,
                              ModelMap model,
                              HttpServletResponse response) throws SolrSearcherException {
        String query = cleanReceivedParameter(identifier);
        if (StringUtils.isNotEmpty(query)) {
            Query queryObject = new Query(query, null, null, null, null);
            Entry iconEntry = searchService.getIcon(queryObject);
            if (iconEntry != null) {
                model.addAttribute(URL_MAPPING, urlMapping);
                model.addAttribute(TITLE, iconEntry.getIconName());
                model.addAttribute(ENTRY, iconEntry);
                // capitalise and remove underline for all categories
                model.addAttribute(CATEGORIES, iconEntry.getIconCategories().stream().map(WordUtils::capitalize).map(cat -> cat.replaceAll("_", " ")).collect(Collectors.toList()));

                if (iconEntry.getIconReferences() != null) {
                    model.addAttribute(REFERENCES, prepareReferences(iconEntry));
                }

                List<Set<PathwayBrowserNode>> ehldPwbTree = new ArrayList<>();
                if (iconEntry.getIconEhlds() != null && !iconEntry.getIconCategories().contains("arrow")) {
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

    @Autowired
    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }

    @Autowired
    public void setDetailsService(DetailsService detailsService) {
        this.detailsService = detailsService;
    }
}
