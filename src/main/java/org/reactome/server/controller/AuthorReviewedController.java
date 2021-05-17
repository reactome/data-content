package org.reactome.server.controller;

import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.graph.domain.model.Person;
import org.reactome.server.graph.domain.model.ReactionLikeEvent;
import org.reactome.server.graph.service.PersonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.matchesHostname;
import static org.reactome.server.util.WebUtils.noDetailsFound;

/**
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @author Guilherme Viteri (gviteri@ebi.ac.uk)
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
@SuppressWarnings("unused")
@Controller
@RequestMapping(value = "/detail")
@PropertySource("classpath:core.properties")
class AuthorReviewedController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String TITLE = "title";
    private static final Integer MAX = 15;

    private static final String SHOW_ORCID_BTN = "showOrcidBtn";

    private PersonService personService;

    @Value("${orcid.server}")
    private String hostname;

    @RequestMapping(value = "/person/{id:.*}", method = RequestMethod.GET)
    public String personDetail(@PathVariable String id, ModelMap model, HttpServletResponse response,
                               @RequestParam(defaultValue = "false") Boolean showAll) {

        return getPersonDetail(id, model, response, showAll);
    }

    @RequestMapping(value = "/widget/person/{id:.*}", method = RequestMethod.GET)
    public String personDetailWidget(@PathVariable String id, ModelMap model, HttpServletResponse response,
                                     @RequestParam(defaultValue = "false") Boolean showAll) {

        model.addAttribute("widget", "widget");
        return getPersonDetail(id, model, response, showAll);
    }

    @RequestMapping(value = "/person/{id:.*}/pathways/authored", method = RequestMethod.GET)
    public String personPathwaysAuthored(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<Pathway> authoredPathways = personService.getAuthoredPathways(id);
            addAttributesToModel(model,person, "Authored Pathways", "pa", "Pathway", "reviewed");
            model.addAttribute("list", authoredPathways);
            model.addAttribute("authoredPathwaysSize", authoredPathways.size());
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/person/{id:.*}/pathways/reviewed", method = RequestMethod.GET)
    public String personPathwaysReviewed(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<Pathway> reviewedPathways = personService.getReviewedPathways(id);
            addAttributesToModel(model,person, "Reviewed Pathways", "pr", "Pathway", "reviewed");
            model.addAttribute("list", reviewedPathways);
            model.addAttribute("authoredPathwaysSize", reviewedPathways.size());
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/person/{id:.*}/reactions/authored", method = RequestMethod.GET)
    public String personReactionsAuthored(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(id);
            addAttributesToModel(model,person, "Authored Reactions", "ra", "Reaction", "authored");
            model.addAttribute("list", authoredReactions);
            model.addAttribute("authoredPathwaysSize", authoredReactions.size());
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/person/{id:.*}/reactions/reviewed", method = RequestMethod.GET)
    public String personReactionsReviewed(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(id);
            addAttributesToModel(model,person, "Reviewed Reactions", "rr", "Reaction", "reviewed");
            model.addAttribute("list", reviewedReactions);
            model.addAttribute("reviewedReactionsSize", reviewedReactions.size());
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }


    @RequestMapping(value = "/widget/person/{id:.*}/pathways/authored", method = RequestMethod.GET)
    public String personPathwaysAuthoredWidget(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<Pathway> authoredPathways = personService.getAuthoredPathways(id);
            addAttributesToModel(model,person, "Authored Pathways", "pa", "Pathway", "reviewed");
            model.addAttribute("list", authoredPathways);
            model.addAttribute("authoredPathwaysSize", authoredPathways.size());
            model.addAttribute("widget", "widget");
            return "graph/personShowAllWidget";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/widget/person/{id:.*}/pathways/reviewed", method = RequestMethod.GET)
    public String personPathwaysReviewedWidget(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<Pathway> reviewedPathways = personService.getReviewedPathways(id);
            addAttributesToModel(model,person, "Reviewed Pathways", "pr", "Pathway", "reviewed");
            model.addAttribute("list", reviewedPathways);
            model.addAttribute("reviewedPathwaysSize", reviewedPathways.size());
            model.addAttribute("widget", "widget");
            return "graph/personShowAllWidget";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/widget/person/{id:.*}/reactions/authored", method = RequestMethod.GET)
    public String personReactionsAuthoredWidget(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(id);
            addAttributesToModel(model,person, "Authored Reactions", "ra", "Reaction", "authored");
            model.addAttribute("list", authoredReactions);
            model.addAttribute("authoredReactionsSize", authoredReactions.size());
            model.addAttribute("widget", "widget");
            return "graph/personShowAllWidget";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/widget/person/{id:.*}/reactions/reviewed", method = RequestMethod.GET)
    public String personReactionsReviewedWidget(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);
        if (person != null) {
            Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(id);
            addAttributesToModel(model,person, "Reviewed Reactions", "rr", "Reaction", "reviewed");
            model.addAttribute("list", reviewedReactions);
            model.addAttribute("reviewedReactionsSize", reviewedReactions.size());
            model.addAttribute(SHOW_ORCID_BTN, matchesHostname(hostname));
            model.addAttribute("widget", "widget");
            return "graph/personShowAllWidget";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    private String getPersonDetail(String id, ModelMap model, HttpServletResponse response, Boolean showAll) {
        Person person = personService.findPerson(id);
        if (person != null) {
            model.addAttribute(TITLE, person.getDisplayName());
            model.addAttribute("person", person);

            Collection<Pathway> authoredPathways = personService.getAuthoredPathways(id);
            model.addAttribute("authoredPathwaysSize", authoredPathways.size());
            model.addAttribute("authoredPathways", showAll ? authoredPathways : authoredPathways.stream().limit(MAX).collect(Collectors.toList()));

            Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(id);
            model.addAttribute("authoredReactionsSize", authoredReactions.size());
            model.addAttribute("authoredReactions", showAll ? authoredReactions : authoredReactions.stream().limit(MAX).collect(Collectors.toList()));

            Collection<Pathway> reviewedPathways = personService.getReviewedPathways(id);
            model.addAttribute("reviewedPathwaysSize", reviewedPathways.size());
            model.addAttribute("reviewedPathways", showAll ? reviewedPathways : reviewedPathways.stream().limit(MAX).collect(Collectors.toList()));

            Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(id);
            model.addAttribute("reviewedReactionsSize", reviewedReactions.size());
            model.addAttribute("reviewedReactions", showAll ? reviewedReactions : reviewedReactions.stream().limit(MAX).collect(Collectors.toList()));

            model.addAttribute(SHOW_ORCID_BTN, matchesHostname(hostname));

            if (model.get("widget") != null) {
                return "graph/personWidget";
            } else {
                infoLogger.info("Search request for id: {} was found", id);
                return "graph/person";
            }
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    private ModelMap addAttributesToModel(ModelMap model,
                                          Person person,
                                          String label,
                                          String claimYourWorkPath,
                                          String type,
                                          String attribute) {
        model.addAttribute(TITLE, person.getDisplayName());
        model.addAttribute("person", person);
        model.addAttribute("label", label);
        model.addAttribute("claimyourworkpath", claimYourWorkPath);
        model.addAttribute("type", type);
        model.addAttribute("attribute", attribute);
        model.addAttribute(SHOW_ORCID_BTN, matchesHostname(hostname));
        return model;
    }

    // ### KEEP IT FOR THE MOMENT ###
    //    @RequestMapping(value = "/bibtex/{id:.*}/{pathway:.*}", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
    //    @ResponseBody
    //    public String bibtex(@PathVariable String id, @PathVariable String pathway, ModelMap model, HttpServletResponse response) {
    //        return bibTexExporter.run(id, pathway);
    //    }

    @Autowired
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

}