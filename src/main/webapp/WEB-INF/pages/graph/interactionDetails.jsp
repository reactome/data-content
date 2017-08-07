<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="clearfix">
    <fieldset class="fieldset-details">
        <legend>Interactors</legend>
        <div id="r-responsive-table" class="details-wrap interactors-table">
            <table>
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
                    <tr>
                        <td data-label="Confidence Score">${interaction.intactScore}</td>
                        <td data-label="Interactor Accession">
                            <!-- Parse the Interactor URL -->
                            <c:set var="interactorResource" value="${interactorResourceMap[interaction.interactorB.interactorResourceId]}" />
                            <c:choose>
                                <%-- Accessions do not have resource (even in intact portal) --%>
                                <c:when test="${interactorResource.name == 'undefined'}">
                                    ${interaction.interactorB.acc}
                                </c:when>
                                <c:otherwise>
                                    <a href="${fn:replace(interactorResource.url, '##ID##', interaction.interactorB.acc)}"
                                       title="Show ${interaction.interactorB.acc}"
                                       rel="nofollow">${interaction.interactorB.acc}</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="Interactor Name">${interaction.interactorB.alias}</td>
                        <td data-label="Evidence (IntAct)">
                            <c:choose>
                                <c:when test="${fn:length(interaction.interactionDetailsList) == 0}">
                                    ${fn:length(interaction.interactionDetailsList)}
                                </c:when>
                                <c:otherwise>
                                    <a href="${evidencesUrlMap[interaction.interactorB.acc]}" title="Open evidence" rel="nofollow" target="_blank">${fn:length(interaction.interactionDetailsList)}</a>
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