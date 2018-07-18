package org.reactome.server.controller;

import io.swagger.annotations.ApiParam;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
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
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.cleanReceivedParameter;

@Controller
class IconLibraryController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final int rowCount = 28;
    private static final String TITLE = "title";
    private static final String PAGE = "page";
    private static final String MAX_PAGE = "maxpage";
    private static final String PAGE_NO_RESULTS_FOUND = "search/noResultsFound";

    private SearchService searchService;

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
        model.addAttribute("icons", aa.getIconGroupFacet());
        model.addAttribute("totalIcons", aa.getTotalNumFount());
        return "icon/folders";
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
            String folderDisplay = StringUtils.capitalize(cleanFolder).replaceAll("_", " ");

            Query queryObject = new Query("{!term f=iconGroup}" + cleanFolder, null, null, null, null);
            Result result = searchService.getIconsResult(queryObject, rowCount, page);

            model.addAttribute(TITLE, folderDisplay);
            model.addAttribute("iconLibDir", iconLibDir);
            model.addAttribute("folder", cleanFolder);
            model.addAttribute("folderDisplay", folderDisplay);
            model.addAttribute("total", result.getEntriesCount());
            model.addAttribute("entries", result.getEntries().stream().sorted((e1, e2) -> e1.getName().compareToIgnoreCase(e2.getName())).collect(Collectors.toList()));
            model.addAttribute(PAGE, page);
            model.addAttribute(MAX_PAGE, (int) Math.ceil((double) result.getEntriesCount() / rowCount));

            return "icon/icons";
        }
        infoLogger.info("Icon group {} doesn't exist", folder);
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return PAGE_NO_RESULTS_FOUND;
    }

    @RequestMapping(value = "/detail/icon/{name}", method = RequestMethod.GET)
    public String iconDetails(@PathVariable(name = "name") String name,
                              ModelMap model,
                              HttpServletResponse response) throws SolrSearcherException {
        String query = cleanReceivedParameter(name);
        if (StringUtils.isNotEmpty(query)) {
            Query queryObject = new Query(query, null, null, null, null);
            Entry iconEntry = searchService.getIcon(queryObject);
            model.addAttribute(TITLE, iconEntry.getIconName());
            model.addAttribute("entry", iconEntry);
            return "icon/details";
        }

        infoLogger.info("Icon {} was NOT found", query);
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return PAGE_NO_RESULTS_FOUND;
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
}
