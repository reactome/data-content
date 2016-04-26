<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="grid_23  padding  margin">
    <fieldset class="fieldset-details">
        <legend>Interactors</legend>
        <div class="wrap">
            <table class="fixedTable">
                <thead style="border-bottom: 1px solid #d3d3d3">
                <tr>
                    <%--<td>Confidence Score</td>--%>
                    <%--<td>Interactor Accession</td>--%>
                    <%--<td>Interactor Name</td>--%>
                    <%--<td>Evidence</td>--%>
                    <td><strong>Confidence Score</strong></td>
                    <td><strong>Interactor Accession</strong></td>
                    <td><strong>Reactome Entry</strong></td>
                    <td><strong>Evidence</strong></td>
                </tr>
                </thead>
            </table>
            <div class="inner_table_div">
                <table>
                    <c:forEach var="interaction" items="${interactions}">
                        <tr>
                            <td>${interaction.intactScore}</td>
                            <td>
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
                            <td>${interaction.interactorB.alias}</td>
                            <td>
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
                </table>
            </div>
        </div>
    </fieldset>
</div>