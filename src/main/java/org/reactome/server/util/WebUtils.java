package org.reactome.server.util;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.reactome.server.interactors.model.Interaction;
import org.reactome.server.interactors.model.InteractionDetails;
import org.reactome.server.interactors.util.InteractorConstant;
import org.reactome.server.interactors.util.Toolbox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

public class WebUtils {

    public static String cleanReceivedParameter(String param) {
        if (param != null && !param.isEmpty()) {
            return Jsoup.clean(param, Whitelist.basic());
        }
        return null;
    }

    public static List<String> cleanReceivedParameters(List<String> list) {
        if (list != null && !list.isEmpty()) {
            List<String> checkedList = new ArrayList<>();
            for (String output : list) {
                checkedList.add(cleanReceivedParameter(output));
            }
            return checkedList;
        }
        return null;
    }

    /**
     * Prepare interaction evidences links.
     * Gets all interaction evidences of a given interactor and build the URL
     * Having all this logic in JSTL wouldn't be clear.
     *
     * @return map as accession and the URL
     */
    public static Map<String, String> prepareEvidencesURLs(List<Interaction> interactions) {
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
