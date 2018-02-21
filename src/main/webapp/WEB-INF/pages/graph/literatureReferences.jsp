<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="clearfix">
    <fieldset class="fieldset-details">
        <legend>Literature References</legend>
        <div id="r-responsive-table" class="details-wrap">
            <table class="reactome">
                <thead>
                <tr>
                    <th scope="col" class="favth-col-md-2">PubMed ID</th>
                    <th scope="col" class="favth-col-md-7">Title</th>
                    <th scope="col" class="favth-col-md-2">Journal</th>
                    <th scope="col" class="favth-col-md-1">Year</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="literature" items="${databaseObject.literatureReference}">
                        <tr>
                            <%-- These are instances of Publication which has different attributes to be shown --%>
                            <c:if test="${literature.schemaClass == 'LiteratureReference'}">
                                <td data-label="PubMed ID" class="favth-col-md-2"><c:if test="${not empty literature.pubMedIdentifier}">${literature.pubMedIdentifier}</c:if></td>
                                <td data-label="Title" class="favth-col-md-7"><c:if test="${not empty literature.title}"><a href="${literature.url}" class=""  title="show Pubmed" > ${literature.title}</a></c:if></td>
                                <td data-label="Journal" class="favth-col-md-2"><c:if test="${not empty literature.journal}">${literature.journal}</c:if></td>
                                <td data-label="Year" class="favth-col-md-1"><c:if test="${not empty literature.year}">${literature.year}</c:if></td>
                            </c:if>
                            <c:if test="${literature.schemaClass == 'URL'}">
                                <td data-label="PubMed ID" class="favth-col-md-2">&nbsp;</td>
                                <td data-label="Title" class="favth-col-md-7"><c:if test="${not empty literature.title}"><a href="${literature.uniformResourceLocator}" class=""  title="show Pubmed" > ${literature.title}</a></c:if></td>
                                <td data-label="Journal" class="favth-col-md-2">&nbsp;</td>
                                <td data-label="Year" class="favth-col-md-1">&nbsp;</td>
                            </c:if>
                            <c:if test="${literature.schemaClass == 'Book'}">
                                <td data-label="PubMed ID" class="favth-col-md-2">&nbsp;</td>
                                <td data-label="Title" class="favth-col-md-7"><c:if test="${not empty literature.title}">${literature.title}</c:if></td>
                                <td data-label="Journal" class="favth-col-md-2">&nbsp;</td>
                                <td data-label="Year" class="favth-col-md-1"><c:if test="${not empty literature.year}">${literature.year}</c:if></td>
                            </c:if>
                        </tr>
                    </c:forEach>
                 </tbody>
            </table>
        </div>
    </fieldset>
</div>