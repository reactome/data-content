<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="http://www.reactome.org/common/header.php"/>
<div class="ebi-content">

    <div class="grid_23 padding">
        <h3>

            <%--<c:set var="test" value="${databaseObject}" scope="request"/>--%>

            <c:if test="${not empty databaseObject.schemaClass}">
                <img src="../resources/images/${databaseObject.schemaClass}.png" title="${databaseObject.schemaClass}" height="20" />
            </c:if>
            <c:if test="${clazz == 'Event'}">
                <c:if test="${databaseObject.isInDisease}">
                    <img src="../resources/images/isDisease.png" title="Disease related entry" height="20" />
                </c:if>
            </c:if>
            <c:out value="${databaseObject.getDisplayName()}" />
            <c:if test="${not empty databaseObject.stableIdentifier}">
                <span> (${databaseObject.stableIdentifier})</span>
            </c:if>
            <c:if test="${not empty databaseObject.speciesName}">
                <span>[${databaseObject.speciesName}]</span>
            </c:if>
        </h3>
        <c:if test="${not empty databaseObject.schemaClass}">
            <span style="color: #1F419A; padding-left: 6px; font-size: 20px" title="${explanation}">${type}</span>
        </c:if>
    </div>

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

    <c:if test="${not empty topLevelNodes}">
        <c:import url="locationsInThePWB.jsp"/>
    </c:if>

    <%--<c:import url="generalAttributes.jsp"/>--%>

    <c:if test="${clazz == 'PhysicalEntity'}">
        <c:import url="physicalEntityDetails.jsp"/>
    </c:if>

    <c:if test="${clazz == 'Event'}">
        <c:import url="eventDetails.jsp"/>
    </c:if>

    <c:if test="${not empty interactions}">
        <c:import url="interactionDetails.jsp"/>
    </c:if>

</div>


<div class="clear"></div>

<%-- Adding some fixed spaces between last content panel and footer --%>
<div style="height: 40px;">&nbsp;</div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="http://www.reactome.org/common/footer.php"/>
