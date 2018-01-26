<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="clearfix">
    <fieldset class="fieldset-details">
        <legend>Interactors</legend>
        <div id="r-responsive-table" class="details-wrap interactors-table">
            <table class="reactome">
                <thead>
                    <tr>
                        <th scope="col">Confidence Score</th>
                        <th scope="col">Interactor Accession</th>
                        <th scope="col">Interactor Name</th>
                        <th scope="col">Evidence (IntAct)</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="interaction" items="${interactions}">
                    <c:set var="interactor" value="${interaction.interactor[0]}" />
                    <tr>
                        <td data-label="Confidence Score">${interaction.score}</td>
                        <td data-label="Interactor Accession">
                            <!-- Parse the Interactor URL -->
                            <a href="${interactor.url}"
                               title="Show ${interactor.identifier}"
                               rel="nofollow">${interactor.displayName}</a>
                        </td>

                        <c:choose>
                            <c:when test="${interactor.schemaClass == 'ReferenceMolecule'}">
                                <td data-label="Interactor Name">${interactor.name[0]}</td>
                            </c:when>
                            <c:when test="${interactor.schemaClass == 'ReferenceDNASequence' ||
                                            interactor.schemaClass == 'ReferenceGeneProduct' ||
                                            interactor.schemaClass == 'ReferenceIsoform'     ||
                                            interactor.schemaClass == 'ReferenceRNASequence'}">
                                <td data-label="Interactor Name">${interactor.geneName[0]}</td>
                            </c:when>
                            <c:otherwise>
                                <td data-label="Interactor Name">&nbsp;</td>
                            </c:otherwise>
                        </c:choose>

                        <td data-label="Evidence (IntAct)">
                            <c:choose>
                                <c:when test="${fn:length(interaction.accession) == 0}">
                                    <c:out value="0"/>
                                </c:when>
                                <c:otherwise>
                                    <a href="${interaction.url}" title="Open evidence" rel="nofollow" target="_blank">${fn:length(interaction.accession)}</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>