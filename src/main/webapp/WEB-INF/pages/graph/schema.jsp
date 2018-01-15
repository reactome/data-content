<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<link rel="stylesheet" href="/content/resources/css/schema.css" type="text/css">

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
    <h3 class="favth-visible-lg favth-visible-md">Graph Database :: Data Schema</h3>
    <h4 class="favth-visible-xs favth-visible-sm">Graph Database :: Data Schema</h4>

    <%-- MAX-WIDTH 768px --%>
    <div>
        <div class="favth-col-sm-6 favth-col-xs-6 favth-visible-sm favth-visible-xs padding0">
            <a><i class="fa fa-filter"></i><span onclick="openSchemaSideNav()">Schema Tree</span></a>
        </div>
        <c:choose>
            <c:when test="${type == 'list'}">
                <div class="favth-col-sm-6 favth-col-xs-6 favth-visible-sm favth-visible-xs padding0 text-right clearfix">
                    <a href="${pageContext.request.contextPath}/schema/${className}"><i class="fa fa-list"></i>Attributes</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="favth-col-sm-6 favth-col-xs-6 favth-visible-sm favth-visible-xs padding0 text-right clearfix">
                    <a href="${pageContext.request.contextPath}/schema/objects/${className}"><i class="fa fa-database"></i>Entries</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="schema-sidenav" class="sidenav schema-sidenav favth-visible-xs favth-visible-sm">
        <div class="sidenav-panel">
            <a href="javascript:void(0);" class="closebtn" onclick="closeSchemaSideNav();">&times;</a>
            <div class="schema-tree-mobile">
                <%-- Can't read the node list twice. JavaScript is inserting the tree here --%>
            </div>
        </div>
    </div>

    <%-- VISIBLE ON DESKTOP --%>
    <div class="favth-col-lg-4 favth-col-md-4 favth-col-sm-12 favth-col-xs-12 favth-hidden-xs favth-hidden-sm padding0 right" id="search-filters">
        <div class="schema-tree-ph">
            <c:if test="${not empty node}">
                <c:import url="schemaTree.jsp"/>
            </c:if>
        </div>
    </div>

    <div class="favth-col-lg-8 favth-col-md-8 favth-col-sm-12 favth-col-xs-12 padding0">
        <c:if test="${type == 'list'}">
            <h5 class="schema-attr-header">Entries: ${className} </h5>
            <c:if test="${not empty speciesList}">
                <div class="species-selector">
                    <span class="schema-label">Select species: </span>
                    <select onchange="location = '?speciesTaxId=' + this.options[this.selectedIndex].value;">
                        <c:forEach var="species" items="${speciesList}">
                            <option value="${species.taxId}" <c:if test="${species.taxId == selectedSpecies}">selected="selected"</c:if>>${species.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>
        </c:if>
        <c:choose>
            <c:when test="${not empty objects}">
                <div class="attributeBrowser">
                    <div id="r-responsive-table-entries">
                        <table class="reactome entries margin0">
                            <thead>
                                <tr>
                                    <th scope="col">Identifier</th>
                                    <th scope="col">Name</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="object" items="${objects}">
                                <tr>
                                    <td class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3">
                                        <c:choose>
                                            <c:when test="${empty object.stId}">
                                                <a href="../instance/browser/${object.dbId}">${object.dbId}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="../instance/browser/${object.stId}">${object.stId}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="favth-col-lg-9 favth-col-md-9 favth-col-sm-9" title="${object.displayName}">
                                        ${object.displayName}
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div id="pagination" class="pagination">
                        <ul class="pagination-list">
                        <c:choose>
                            <c:when test="${maxpage>1}">
                                <c:choose>
                                    <c:when test="${1 == page}">
                                        <li class="active"><a>1</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${empty selectedSpecies}">
                                                <li><a href="./${className}">1</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="./${className}&speciesTaxId=${selectedSpecies}">1</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${page > 5}"><li><span style="border: none; padding: 15px 10px 0; color: #333;">...</span></li></c:if>
                                <c:forEach var="val" begin="2" end="${maxpage - 1}">
                                    <c:if test="${val > page-4 && val < page+4}">
                                        <c:choose>
                                            <c:when test="${val == page}">
                                                <li class="pagenav active"><a>${val}</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${empty selectedSpecies}">
                                                        <li><a href="./${className}?page=${val}">${val}</a></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li><a href="./${className}?speciesTaxId=${selectedSpecies}&page=${val}">${val}</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${page < (maxpage - 4)}">
                                    <li><span style="border: none; padding: 15px 10px 0; color: #333;">...</span></li>
                                </c:if>
                                <c:choose>
                                    <c:when test="${maxpage == page}">
                                        <li class="active"><a>${maxpage}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${empty selectedSpecies}">
                                                <li><a href="./${className}?page=${maxpage}">${maxpage}</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="./${className}?speciesTaxId=${selectedSpecies}&page=${maxpage}">${maxpage}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                        </ul>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${type == 'list'}">
                    <div class="attributeBrowser">
                        <div id="r-responsive-table-empty">
                            <table class="reactome margin0">
                                <thead>
                                <tr>
                                    <th>Identifier</th>
                                    <th>Name</th>
                                </tr>
                                </thead>
                            </table>
                            <div class="text-center">
                                No entries found for this species
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty properties}">
                    <div class="attributeBrowser">
                        <h5 class="schema-attr-header">Attributes of class ${className}</h5>
                        <%--<div class="favth-visible-xs favth-hidden-sm clearfix padding0 bottom text-center">--%>
                            <%--<a href="${pageContext.request.contextPath}/schema/objects/${className}"><i class="fa fa-database"></i>List Entries</a>--%>
                        <%--</div>--%>

                        <div id="r-responsive-table-attr">
                            <table class="reactome margin0">
                                <thead>
                                    <tr>
                                        <th scope="col">Attribute name</th>
                                        <th scope="col">Cardinality</th>
                                        <th scope="col">Value Type</th>
                                        <th scope="col">Attribute Origin</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="property" items="${properties}">
                                    <tr class="<c:if test="${property.origin.simpleName != className}">un</c:if>declared">
                                        <td data-label="Name" title="${property.name}">${property.name}</td>
                                        <td data-label="Cardinality">${property.cardinality}</td>
                                        <td data-label="Type" title="${type.simpleName}">
                                            <ul class="types">
                                            <c:forEach items="${property.attributeClasses}" var="attr">
                                                <li>
                                                <c:choose>
                                                    <c:when test="${attr.valueTypeDatabaseObject}">
                                                        <a href="./${attr.type.simpleName}" title="${attr.type.simpleName}">${attr.type.simpleName}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span width="26%" title="${attr.type.simpleName}">${attr.type.simpleName}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                </li>
                                            </c:forEach>
                                            </ul>
                                        </td>
                                        <td data-label="Origin" title="${property.origin.simpleName}"><a href="./${property.origin.simpleName}">${property.origin.simpleName}</a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <c:if test="${not empty referrals}">
                        <div class="padding0 top30">
                            <h5 class="schema-attr-header">Referrals of class '${className}' instances</h5>
                            <div id="r-responsive-table-referrals">
                                <table class="reactome margin0">
                                    <thead>
                                        <tr>
                                            <th scope="col">Attribute Origin</th>
                                            <th scope="col">Attribute name</th>
                                            <th scope="col">Cardinality</th>
                                            <th scope="col">Value Type</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="property" items="${referrals}">
                                        <tr class="undeclared">
                                            <td data-label="Origin" title="${property.origin.simpleName}">
                                                <a href="./${property.origin.simpleName}" title="${property.origin.simpleName}">${property.origin.simpleName}</a>
                                            </td>
                                            <td data-label="Name">${property.name}</td>
                                            <td data-label="Cardinality">${property.cardinality}</td>
                                            <td data-label="Type">
                                                <ul class="types">
                                                <c:forEach items="${property.attributeClasses}" var="attr">
                                                    <li title="${attr.type.simpleName}"><a href="./${attr.type.simpleName}" title="${attr.type.simpleName}">${attr.type.simpleName}</a></li>
                                                </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>

                    <div class="instructions">
                        <hr/>
                        <p>You can find documentation for the Reactome data model <a
                                href="/documentation/data-model">here</a>.
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
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>


</div>
<c:import url="../footer.jsp"/>
