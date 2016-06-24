<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<h3 class="details-title">

    <c:choose>
        <c:when test="${hasReferenceEntity}">
            <i class="sprite sprite-${databaseObject.referenceType}" title="${type}"></i>
        </c:when>
        <c:otherwise>
            <c:if test="${not empty databaseObject.schemaClass}">
                <i class="sprite sprite-${databaseObject.schemaClass}" title="${type}"></i>
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

<div class="extended-header">
    <c:if test="${not empty databaseObject.stId}">
        <div class="label">
            <span>Stable Identifier</span>
        </div>
        <div class="field">
            <span>${databaseObject.stId}</span>
        </div>
        <div class="clear"></div>
    </c:if>

    <c:if test="${not empty databaseObject.schemaClass}">
        <div class="label">
            <span>Type</span>
        </div>
        <div class="field">
            <span title="${databaseObject.explanation}">${databaseObject.className}</span>
        </div>
        <div class="clear"></div>
    </c:if>

    <c:if test="${clazz != 'Regulation'}">
        <c:if test="${not empty databaseObject.speciesName}">
            <div class="label">
                <span>Species</span>
            </div>
            <div class="field">
                <span>${databaseObject.speciesName}</span>
            </div>
            <div class="clear"></div>
        </c:if>
        <c:if test="${not empty databaseObject.compartment}">
            <div class="label">
                <span>Compartment</span>
            </div>
            <div class="field">
                <c:forEach var="compartment" items="${databaseObject.compartment}" varStatus="loop">
                    <span><a href="${compartment.url}" class="" rel="nofollow" title="Show ${compartment.name}">${compartment.name}</a><c:if test="${not loop.last}">, </c:if></span>
                </c:forEach>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${not empty databaseObject.name && fn:length(databaseObject.name) gt 1}">
            <div class="label">
                <span>Synonyms</span>
            </div>
            <div class="field">
                <c:forEach var="synonym" items="${databaseObject.name}" varStatus="loop">
                    <c:if test="${!loop.first}">${synonym}</c:if><c:if test="${!loop.first && !loop.last}">, </c:if>
                </c:forEach>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${clazz == 'PhysicalEntity'}">
            <c:if test="${not empty databaseObject.goCellularComponent}">
                <div class="label"><span>GO Cellular Component</span></div>
                <div class="field">
                    <a href="${databaseObject.goCellularComponent.url}" class="" title="show ${databaseObject.goCellularComponent.name}" rel="nofollow">${databaseObject.goCellularComponent.name}</a> (${databaseObject.goCellularComponent.accession})
                </div>
                <div class="clear"></div>
            </c:if>
        </c:if>

    </c:if>
</div>

