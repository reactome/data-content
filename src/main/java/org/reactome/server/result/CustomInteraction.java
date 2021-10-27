package org.reactome.server.result;

import org.neo4j.driver.Record;
import org.reactome.server.graph.domain.result.CustomQuery;
import org.reactome.server.graph.domain.result.SimpleDatabaseObject;

import java.util.Collection;
import java.util.Comparator;
import java.util.stream.Collectors;

public class CustomInteraction implements CustomQuery {
    private Double score;
    private String accession;
    private String accessionURL;
    private Collection<SimpleDatabaseObject> physicalEntity;
    private Integer evidences;
    private String url;

    public CustomInteraction() {
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getAccession() {
        return accession;
    }

    public void setAccession(String accession) {
        this.accession = accession;
    }

    public String getAccessionURL() {
        return accessionURL;
    }

    public void setAccessionURL(String accessionURL) {
        this.accessionURL = accessionURL;
    }

    public Collection<SimpleDatabaseObject> getPhysicalEntity() {
        return physicalEntity.stream().sorted(Comparator.comparing(SimpleDatabaseObject::getDisplayName, String.CASE_INSENSITIVE_ORDER)).collect(Collectors.toList());
    }

    public void setPhysicalEntity(Collection<SimpleDatabaseObject> physicalEntity) {
        this.physicalEntity = physicalEntity;
    }

    public Integer getEvidences() {
        return evidences;
    }

    public void setEvidences(Integer evidences) {
        this.evidences = evidences;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public CustomQuery build(Record r) {
        CustomInteraction ci = new CustomInteraction();
        ci.setAccession(r.get("accession").asString(null));
        ci.setAccessionURL(r.get("accessionURL").asString(null));
        ci.setEvidences(r.get("evidences").asInt(0));
        ci.setScore(r.get("score").asDouble(0));
        ci.setUrl(r.get("url").asString(null));
        ci.setPhysicalEntity(r.get("physicalEntity").asList(SimpleDatabaseObject::build));
        return ci;
    }
}
