package org.reactome.server.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.reactome.server.exception.ViewException;
import org.reactome.server.graph.domain.model.*;
import org.reactome.server.graph.domain.schema.SchemaDataSet;
import org.reactome.server.graph.service.AdvancedDatabaseObjectService;
import org.reactome.server.graph.service.DetailsService;
import org.reactome.server.graph.service.GeneralService;
import org.reactome.server.graph.service.InteractionsService;
import org.reactome.server.graph.service.helper.ContentDetails;
import org.reactome.server.graph.service.helper.PathwayBrowserNode;
import org.reactome.server.graph.service.helper.RelationshipDirection;
import org.reactome.server.graph.service.helper.SchemaNode;
import org.reactome.server.graph.service.util.DatabaseObjectUtils;
import org.reactome.server.graph.service.util.PathwayBrowserLocationsUtils;
import org.reactome.server.util.IconPhysicalEntityCache;
import org.reactome.server.util.MapSet;
import org.reactome.server.util.UAgentInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.nio.charset.Charset;
import java.util.*;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.noDetailsFound;

/**
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @author Guilherme Viteri (gviteri@ebi.ac.uk)
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
@SuppressWarnings("unused")
@Controller
class DetailsController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String TITLE = "title";

    private static final int OFFSET = 55;
    private final Set<String> ehlds = new HashSet<>();
    private GeneralService generalService;
    private AdvancedDatabaseObjectService advancedDatabaseObjectService;
    private InteractionsService interactionsService;
    private DetailsService detailsService;
    private SchemaNode classBrowserCache;

    @Value("${icons.lib.dir}")
    private String iconLibDir; // E

    /**
     * These resources are the same all the time.
     * In order to speed up the query result and less memory usage, I decided to keep the resource out of the query
     * and keep a cache with them. Thus we avoid having the same information for all results.
     */
    @Autowired
    public DetailsController(@Value("${svg.summary.file}") String svgSummaryFile) {
        try {
            ehlds.addAll(IOUtils.readLines(new FileInputStream(svgSummaryFile), Charset.defaultCharset()));
        } catch (IOException e) {
            errorLogger.error("EHLD summary file cannot be loaded: " + e.getMessage(), e);
        }
    }

    /**
     * * Shows detailed information of an entry
     *
     * @param id    StId or DbId
     * @param model SpringModel
     * @return Detailed page
     * @throws ViewException Runtime exception when building the details page
     */
    @RequestMapping(value = "/detail/{id:.*}", method = RequestMethod.GET)
    public String detail(@PathVariable String id,
                         @RequestParam(required = false, defaultValue = "") String interactor,
                         ModelMap model,
                         HttpServletRequest request,
                         HttpServletResponse response) {

        try {
            UAgentInfo u = new UAgentInfo(request.getHeader("User-Agent"), null);

            boolean interactorPage = StringUtils.isNotEmpty(interactor);

            ContentDetails contentDetails = detailsService.getContentDetails(id, interactorPage);

            if (contentDetails != null && contentDetails.getDatabaseObject() != null) {
                DatabaseObject databaseObject = contentDetails.getDatabaseObject();
                String superClass = getSuperClass(databaseObject);
                if (superClass == null) {
                    /*
                     * The database object contains already all outgoing relationships.
                     * To complete the object for the instance/browser view all incoming relationships have to be loaded.
                     * The Mapping will be done automatically by Spring.
                     */
                    advancedDatabaseObjectService.findById(databaseObject.getDbId(), RelationshipDirection.INCOMING);
                    model.addAttribute("map", DatabaseObjectUtils.getAllFields(databaseObject));
                    return "redirect:/schema/instance/browser/" + id;
                } else {
                    Set<PathwayBrowserNode> topLevelNodes = contentDetails.getNodes();

                    model.addAttribute(TITLE, databaseObject.getDisplayName());

                    model.addAttribute("databaseObject", databaseObject);
                    model.addAttribute("clazz", superClass);
                    model.addAttribute("topLevelNodes", topLevelNodes);
                    model.addAttribute("availableSpecies", PathwayBrowserLocationsUtils.getAvailableSpecies(topLevelNodes));
                    model.addAttribute("componentOf", contentDetails.getComponentOf());
                    model.addAttribute("otherFormsOfThisMolecule", contentDetails.getOtherFormsOfThisMolecule());
                    model.addAttribute("orthologousEvents", getSortedOrthologousEvent(databaseObject));
                    model.addAttribute("inferredTo", getSortedInferredTo(databaseObject));
                    model.addAttribute("hasEHLD", ehlds.contains(databaseObject.getStId()));

                    //RegulatedBy moved to RLE without distinction in the types (now it needs to be done here)
                    List<NegativeRegulation> negativeRegulations = new ArrayList<>();
                    List<PositiveRegulation> positiveRegulations = new ArrayList<>();
                    List<Requirement> requirements = new ArrayList<>();
                    if (databaseObject instanceof ReactionLikeEvent) {
                        ReactionLikeEvent rle = (ReactionLikeEvent) databaseObject;
                        if (rle.getRegulatedBy() != null) {
                            for (Regulation regulation : rle.getRegulatedBy()) {
                                if (regulation instanceof NegativeRegulation) {
                                    negativeRegulations.add((NegativeRegulation) regulation);
                                } else if (regulation instanceof Requirement) {
                                    requirements.add((Requirement) regulation);
                                } else {
                                    positiveRegulations.add((PositiveRegulation) regulation);
                                }
                            }
                        }
                    }
                    model.addAttribute("negativelyRegulatedBy", negativeRegulations);
                    model.addAttribute("requirements", requirements);
                    model.addAttribute("positivelyRegulatedBy", positiveRegulations);

                    List<DatabaseIdentifier> crossReferences = getCrossReference(databaseObject);
                    setClassAttributes(databaseObject, model);
                    if (databaseObject instanceof EntityWithAccessionedSequence) {
                        EntityWithAccessionedSequence ewas = (EntityWithAccessionedSequence) databaseObject;
                        List<Interaction> interactions = interactionsService.getInteractions(ewas.getReferenceEntity().getIdentifier());
                        model.addAttribute("interactions", interactions);
                        crossReferences.addAll(getCrossReference(ewas.getReferenceEntity()));
//                        if (ewas.getReferenceEntity() instanceof ReferenceSequence) {
                            model.addAttribute("isReferenceSequence", true);
//                        }
                    }
                    model.addAttribute("crossReferences", groupCrossReferences(crossReferences));

                    // extras
                    String referenceIdentifier = getReferenceEntityIdentifier(databaseObject);
                    model.addAttribute("flg", referenceIdentifier);
                    model.addAttribute("relatedSpecies", getRelatedSpecies(databaseObject));
                    model.addAttribute("jsonLd", eventDiscovery(contentDetails.getDatabaseObject()));
                    model.addAttribute("icon", IconPhysicalEntityCache.getIconsMapping().get(referenceIdentifier));

                    // responsive design, avoid loading same content twice on screen
                    // instead hiding using CSS, java will detect and the content won't be processed.
                    model.addAttribute("isMobile", u.detectMobileQuick());

                    infoLogger.info("DatabaseObject for id: {} was found", id);
                    return "graph/detail";
                }
            }
            infoLogger.info("DatabaseObject for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        } catch (Throwable t) {
            // Catch any exception that could happen in the details page and pass it to the  GlobalExceptionHandler
            throw new ViewException(t);
        }
    }

    private void setClassAttributes(DatabaseObject databaseObject, ModelMap model) {
        if (databaseObject instanceof ReactionLikeEvent) {
            model.addAttribute("isReactionLikeEvent", true);
        } else if (databaseObject instanceof EntitySet) {
            model.addAttribute("isEntitySet", true);
            if (databaseObject instanceof OpenSet) {
                model.addAttribute("hasReferenceEntity", true);
            }
        } else if (databaseObject instanceof EntityWithAccessionedSequence || databaseObject instanceof SimpleEntity) {
            model.addAttribute("hasReferenceEntity", true);
        }
    }

    private Map<String, Set<DatabaseIdentifier>> groupCrossReferences(List<DatabaseIdentifier> databaseIdentifiers) {
        if (databaseIdentifiers == null) return null;
        Map<String, Set<DatabaseIdentifier>> groupedCrossReferences = new HashMap<>();
        for (DatabaseIdentifier databaseIdentifier : databaseIdentifiers) {
            groupedCrossReferences.computeIfAbsent(databaseIdentifier.getDatabaseName(), crossRef -> new HashSet<>()).add(databaseIdentifier);
        }
        return groupedCrossReferences;
    }

    @SuppressWarnings("unchecked")
    private List<DatabaseIdentifier> getCrossReference(DatabaseObject databaseObject) {
        List<DatabaseIdentifier> crossReferences = null;
        try {
            crossReferences = (List<DatabaseIdentifier>) databaseObject.getClass().getMethod("getCrossReference").invoke(databaseObject);
            ReferenceEntity re = (ReferenceEntity) databaseObject.getClass().getMethod("getReferenceEntity").invoke(databaseObject);
            if (re.getCrossReference() != null) crossReferences.addAll(re.getCrossReference());
        } catch (Exception e) { /* Nothing here*/ }
        return crossReferences == null ? new ArrayList<>() : crossReferences;
    }

    private String getSuperClass(DatabaseObject databaseObject) {
        if (databaseObject != null) {
            if (databaseObject instanceof Event) {
                return Event.class.getSimpleName();
            } else if (databaseObject instanceof PhysicalEntity) {
                return PhysicalEntity.class.getSimpleName();
            } else if (databaseObject instanceof Regulation) {
                return Regulation.class.getSimpleName();
            }
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    private Map<String, Collection<Event>> getSortedOrthologousEvent(DatabaseObject databaseObject) {
        Map<String, Collection<Event>> ret = new HashMap<>();
        if (databaseObject instanceof Event) {
            MapSet<String, Event> mapSet = new MapSet<>();
            Event event = (Event) databaseObject;
            if (event.getOrthologousEvent() != null) {
                for (Event orthologousEvent : event.getOrthologousEvent()) {
                    mapSet.add(orthologousEvent.getDisplayName(), orthologousEvent);
                }
                for (String key : mapSet.keySet()) {
                    TreeMap<String, Event> sortedMap = new TreeMap<>();
                    Set<Event> orthologousEvents = mapSet.getElements(key);
                    for (Event orthologousEvent : orthologousEvents) {
                        sortedMap.put(orthologousEvent.getSpeciesName(), orthologousEvent);
                    }
                    ret.put(key, sortedMap.values());
                }
            }
        }
        return ret;
    }

    @SuppressWarnings("unchecked")
    private Map<String, List<PhysicalEntity>> getSortedInferredTo(DatabaseObject databaseObject) {
        /*
         * Sorting inferredTo requires:
         *  1st: Sort list by name
         *  2nd: Sort by Species
         */
        Map<String, List<PhysicalEntity>> ret = new HashMap<>();
        if (databaseObject instanceof PhysicalEntity) {
            MapSet<String, PhysicalEntity> mapSet = new MapSet<>();
            PhysicalEntity physicalEntity = (PhysicalEntity) databaseObject;
            if (physicalEntity.getInferredTo() != null) {
                /*
                 * Create a MapSet having the key:displayName, value: inferredToObj. Every key (already sorted), has the
                 * collection of inferredTo (the same entry is present in many species)
                 *   -Homologues of PTEN [cytosol] (Oryza sativa)
                 *   -Homologues of PTEN [cytosol] (Danio rerio)
                 *   -Homologues of PTEN [cytosol] (Arabidopsis thaliana)
                 *   -PTEN [cytosol] (Bos Taurus)
                 *   -PTEN [cytosol] (Arabidopsis thaliana)
                 */
                for (PhysicalEntity inferredTo : physicalEntity.getInferredTo()) {
                    mapSet.add(inferredTo.getDisplayName(), inferredTo);
                }

                /*
                 * Then, for every key we get the list of inferredTo and sort them by Species.
                 * However we can have many entries for each species which we are going to take into account only
                 * the first one. So, the new map has the species as key and a sorted list of inferredTos sorting
                 * by StId.
                 */
                for (String key : mapSet.keySet()) {
                    TreeMap<String, List<PhysicalEntity>> sortedMap = new TreeMap<>();
                    Set<PhysicalEntity> inferredsTo = mapSet.getElements(key);
                    for (PhysicalEntity inferredTo : inferredsTo) {
                        List<PhysicalEntity> inferredToList;
                        if (sortedMap.containsKey(inferredTo.getSpeciesName())) {
                            inferredToList = sortedMap.get(inferredTo.getSpeciesName());
                            inferredToList.add(inferredTo);
                        } else {
                            inferredToList = new ArrayList<>();
                            inferredToList.add(inferredTo);
                        }
                        inferredToList.sort(Comparator.comparing(DatabaseObject::getStId));
                        sortedMap.put(inferredTo.getSpeciesName(), inferredToList);
                    }

                    // map -> key:display, value:sorted inferredTos, only one (the first) per species.
                    // NOTICE: if you to return all of them -> uses sortedMap.values() and change the return
                    //         statement to be Collection<List<PhysicalEntity>. Adjust physicalEntityDetails.jsp too.
                    ret.put(key, sortedMap.values().stream().map(physicalEntities -> physicalEntities.get(0)).collect(Collectors.toList()));
                }
            }
        }
        return ret;
    }

    /**
     * Return the Reference Entity Identifier. Later it will be used to build the link to the PWB in order to flag
     * the instance.
     *
     * @return the identifier
     */
    private String getReferenceEntityIdentifier(DatabaseObject databaseObject) {
        String ret = "";
        try {
            ReferenceEntity re = (ReferenceEntity) databaseObject.getClass().getMethod("getReferenceEntity").invoke(databaseObject);
            if (re == null) { //Check referenceTherapeutic slot for ProteinDrug
                re = (ReferenceEntity) databaseObject.getClass().getMethod("getReferenceTherapeutic").invoke(databaseObject);
            }
            ret = re.getIdentifier();
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException | NullPointerException e) {
            // nothing here
        }
        return ret;
    }

    @SuppressWarnings("unchecked")
    private List<Species> getRelatedSpecies(DatabaseObject databaseObject) {
        try {
            return (List<Species>) databaseObject.getClass().getMethod("getRelatedSpecies").invoke(databaseObject);
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException | NullPointerException e) {
            // nothing here
        }
        return null;
    }

    private String eventDiscovery(DatabaseObject databaseObject) {
        if (databaseObject instanceof Event) {
            SchemaDataSet aux = new SchemaDataSet((Event) databaseObject, generalService.getDBVersion());
            try {
                ObjectMapper objectMapper = new ObjectMapper();
                return objectMapper.writeValueAsString(aux);
            } catch (JsonProcessingException e) {
                //Nothing here
            }
        }
        return null;
    }

    @Autowired
    public void setGeneralService(GeneralService generalService) {
        this.generalService = generalService;
    }

    @Autowired
    public void setAdvancedDatabaseObjectService(AdvancedDatabaseObjectService advancedDatabaseObjectService) {
        this.advancedDatabaseObjectService = advancedDatabaseObjectService;
    }

    @Autowired
    public void setDetailsService(DetailsService detailsService) {
        this.detailsService = detailsService;
    }

    @Autowired
    public void setInteractionsService(InteractionsService interactionsService) {
        this.interactionsService = interactionsService;
    }
}