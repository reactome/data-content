<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<link rel="stylesheet" href="/css/main.css" type="text/css">
<link rel="stylesheet" href="/css/ebi-fluid.css" type="text/css">
<div class="ebi-content" style="margin-top: 10px">

    <%--<div class="grid_24">--%>
    <%--<h2>Data Schema</h2>--%>
    <%--</div>--%>

    <div class="grid_16 push_8">
        <c:choose>
            <c:when test="${not empty objects}">
                <div class="attributeBrowser">
                    <h5 class="schema-attr-header">Entries: ${className}</h5>
                    <div class="wrap no-margin">
                        <table class="dt-fixed-header schema-attr-table">
                            <thead>
                            <tr>
                                <th style="width: 20%">Identifier</th>
                                <th style="width: 80%">Name</th>
                            </tr>
                            </thead>
                        </table>
                        <div class="dt-content">
                            <table class="schema-attr-table">
                                <tbody>
                                <c:forEach var="object" items="${objects}" varStatus="loopStatus">
                                    <tr class="${loopStatus.index % 2 == 0 ? 'even' : 'odd'}">
                                        <td style="width: 20%">
                                            <c:choose>
                                                <c:when test="${empty object.stId}">
                                                    <a href="../object/detail/${object.dbId}">${object.dbId}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="../object/detail/${object.stId}">${object.stId}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="width: 80%" title="${object.displayName}">
                                            ${object.displayName}
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="pagination">
                        <c:choose>
                            <c:when test="${maxpage>1}">
                                <c:choose>
                                    <c:when test="${1 == page}">
                                        <span class="search-page active">first</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="search-page" href="../objects/${className}?page=1">first</a>
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach var="val" begin="2" end="${maxpage - 1}">
                                    <c:if test="${val > page-4 && val < page+4}">
                                        <c:choose>
                                            <c:when test="${val == page}">
                                                <span class="search-page active">${val}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="search-page"
                                                   href="../objects/${className}?page=${val}">${val}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${maxpage == page}">
                                        <span class="search-page active">last</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="search-page" href="../objects/${className}?page=${maxpage}">last</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="attributeBrowser">
                    <c:if test="${not empty properties}">
                        <h5 class="schema-attr-header">Attributes of class ${className}</h5>
                        <div class="wrap no-margin">
                            <table class="dt-fixed-header schema-attr-table">
                                <thead>
                                <tr>
                                    <th width="30%">Attribute name</th>
                                    <th width="14%">Cardinality</th>
                                    <th width="26%">Value Type</th>
                                    <th width="30%">Attribute Origin</th>
                                </tr>
                                </thead>
                            </table>
                            <div class="dt-content">
                                <table class="schema-attr-table">
                                    <tbody>
                                    <c:forEach var="property" items="${properties}">
                                        <c:choose>
                                            <c:when test="${property.origin.simpleName == className}">
                                                <tr class="declared">
                                                    <td width="30%" title="${property.name}">${property.name}</td>
                                                    <td width="14%">${property.cardinality}</td>
                                                    <c:choose>
                                                        <c:when test="${property.valueTypeDatabaseObject}">
                                                            <td width="26%" title="${property.valueType.simpleName}"><a
                                                                    href="./${property.valueType.simpleName}"
                                                                    title="${property.valueType.simpleName}">${property.valueType.simpleName}
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td width="26%" title="${property.valueType.simpleName}">${property.valueType.simpleName}</td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td width="30%" title="${property.origin.simpleName}">${property.origin.simpleName}</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td width="30%">${property.name}</td>
                                                    <td width="14%">${property.cardinality}</td>
                                                    <c:choose>
                                                        <c:when test="${property.valueTypeDatabaseObject}">
                                                            <td width="26%" title="${property.valueType.simpleName}"><a
                                                                    href="./${property.valueType.simpleName}"
                                                                    title="${property.valueType.simpleName}">${property.valueType.simpleName}
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td width="26%" title="${property.valueType.simpleName}">${property.valueType.simpleName}</td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td width="30%" title="${property.origin.simpleName}">
                                                        <a href="./${property.origin.simpleName}" title="${property.origin.simpleName}">${property.origin.simpleName}</a>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>


        <%--<div class="attributeBrowser">--%>
        <div class="instructions attributeBrowser">
            <hr/>
            <p>You can find documentation for the Reactome data model <a
                    href="http://www.reactome.org/pages/documentation/data-model">here</a>.
            </p>
            <p>Sidebar on the left shows the hierarchy of Reactome classes. The number of instances
                of this class is shown in square brackets and is hyperlinked to a page listing all instances in this
                class.
            </p>
            <p>The main panel shows attributes of the selected class. Own attributes, i.e. the ones which are not
                inherited from a parent class are indicated in <span class="own">colour</span>.
            </p>
            <p>'+' in 'Cardinality' column indicates that this is a multi-value attribute.
            </p>
            <p>'Value defines instance' column indicates the attributes the values of which determine instance identity
                and are used to check if an identical instance has been stored in the database already. 'ALL' indicates
                that
                that all of the values of a given attribute must be identical while 'ANY' shows that identity of any
                single
                value of a given attribute is enough. Of course, if the identity is defined by multiple attributes each
                of them
                has to match.
            </p>
        </div>
        <%--</div>--%>

    </div>

    <div class="grid_8 pull_16">
        <c:if test="${not empty node}">
            <div>
                <div class="dataschema-tree">
                        <%--<div class="div-header">--%>
                        <%--<strong>Selected: ${className}</strong>--%>
                        <%--</div>--%>
                    <ul class="tree">
                        <li class="schema-item" >
                            <span class="node-item ${node.clazz.simpleName == className ? 'selected' : ''}">
                                <a href="${pageContext.request.contextPath}/schema/${node.clazz.simpleName}"
                                   >${node.clazz.simpleName}</a>
                                [<a href="${pageContext.request.contextPath}/schema/objects/${node.clazz.simpleName}?page=1"
                                    title="Show Entries">${node.count}</a>]
                            </span>
                            <c:import url="schemaNode.jsp"/>
                        </li>
                    </ul>
                </div>
            </div>
        </c:if>
    </div>

</div>

<div class="clear"></div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="../footer.jsp"/>
