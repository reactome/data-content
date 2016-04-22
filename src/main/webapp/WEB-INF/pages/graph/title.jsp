<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid_23 padding">
    <h3>
        <c:if test="${not empty databaseObject.schemaClass}">
            <i class="sprite sprite-${databaseObject.schemaClass}" title="${type}"></i>
        </c:if>

        <c:if test="${clazz == 'Event'}">
            <c:if test="${databaseObject.isInDisease}">
                <i class="sprite sprite-isDisease" title="Disease related entry"></i>
            </c:if>
        </c:if>

        <c:choose>
            <c:when test="${clazz == 'Regulation'}">
                <c:choose>
                    <c:when test="${not empty databaseObject.name}">
                        <c:out value="${databaseObject.name[0]}" />
                    </c:when>
                    <c:otherwise>
                        <c:out value="${databaseObject.displayName}" />
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:out value="${databaseObject.displayName}" />
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty databaseObject.stableIdentifier}">
            <span> (${databaseObject.stableIdentifier})</span>
        </c:if>
        <c:if test="${clazz != 'Regulation'}">
            <c:if test="${not empty databaseObject.speciesName}">
                <span>[${databaseObject.speciesName}]</span>
            </c:if>
        </c:if>
    </h3>
    <c:if test="${not empty databaseObject.schemaClass}">
        <span style="color: #1F419A; padding-left: 6px; font-size: 20px" title="${databaseObject.explanation}">${type}</span>
    </c:if>
</div>


<c:if test="${not empty databaseObject.compartment}">
    <div class="grid_23  padding  margin">
        <h5>Compartment</h5>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td>Database</td>
                <td>Identifier</td>
                <td>Definition</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="compartment" items="${databaseObject.compartment}">
                <tr>
                    <td><strong>${compartment.databaseName}</strong></td>
                    <td><a href="${compartment.url}" class="" title="Show Details" rel="nofollow">${compartment.name}</a></td>
                    <td>${compartment.definition}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


</c:if>


<%--Both physicalEntities and event can have a summation--%>
<c:if test="${not empty databaseObject.summation}">
    <div class="grid_23  padding">
        <h5>Summation</h5>
        <div class="paddingleft">
            <c:forEach var="summation" items="${databaseObject.summation}">
                <p>${summation.text}</p>
            </c:forEach>
        </div>
    </div>
</c:if>


