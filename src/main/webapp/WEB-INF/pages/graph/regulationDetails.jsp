<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty databaseObject.regulatedEntity || not empty databaseObject.regulator}">
    <div class="grid_23  padding  margin">
        <h5>Regulation participants</h5>
        <table>
            <thead>
            <tr class="tableHead">
                <td></td>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty databaseObject.schemaClass}">
                <tr>
                    <td><strong>regulation type</strong></td>
                    <td>${databaseObject.schemaClass}</td>
                </tr>
            </c:if>
            <c:if test="${not empty databaseObject.regulatedEntity}">
                <tr>
                    <td><strong>Regulated entity</strong></td>
                    <td><a href="../detail/${databaseObject.regulatedEntity.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.regulatedEntity.displayName}</a></td>
                </tr>
            </c:if>
            <c:if test="${not empty databaseObject.regulator}">
                <tr>
                    <td><strong>Regulator</strong></td>
                    <td><a href="../detail/${databaseObject.regulator.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.regulator.displayName}</a></td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</c:if>

