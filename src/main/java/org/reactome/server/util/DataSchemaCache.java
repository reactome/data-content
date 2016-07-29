package org.reactome.server.util;

import org.reactome.server.graph.service.GeneralService;
import org.reactome.server.graph.service.helper.SchemaNode;
import org.reactome.server.graph.service.util.DatabaseObjectUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Graph Schema page takes very long to load the first time, this happens because we
 * are caching the whole DataSchema Tree and number. Then this value is cached.
 * This class runs a separated thread whilst initialising the Application and cache the tree.
 * Thus, the loading time won't take long anymore.
 *
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */
@Component
public class DataSchemaCache {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");

    private static SchemaNode classBrowserCache = null;

    @Autowired
    private GeneralService generalService;

    @PostConstruct
    public void queryPsicquicResources() {
        (new Thread(){
            @Override
            public void run() {
                try {
                    if (classBrowserCache == null) {
                        classBrowserCache = DatabaseObjectUtils.getGraphModelTree(generalService.getSchemaClassCounts());
                    }
                } catch (ClassNotFoundException e) {
                    infoLogger.warn("Could not cache the Graph Model Tree which is used in the Data Schema. It will cache when the page starts.");
                }
            }
        }).start();
    }

    public static SchemaNode getClassBrowserCache() {
        return classBrowserCache;
    }
}
