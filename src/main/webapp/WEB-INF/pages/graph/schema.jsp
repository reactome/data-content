<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<link rel="stylesheet" href="/css/main.css" type="text/css">
<link rel="stylesheet" href="/css/ebi-fluid.css" type="text/css">
<div class="ebi-content" style="margin-top: 10px">

    <%--<div class="grid_24">--%>
        <%--<h2>Data Schema</h2>--%>
    <%--</div>--%>

    <div class="grid_16 push_8" >
        <c:choose>
            <c:when test="${not empty objects}">
                <div class="wrap" style="margin-left: 10px;">
                    <h5>Entries: ${className}</h5>
                    <table class="dt-fixed-header">
                        <thead>
                        <tr>
                            <th style="width: 50px">ID</th>
                            <th style="width: 230px">Name</th>
                        </tr>
                        </thead>
                    </table>
                    <div class="dt-content">
                        <table>
                            <tbody>
                            <c:forEach var="object" items="${objects}">
                                <tr>
                                    <td style="width: 50px">
                                        <c:choose>
                                            <c:when test="${empty object.stId}">
                                                <a href="/schema/object/detail/${object.dbId}">${object.dbId}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/schema/object/detail/${object.stId}">${object.stId}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="width: 230px">
                                        <div class=scrollable>
                                                ${object.displayName}
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="pagination" style="margin-left: 10px;">
                    <c:choose>
                        <c:when test="${maxpage>1}">
                            <c:choose>
                                <c:when test="${1 == page}">
                                    <span class="search-page active">first</span>
                                </c:when>
                                <c:otherwise>
                                    <a class="search-page" href="/schema/objects/${className}?page=1">first</a>
                                </c:otherwise>
                            </c:choose>
                            <c:forEach var="val" begin="2" end="${maxpage - 1}" >
                                <c:if test="${val > page-4 && val < page+4}">
                                    <c:choose>
                                        <c:when test="${val == page}">
                                            <span class="search-page active">${val}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="search-page" href="/schema/objects/${className}?page=${val}">${val}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${maxpage == page}">
                                    <span class="search-page active">last</span>
                                </c:when>
                                <c:otherwise>
                                    <a class="search-page" href="/schema/objects/${className}?page=${maxpage}">last</a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="attributeBrowser" style="margin-left: 10px;">
                    <c:if test="${not empty properties}">
                        <h5 class="schema-attr-header">Attributes of class ${className}</h5>
                        <div class="wrap no-margin">
                            <table class="dt-fixed-header schema-attr-table">
                                <thead>
                                    <tr>
                                        <th width="100px">Attribute name</th>
                                        <th width="50px">Cardinality</th>
                                        <th width="100px">Value Type</th>
                                        <th width="100px">Attribute Origin</th>
                                    </tr>
                                </thead>
                            </table>
                            <div class="dt-content">
                                <table>
                                    <tbody>
                                    <c:forEach var="property" items="${properties}">
                                        <c:choose>
                                            <c:when test="${property.origin.simpleName == className}">
                                                <tr class="declared">
                                                    <td width="100px">${property.name}</td>
                                                    <td width="50px">${property.cardinality}</td>
                                                    <c:choose>
                                                        <c:when test="${property.valueTypeDatabaseObject}">
                                                            <td width="100px"><a href="/schema/${property.valueType.simpleName}" title="Show Class attributes">${property.valueType.simpleName}</td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td width="100px">${property.valueType.simpleName}</td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td width="100px">${property.origin.simpleName}</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td width="100px">${property.name}</td>
                                                    <td width="50px">${property.cardinality}</td>
                                                    <c:choose>
                                                        <c:when test="${property.valueTypeDatabaseObject}">
                                                            <td width="100px"><a href="/schema/${property.valueType.simpleName}" title="Show Class attributes">${property.valueType.simpleName}</td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td width="100px">${property.valueType.simpleName}</td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td width="100px"><a href="/schema/${property.origin.simpleName}" title="Show Class attributes">${property.origin.simpleName}</a></td>
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

        <hr/>

        <div class="instructions">
            <p>You can find documentation for the Reactome data model <a href="http://www.reactome.org/pages/documentation/data-model">here</a>.
            </p><p>Sidebar on the left shows the hierarchy of Reactome classes. The number of instances
            of this class is shown in square brackets and is hyperlinked to a page listing all instances in this class.
        </p><p>The main panel shows attributes of the selected class. Own attributes, i.e. the ones which are not
            inherited from a parent class are indicated in <a class="own">colour</a>.
        </p><p>'+' in 'Cardinality' column indicates that this is a multi-value attribute.
        </p><p>'Value defines instance' column indicates the attributes the values of which determine instance identity
            and are used to check if an identical instance has been stored in the database already. 'ALL' indicates that
            that all of the values of a given attribute must be identical while 'ANY' shows that identity of any single
            value of a given attribute is enough. Of course, if the identity is defined by multiple attributes each of them
            has to match.
        </p></div>

    </div>

    <div class="grid_8 pull_16">
        <c:if test="${not empty node}">
            <div>
                <div class="dataschema-tree">
                    <%--<div class="div-header">--%>
                        <%--<strong>Selected: ${className}</strong>--%>
                    <%--</div>--%>
                    <ul class="tree">
                        <li class="schema-item">
                            <a href="/schema/${node.clazz.simpleName}" title="Show Class attributes">${node.clazz.simpleName}</a>
                            [<a href="/schema/objects/${node.clazz.simpleName}?page=1" title="Show Entries">${node.count}</a>]
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
