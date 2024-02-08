package org.reactome.server.controller;


import org.reactome.server.graph.domain.result.PersonAuthorReviewer;
import org.reactome.server.util.ContributorsCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

@Controller
public class ContributorsController {

    private static final String PERSON_AUTHOR_REVIEWERS = "personAuthorReviewers";
    private static final String PAGE = "page";
    private static final String LETTERS = "letters";
    private static final String COUNT = "count";
    private static final String TITLE = "title";

    private ContributorsCache contributorsCache;


    @Autowired
    public void setContributorsCache(ContributorsCache contributorsCache) {
        this.contributorsCache = contributorsCache;
    }

    public ContributorsController() {
    }

    @RequestMapping(value = "/contributors", method = RequestMethod.GET)
    public String test(
            @RequestParam(defaultValue = "All") String page,
            ModelMap model) {

        if (page == null) page = "All";
        String finalPage = page;

        List<String> letters = Stream.concat(Stream.of("All"), Arrays.stream(IntStream.rangeClosed('A', 'Z').mapToObj(c -> String.valueOf((char) c)).toArray(String[]::new)))
                .collect(Collectors.toList());
        Collection<PersonAuthorReviewer> allPersonAuthorReviewer = contributorsCache.getPersonAuthorReviewerCache().stream().sorted(Comparator.comparing(person -> person.getPerson().getDisplayName())).collect(Collectors.toList());
        Collection<PersonAuthorReviewer> personAuthorReviewerWithRange = allPersonAuthorReviewer.stream().filter(person -> person.getPerson().getSurname().toUpperCase().startsWith(finalPage)).collect(Collectors.toList());
        Collection<PersonAuthorReviewer> personAuthorReviewers = page.equals("All") ? allPersonAuthorReviewer : personAuthorReviewerWithRange;

        model.addAttribute(TITLE, "Contributors");
        model.addAttribute(PERSON_AUTHOR_REVIEWERS, personAuthorReviewers);
        model.addAttribute(COUNT, allPersonAuthorReviewer.size());
        model.addAttribute(PAGE, page);
        model.addAttribute(LETTERS, letters);
        return "graph/contributors";
    }
}
