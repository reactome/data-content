<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="tree">
<c:forEach var="node" items="${node.children}">
    <li>
            <c:if test="${not empty node.url}">
                <%--<img src="../resources/images/${node.type}.png" title="${node.type}" width="12" height="11" />--%>
                <span style="font-size:13px"><i class="sprite-resize sprite sprite-${node.type}"></i></span>
                <a href="${node.url}" class=""  title="Show Details" rel="nofollow">${node.name} <c:if test="${not empty node.species}">(${node.species})</c:if></a>
            </c:if>
    <c:set var="node" value="${node}" scope="request"/>
    <c:import url="node.jsp"/>
    </li>
</c:forEach>
</ul>
