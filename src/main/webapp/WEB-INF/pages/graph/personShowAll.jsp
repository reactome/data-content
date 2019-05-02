<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<c:import url="../header.jsp"/>

<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession" />
<c:set value="${not empty tokenSession && (person.orcidId == tokenSession.orcid) || (not empty param['orcidtest'] && tokenSession.orcid == param['orcidtest'])}" var="isAuthenticated" />

<%-- Person Page--%>
<c:if test="${not empty person}">
    <c:choose>
        <c:when test="${not empty person.orcidId}">
            <a href="${pageContext.request.contextPath}/detail/person/${person.orcidId}" class="" title="Return to person details">  <<< Go back</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/detail/person/${person.dbId}" class="" title="Return to person details">  <<< Go back</a>
        </c:otherwise>
    </c:choose>
    <div class="favth-col-xs-12">
        <h3 class="details-title">
            <i class="sprite sprite-Person"></i>
            <c:set var="personName" value="${person.displayName}" />
            <c:choose>
                <c:when test="${not empty person.firstname && not empty person.surname}">
                    <c:set var="personName" value="${person.firstname}&nbsp;${person.surname}" />
                    <span>${person.firstname}&nbsp;${person.surname}</span>
                </c:when>
                <c:otherwise>
                    <span>${person.displayName}</span>
                </c:otherwise>
            </c:choose>
        </h3>
        <div class="extended-header favth-clearfix">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12" style="line-height:22px; <c:if test="${isAuthenticated}">line-height:30px;</c:if>" >
                <c:if test="${isAuthenticated}">
                    <img alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="13" height="13" hspace="4" title="You are logged in with your ORCID account"/>
                </c:if>
                <span>ORCID<a href="/orcid" title="Click here to know more about Orcid Integration">&nbsp;<i class="fa fa-external-link" aria-hidden="true" style="font-size: 12px; padding-right: 0;"></i></a></span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:if test="${not empty person.orcidId}">
                    <span><a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank">${person.orcidId}</a></span>
                </c:if>

                <c:if test="${empty tokenSession}">
                    <button id="connect-orcid-button"><img id="orcid-id-icon" alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="16" height="16" hspace="4" title="ORCID provides a persistent digital identifier that distinguishes you from other researchers. Learn more at orcid.org"/>Are you ${personName} ? Register or Connect your ORCID</button>
                </c:if>

                <c:choose>
                    <c:when test="${isAuthenticated}">
                        <button id="claim-your-work-${claimyourworkpath}" name="${claimyourworkpath}"><img id="orcid-id-icon-${claimyourworkpath}" alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="16" height="16" hspace="4"/>Claim ${fn:toLowerCase(label)} (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(list)}"/>)</button>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${empty person.orcidId && not empty tokenSession}">
                            <div>
                                <span>Let us know your <img alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="16" height="16" hspace="4" class="margin margin0" style="margin-bottom: 3px; margin-right: 1px;"/>ORCID. Contact <a href="mailto:help@reactome.org?subject=[ORCID]I'd like my Orcid to be added in Reactome&body=Name: %0D%0AORCID: ">help@reactome.org</a></span>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>

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

        <c:if test="${not empty list}">
            <fieldset class="fieldset-details">
                <legend>${label} (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(list)}"/>)</legend>
                <div id="r-responsive-table-ap" class="details-wrap" style="max-height: none;">
                    <table class="reactome">
                        <thead>
                            <tr>
                                <th scope="col" style="width:10%;">Date</th>
                                <th scope="col" style="width:15%;">Identifier</th>
                                <th scope="col" style="width:70%;">${type}</th>
                                <th scope="col" style="width:5%;">Reference</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td data-label="Date">
                                    <c:choose>
                                        <c:when test="${attribute eq 'authored'}">
                                            <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${item.authored[0].dateTime}" var="date"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${item.reviewed[0].dateTime}" var="date"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="/content/detail/${item.stId}" title="Go to Pathway ${item.stId}"> ${item.stId}</a>
                                </td>
                                <td data-label="${type}">
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
            </fieldset>
        </c:if>

    </div>
</c:if>

<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<c:import url="personCommon.jsp"/>
<c:import url="../footer.jsp"/>