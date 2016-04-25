<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty componentOf}">
    <c:forEach var="component" items="${componentOf}">
        <div class="extended-header">
        <div class="label">
            <span>component of: ${component.type}</span>
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

    <%--<div class="grid_23  padding  margin">--%>
    <%--<h5>This entry is a component of:</h5>--%>
    <%--<table class="fixedTable">--%>
    <%--<thead>--%>
    <%--<tr class="tableHead">--%>
    <%--<td></td>--%>
    <%--<td></td>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody>--%>
    <%--<c:forEach var="component" items="${componentOf}">--%>
    <%--<tr>--%>
    <%--<td><strong>${component.type}</strong></td>--%>
    <%--<td>--%>
    <%--<ul class="list overflowList">--%>
    <%--<c:forEach var="names" items="${component.names}" varStatus="loop">--%>
    <%--<li><c:if test="${not empty component.stIds}"><a href="../detail/${component.stIds.get(loop.index)}" class="" title="Show Details" rel="nofollow">${names}</a></c:if></li>--%>
    <%--</c:forEach>--%>
    <%--</ul>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--</c:forEach>--%>
    <%--</tbody>--%>
    <%--</table>--%>
    <%--</div>--%>
</c:if>