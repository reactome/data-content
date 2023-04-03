<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="myTld" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="/content/resources/css/score.css" type="text/css">

<c:set var = "url" value ="${pageContext.request.serverName}"/>

<h3 class="details-title">
    <c:choose>
        <c:when test="${hasReferenceEntity && (databaseObject.schemaClass == 'EntityWithAccessionedSequence' || databaseObject.schemaClass == 'SimpleEntity')}">
            <i class="sprite sprite-${databaseObject.referenceType}" title="${databaseObject.referenceType}"></i>
        </c:when>
        <c:otherwise>
            <c:if test="${not empty databaseObject.schemaClass}">
                <i class="sprite sprite-${databaseObject.schemaClass}" title="${databaseObject.schemaClass}"></i>
            </c:if>
        </c:otherwise>
    </c:choose>

    <c:if test="${clazz == 'Event'}">
        <c:if test="${databaseObject.isInDisease}">
            <i class="sprite sprite-isDisease" title="Disease related entry"></i>
        </c:if>
    </c:if>
    <c:out value="${title}" />
    <%--<c:choose>--%>
        <%--&lt;%&ndash; Always take the first name. If not present then take the displayName &ndash;%&gt;--%>
        <%--<c:when test="${not empty databaseObject.name}">--%>
            <%--<c:out value="${databaseObject.name[0]}" />--%>
        <%--</c:when>--%>
        <%--<c:otherwise>--%>
            <%--<c:out value="${databaseObject.displayName}" />--%>
        <%--</c:otherwise>--%>
    <%--</c:choose>--%>
</h3>

<%--
   Creating responsive design in case an icon is present
   columns-css by default doesn't split the grid and it is 12.
   Once the icon is present we desing it in 9-3 grid.
--%>
<c:set var="columnsCss" value="favth-col-xs-12" />
<c:if test="${not empty icon}">
    <c:set var="columnsCss" value="favth-col-lg-10 favth-col-md-10 favth-col-sm-10 favth-col-xs-12" />
    <c:set var="iconName" value="${fn:split(icon, '/')[1]}" />
    <c:set var="hasIcon" value="true" />
</c:if>

<c:choose>
    <c:when test="${not empty widget}">
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
    </c:when>
    <c:otherwise>
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
    </c:otherwise>
</c:choose>

<div class="extended-header favth-clearfix">
    <div class="${columnsCss}">
        <c:if test="${not empty databaseObject.stId}">
            <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                <span>Stable Identifier</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                <span>${databaseObject.stId}</span>
            </div>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'Pathway'}">
            <c:if test="${not empty databaseObject.doi}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                    <span>DOI</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                <span>  <a href="https://search.crossref.org/?q=${databaseObject.doi}" target="_blank"
                           title="Search in Crossref">${databaseObject.doi}</a></span>
                </div>
            </c:if>
        </c:if>

        <c:if test="${not empty databaseObject.schemaClass}">
            <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                <span>Type</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
            <%-- show category for ReactionLikeEvent --%>
                <span title="${databaseObject.explanation}">${fn:replace(databaseObject.className, "TopLevel", "")}
                    <c:choose>
                        <c:when test="${not empty rleCategory}">[${rleCategory}]</c:when>
                        <c:otherwise><c:if test="${databaseObject.schemaClass ne databaseObject.className}">[${databaseObject.schemaClass}]</c:if></c:otherwise>
                    </c:choose>
                </span>
            </div>
        </c:if>

        <c:if test="${clazz != 'Regulation'}">
            <c:if test="${not empty databaseObject.speciesName}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                    <span>Species</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                    <span>${databaseObject.speciesName}</span>
                </div>
            </c:if>
            <c:if test="${not empty relatedSpecies}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                    <span>Related Species</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                    <c:forEach var="relatedSpecies" items="${relatedSpecies}" varStatus="loop">
                        <span>${relatedSpecies.displayName}<c:if test="${not loop.last}">, </c:if></span>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${not empty databaseObject.compartment}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                    <span>Compartment</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                    <c:forEach var="compartment" items="${databaseObject.compartment}" varStatus="loop">
                        <span><a href="${compartment.url}" target="_blank"  title="Show ${compartment.name}">${compartment.name}</a><c:if test="${not loop.last}">, </c:if></span>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${not empty databaseObject.name && fn:length(databaseObject.name) gt 1}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                    <span>Synonyms</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                    <c:forEach var="synonym" items="${databaseObject.name}" varStatus="loop">
                        <c:if test="${!loop.first}">${synonym}</c:if><c:if test="${!loop.first && !loop.last}">, </c:if>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${clazz == 'PhysicalEntity'}">
                <c:if test="${not empty databaseObject.goCellularComponent}">
                    <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12">
                        <span>GO Cellular Component</span>
                    </div>
                    <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                        <a href="${databaseObject.goCellularComponent.url}" class="" title="show ${databaseObject.goCellularComponent.name}" >${databaseObject.goCellularComponent.name}</a> (${databaseObject.goCellularComponent.accession})
                    </div>
                </c:if>
            </c:if>

            <%-- This is visible on phones only, if you change something here, consider changing also #hidden-xs --%>
            <c:if test="${hasIcon}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12 favth-visible-xs">
                    <a href="${detailRequestPrefix}${icon}" title="Open icon detail">Icon</a>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12 favth-visible-xs">
                    <a href="${detailRequestPrefix}${icon}" title="Open icon detail">
                        <img style="width: 100px; height: 50px;" src="/icon/${icon}.svg" alt="${databaseObject.displayName} icon" />
                    </a>
                </div>
            </c:if>
        </c:if>

        <c:if test="${clazz == 'Event'}">
            <c:if test="${not empty databaseObject.reviewStatus}">
                <div class="details-label favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-12"
                     style="margin-top: 8px">
                    <span>ReviewStatus</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
                    <c:set var="star" value="${databaseObject.reviewStatus.displayName}"/>
                    <c:choose>
                        <c:when test="${star == 'five stars'}">
                            <c:set var="score" value="100"/>
                        </c:when>
                        <c:when test="${star == 'four stars'}">
                            <c:set var="score" value="80"/>
                        </c:when>
                        <c:when test="${star == 'three stars'}">
                            <c:set var="score" value="60"/>
                        </c:when>
                        <c:when test="${star == 'two stars'}">
                            <c:set var="score" value="40"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="score" value="20"/>
                        </c:otherwise>
                    </c:choose>
                    <div class="c100 p${score} small">
                        <span><a href="https://${url}/userguide/review-status" target="_blank"
                                 title="Read more details"><fmt:formatNumber type="number" maxFractionDigits="0"
                                                                             value="${score/20}"/>/5</a></span>
                        <div class="slice">
                            <div class="bar"></div>
                            <div class="fill"></div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>
    </div>
    <c:if test="${hasIcon}"> <%-- #hidden-xs --%>
        <a href="${detailRequestPrefix}${icon}" title="Open icon detail" >
            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2 favth-col-xs-12 text-center favth-hidden-xs details-icon-pe">
                <img style="width: 200px; height: 85px;" src="/icon/${icon}.svg" alt="${databaseObject.displayName} icon"/>
            </div>
        </a>
    </c:if>
</div>

