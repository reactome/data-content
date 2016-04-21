<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<div class="ebi-content" >





                    <c:if test="${not empty entry.referenceEntity.referenceSynonyms}">
                        <tr>
                            <td><strong>external Synonyms</strong></td>
                            <td class="block">
                                <c:forEach var="synonym" items="${entry.referenceEntity.referenceSynonyms}" varStatus="loop">${synonym}<c:if test="${!loop.last}">, </c:if></c:forEach>
                            </td>
                        </tr>


    <c:if test="${not empty entry.catalystActivities}">
        <div class="grid_23  padding  margin">
            <h5>Catalyst Activity</h5>
            <table>
                <thead>
                <tr class="tableHead">
                    <td>PhysicalEntity</td>
                    <td>Activity</td>
                    <td>Active Units</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="catalystActivity" items="${entry.catalystActivities}">
                    <tr>
                        <c:if test="${not empty catalystActivity.physicalEntity}">
                            <td><a href="../detail/${catalystActivity.physicalEntity.stId}" class="" title="show Reactome ${catalystActivity.physicalEntity.stId}" rel="nofollow">${catalystActivity.physicalEntity.name}</a></td>
                        </c:if>
                        <c:if test="${not empty catalystActivity.activity}">
                            <td><a href="${catalystActivity.activity.database.url}" class=""  title="show ${catalystActivity.activity.database.name}" rel="nofollow">${catalystActivity.activity.name} (${catalystActivity.activity.accession})</a></td>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty catalystActivity.activeUnit}">
                                <td>
                                    <ul class="list overflowList">
                                        <c:forEach var="activeUnit" items="${catalystActivity.activeUnit}">
                                            <li><a href="../detail/${activeUnit.stId}" class="" title="show Reactome ${activeUnit.stId}" rel="nofollow">${activeUnit.name}</a></li>
                                        </c:forEach>
                                    </ul>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>&nbsp;</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>





    <c:if test="${not empty entry.regulatingEntities}">
        <div class="grid_23  padding  margin">
            <h5>This entity regulates</h5>
            <table class="fixedTable">
                <thead>
                <tr class="tableHead">
                    <td>Regulation type</td>
                    <td>Name</td>

                </tr>
                </thead>
                <tbody>
                <c:forEach var="regulation" items="${entry.regulatingEntities}">
                    <tr>
                        <td><strong>${regulation.key}</strong></td>
                        <td>
                            <ul class="list overflowList">
                                <c:forEach var="value" items="${regulation.value}" varStatus="loop">
                                    <li><c:if test="${not empty value.regulatedEntity.stId}"><a href="../detail/${value.regulatedEntity.stId}" class="" title="Show Details" rel="nofollow">${value.regulatedEntity.name}<c:if test="${not empty value.regulatedEntity.species}"> (${value.regulatedEntity  .species})</c:if></a></c:if></li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </div>
    </c:if>



