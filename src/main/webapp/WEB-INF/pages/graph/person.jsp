<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<c:import url="../header.jsp"/>

<%-- Person Page--%>
<c:if test="${not empty person}">
    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 ">
        <h3 class="details-title">
            <i class="sprite sprite-Person"></i>
            <c:choose>
                <c:when test="${not empty person.firstname && not empty person.surname}">
                    <span>${person.firstname}&nbsp;${person.surname}</span>
                </c:when>
                <c:otherwise>
                    <span>${person.displayName}</span>
                </c:otherwise>
            </c:choose>
        </h3>

        <c:choose>
            <c:when test="${param['showAll']}">
                <div>
                    <a href="?" class="btn btn-info person-switch-btn">Show Summary</a>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <a href="?showAll=true" class="btn btn-info person-switch-btn">Expand All</a>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="extended-header favth-clearfix">
            <c:if test="${not empty person.orcidId}">
                <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                    <span>Orcid ID</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                    <span><a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank">${person.orcidId}</a></span>
                </div>
            </c:if>
            <c:if test="${not empty person.project}">
                <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                    <span>Project</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                    <span>${person.project}</span>
                </div>
            </c:if>
            <c:if test="${not empty person.affiliation}">
                <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                    <span>Affiliation</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                    <div>
                        <c:forEach var="aff" items="${person.affiliation}" varStatus="loop">
                            ${aff.displayName}<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>

        <c:if test="${not empty authoredPathways}">
            <fieldset class="fieldset-details">
                <legend>Authored Pathways (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(authoredPathways)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${authoredPathwaysSize}"/>)</legend>
                <div id="r-responsive-table-ap" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                            <tr>
                                <th scope="col" style="width:10%;">Date</th>
                                <th scope="col" style="width:15%;">Identifier</th>
                                <th scope="col" style="width:70%;">Pathway</th>
                                <th scope="col" style="width:5%;">Reference</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${authoredPathways}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${item.authored[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${item.stId}" title="Go to Pathway ${item.stId}"> ${item.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <span>${item.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${item.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div style="padding: 5px 0 0 14px;">
                    <c:choose>
                        <c:when test="${not empty person.orcidId}">
                            <a href="./${person.orcidId}/pathways/authored" class="" title="Show all" >Show all authored pathways...</a>
                        </c:when>
                        <c:otherwise>
                            <a href="./${person.id}/pathways/authored" class="" title="Show all" >Show all authored pathways...</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </fieldset>
        </c:if>

        <c:if test="${not empty authoredReactions}">
            <fieldset class="fieldset-details">
                <legend>Authored Reactions (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(authoredReactions)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${authoredReactionsSize}"/>)</legend>
                <div id="r-responsive-table-ar" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                        <tr>
                            <th scope="col" style="width:10%;">Date</th>
                            <th scope="col" style="width:15%;">Identifier</th>
                            <th scope="col" style="width:70%;">Reaction</th>
                            <th scope="col" style="width:5%;">Reference</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="authoredReaction" items="${authoredReactions}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${authoredReaction.authored[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${authoredReaction.stId}" title="Go to Pathway ${authoredReaction.stId}"> ${authoredReaction.stId}</a>
                                </td>
                                <td data-label="Reaction">
                                    <span>${authoredReaction.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${authoredReaction.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div style="padding: 5px 0 0 14px;">
                    <c:choose>
                        <c:when test="${not empty person.orcidId}">
                            <a href="./${person.orcidId}/pathways/reviewed" class="" title="Show all" >Show all reviewed pathways...</a>
                        </c:when>
                        <c:otherwise>
                            <a href="./${person.id}/pathways/reviewed" class="" title="Show all" >Show all reviewed pathways...</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </fieldset>
        </c:if>

        <c:if test="${not empty reviewedPathways}">
            <fieldset class="fieldset-details">
                <legend>Reviewed Pathways (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(reviewedPathways)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${reviewedPathwaysSize}"/>)</legend>
                <div id="r-responsive-table-reviewed-rp" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                        <tr>
                            <th scope="col" style="width:10%;">Date</th>
                            <th scope="col" style="width:15%;">Identifier</th>
                            <th scope="col" style="width:70%;">Pathway</th>
                            <th scope="col" style="width:5%;">Reference</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reviewedPathway" items="${reviewedPathways}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${reviewedPathway.reviewed[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${reviewedPathway.stId}" title="Go to Pathway ${reviewedPathway.stId}" >${reviewedPathway.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <span>${reviewedPathway.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${reviewedPathway.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div style="padding: 5px 0 0 14px;">
                    <c:choose>
                        <c:when test="${not empty person.orcidId}">
                            <a href="./${person.orcidId}/reactions/authored" class="" title="Show all" >Show all authored reactions...</a>
                        </c:when>
                        <c:otherwise>
                            <a href="./${person.id}/reactions/authored" class="" title="Show all" >Show all authored reactions...</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </fieldset>
        </c:if>

        <c:if test="${not empty reviewedReactions}">
            <fieldset class="fieldset-details">
                <legend>Reviewed Reactions (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(reviewedReactions)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${reviewedReactionsSize}"/>)</legend>
                <div id="r-responsive-table-reviewed-rr" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                        <tr>
                            <th scope="col" style="width:10%;">Date</th>
                            <th scope="col" style="width:15%;">Identifier</th>
                            <th scope="col" style="width:70%;">Reaction</th>
                            <th scope="col" style="width:5%;">Reference</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reviewedReaction" items="${reviewedReactions}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${reviewedReaction.reviewed[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${reviewedReaction.stId}" title="Go to Pathway ${reviewedReaction.stId}" >${reviewedReaction.stId}</a>
                                </td>
                                <td data-label="Reaction">
                                    <span>${reviewedReaction.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${reviewedReaction.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div style="padding: 5px 0 0 14px;">
                    <c:choose>
                        <c:when test="${not empty person.orcidId}">
                            <a href="./${person.orcidId}/reactions/reviewed" class="" title="Show all" >Show all reviewed reactions...</a>
                        </c:when>
                        <c:otherwise>
                            <a href="./${person.id}/reactions/reviewed" class="" title="Show all" >Show all reviewed reactions...</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </fieldset>
        </c:if>
    </div>
</c:if>
<c:import url="../footer.jsp"/>