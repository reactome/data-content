package org.reactome.server.util;

import org.reactome.server.search.domain.Entry;
import org.reactome.server.search.service.SearchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * This class runs a separated thread whilst initialising the Application and caches
 * Icon References and Icon path.
 *
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
@Component
public class IconPhysicalEntityCache {
    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static Map<String, String> iconsMapping = new HashMap<>();
    private SearchService searchService;

    public static Map<String, String> getIconsMapping() {
        return iconsMapping;
    }

    @PostConstruct
    public void init() {
        (new Thread(() -> {
            try {
                List<Entry> entries = searchService.getAllIcons();
                for (Entry entry : entries) {
                    List<String> refs = entry.getIconReferences();
                    if (refs != null) {
                        for (String ref : refs) {
                            iconsMapping.put(ref, entry.getStId());
                        }
                    }
                }
            } catch (Exception e) {
                infoLogger.warn("Could not cache icons and their references");
            }
        }, "DC-" + IconPhysicalEntityCache.class.getSimpleName())).start();
    }

    @Autowired
    public void setSearchService(SearchService searchService) {
        this.searchService = searchService;
    }
}
