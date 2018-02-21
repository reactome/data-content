<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Interactors in the Details Page--%>
<div class="clearfix">
    <fieldset class="fieldset-details">
        <legend>Interactors (${fn:length(interactions)})</legend>
        <div id="r-responsive-table" class="details-wrap interactors-table enlarge-table">
            <table class="reactome">
                <thead>
                    <tr>
                        <th scope="col">Accession</th>
                        <th scope="col">#Entities</th>
                        <th scope="col">Entities</th>
                        <th scope="col">Confidence Score</th>
                        <th scope="col">Evidence (IntAct)</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="interaction" items="${interactions}">
                    <c:set var="interactor" value="${interaction.interactor[0]}" />
                    <tr>
                        <td data-label="Accession">
                            <a href="./interactor/${interactor.identifier}" class="" title="Show Interactor Details" ><i class="sprite sprite-Interactor"></i>&nbsp;${interactor.displayName}&nbsp;</a>
                            <a href="${interactor.url}"
                               title="Go to ${interactor.displayName}"
                               ><i class="fa fa-external-link" style="font-size: 13px;"></i></a>
                        </td>
                        <td data-label="#Entities">
                            <c:choose>
                                <c:when test="${not empty interactor.physicalEntity}">
                                    <c:out value="${fn:length(interactor.physicalEntity)}" />
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="Entities">
                            <c:choose>
                                <c:when test="${not empty interactor.physicalEntity}">
                                    <ul class="list">
                                        <c:forEach var="pe" items="${interactor.physicalEntity}">
                                            <li>
                                                <i class="sprite sprite-${pe.schemaClass}" title="${pe.schemaClass}"></i>
                                                <a href="/content/detail/${pe.stId}" title="Show Details" target="_blank" >${pe.displayName}<span> (${pe.stId})</span></a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td data-label="Confidence Score">${interaction.score}</td>
                        <td data-label="Evidence (IntAct)">
                            <c:choose>
                                <c:when test="${fn:length(interaction.accession) == 0}">
                                    <c:out value="0"/>
                                </c:when>
                                <c:otherwise>
                                    <a href="${interaction.url}" title="Open evidence"  target="_blank">${fn:length(interaction.accession)}</a>
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