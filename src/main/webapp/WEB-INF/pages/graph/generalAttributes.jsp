<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${clazz != 'Regulation'}">

    <c:if test="${not empty databaseObject.disease || not empty crossReferences}">
        <fieldset class="fieldset-details">
            <legend>Additional Information</legend>

            <c:if test="${not empty databaseObject.disease}">
                <div class="wrap">
                    <h5>Diseases</h5>
                    <table class="dt-fixed-header">
                        <thead>
                        <tr>
                            <th style="width: 260px;">Name</th>
                            <th style="width: 60px;">Identifier</th>
                            <th style="width: 60px;">Synonyms</th>
                        </tr>
                        </thead>
                    </table>
                    <div class="dt-content-ovf">
                        <table>
                            <tbody>
                                <c:forEach var="disease" items="${databaseObject.disease}">
                                    <tr>
                                        <td style="width: 265px;"><a href="${diseases.database.url}" class=""  title="Show Details" rel="nofollow">${disease.displayName} </a></td>
                                        <td style="width: 65px;"><c:if test="${not empty disease.identifier}">${disease.identifier}</c:if></td>
                                        <td style="width: 65px;"><c:if test="${not empty disease.synonym}">${disease.synonym}</c:if></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty crossReferences}">
                <div class="wrap">
                    <h5>Cross References</h5>
                    <table class="dt-fixed-header">
                        <thead>
                        <tr>
                            <th style="width:50px;">Database Name</th>
                            <th style="width:250px;">Identifier</th>
                        </tr>
                        </thead>
                    </table>
                    <div class="dt-content-ovf">
                        <table>
                            <tbody>
                                <c:forEach var="crossReference" items="${crossReferences}">
                                    <tr>
                                        <td style="width:55px;"><strong>${crossReference.key}</strong></td>
                                        <td style="width:255px;">
                                            <c:forEach var="value" items="${crossReference.value}" varStatus="loop">
                                                <a href="${value.url}" title="show ${value.displayName}" rel="nofollow">${value.identifier}</a><c:if test="${!loop.last}">, </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

        </fieldset>
    </c:if>

</c:if>


