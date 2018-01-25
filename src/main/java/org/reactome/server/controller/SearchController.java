package org.reactome.server.controller;

import org.apache.commons.lang.StringUtils;
import org.reactome.server.search.domain.FacetMapping;
import org.reactome.server.search.domain.InteractorEntry;
import org.reactome.server.search.domain.Query;
import org.reactome.server.search.domain.SearchResult;
import org.reactome.server.search.exception.SolrSearcherException;
import org.reactome.server.search.service.SearchService;
import org.reactome.server.util.MailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.reactome.server.util.WebUtils.cleanReceivedParameter;
import static org.reactome.server.util.WebUtils.cleanReceivedParameters;

/**
 * Spring WEB Controller
 *
 * @author Florian Korninger (fkorn@ebi.ac.uk)
 * @version 1.0
 */
@Controller
class SearchController {

    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");
    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");

    private SearchService searchService;
    private MailService mailService;

    private static final int rowCount = 30;
   // private Map<Long, InteractorResource> interactorResourceMap = new HashMap<>();

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

    // PAGES REDIRECT
    private static final String PAGE_INTERACTOR = "search/interactors";

    private static final String PAGE_NO_DETAILS_FOUND = "search/noDetailsFound";
    private static final String PAGE_NO_RESULTS_FOUND = "search/noResultsFound";
    private static final String PAGE_EBI_ADVANCED = "search/advanced";
    private static final String PAGE_EBI_SEARCHER = "search/results";

    @Value("${mail.error.dest}")
    private String mailErrorDest; // E

    @Value("${mail.support.dest}")
    private String mailSupportDest; // W

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
        model.addAttribute(TITLE, "Advanced Search");
        return PAGE_EBI_ADVANCED;
    }

    /**
     * Shows detailed information of an entry
     *
     * @param id    StId or DbId
     * @param model SpringModel
     * @return Detailed page
     * @throws SolrSearcherException
     */
    @RequestMapping(value = "/detail/interactor/{id:.*}", method = RequestMethod.GET)
    public String interactorDetail(@PathVariable String id, ModelMap model) throws SolrSearcherException {

        InteractorEntry entry = searchService.getInteractionDetail(id);
        if (entry != null) {
            model.addAttribute(ENTRY, entry);
            model.addAttribute(TITLE, entry.getName());
            infoLogger.info("Search request for id: {} was found", id);
            return PAGE_INTERACTOR;
        } else {
            autoFillDetailsPage(model, id);
            infoLogger.info("Search request for id: {} was not found", id);
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
                infoLogger.info("Search request for query: {} was found", q);
                return PAGE_EBI_SEARCHER;
            } else {
                // Generating spell check suggestions if no faceting information was found, while using no filters
                model.addAttribute(SUGGESTIONS, searchService.getSpellcheckSuggestions(q));
            }
        }
        autoFillContactForm(model, q);
        infoLogger.info("Search request for query: {} was NOT found", q);
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
                          @RequestParam String subject,
                          @RequestParam String source) throws Exception {

        String to = mailSupportDest;
        if (source.equals("E")) {
            to = mailErrorDest;
            message = message.concat("\n\n URL: " + url);
            message = message.concat("\n\n Exception: " + exception);
            subject = "Unexpected error occurred.";
        }
        if(StringUtils.isNotBlank(contactName)) {
            contactName = contactName.trim();
            message = message.concat("--\n").concat(contactName.trim());
        }
        // Call email service.
        mailService.send(to, mailAddress, subject, message, sendEmailCopy, contactName);
        return "success";
    }

    private void autoFillContactForm(ModelMap model, String search) {
        final String MAIL_MESSAGE_PLACEHOLDER = "Dear help desk,\n\nI've searched for \"%s\" and couldn't find it.\n\nThank you for contacting us!\nWe will try to get back to you as soon as possible.\n\nNOTE: This is an automatically generated message.\n\n";
        model.addAttribute(Q, search);
        try {
            List<String> suggestions = searchService.getSpellcheckSuggestions(search);
            model.addAttribute(SUGGESTIONS, suggestions);
        } catch (SolrSearcherException e) {
            errorLogger.error("Error building suggestions on autoFillContactForm.");
        }
        model.addAttribute(MAIL_SUBJECT, MAIL_SUBJECT_PLACEHOLDER + search);
        model.addAttribute(MAIL_MESSAGE, String.format(MAIL_MESSAGE_PLACEHOLDER, search));
        model.addAttribute(TITLE, "No results found for " + search);
    }

    private void autoFillDetailsPage(ModelMap model, String search) {
        model.addAttribute("search", search);
        model.addAttribute(TITLE, "No details found for " + search);
    }

    @Autowired
    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }

    @Autowired
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }

}
