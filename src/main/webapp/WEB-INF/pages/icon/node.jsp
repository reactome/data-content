<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- called by locationsInThePWB.jsp --%>
<ul class="tree">
    <c:forEach var="node" items="${node.children}">
        <li>
            <c:if test="${not empty node.url}">
                <span style="font-size:13px"><i class="sprite-resize sprite sprite-${node.type}" title="${node.type}"></i></span>
                <c:choose>
                    <c:when test="${node.clickable}">
                        <a href="${node.url}" <c:if test="${node.highlighted}">class="tree-highlighted-item"</c:if>  title="Show Details" <c:if test="${not empty widget}"> target="_blank" </c:if>>${node.name} <c:if test="${not empty node.stId}">(${node.stId})</c:if></a>
                    </c:when>
                    <c:otherwise>
                        <span class="tree-grayedout-item">${node.name} <c:if test="${not empty node.species}">(${node.stId})</c:if></span>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:set var="node" value="${node}" scope="request"/>
            <c:import url="node.jsp"/>
        </li>
    </c:forEach>
</ul>
