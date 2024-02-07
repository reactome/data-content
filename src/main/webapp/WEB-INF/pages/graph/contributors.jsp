<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="../header.jsp"/>
<div class="favth-col-lg-12">

    <fmt:formatNumber  var="personAuthorReviewersSize" type="number" value="${fn:length(personAuthorReviewers)}"/>
    <fmt:formatNumber var="count" type="number" value="${count}"/>


    <c:set var="pageWithNumber" value="${personAuthorReviewersSize} / ${count}"/>
    <c:set var="number"  value="${page == 'all'? count : pageWithNumber}"/>

    <div>
        <h3 style="margin-left: 5px">Contributors (${number})</h3>

        <p>We value the contributions from authors, curators, and reviewers of Reactome content. Here is a list of Reactome
            contributors who have authored or reviewed reactions or pathways, with links to their ORCID profiles.</p>
        <p>If you want to add ORCID to your profile, you can quickly and easily claim your Reactome contributions in ORCID
        using our ORCID claiming feature, described <a href="userguide/claim-your-work">here</a>. Please visit our <a
            href="https://academic.oup.com/database/article/doi/10.1093/database/baz123/5645654"
            target="_blank">paper</a>, to learn more about Reactome and ORCID credit attribution.</p>
       <p> If you are interested in contributing to Reactome and receiving credit for your contributions, please visit the
           following <a href="community/collaboration">page</a> for pathways that are ready for external review. If you'd like to contribute a pathway that is
           not on this list, please <a href="about/contact-us">contact us</a>. We would be happy to work with you!</p>
    </div>
    <div class="favth-col-xs-12">
    <div id="pagination" class="pagination" style="margin: 1% auto">
        <ul class="pagination-list">
            <c:forEach var="val" items="${letters}">
                <c:choose>
                    <c:when test="${val eq page}">
                        <li class="active"><a style="padding: 10px 14px">${val}</a></li>
                    </c:when>
                    <c:when test="${val eq 'All'}">
                        <c:choose>
                            <c:when test="${page eq 'All'}">
                                <li class="active"><a style="padding: 10px 14px" href="contributors">${val}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a style="padding: 10px 14px" href="?page=${val}">${val}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <li><a style="padding: 10px 14px" href="?page=${val}">${val}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
</div>


<c:if test="${not empty personAuthorReviewers}">

    <div id="r-responsive-table">
        <table class="reactome" style="width:100%; border:0;">
            <thead>
            <tr>
                <th scope="col">Name</th>
                <th scope="col" style="text-align:center">ORCID</th>
                <th scope="col" style="text-align:center">Authored Pathways</th>
                <th scope="col" style="text-align:center">Authored Reactions</th>
                <th scope="col" style="text-align:center">Reviewed Pathways</th>
                <th scope="col" style="text-align:center">Reviewed Reactions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="contributor" items="${personAuthorReviewers}">
                <tr>
                    <td data-label="Name">
                        <c:set var="id"
                               value="${not empty contributor.person.orcidId ? contributor.person.orcidId  : contributor.person.dbId}"/>
                        <c:set var="fullname"
                               value="${contributor.person.surname}, ${not empty contributor.person.firstname ? contributor.person.firstname  : contributor.person.initial}"/>
                        <a href="/content/detail/person/${id}"
                           title="Show person details">${fullname}</a>
                    </td>

                    <td data-label="ORCID" style="text-align:center">
                        <a href="https://orcid.org/${contributor.person.orcidId}" target="_blank"
                           title="Open in ORCID">${contributor.person.orcidId}</a>
                    </td>

                    <td data-label="Authored Pathways" style="text-align:center">
                            ${contributor.authoredPathways}
                    </td>

                    <td data-label="Reviewed Pathways" style="text-align:center">
                            ${contributor.reviewedPathways}
                    </td>

                    <td data-label="Authored Reactions" style="text-align:center">
                            ${contributor.authoredReactions}
                    </td>

                    <td data-label="Reviewed Reactions" style="text-align:center">
                            ${contributor.reviewedReactions}
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

</div>
<c:import url="../footer.jsp"/>
