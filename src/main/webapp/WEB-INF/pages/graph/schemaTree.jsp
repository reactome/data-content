<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="dataschema-tree">
    <ul class="tree">
        <li class="schema-item">
            <span class="node-item ${node.clazz.simpleName == className ? 'selected' : ''}">
                <a href="${pageContext.request.contextPath}/schema/${node.clazz.simpleName}">${node.clazz.simpleName}</a>
            </span>
            <c:import url="schemaNode.jsp"/>
        </li>
    </ul>
</div>