<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession"/>
<c:set value="${showOrcidBtn && not empty tokenSession && (person.orcidId == tokenSession.orcid)}"
       var="isAuthenticated"/>
<c:choose>
    <c:when test="${not empty widget}">
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
    </c:when>
    <c:otherwise>
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
    </c:otherwise>
</c:choose>

<div class="favth-col-xs-12 ">
    <h3 class="details-title">
        <i class="sprite sprite-Person"></i>
        <c:set var="personName" value="${person.displayName}"/>
        <c:choose>
            <c:when test="${not empty person.firstname && not empty person.surname}">
                <c:set var="personName" value="${person.firstname}&nbsp;${person.surname}"/>
                <span>${personName}</span>
            </c:when>
            <c:otherwise>
                <span>${person.displayName}</span>
            </c:otherwise>
        </c:choose>
    </h3>

    <div class="extended-header favth-clearfix">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12"
             style="line-height:22px; <c:if test="${isAuthenticated}">line-height:30px;</c:if>">
                        <span><a href="/orcid" title="Click here to know more about Orcid Integration"><i
                                class="fa fa-info-circle" aria-hidden="true"
                                style="font-size: 12px; padding-right: 0;"></i></a>&nbsp;ORCID</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <c:if test="${isAuthenticated}">
                <a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank"><img
                        alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="13"
                        height="13" hspace="4" title="You are logged in with your ORCID account"/></a>
            </c:if>
            <c:if test="${not empty person.orcidId}">
                <span><a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank">https://orcid.org/${person.orcidId}</a></span>
            </c:if>

            <c:if test="${empty tokenSession && showOrcidBtn}">
                <button id="connect-orcid-button"><img id="orcid-id-icon" alt="ORCID logo"
                                                       src="/content/resources/images/orcid_16x16.png"
                                                       width="16" height="16" hspace="4"
                                                       title="ORCID provides a persistent digital identifier that distinguishes you from other researchers. Learn more at orcid.org"/>Are
                    you ${personName} ? Register or Connect your ORCID
                </button>
            </c:if>

            <c:choose>
                <c:when test="${isAuthenticated}">
                    <c:set var="allWorks"
                           value="${authoredPathwaysSize + authoredReactionsSize + reviewedPathwaysSize + reviewedReactionsSize}"/>
                    <button id="claim-your-work" name="all"><img id="orcid-id-icon-all" alt="ORCID logo"
                                                                 src="/content/resources/images/orcid_16x16.png"
                                                                 width="16" height="16" hspace="4"/>Claim
                        all work (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                    value="${allWorks}"/>)
                    </button>
                </c:when>
                <c:otherwise>
                    <c:if test="${showOrcidBtn && (empty person.orcidId && not empty tokenSession)}">
                        <div>
                                        <span><a href="/content/orcid/let-us-know-your-orcid" rel="nofollow noindex">Let us know your <img
                                                alt="ORCID logo" src="/content/resources/images/orcid_16x16.png"
                                                width="16" height="16" hspace="4" class="margin margin0"
                                                style="margin-bottom: 3px; margin-right: 1px;"/>ORCID.</a> </span>
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

    <div class="favth-clearfix">
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
    </div>

    <c:if test="${not empty authoredPathways}">
        <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Authored Pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                             value="${fn:length(authoredPathways)}"/>/<fmt:formatNumber
                        type="number" maxFractionDigits="3" value="${authoredPathwaysSize}"/>)
                </legend>
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
                                    <fmt:parseDate pattern="yyyy-MM-dd H:m:s"
                                                   value="${item.dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="${detailRequestPrefix}${item.stId}"
                                       title="Go to Pathway ${item.stId}"> ${item.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <span>${item.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/ContentService/citation/export/${item.stId}?ext=bib"
                                       title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                         style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="${detailRequestPrefix}person/${person.orcidId}/pathways/authored" class=""
                                   title="Show all">Show
                                    all authored pathways...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${detailRequestPrefix}person/${person.dbId}/pathways/authored" class=""
                                   title="Show all">Show
                                    all authored pathways...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${isAuthenticated}">
                    <c:set var="columns"
                           value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                    <c:if test="${param['showAll']}">
                        <c:set var="columns" value="favth-col-xs-12"/>
                    </c:if>
                    <div class="${columns} text-right text-xs-center">
                        <button id="claim-your-work-pa" name="pa"><img id="orcid-id-icon-pa"
                                                                       alt="ORCID logo"
                                                                       src="/content/resources/images/orcid_16x16.png"
                                                                       width="16" height="16" hspace="4"/>Claim
                            authored pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                 value="${authoredPathwaysSize}"/>)
                        </button>
                    </div>
                </c:if>
            </fieldset>
        </div>
    </c:if>

    <c:if test="${not empty authoredReactions}">
        <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Authored Reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${fn:length(authoredReactions)}"/>/<fmt:formatNumber
                        type="number" maxFractionDigits="3" value="${authoredReactionsSize}"/>)
                </legend>
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
                                    <fmt:parseDate pattern="yyyy-MM-dd H:m:s"
                                                   value="${authoredReaction.dateTime}"
                                                   var="date"/>
                                    <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="${detailRequestPrefix}${authoredReaction.stId}"
                                       title="Go to Reaction ${authoredReaction.stId}"> ${authoredReaction.stId}</a>
                                </td>
                                <td data-label="Reaction">
                                    <span>${authoredReaction.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/ContentService/citation/export/${authoredReaction.stId}?ext=bib"
                                       title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                         style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="${detailRequestPrefix}person/${person.orcidId}/reactions/authored" class=""
                                   title="Show all">Show
                                    all authored reactions...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${detailRequestPrefix}person/${person.dbId}/reactions/authored" class=""
                                   title="Show all">Show
                                    all authored reactions...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${isAuthenticated}">
                    <c:set var="columns"
                           value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                    <c:if test="${param['showAll']}">
                        <c:set var="columns" value="avth-col-xs-12"/>
                    </c:if>
                    <div class="${columns} text-right text-xs-center">
                        <button id="claim-your-work-ra" name="ra"><img id="orcid-id-icon-pr"
                                                                       alt="ORCID logo"
                                                                       src="/content/resources/images/orcid_16x16.png"
                                                                       width="16" height="16" hspace="4"/>Claim
                            authored reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                  value="${authoredReactionsSize}"/>)
                        </button>
                    </div>
                </c:if>
            </fieldset>
        </div>
    </c:if>

    <c:if test="${not empty reviewedPathways}">
        <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Reviewed Pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                             value="${fn:length(reviewedPathways)}"/>/<fmt:formatNumber
                        type="number" maxFractionDigits="3" value="${reviewedPathwaysSize}"/>)
                </legend>
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
                                    <fmt:parseDate pattern="yyyy-MM-dd H:m:s"
                                                   value="${reviewedPathway.dateTime}"
                                                   var="date"/>
                                    <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="${detailRequestPrefix}${reviewedPathway.stId}"
                                       title="Go to Pathway ${reviewedPathway.stId}">${reviewedPathway.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <span>${reviewedPathway.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/ContentService/citation/export/${reviewedPathway.stId}?ext=bib"
                                       title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                         style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="${detailRequestPrefix}person/${person.orcidId}/pathways/reviewed" class=""
                                   title="Show all">Show
                                    all reviewed pathways...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${detailRequestPrefix}person/${person.dbId}/pathways/reviewed" class=""
                                   title="Show all">Show
                                    all reviewed pathways...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${isAuthenticated}">
                    <c:set var="columns"
                           value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                    <c:if test="${param['showAll']}">
                        <c:set var="columns" value="favth-col-xs-12"/>
                    </c:if>
                    <div class="${columns} text-right text-xs-center">
                        <button id="claim-your-work-pr" name="pr"><img id="orcid-id-icon-ra"
                                                                       alt="ORCID logo"
                                                                       src="/content/resources/images/orcid_16x16.png"
                                                                       width="16" height="16" hspace="4"/>Claim
                            reviewed pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                 value="${reviewedPathwaysSize}"/>)
                        </button>
                    </div>
                </c:if>

            </fieldset>
        </div>
    </c:if>

    <c:if test="${not empty reviewedReactions}">
        <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Reviewed Reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${fn:length(reviewedReactions)}"/>/<fmt:formatNumber
                        type="number" maxFractionDigits="3" value="${reviewedReactionsSize}"/>)
                </legend>
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
                                    <fmt:parseDate pattern="yyyy-MM-dd H:m:s"
                                                   value="${reviewedReaction.dateTime}"
                                                   var="date"/>
                                    <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="${detailRequestPrefix}${reviewedReaction.stId}"
                                       title="Go to Reaction ${reviewedReaction.stId}">${reviewedReaction.stId}</a>
                                </td>
                                <td data-label="Reaction">
                                    <span>${reviewedReaction.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/ContentService/citation/export/${reviewedReaction.stId}?ext=bib"
                                       title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                         style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="${detailRequestPrefix}person/${person.orcidId}/reactions/reviewed" class=""
                                   title="Show all">Show
                                    all reviewed reactions...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${detailRequestPrefix}person/${person.dbId}/reactions/reviewed" class=""
                                   title="Show all">Show
                                    all reviewed reactions...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${isAuthenticated}">
                    <c:set var="columns"
                           value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                    <c:if test="${param['showAll']}">
                        <c:set var="columns" value="favth-col-xs-12"/>
                    </c:if>
                    <div class="${columns} text-right text-xs-center">
                        <button id="claim-your-work-rr" name="rr"><img id="orcid-id-icon-rr"
                                                                       alt="ORCID logo"
                                                                       src="/content/resources/images/orcid_16x16.png"
                                                                       width="16" height="16" hspace="4"/>Claim
                            reviewed reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                  value="${reviewedReactionsSize}"/>)
                        </button>
                    </div>
                </c:if>

            </fieldset>
        </div>
    </c:if>
</div>