<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="tree">
    <c:forEach var="node" items="${node.children}">
        <li class="schema-item">
            <a href="./${node.clazz.simpleName}" title="Show Class attributes">${node.clazz.simpleName}</a>
            [<a href="./objects/${node.clazz.simpleName}?page=1" title="Show Entries">${node.count}</a>]
            <c:set var="node" value="${node}" scope="request"/>
            <c:import url="schemaNode.jsp"/>
        </li>
    </c:forEach>
</ul>
