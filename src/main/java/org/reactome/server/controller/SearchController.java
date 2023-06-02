package org.reactome.server.controller;

import org.apache.commons.lang3.StringUtils;
import org.reactome.server.captcha.HCaptchaResponseV3Handler;
import org.reactome.server.captcha.InvalidHCaptchaTokenException;
import org.reactome.server.graph.service.GeneralService;
import org.reactome.server.orcid.domain.OrcidToken;
import org.reactome.server.orcid.util.OrcidHelper;
import org.reactome.server.search.domain.FacetMapping;
import org.reactome.server.search.domain.Query;
import org.reactome.server.search.domain.SearchResult;
import org.reactome.server.search.domain.TargetResult;
import org.reactome.server.search.exception.SolrSearcherException;
import org.reactome.server.search.service.SearchService;
import org.reactome.server.util.MailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.cleanReceivedParameter;
import static org.reactome.server.util.WebUtils.cleanReceivedParameters;

/**
 * Spring WEB Controller
 *
 * @author Florian Korninger (fkorn@ebi.ac.uk)
 * @version 1.0
 */
@Controller
@PropertySource("classpath:core.properties")
class SearchController {

    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");
    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final int rowCount = 30;
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
    private static final String GROUPED_RESULT = "groupedResult";
    private static final String SUGGESTIONS = "suggestions";
    private static final String PAGE = "page";
    private static final String MAX_PAGE = "maxpage";
    private static final String GROUPED = "grouped";
    private static final String CAPTCHA_SITE_KEY = "captchaSiteKey";
    private static final String MAIL_SUBJECT = "subject";
    private static final String MAIL_SUBJECT_PLACEHOLDER = "No results found for ";
    private static final String MAIL_MESSAGE = "message";
    private static final String PAGE_NO_RESULTS_FOUND = "search/noResultsFound";
    private static final String PAGE_EBI_ADVANCED = "search/advanced";
    private static final String PAGE_EBI_SEARCHER = "search/results";
    private static final String TARGETS = "targets";
    private final Integer releaseNumber;
    private static Pattern stIdPattern;

    private SearchService searchService;
    private MailService mailService;

    private HCaptchaResponseV3Handler captchaHandler;

    @Value("${captcha.site.key}")
    private String captchaSiteKey;

    @Autowired
    public SearchController(GeneralService generalService) {
        releaseNumber = generalService.getDBInfo().getVersion();
        stIdPattern = Pattern.compile("(?i)(^R-[A-Z]{3}-\\d+(-\\d+)?(\\.\\d+)?$)|(^REACT_\\d+(\\.\\d+)?$)");
    }

    /**
     * Method for autocompletion
     *
     * @param tagName query snippet to be autocompleted
     * @return List of Suggestions
     * @throws SolrSearcherException could not query SolR
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
     * @throws SolrSearcherException could not query SolR
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
     * spellcheck has to be applied after faceting search because dictionary can not contain 100% all index info
     *
     * @param q,species,types,compartments,keywords parameters to save existing query and facets
     * @param page                                  page number
     * @param model                                 SpringModel
     * @return main search result page
     * @throws SolrSearcherException could not query SolR
     */
    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String search(@RequestParam String q,
                         @RequestParam(required = false) List<String> species,
                         @RequestParam(required = false) List<String> types,
                         @RequestParam(required = false) List<String> keywords,
                         @RequestParam(required = false) List<String> compartments,
                         @RequestParam(required = false) Boolean cluster,
                         @RequestParam(required = false) Integer page,
                         ModelMap model,
                         HttpServletRequest request,
                         HttpServletResponse response) throws SolrSearcherException {

        if (q != null && !q.isEmpty()) {
            if (q.length() >= 50) return PAGE_NO_RESULTS_FOUND;
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
            model.addAttribute(GROUPED, cluster);
            model.addAttribute(PAGE, page);

            String stIdMatch = null;
            Matcher matcher = stIdPattern.matcher(q);
            if (matcher.matches()) {
                stIdMatch = "oldStId:" + q + " OR stId:" + q;
            }

            Query queryObject = new Query.Builder(q)
                    .forSpecies(species)
                    .withTypes(types)
                    .withKeywords(keywords)
                    .inCompartments(compartments)
                    .withReportInfo(getReportInformation(request))
                    .build();

            if (stIdMatch != null) {
                queryObject.setQuery(stIdMatch);
            }

            SearchResult searchResult = searchService.getSearchResult(queryObject, rowCount, page, cluster);
            if (searchResult != null && (searchResult.getTargetResults() == null || searchResult.getTargetResults().isEmpty())) {
                FacetMapping facetMapping = searchResult.getFacetMapping();
                model.addAttribute(SPECIES_FACET, facetMapping.getSpeciesFacet());
                model.addAttribute(TYPES_FACET, facetMapping.getTypeFacet());
                model.addAttribute(KEYWORDS_FACET, facetMapping.getKeywordFacet());
                model.addAttribute(COMPARTMENTS_FACET, facetMapping.getCompartmentFacet());
                model.addAttribute(MAX_PAGE, (int) Math.ceil(searchResult.getResultCount() / searchResult.getRows()));
                model.addAttribute(GROUPED_RESULT, searchResult.getGroupedResult());
                if (searchResult.getGroupedResult() == null || searchResult.getGroupedResult().getRowCount() == 0) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                infoLogger.info("Search request for query: {} was found", q);

                return PAGE_EBI_SEARCHER;
            } else {
                // Generating spell check suggestions if no faceting information was found, while using no filters
                model.addAttribute(SUGGESTIONS, searchService.getSpellcheckSuggestions(q));
            }

            if (searchResult != null && !searchResult.getTargetResults().isEmpty()) {
                model.addAttribute(TARGETS, searchResult.getTargetResults().stream().filter(TargetResult::isTarget).map(TargetResult::getTerm).collect(Collectors.toList()));
            }
        }

        model.addAttribute(CAPTCHA_SITE_KEY, captchaSiteKey);
        autoFillContactForm(model, q);
        infoLogger.info("Search request for query: {} was NOT found", q);
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return PAGE_NO_RESULTS_FOUND;
    }

    @RequestMapping(value = "/contact", method = RequestMethod.POST)
    @ResponseBody
    public String contact(@RequestParam String contactName,
                          @RequestParam String mailAddress,
                          @RequestParam String message,
                          @RequestParam String exception,
                          @RequestParam String url,
                          @RequestParam String subject,
                          @RequestParam String source,
                          @RequestParam(value = "h-captcha-response") String captchaResponse,
                          HttpServletRequest request) {
        try {
            float score = captchaResponse == null || captchaResponse.isBlank() ? 0 : captchaHandler.verify(captchaResponse);
            if (score >= 0.5) {
                errorLogger.warn("Captcha blocked /content/contact from " + getReportInformation(request).toString());
                return "failure";
            }
        } catch (InvalidHCaptchaTokenException e) {
            errorLogger.error("Error checking captcha.");
            return "failure";
        }

        if (StringUtils.isNotBlank(contactName)) {
            contactName = contactName.trim();
            message = message.concat("\n\n--\n").concat(contactName.trim());
        }

        subject = String.format("[%s] %s", StringUtils.isEmpty(contactName) ? mailAddress : contactName, subject);
        if (source.equals("E")) {
            subject = "Unexpected error occurred [" + url + "]";
            message = message.concat("\nFailed URL: " + url);
            message = message.concat("\nException: " + exception.replaceAll("##C##", "\n\t\t").replaceAll("#", "\n\t"));
            mailService.error(contactName, mailAddress, subject, message);
        } else if (source.equals("O")) {
            OrcidToken tokenSession = (OrcidToken) request.getSession().getAttribute(OrcidHelper.ORCID_TOKEN);
            if (tokenSession != null) {
                message = message.concat("\n\n----- AUTOMATICALLY ADDED BY THE SERVER -----");
                message = message.concat("\nNAME: " + tokenSession.getName());
                message = message.concat("\nORCID: " + tokenSession.getOrcid());
            }
            mailService.help(contactName, mailAddress, subject, message);
        } else {
            mailService.help(contactName, mailAddress, subject, message);
        }
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

    @Autowired
    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }

    @Autowired
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }

    @Autowired
    public void setCaptchaHandler(HCaptchaResponseV3Handler captchaHandler) {
        this.captchaHandler = captchaHandler;
    }

    /**
     * Extra information to be sent to report service in order to store potential target
     */
    private Map<String, String> getReportInformation(HttpServletRequest request) {
        if (request == null) return null;

        Map<String, String> result = new HashMap<>();
        result.put("user-agent", request.getHeader("User-Agent"));
        String remoteAddr = request.getHeader("X-FORWARDED-FOR"); // Client IP
        if (!StringUtils.isEmpty(remoteAddr)) {
            // The general format of the field is: X-Forwarded-For: client, proxy1, proxy2 ... we only want the client
            remoteAddr = new StringTokenizer(remoteAddr, ",").nextToken().trim();
        } else {
            remoteAddr = request.getRemoteAddr();
        }

        result.put("ip-address", remoteAddr);
        result.put("release-version", releaseNumber.toString());

        return result;
    }
}
