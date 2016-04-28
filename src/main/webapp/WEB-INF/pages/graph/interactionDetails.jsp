<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="grid_23  padding  margin">
    <fieldset class="fieldset-details">
        <legend>Interactors</legend>
        <div class="wrap">
            <table class="fixedTable">
                <thead>
                    <tr>
                        <th style="width:60px; border-radius: 5px 0 0 0;">Confidence Score</th>
                        <th style="width:100px;">Interactor Accession</th>
                        <th style="width:100px;">Interactor Name</th>
                        <th style="width:25px; border-radius: 0 5px 0 0;">Evidence</th>
                        <%--<td style="text-align: center;">Confidence Score</td>--%>
                        <%--<td style="text-align: center;">Interactor Accession</td>--%>
                        <%--<td style="text-align: center;">Reactome Entry</td>--%>
                        <%--<td style="text-align: center;">Evidence</td>--%>
                    </tr>
                </thead>
            </table>
            <div class="inner_table_div">
                <table>
                    <tbody>
                    <c:forEach var="interaction" items="${interactions}">
                        <tr>
                            <td style="text-align: left;width:50px;">${interaction.intactScore}</td>
                            <td style="text-align: left;width:80px;">
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
                            <td style="text-align: left;width:80px;">${interaction.interactorB.alias}</td>
                            <td style="text-align: left;width:10px;">
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
        </div>
    </fieldset>
</div>