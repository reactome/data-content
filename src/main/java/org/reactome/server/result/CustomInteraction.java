package org.reactome.server.result;

import org.reactome.server.graph.domain.result.SimpleDatabaseObject;

/**
 * @author Åntonio Fabregat (fabregat@ebi.ac.uk)
 */
public class CustomInteraction {
    private Double score;
    private String accession;
    private SimpleDatabaseObject physicalEntity;
    private Integer evidences;
    private String url;

    public CustomInteraction() { }


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

    public SimpleDatabaseObject getPhysicalEntity() {
        return physicalEntity;
    }

    public void setPhysicalEntity(SimpleDatabaseObject physicalEntity) {
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
}
