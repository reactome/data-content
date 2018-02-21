<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<h3 class="details-title">
    <c:choose>
        <c:when test="${hasReferenceEntity}">
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
    <c:choose>
        <%-- Always take the first name. If not present then take the displayName --%>
        <c:when test="${not empty databaseObject.name}">
            <c:out value="${databaseObject.name[0]}" />
        </c:when>
        <c:otherwise>
            <c:out value="${databaseObject.displayName}" />
        </c:otherwise>
    </c:choose>
</h3>

<div class="extended-header favth-clearfix">
    <c:if test="${not empty databaseObject.stId}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Stable Identifier</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${databaseObject.stId}</span>
        </div>
    </c:if>

    <c:if test="${not empty databaseObject.schemaClass}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Type</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span title="${databaseObject.explanation}">${databaseObject.className} <c:if test="${databaseObject.schemaClass ne databaseObject.className}">[${databaseObject.schemaClass}]</c:if></span>
        </div>
    </c:if>

    <c:if test="${clazz != 'Regulation'}">
        <c:if test="${not empty databaseObject.speciesName}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Species</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <span>${databaseObject.speciesName}</span>
            </div>
        </c:if>
        <c:if test="${not empty relatedSpecies}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Related Species</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:forEach var="relatedSpecies" items="${relatedSpecies}" varStatus="loop">
                    <span>${relatedSpecies.displayName}<c:if test="${not loop.last}">, </c:if></span>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.compartment}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Compartment</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:forEach var="compartment" items="${databaseObject.compartment}" varStatus="loop">
                    <span><a href="${compartment.url}" target="_blank"  title="Show ${compartment.name}">${compartment.name}</a><c:if test="${not loop.last}">, </c:if></span>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${not empty databaseObject.name && fn:length(databaseObject.name) gt 1}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Synonyms</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:forEach var="synonym" items="${databaseObject.name}" varStatus="loop">
                    <c:if test="${!loop.first}">${synonym}</c:if><c:if test="${!loop.first && !loop.last}">, </c:if>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${clazz == 'PhysicalEntity'}">
            <c:if test="${not empty databaseObject.goCellularComponent}">
                <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                    <span>GO Cellular Component</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                    <a href="${databaseObject.goCellularComponent.url}" class="" title="show ${databaseObject.goCellularComponent.name}" >${databaseObject.goCellularComponent.name}</a> (${databaseObject.goCellularComponent.accession})
                </div>
            </c:if>
        </c:if>

    </c:if>
</div>

