package org.reactome.server.orcid.util;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

public class OrcidClaimRecord {

    private String stId;
    private String orcid;
    private Long putCode;

    public OrcidClaimRecord() {
    }

    public OrcidClaimRecord(String stId, String orcid, Long putCode) {
        this.stId = stId;
        this.orcid = orcid;
        this.putCode = putCode;
    }

    public String getStId() {
        return stId;
    }

    public void setStId(String stId) {
        this.stId = stId;
    }

    public String getOrcid() {
        return orcid;
    }

    public void setOrcid(String orcid) {
        this.orcid = orcid;
    }

    public Long getPutCode() {
        return putCode;
    }

    public void setPutCode(Long putCode) {
        this.putCode = putCode;
    }

}
