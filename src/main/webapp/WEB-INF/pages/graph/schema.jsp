<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/schema-table.css" type="text/css">
<div class="ebi-content" style="margin-top: 10px">

    <div style="font-weight: bold;font-size: larger; color:#009;margin-left: 10px;">Graph Database :: Data Schema</div>

    <div class="grid_16 push_8">
        <c:if test="${type == 'list'}">
            <h5 class="schema-attr-header">Entries: ${className}</h5>
            <c:if test="${not empty speciesList}">
                <div><span style="font-weight: bold;font-size: 14px; color:#009;margin-left: 10px;text-align: center;">Select species: </span><select onchange="location = '?speciesTaxId=' + this.options[this.selectedIndex].value;"><c:forEach var="species" items="${speciesList}">
                    <option value="${species.taxId}" <c:if test="${species.taxId == selectedSpecies}">selected="selected"</c:if>>${species.displayName}</option>
                </c:forEach></select></div>
            </c:if>
        </c:if>
        <c:choose>
            <c:when test="${not empty objects}">
                <div class="attributeBrowser">
                    <div class="schema-table no-margin">
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
                                                    <a href="../instance/browser/${object.dbId}">${object.dbId}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="../instance/browser/${object.stId}">${object.stId}</a>
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
                                        <span class="search-page active">1</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${empty selectedSpecies}">
                                                <a class="search-page" href="./${className}">1</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="search-page" href="./${className}&speciesTaxId=${selectedSpecies}">1</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${page > 5}">...&nbsp;&nbsp;</c:if>
                                <c:forEach var="val" begin="2" end="${maxpage - 1}">
                                    <c:if test="${val > page-4 && val < page+4}">
                                        <c:choose>
                                            <c:when test="${val == page}">
                                                <span class="search-page active">${val}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${empty selectedSpecies}">
                                                        <a class="search-page" href="./${className}?page=${val}">${val}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="search-page" href="./${className}?speciesTaxId=${selectedSpecies}&page=${val}">${val}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${page < (maxpage - 4)}">...&nbsp;&nbsp;</c:if>
                                <c:choose>
                                    <c:when test="${maxpage == page}">
                                        <span class="search-page active">${maxpage}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${empty selectedSpecies}">
                                                <a class="search-page" href="./${className}?page=${maxpage}">${maxpage}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="search-page" href="./${className}?speciesTaxId=${selectedSpecies}&page=${maxpage}">${maxpage}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${type == 'list'}">
                    <div class="attributeBrowser">
                        <div class="schema-table no-margin">
                            <table class="dt-fixed-header schema-attr-table">
                                <thead>
                                <tr>
                                    <th style="width: 20%">Identifier</th>
                                    <th style="width: 80%">Name</th>
                                </tr>
                                </thead>
                            </table>
                            <div class="dt-content" style="font-weight: bold;font-size: 14px; color:#009;margin-left: 10px;text-align: center;">
                                No entries found for this species
                            </div>
                        </div>
                    </div>
                </c:if>

                <div class="attributeBrowser">
                    <c:if test="${not empty properties}">
                        <h5 class="schema-attr-header">Attributes of class ${className}</h5>
                        <div class="schema-table no-margin">
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
                                        <tr class="<c:if test="${property.origin.simpleName != className}">un</c:if>declared">
                                            <td width="30%" title="${property.name}">${property.name}</td>
                                            <td width="14%">${property.cardinality}</td>
                                            <td width="26%" title="${type.simpleName}">
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
                                            <td width="30%" title="${property.origin.simpleName}"><a href="./${property.origin.simpleName}">${property.origin.simpleName}</a></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>

                <c:if test="${not empty referrals}">
                    <div class="attributeBrowser" style="margin-top:50px;">
                        <h5 class="schema-attr-header">Referrals of class '${className}' instances</h5>
                        <div class="schema-table no-margin">
                            <table class="dt-fixed-header schema-attr-table">
                                <thead>
                                <tr>
                                    <th width="28%">Attribute Origin</th>
                                    <th width="30%">Attribute name</th>
                                    <th width="14%">Cardinality</th>
                                    <th width="28%">Value Type</th>
                                </tr>
                                </thead>
                            </table>
                            <div class="dt-content">
                                <table class="schema-attr-table">
                                    <tbody>
                                    <c:forEach var="property" items="${referrals}">
                                        <tr class="undeclared">
                                            <td width="28%" title="${property.origin.simpleName}">
                                                <a href="./${property.origin.simpleName}" title="${property.origin.simpleName}">${property.origin.simpleName}</a>
                                            </td>
                                            <td width="30%">${property.name}</td>
                                            <td width="14%">${property.cardinality}</td>
                                            <td width="28%">
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
                    </div>
                </c:if>
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
            <%--<p>'Value defines instance' column indicates the attributes the values of which determine instance identity--%>
                <%--and are used to check if an identical instance has been stored in the database already. 'ALL' indicates--%>
                <%--that--%>
                <%--that all of the values of a given attribute must be identical while 'ANY' shows that identity of any--%>
                <%--single--%>
                <%--value of a given attribute is enough. Of course, if the identity is defined by multiple attributes each--%>
                <%--of them--%>
                <%--has to match.--%>
            <%--</p>--%>
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
                                    <%--
                                    <!-- No entities number for the DatabaseObject -->
                                    [<a href="${pageContext.request.contextPath}/schema/objects/${node.clazz.simpleName}"
                                    title="Show Entries">${node.count}</a>]
                                    --%>
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
