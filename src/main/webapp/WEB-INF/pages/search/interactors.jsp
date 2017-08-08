<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<c:if test="${not empty entry.interactions}">
    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 ">
        <h3>${entry.name}</h3>

        <div id="r-responsive-table" class="interactors-table">
            <table>
                <thead>
                    <tr>
                        <th scope="col">Confidence Score</th>
                        <th scope="col">Accession</th>
                        <th scope="col">Reactome Entry</th>
                        <th scope="col">Evidence (IntAct)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="interaction" items="${entry.interactions}">
                    <tr>
                        <td data-label="Confidence Score">${interaction.score}</td>
                        <td data-label="Accession"><a href="${interaction.accessionURL}" class=""
                                                   title="Show ${interaction.accession}"
                                                   rel="nofollow">${interaction.accession}</a></td>
                        <td data-label="Reactome Entry">
                            <c:forEach var="reactomeEntry" items="${interaction.interactorReactomeEntries}">
                                <ul class="list overflow">
                                    <li>
                                        <a href="/content/detail/${reactomeEntry.reactomeId}?interactor=${entry.name}" class=""
                                           title="Show Details"
                                           rel="nofollow">${reactomeEntry.reactomeName}<span> (${reactomeEntry.reactomeId})</span></a>
                                    </li>
                                </ul>
                            </c:forEach>
                        </td>
                        <td data-label="Evidence (IntAct)">
                            <a href="${interaction.evidencesURL}" title="Open evidence in IntAct" rel="nofollow"
                               target="_blank">${fn:length(interaction.interactionEvidences)}</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <p>&nbsp;</p>
    </div>
</c:if>
<c:import url="../footer.jsp"/>