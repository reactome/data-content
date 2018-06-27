<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${clazz != 'Regulation'}">

     <c:if test="${not empty databaseObject.disease}">
     <div class="favth-clearfix">
        <fieldset class="fieldset-details">
            <legend>Disease</legend>
            <div id="r-responsive-table" class="details-wrap">
                <table class="reactome">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Identifier</th>
                            <th scope="col">Synonyms</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="disease" items="${databaseObject.disease}">
                        <tr>
                            <td data-label="Name"><a href="${disease.url}" class="" target="_blank" title="Show Details" >${disease.displayName} </a></td>
                            <td data-label="Identifier"><c:if test="${not empty disease.identifier}">${disease.identifier}</c:if></td>
                            <td data-label="Synonyms">
                                <c:forEach var="synonym" items="${disease.synonym}" varStatus="loop">
                                    ${synonym}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </fieldset>
     </div>
    </c:if>

    <c:if test="${not empty crossReferences}">
        <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Cross References</legend>
                <c:forEach var="crossReference" items="${crossReferences}">
                    <div class="fieldset-pair-container">
                        <div class="favth-clearfix">
                            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">${crossReference.key}</div>
                            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                <div>
                                <c:forEach var="value" items="${crossReference.value}" varStatus="loop">
                                    <a href="${value.url}" target="_blank" title="show ${value.displayName}" >${value.identifier}</a><c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </fieldset>
        </div>
    </c:if>

</c:if>

<c:if test="${not empty databaseObject.authored}">
    <fieldset class="fieldset-details">
        <legend>Authored</legend>
        <div class="wrap overflow">
            <c:forEach var="authored" items="${databaseObject.authored}">
                <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${authored.dateTime}" var="date"/>
                <ul class="list">
                    <c:forEach var="person" items="${authored.author}">
                        <li>
                            <c:choose>
                                <c:when test="${not empty person.orcidId}">
                                    <a href="../detail/person/${person.orcidId}" class="" title="${person.displayName}" >${person.displayName} &nbsp;(<fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/>)</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="../detail/person/${person.dbId}" class="" title="${person.displayName}" >${person.displayName} &nbsp;(<fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/>)</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.reviewed}">
    <fieldset class="fieldset-details">
        <legend>Reviewed</legend>
        <div class="wrap overflow">
            <c:forEach var="reviewed" items="${databaseObject.reviewed}">
                <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${reviewed.dateTime}" var="date"/>
                <ul class="list">
                    <c:forEach var="person" items="${reviewed.author}">
                        <li>
                            <c:choose>
                                <c:when test="${not empty person.orcidId}">
                                    <a href="../detail/person/${person.orcidId}" class="" title="${person.displayName}" >${person.displayName} &nbsp;(<fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/>)</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="../detail/person/${person.dbId}" class="" title="${person.displayName}" >${person.displayName} &nbsp;(<fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/>)</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
    </fieldset>
</c:if>