<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty databaseObject.regulatedEntity || not empty databaseObject.regulator}">
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
                    <i class="sprite sprite-resize sprite-${databaseObject.regulatedEntity.schemaClass} sprite-position" title="${databaseObject.regulatedEntity.schemaClass}"></i>
                    <a href="../detail/${databaseObject.regulatedEntity.stId}" class="" title="Show Details" >${databaseObject.regulatedEntity.displayName}</a>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.regulator}">
            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Regulator</div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <i class="sprite sprite-resize sprite-${databaseObject.regulator.schemaClass} sprite-position" title="${databaseObject.regulator.schemaClass}"></i>
                    <a href="../detail/${databaseObject.regulator.stId}" class="" title="Show Details" >${databaseObject.regulator.displayName}</a>
                </div>
            </div>
        </c:if>
    </fieldset>
</c:if>