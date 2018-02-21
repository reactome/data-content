<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                            <td data-label="Name"><a href="${disease.url}" class=""  title="Show Details" >${disease.displayName} </a></td>
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
                                    <a href="${value.url}" title="show ${value.displayName}" >${value.identifier}</a><c:if test="${!loop.last}">, </c:if>
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
