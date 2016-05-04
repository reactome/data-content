<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<div class="ebi-content">
    <c:if test="${not empty entry.interactions}">
        <div class="grid_24">
            <h3>${entry.name}</h3>

            <fieldset class="fieldset-details">
            <legend>Interactions for <a href="${entry.url}" style="color: #009;" title="Show ${entry.accession}"
                                    rel="nofollow">${entry.accession}</a></legend>
            <div class="wrap">
                <table class="dt-fixed-header">
                    <thead>
                    <tr>
                        <th style="width: 55px">Confidence Score</th>
                        <th style="width: 45px">Accession</th>
                        <th style="width: 230px">Reactome Entry</th>
                        <th style="width: 50px">Evidence</th>
                    </tr>
                    </thead>
                </table>
                <div class="dt-content">
                    <table>
                        <tbody>
                        <c:forEach var="interaction" items="${entry.interactions}">
                            <tr>
                                <td style="width: 60px">${interaction.score}</td>
                                <td style="width: 50px"><a href="${interaction.accessionURL}" class=""
                                                           title="Show ${interaction.accession}"
                                                           rel="nofollow">${interaction.accession}</a></td>
                                <td style="width: 235px">
                                    <c:forEach var="reactomeEntry" items="${interaction.interactorReactomeEntries}">
                                        <ul class="list overflowList">
                                            <li>
                                                <a href="/content/detail/${reactomeEntry.reactomeId}" class=""
                                                   title="Show Details"
                                                   rel="nofollow">${reactomeEntry.reactomeName}<span> (${reactomeEntry.reactomeId})</span></a>
                                            </li>
                                        </ul>
                                    </c:forEach>
                                </td>
                                <td style="width: 55px">
                                    <a href="${interaction.evidencesURL}" title="Open evidence" rel="nofollow"
                                       target="_blank">${fn:length(interaction.interactionEvidences)}</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            </fieldset>
        </div>
    </c:if>
</div>
<div class="clear"></div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="../footer.jsp"/>