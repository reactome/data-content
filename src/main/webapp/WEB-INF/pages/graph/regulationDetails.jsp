<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tags/modelTags.tld" prefix="m" %>

<c:if test="${not empty databaseObject.regulatedEntity || not empty databaseObject.regulator}">
    <c:choose>
        <c:when test="${not empty widget}">
            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
        </c:when>
        <c:otherwise>
            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
        </c:otherwise>
    </c:choose>
    <fieldset class="fieldset-details">
        <legend>Regulation participants</legend>
        <c:if test="${not empty databaseObject.schemaClass}">
            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Regulation type</div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">${databaseObject.className}</div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.regulatedEntity}">
            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Regulated entity</div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <m:link object="${databaseObject.regulatedEntity}" detailRequestPrefix="${detailRequestPrefix}" displaySpecies="false"/>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.regulator}">
            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Regulator</div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <m:link object="${databaseObject.regulator}" detailRequestPrefix="${detailRequestPrefix}" displaySpecies="false"/>
                </div>
            </div>
        </c:if>
    </fieldset>
</c:if>