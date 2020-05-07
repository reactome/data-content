package org.reactome.server.result;


import org.reactome.server.graph.domain.model.Person;

import java.util.Collection;


public class CustomPathway {
    private String displayName;
    private String doi;
    private String stId;
    private String species;
    private String releaseDate;

    private String reviseDate;
    private String releaseStatus;


    private Collection<Person> authors;
    private Collection<Person> reviewers;
    private Collection<Person> editors;

    public Collection<Person> getAuthors() {
        return authors;
    }

    public void setAuthors(Collection<Person> authors) {
        this.authors = authors;
    }

    public Collection<Person> getReviewers() {
        return reviewers;
    }

    public void setReviewers(Collection<Person> reviewers) {
        this.reviewers = reviewers;
    }

    public Collection<Person> getEditors() {
        return editors;
    }

    public void setEditors(Collection<Person> editors) {
        this.editors = editors;
    }

    public String getReviseDate() {
        return reviseDate;
    }

    public void setReviseDate(String reviseDate) {
        this.reviseDate = reviseDate;
    }

    public CustomPathway() {

    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getDoi() {
        return doi;
    }

    public void setDoi(String doi) {
        this.doi = doi;
    }

    public String getStId() {
        return stId;
    }

    public void setStId(String stId) {
        this.stId = stId;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }


    public String getReleaseStatus() {
        return releaseStatus;
    }

    public void setReleaseStatus(String releaseStatus) {
        this.releaseStatus = releaseStatus;
    }
}
