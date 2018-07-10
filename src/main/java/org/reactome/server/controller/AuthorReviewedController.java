package org.reactome.server.controller;

import org.reactome.server.graph.domain.model.Pathway;
import org.reactome.server.graph.domain.model.Person;
import org.reactome.server.graph.domain.model.ReactionLikeEvent;
import org.reactome.server.graph.service.PersonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.Comparator;
import java.util.function.Function;
import java.util.stream.Collectors;

import static org.reactome.server.util.WebUtils.noDetailsFound;

/**
 * @author Florian Korninger (florian.korninger@ebi.ac.uk)
 * @author Guilherme Viteri (gviteri@ebi.ac.uk)
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
@SuppressWarnings("unused")
@Controller
class AuthorReviewedController {

    private static final Logger infoLogger = LoggerFactory.getLogger("infoLogger");
    private static final Logger errorLogger = LoggerFactory.getLogger("errorLogger");

    private static final String TITLE = "title";
    private static final Integer MAX = 15;

    private PersonService personService;

    @RequestMapping(value = "/detail/person/{id:.*}", method = RequestMethod.GET)
    public String personDetail(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);

        if (person != null) {
            model.addAttribute(TITLE, person.getDisplayName());
            model.addAttribute("person", person);

            Collection<Pathway> authoredPathways = personService.getAuthoredPathways(id).stream().sorted(Comparator.comparing(getAuthoredPathways()).reversed()).collect(Collectors.toList());
            model.addAttribute("authoredPathwaysSize", authoredPathways.size());
            model.addAttribute("authoredPathways", authoredPathways.stream().limit(MAX).collect(Collectors.toList()));

            Collection<ReactionLikeEvent> authoredReactions = personService.getAuthoredReactions(id).stream().sorted(Comparator.comparing(getAuthoredReactions()).reversed()).collect(Collectors.toList());
            model.addAttribute("authoredReactionsSize", authoredReactions.size());
            model.addAttribute("authoredReactions", authoredReactions.stream().limit(MAX).collect(Collectors.toList()));

            Collection<Pathway> reviewedPathways = personService.getReviewedPathways(id).stream().sorted(Comparator.comparing(getReviewedPathways()).reversed()).collect(Collectors.toList());
            model.addAttribute("reviewedPathwaysSize", reviewedPathways.size());
            model.addAttribute("reviewedPathways", reviewedPathways.stream().limit(MAX).collect(Collectors.toList()));

            Collection<ReactionLikeEvent> reviewedReactions = personService.getReviewedReactions(id).stream().sorted(Comparator.comparing(getReviewedReactions()).reversed()).collect(Collectors.toList());
            model.addAttribute("reviewedReactionsSize", reviewedReactions.size());
            model.addAttribute("reviewedReactions", reviewedReactions.stream().limit(MAX).collect(Collectors.toList()));

            infoLogger.info("Search request for id: {} was found", id);
            return "graph/person";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/detail/person/{id:.*}/pathways/authored", method = RequestMethod.GET)
    public String personPathwaysAuthored(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);

        if (person != null) {
            model.addAttribute(TITLE, person.getDisplayName());
            model.addAttribute("person", person);
            model.addAttribute("label", "Authored Pathways");
            model.addAttribute("type", "Pathway");
            model.addAttribute("list", personService.getAuthoredPathways(id).stream().sorted(Comparator.comparing(getAuthoredPathways()).reversed()).collect(Collectors.toList()));
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/detail/person/{id:.*}/pathways/reviewed", method = RequestMethod.GET)
    public String personPathwaysReviewed(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);

        if (person != null) {
            model.addAttribute(TITLE, person.getDisplayName());
            model.addAttribute("person", person);
            model.addAttribute("label", "Reviewed Pathways");
            model.addAttribute("type", "Pathway");
            model.addAttribute("list", personService.getAuthoredReactions(id).stream().sorted(Comparator.comparing(getAuthoredReactions()).reversed()).collect(Collectors.toList()));
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/detail/person/{id:.*}/reactions/authored", method = RequestMethod.GET)
    public String personReactionsAuthored(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);

        if (person != null) {
            model.addAttribute(TITLE, person.getDisplayName());
            model.addAttribute("person", person);
            model.addAttribute("label", "Authored Reactions");
            model.addAttribute("type", "Reaction");
            model.addAttribute("list", personService.getReviewedPathways(id).stream().sorted(Comparator.comparing(getReviewedPathways()).reversed()).collect(Collectors.toList()));
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    @RequestMapping(value = "/detail/person/{id:.*}/reactions/reviewed", method = RequestMethod.GET)
    public String personReactionsReviewed(@PathVariable String id, ModelMap model, HttpServletResponse response) {
        Person person = personService.findPerson(id);

        if (person != null) {
            model.addAttribute(TITLE, person.getDisplayName());
            model.addAttribute("person", person);
            model.addAttribute("label", "Reviewed Reactions");
            model.addAttribute("type", "Reaction");
            model.addAttribute("list", personService.getReviewedReactions(id).stream().sorted(Comparator.comparing(getReviewedReactions()).reversed()).collect(Collectors.toList()));
            return "graph/personShowAll";
        } else {
            infoLogger.info("Search request for id: {} was not found", id);
            return noDetailsFound(model, response, id);
        }
    }

    private Function<Pathway, String> getAuthoredPathways() {
        return pathway -> pathway.getAuthored().get(0).getDateTime();
    }

    private Function<ReactionLikeEvent, String> getAuthoredReactions() {
        return reaction -> reaction.getAuthored().get(0).getDateTime();
    }

    private Function<Pathway, String> getReviewedPathways() {
        return pathway -> pathway.getReviewed().get(0).getDateTime();
    }

    private Function<ReactionLikeEvent, String> getReviewedReactions() {
        return reaction -> reaction.getReviewed().get(0).getDateTime();
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