package org.reactome.server.controller;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.reactome.server.tools.interactors.model.Interaction;
import org.reactome.server.tools.interactors.model.InteractionDetails;
import org.reactome.server.tools.interactors.model.InteractorResource;
import org.reactome.server.tools.interactors.service.InteractorResourceService;
import org.reactome.server.tools.interactors.util.InteractorConstant;
import org.reactome.server.tools.interactors.util.Toolbox;
import org.reactome.server.tools.search.domain.*;
import org.reactome.server.tools.search.exception.EnricherException;
import org.reactome.server.tools.search.exception.SolrSearcherException;
import org.reactome.server.tools.search.service.SearchService;
import org.reactome.server.util.MailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Spring WEB Controller
 *
 * @author Florian Korninger (fkorn@ebi.ac.uk)
 * @version 1.0
 */
@SuppressWarnings("SameReturnValue")
@Controller
@RequestMapping("")
class SearchController {

    @Autowired
    private SearchService searchService;

    @Autowired
    private MailService mailService;

    private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

    private static String defaultSubject;
    private static final int rowCount = 30;
    private Map<Long, InteractorResource> interactorResourceMap = new HashMap<>();

    private static final String SPECIES_FACET = "species_facet";
    private static final String TYPES_FACET = "type_facet";
    private static final String KEYWORDS_FACET = "keyword_facet";
    private static final String COMPARTMENTS_FACET = "compartment_facet";

    private static final String Q = "q";
    private static final String SPECIES = "species";
    private static final String TYPES = "types";
    private static final String KEYWORDS = "keywords";
    private static final String COMPARTMENTS = "compartments";

    private static final String TITLE = "title";
    private static final String ENTRY = "entry";
    private static final String GROUPED_RESULT = "groupedResult";
    private static final String SUGGESTIONS = "suggestions";
    private static final String PAGE = "page";
    private static final String MAX_PAGE = "maxpage";
    private static final String CLUSTER = "cluster";

    private static final String MAIL_SUBJECT = "subject";
    private static final String MAIL_SUBJECT_PLACEHOLDER = "[SEARCH] No results found for ";
    private static final String MAIL_MESSAGE = "message";

    private static final String INTERACTOR_RESOURCES_MAP = "interactorResourceMap";
    private static final String EVIDENCES_URL_MAP = "evidencesUrlMap";

    // PAGES REDIRECT
    private static final String PAGE_DETAIL = "search/detail";
    private static final String PAGE_INTERACTOR = "search/interactor";

    private static final String PAGE_NO_DETAILS_FOUND = "search/nodetailsfound";
    private static final String PAGE_NO_RESULTS_FOUND = "search/noresultsfound";
    private static final String PAGE_EBI_ADVANCED = "search/ebiadvanced";
    private static final String PAGE_EBI_SEARCHER = "search/ebisearcher";

    @Value("${mail_error_dest}")
    private String mailErrorDest; // E

    @Value("${mail_support_dest}")
    private String mailSupportDest; // W

    @Autowired
    private InteractorResourceService interactorResourceService;

    /**
     * Method for autocompletion
     *
     * @param tagName query snippet to be autocompleted
     * @return List of Suggestions
     * @throws SolrSearcherException
     */
    @RequestMapping(value = "/getTags", method = RequestMethod.GET)
    @ResponseBody
    public List<String> getTags(@RequestParam String tagName) throws SolrSearcherException {
        return searchService.getAutocompleteSuggestions(tagName);
    }

    /**
     * Loads data for advanced view and displays advanced view
     *
     * @param model SpringModel
     * @return Advanced view
     * @throws SolrSearcherException
     */
    @RequestMapping(value = "/advanced", method = RequestMethod.GET)
    public String gotoAdv(ModelMap model) throws SolrSearcherException {
        FacetMapping facetMapping = searchService.getTotalFacetingInformation();
        model.addAttribute(SPECIES_FACET, facetMapping.getSpeciesFacet());
        model.addAttribute(TYPES_FACET, facetMapping.getTypeFacet());
        model.addAttribute(KEYWORDS_FACET, facetMapping.getKeywordFacet());
        model.addAttribute(COMPARTMENTS_FACET, facetMapping.getCompartmentFacet());
        model.addAttribute(TITLE, "advanced Search");
        return PAGE_EBI_ADVANCED;
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

        cacheInteractorResources();
        EnrichedEntry entry = searchService.getEntryById(id);
        if (entry != null) {
            model.addAttribute(ENTRY, entry);
            model.addAttribute(TITLE, entry.getName());
            model.addAttribute(INTERACTOR_RESOURCES_MAP, interactorResourceMap); // interactor URL
            model.addAttribute(EVIDENCES_URL_MAP, prepareEvidencesURLs(entry.getInteractionList())); // evidencesURL
            return PAGE_DETAIL;
        } else {
            autoFillDetailsPage(model, id);
            return PAGE_NO_DETAILS_FOUND;
        }
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
    @RequestMapping(value = "/detail/interactor/{id:.*}", method = RequestMethod.GET)
    public String interactorDetail(@PathVariable String id, ModelMap model) throws EnricherException, SolrSearcherException {

        InteractorEntry entry = searchService.getInteractionDetail(id);
        if (entry != null) {
            model.addAttribute(ENTRY, entry);
            model.addAttribute(TITLE, entry.getName());
            return PAGE_INTERACTOR;
        } else {
            autoFillDetailsPage(model, id);
            return PAGE_NO_DETAILS_FOUND;
        }
    }

    /**
     * spellcheck has to be applied after faceting search because dictionary can not contain 100% all index info
     *
     * @param q,species,types,compartments,keywords parameters to save existing query and facets
     * @param page                                  page number
     * @param model                                 SpringModel
     * @return main search result page
     * @throws SolrSearcherException
     */
    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String search(@RequestParam String q,
                         @RequestParam(required = false) List<String> species,
                         @RequestParam(required = false) List<String> types,
                         @RequestParam(required = false) List<String> keywords,
                         @RequestParam(required = false) List<String> compartments,
                         @RequestParam(required = false) Boolean cluster,
                         @RequestParam(required = false) Integer page,
                         ModelMap model) throws SolrSearcherException {

        if (q != null && !q.isEmpty()) {
            if (cluster == null) cluster = false;
            if (page == null || page == 0) page = 1;

            q = cleanReceivedParameter(q);
            species = cleanReceivedParameters(species);
            types = cleanReceivedParameters(types);
            keywords = cleanReceivedParameters(keywords);
            compartments = cleanReceivedParameters(compartments);

            model.addAttribute(Q, q);
            model.addAttribute(TITLE, "Search results for " + q);
            model.addAttribute(SPECIES, species);
            model.addAttribute(TYPES, types);
            model.addAttribute(COMPARTMENTS, compartments);
            model.addAttribute(KEYWORDS, keywords);
            model.addAttribute(CLUSTER, cluster);
            model.addAttribute(CLUSTER, cluster);
            model.addAttribute(PAGE, page);

            Query queryObject = new Query(q, species, types, compartments, keywords);
            SearchResult searchResult = searchService.getSearchResult(queryObject, rowCount, page, cluster);

            if (searchResult != null) {
                model.addAttribute(SPECIES_FACET, searchResult.getFacetMapping().getSpeciesFacet());
                model.addAttribute(TYPES_FACET, searchResult.getFacetMapping().getTypeFacet());
                model.addAttribute(KEYWORDS_FACET, searchResult.getFacetMapping().getKeywordFacet());
                model.addAttribute(COMPARTMENTS_FACET, searchResult.getFacetMapping().getCompartmentFacet());
                model.addAttribute(MAX_PAGE, (int) Math.ceil(searchResult.getResultCount() / searchResult.getRows()));
                model.addAttribute(GROUPED_RESULT, searchResult.getGroupedResult());
                return PAGE_EBI_SEARCHER;
            } else {
                // Generating spell check suggestions if no faceting information was found, while using no filters
                model.addAttribute(SUGGESTIONS, searchService.getSpellcheckSuggestions(q));
            }
        }
        autoFillContactForm(model, q);
        return PAGE_NO_RESULTS_FOUND;
    }

    @RequestMapping(value = "/contact", method = RequestMethod.POST)
    @ResponseBody
    public String contact(@RequestParam String contactName,
                          @RequestParam String mailAddress,
                          @RequestParam(required = false, defaultValue = "false") Boolean sendEmailCopy,
                          @RequestParam String message,
                          @RequestParam String exception,
                          @RequestParam String url,
                          @RequestParam String source) throws Exception {

        String to = mailSupportDest;
        if (source.equals("E")) {
            to = mailErrorDest;
            message = message.concat("\n\n URL: " + url);
            message = message.concat("\n\n Exception: " + exception);
            defaultSubject = "Unexpected error occurred.";
        }
        message = message.concat("--\n").concat(contactName);
        // Call email service.
        mailService.send(to, mailAddress, defaultSubject, message, sendEmailCopy);
        return "success";
    }

    private String cleanReceivedParameter(String param) {
        if (param != null && !param.isEmpty()) {
            return Jsoup.clean(param, Whitelist.basic());
        }
        return null;
    }

    private List<String> cleanReceivedParameters(List<String> list) {
        if (list != null && !list.isEmpty()) {
            List<String> checkedList = new ArrayList<>();
            for (String output : list) {
                checkedList.add(cleanReceivedParameter(output));
            }
            return checkedList;
        }
        return null;
    }

    private void autoFillContactForm(ModelMap model, String search) {

        final String MAIL_MESSAGE_PLACEHOLDER = "Dear help desk,\n\nI've searched for \"%s\" and couldn't find it.\n\nThank you.\n\n";
        model.addAttribute(Q, search);
        try {
            List<String> suggestions = searchService.getSpellcheckSuggestions(search);
            model.addAttribute(SUGGESTIONS, suggestions);
        } catch (SolrSearcherException e) {
            logger.error("Error building suggestions on autoFillContactForm.");
        }
        defaultSubject = MAIL_SUBJECT_PLACEHOLDER + search;
        model.addAttribute(MAIL_SUBJECT, defaultSubject);
        model.addAttribute(MAIL_MESSAGE, String.format(MAIL_MESSAGE_PLACEHOLDER, search));
        model.addAttribute(TITLE, "No results found for " + search);
    }

    private void autoFillDetailsPage(ModelMap model, String search) {
        model.addAttribute("search", search);
        model.addAttribute(TITLE, "No details found for " + search);
    }

    /**
     * These resources are the same all the time.
     * In order to speed up the query result and less memory usage, I decided to keep the resource out of the query
     * and keep a cache with them. Thus we avoid having the same information for all result.
     * <p>
     * This method set the map class attribute.
     */
    private void cacheInteractorResources() {
        try {
            interactorResourceMap = interactorResourceService.getAllMappedById();
        } catch (SQLException e) {
            logger.error("An error has occurred while querying InteractorResource: " + e.getMessage(), e);
        }
    }

    /**
     * Prepare interaction evidences links.
     * Gets all interaction evidences of a given interactor and build the URL
     * Having all this logic in JSTL wouldn't be clear.
     *
     * @return map as accession and the URL
     */
    private Map<String, String> prepareEvidencesURLs(List<Interaction> interactions) {
        Map<String, String> evidencesUrlMap = new HashMap<>();
        List<String> evidenceIds = new ArrayList<>();
        if (interactions != null) {
            for (Interaction interaction : interactions) {
                List<InteractionDetails> evidences = interaction.getInteractionDetailsList();
                for (InteractionDetails evidence : evidences) {
                    evidenceIds.add(evidence.getInteractionAc());
                }

                evidencesUrlMap.put(interaction.getInteractorB().getAcc(), Toolbox.getEvidencesURL(evidenceIds, InteractorConstant.STATIC));
                evidenceIds.clear();
            }
        }

        return evidencesUrlMap;
    }
}
