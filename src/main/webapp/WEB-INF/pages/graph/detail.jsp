<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="databaseObject" type="org.reactome.server.graph.domain.model.Pathway"--%>
<%--@elvariable id="literature" type="org.reactome.server.graph.domain.model.LiteratureReference"--%>

<c:import url="../header.jsp"/>
<div class="ebi-content">

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
            <span style="color: #1F419A; padding-left: 6px; font-size: 20px" title="${explanation}">${type}</span>
        </c:if>
    </div>


    <c:if test="${not empty databaseObject.name}">
    <div class="grid_23  padding">
        <h5>Synonyms</h5>
        <c:forEach var="synonym" items="${databaseObject.name}" varStatus="loop">${synonym}<c:if test="${!loop.last}">, </c:if></c:forEach>
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

    <c:if test="${not empty topLevelNodes}">
        <c:import url="locationsInThePWB.jsp"/>
    </c:if>

    <c:if test="${clazz == 'PhysicalEntity'}">
        <c:import url="physicalEntityDetails.jsp"/>
    </c:if>

    <c:if test="${clazz == 'Event'}">
        <c:import url="eventDetails.jsp"/>
    </c:if>

    <c:if test="${clazz == 'Regulation'}">
        <c:import url="regulationDetails.jsp"/>
    </c:if>

    <c:if test="${clazz != 'Regulation'}">
        <c:import url="generalAttributes.jsp"/>
    </c:if>

    <c:if test="${not empty interactions}">
        <c:import url="interactionDetails.jsp"/>
    </c:if>


    <c:if test="${not empty databaseObject.literatureReference}">
        <div class="grid_23  padding  margin">
            <h5>Literature References</h5>
            <table>
                <thead>
                <tr class="tableHead">
                    <td>pubMedId</td>
                    <td>Title</td>
                    <td>Journal</td>
                    <td>Year</td>
                </tr>
                </thead>
                <tbody class="tableBody">
                <c:forEach var="literature" items="${databaseObject.literatureReference}">
                    <tr>
                        <td><c:if test="${not empty literature.pubMedIdentifier}">${literature.pubMedIdentifier}</c:if></td>
                        <td><c:if test="${not empty literature.title}"><a href="${literature.url}" class=""  title="show Pubmed" rel="nofollow"> ${literature.title}</a></c:if></td>
                        <td><c:if test="${not empty literature.journal}">${literature.journal}</c:if></td>
                        <td><c:if test="${not empty literature.year}">${literature.year}</c:if></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

</div>


<div class="clear"></div>

<%-- Adding some fixed spaces between last content panel and footer --%>
<div style="height: 40px;">&nbsp;</div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="../footer.jsp"/>
