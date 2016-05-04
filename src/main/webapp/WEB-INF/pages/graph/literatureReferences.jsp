<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fieldset class="fieldset-details">
    <legend>Literature References</legend>
    <div class="wrap">
        <table class="dt-fixed-header">
            <thead>
            <tr>
                <th style="width:30px;">PubMed ID</th>
                <th style="width:190px;">Title</th>
                <th style="width:40px;">Journal</th>
                <th style="width:40px;">Year</th>
            </tr>
            </thead>
        </table>
        <div class="dt-content">
            <table>
                <tbody>
                <c:forEach var="literature" items="${databaseObject.literatureReference}">
                    <tr>
                            <%-- These are instances of Publication which has different attributes to be shown --%>
                        <c:if test="${literature.schemaClass == 'LiteratureReference'}">
                            <td style="width:35px;"><c:if test="${not empty literature.pubMedIdentifier}">${literature.pubMedIdentifier}</c:if></td>
                            <td style="width:195px;"><c:if test="${not empty literature.title}"><a href="${literature.url}" class=""  title="show Pubmed" rel="nofollow"> ${literature.title}</a></c:if></td>
                            <td style="width:45px;"><c:if test="${not empty literature.journal}">${literature.journal}</c:if></td>
                            <td style="width:45px;"><c:if test="${not empty literature.year}">${literature.year}</c:if></td>
                        </c:if>
                        <c:if test="${literature.schemaClass == 'URL'}">
                            <td style="width:35px;">&nbsp;</td>
                            <td style="width:195px;"><c:if test="${not empty literature.title}"><a href="${literature.uniformResourceLocator}" class=""  title="show Pubmed" rel="nofollow"> ${literature.title}</a></c:if></td>
                            <td style="width:45px;">&nbsp;</td>
                            <td style="width:45px;">&nbsp;</td>
                        </c:if>
                        <c:if test="${literature.schemaClass == 'Book'}">
                            <td style="width:35px;">&nbsp;</td>
                            <td style="width:195px;"><c:if test="${not empty literature.title}">${literature.title}</c:if></td>
                            <td style="width:45px;">&nbsp;</td>
                            <td style="width:45px;"><c:if test="${not empty literature.year}">${literature.year}</c:if></td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</fieldset>
