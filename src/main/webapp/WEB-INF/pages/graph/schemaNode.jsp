<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- called by schema.jsp to build up the class hierarchy --%>
<ul class="tree">
    <c:forEach var="node" items="${node.children}">
        <li class="schema-item">
            <span class="node-item ${node.clazz.simpleName == className ? 'selected' : ''}">
                <a href="${pageContext.request.contextPath}/schema/${node.clazz.simpleName}">${node.clazz.simpleName}</a>
            </span>
            <span class="node-count">
                [<a href="${pageContext.request.contextPath}/schema/objects/${node.clazz.simpleName}" title="Show Entries">${node.count}</a>]
            </span>
            <c:set var="node" value="${node}" scope="request"/>
            <c:import url="schemaNode.jsp"/>
        </li>
    </c:forEach>
</ul>
