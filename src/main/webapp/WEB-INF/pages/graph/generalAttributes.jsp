<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty databaseObject.literatureReference}">
    <h5>Literature References</h5>
    <table style="width: 100%; padding: 0 5px">
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
</c:if>

<c:if test="${clazz != 'Regulation'}">

    <c:if test="${not empty databaseObject.disease}">
        <h5>Diseases</h5>
        <table>
            <thead>
            <tr class="tableHead">
                <td>Name</td>
                <td>Identifier</td>
                <td>Synonyms</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="disease" items="${databaseObject.disease}">
                <tr>
                    <td><a href="${diseases.database.url}" class=""  title="Show Details" rel="nofollow">${disease.displayName} </a></td>
                    <td><c:if test="${not empty disease.identifier}">${disease.identifier}</c:if></td>
                    <td><c:if test="${not empty disease.synonym}">${disease.synonym}</c:if></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${not empty crossReferences}">
        <h5>Cross References</h5>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td>Database</td>
                <td>Identifier</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="crossReference" items="${crossReferences}">
                <tr>
                    <td><strong>${crossReference.key}</strong></td>
                    <td>
                        <c:forEach var="value" items="${crossReference.value}" varStatus="loop">
                            <a href="${value.url}" title="show ${value.displayName}" rel="nofollow">${value.identifier}</a>
                            <c:if test="${!loop.last}">, </c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

</c:if>


