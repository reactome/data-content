<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty databaseObject.regulatedEntity || not empty databaseObject.regulator}">
    <fieldset class="fieldset-details">
        <legend>Regulation participants</legend>
        <c:if test="${not empty databaseObject.schemaClass}">
            <div class="fieldset-pair-container">
                <div class="label">regulation type</div>
                <div class="field">${databaseObject.schemaClass}</div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.regulatedEntity}">
            <div class="fieldset-pair-container">
                <div class="label">Regulated entity</div>
                <div class="field"><a href="../detail/${databaseObject.regulatedEntity.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.regulatedEntity.displayName}</a></div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.regulator}">
            <div class="fieldset-pair-container">
                <div class="label">Regulator</div>
                <div class="field"><a href="../detail/${databaseObject.regulator.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.regulator.displayName}</a></div>
                <div class="clear"></div>
            </div>
        </c:if>
    </fieldset>
</c:if>