<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty databaseObject.crossReference}">
  <div class="grid_23  padding  margin">
    <h5>Cross References</h5>
    <table class="fixedTable">
      <thead>
      <tr class="tableHead">
        <td>Database</td>
        <td>Identifier</td>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="crossReference" items="${databaseObject.crossReference}">
        <tr>
          <td><strong>${crossReference.databaseName}</strong></td>
          <td>
              <a href="${crossReference.url}" title="show ${crossReference.databaseName}" rel="nofollow">${crossReference.identifier}</a><c:if test="${!loop.last}">, </c:if>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
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

<c:if test="${not empty databaseObject.disease}">
  <div class="grid_23  padding  margin">
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
  </div>
</c:if>


<c:if test="${not empty componentOf}">
  <div class="grid_23  padding  margin">
    <h5>This entry is a component of:</h5>
    <table class="fixedTable">
      <thead>
      <tr class="tableHead">
        <td></td>
        <td></td>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="component" items="${componentOf}">
        <tr>
          <td><strong>${component.type}</strong></td>
          <td>
            <ul class="list overflowList">
              <c:forEach var="names" items="${component.names}" varStatus="loop">
                <li><c:if test="${not empty component.stIds}"><a href="../detail/${component.stIds.get(loop.index)}" class="" title="Show Details" rel="nofollow">${names}</a></c:if></li>
              </c:forEach>
            </ul>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</c:if>

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