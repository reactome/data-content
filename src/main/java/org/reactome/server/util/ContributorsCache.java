package org.reactome.server.util;

import org.reactome.server.graph.domain.result.PersonAuthorReviewer;
import org.reactome.server.graph.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collection;

@Component
public class ContributorsCache {

    @Autowired
    private PersonService personService;

    private Collection<PersonAuthorReviewer> personAuthorReviewer;

    @Autowired
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

    @PostConstruct
    public void getPersonAuthorReviewer() {
        if (personAuthorReviewer == null) {
            personAuthorReviewer = personService.getAuthorsReviewers();
        }
    }

    public Collection<PersonAuthorReviewer> getPersonAuthorReviewerCache() {
        return personAuthorReviewer;
    }
}
