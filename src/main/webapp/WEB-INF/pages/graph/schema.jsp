<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<link rel="stylesheet" href="/css/main.css" type="text/css">
<link rel="stylesheet" href="/css/ebi-fluid.css" type="text/css">
<div class="ebi-content">

    <div class="grid_24">
        <h2>DataSchema</h2>
    </div>

    <div class="grid_16 push_8">

        <c:choose>
            <c:when test="${not empty objects}">
                <div class="detailBrowser">
                    <h5>Entries</h5>
                    <table class="fixedTable">
                        <thead>
                        <tr class="tableHead">
                            <td style="width: 10%">DbId</td>
                            <td style="width: 18%">StId</td>
                            <td style="width: 72%">Name</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="object" items="${objects}">
                            <tr>
                                <td style="width: 10%">
                                    <a href="/schema/object/detail/${object.dbId}">${object.dbId}</a>
                                </td>
                                <td style="width: 18%">
                                    <a href="/schema/object/detail/${object.stId}">${object.stId}</a>
                                <td style="width: 72%">
                                    <div class=scrollable>
                                            ${object.displayName}
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
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
                <div class="attributeBrowser">
                    <c:if test="${not empty properties}">
                        <h5>Attributes</h5>
                        <table class="fixedTable">
                            <thead>
                            <tr class="tableHead">
                                <td>Attribute name</td>
                                <td>Cardinality</td>
                                <td>ValueType</td>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="property" items="${properties}">
                                <c:choose>
                                    <c:when test="${property.declaredMethod}">
                                        <tr class="declared">
                                            <td>${property.name}</td>
                                            <td>${property.cardinality}</td>
                                            <td>${property.valueType}</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td>${property.name}</td>
                                            <td>${property.cardinality}</td>
                                            <td>${property.valueType}</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="grid_8 pull_16">
        <c:if test="${not empty node}">
            <div >
                <h5>Class Hierarchy</h5>
                <div class="dataschema-tree">
                    <div class="div-header">
                        Selected: ${className}
                    </div>
                    <ul class="tree">
                        <li class="schema-item">
                            <a href="/classbrowser/${node.clazz.simpleName}" title="Show Class attributes">${node.clazz.simpleName}</a>
                            [<a href="/classbrowser/${node.clazz.simpleName}?page=1" title="Show Entries">${node.count}</a>]
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
