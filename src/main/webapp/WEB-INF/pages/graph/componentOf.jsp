<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty componentOf}">
    <c:forEach var="component" items="${componentOf}">
        <div class="fieldset-pair-container">
        <div class="label">
            <span><strong>${component.type}</strong></span>
        </div>
        <div class="field">
            <ul class="list overflowList">
                <c:forEach var="names" items="${component.names}" varStatus="loop">
                    <li><c:if test="${not empty component.stIds}"><a href="../detail/${component.stIds.get(loop.index)}" class="" title="Show Details" rel="nofollow">${names}</a></c:if></li>
                </c:forEach>
            </ul>
        </div>
        <div class="clear"></div>
        </div>
    </c:forEach>
</c:if>