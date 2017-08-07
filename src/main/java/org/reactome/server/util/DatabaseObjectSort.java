package org.reactome.server.util;

import org.reactome.server.graph.domain.model.DatabaseObject;

import java.util.List;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

public class DatabaseObjectSort {
    public static List<DatabaseObject> sortByDisplayName(List<DatabaseObject> databaseObjectList) {
        databaseObjectList.sort((o1, o2) -> o1.getDisplayName().compareToIgnoreCase(o2.getDisplayName()));
        return databaseObjectList;
    }

    public static List<String> sortList(List<String> list) {
        list.sort(String::compareToIgnoreCase);
        return list;
    }
}
