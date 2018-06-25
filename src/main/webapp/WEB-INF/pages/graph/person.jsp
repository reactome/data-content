<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

        <c:if test="${not empty authored}">
            <fieldset class="fieldset-details">
                <legend>Authored (${fn:length(authored)})</legend>
                <div id="r-responsive-table" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                            <tr>
                                <th scope="col" style="width:15%;">Identifier</th>
                                <th scope="col" style="width:85%;">Pathway</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="authoredPathway" items="${authored}">
                            <tr>
                                <td data-label="Identifier">
                                    <a href="./../${authoredPathway.stId}" title="Go to Pathway ${authoredPathway.stId}"> ${authoredPathway.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <a href="/cgi-bin/bibtex?DB_ID=${authoredPathway.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank"> <i class="fa fa-file-code-o"></i></a><span>${authoredPathway.displayName}</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </fieldset>
        </c:if>

        <c:if test="${not empty reviewed}">
            <fieldset class="fieldset-details">
                <legend>Reviewed (${fn:length(reviewed)})</legend>
                <div id="r-responsive-table-reviewed" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                        <tr>
                            <th scope="col" style="width:15%;">Identifier</th>
                            <th scope="col" style="width:85%;">Pathway</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reviewedPathway" items="${reviewed}">
                            <tr>
                                <td data-label="Identifier">
                                    <a href="./../${reviewedPathway.stId}" title="Go to Pathway ${reviewedPathway.stId}" >${reviewedPathway.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <a href="/cgi-bin/bibtex?DB_ID=${reviewedPathway.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank"> <i class="fa fa-file-code-o"></i></a><span>${reviewedPathway.displayName}</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </fieldset>
        </c:if>
    </div>
</c:if>
<c:import url="../footer.jsp"/>