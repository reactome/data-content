<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>

<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/schema.css" type="text/css">--%>
<link rel="stylesheet" href="/content/resources/css/schema.css" type="text/css">

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
    <div>
        <div class="breadcrumbs clearfix">
            <a href="${pageContext.request.contextPath}/schema/">Schema</a> &gt;
            <a href="${pageContext.request.contextPath}/schema/${breadcrumbSchemaClass}">${breadcrumbSchemaClass}</a> &gt;
            <a href="${pageContext.request.contextPath}/schema/objects/${breadcrumbSchemaClass}">Entries</a>
        </div>
    </div>

    <h3 class="details-title padding0 top">
        ${map.get('displayName')}<c:catch><c:if test="${not empty map.get('speciesName')}"> [${map.get('speciesName')}]</c:if></c:catch>
    </h3>

    <c:if test="${linkToDetailsPage}">
        <div>
            <a href="${pageContext.request.contextPath}/detail/${id}" class="btn btn-info goto-details-light">Go to Details</a>
        </div>
    </c:if>

    <div id="r-responsive-table">
        <table class="reactome instance-table margin0">
            <tbody>
            <c:forEach var="entry" items="${map}">
                <tr>
                    <td class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2">${entry.key}</td>
                    <td class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10">
                        <c:choose>
                            <c:when test="${entry.value.getClass().getSimpleName() == 'String'        ||
                                                entry.value.getClass().getSimpleName() == 'Double'    ||
                                                entry.value.getClass().getSimpleName() == 'Float'     ||
                                                entry.value.getClass().getSimpleName() == 'Long'      ||
                                                entry.value.getClass().getSimpleName() == 'Integer'   ||
                                                entry.value.getClass().getSimpleName() == 'Date'      ||
                                                entry.value.getClass().getSimpleName() == 'Boolean'}">
                                <c:choose>
                                    <%-- add value into an anchor tag just to show as a link. it's generic we need this check --%>
                                    <c:when test="${fn:startsWith(entry.value, 'http://') || fn:startsWith(entry.value, 'https://')}">
                                        <a href="${entry.value}" title="${entry.value}">${entry.value}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:black"> ${entry.value} </span>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:when test="${entry.value.getClass().getSimpleName() == 'StoichiometryObject'}">
                                <c:set var="id" value="${list.getDbId()}"/>
                                <c:if test="${!empty list.getStId()}">
                                    <c:set var="id" value="${list.getStId()}"/>
                                </c:if>
                                <c:if test="${entry.value.stoichiometry gt 1}">${entry.value.stoichiometry} &times; </c:if><a href="./${id}" title="${entry.value.object.getDisplayName()}">[${entry.value.object.getSchemaClass()}:${id}] ${entry.value.object.getDisplayName()}<c:catch><c:if test="${not empty list.getSpeciesName()}"> - ${list.getSpeciesName()}</c:if></c:catch></a>
                            </c:when>
                            <c:when test="${entry.value.getClass().getSimpleName() == 'ArrayList' ||
                                            entry.value.getClass().getSimpleName() == 'HashSet' ||
                                            entry.value.getClass().getSimpleName() == 'LinkedHashSet'}">
                                <ul class="list overflow">
                                    <c:forEach var="list" items="${entry.value}">
                                        <li>
                                            <c:choose>
                                                <c:when test="${list.getClass().getSimpleName() == 'String'       ||
                                                                    list.getClass().getSimpleName() == 'Double'   ||
                                                                    list.getClass().getSimpleName() == 'Float'    ||
                                                                    list.getClass().getSimpleName() == 'Long'     ||
                                                                    list.getClass().getSimpleName() == 'Integer'  ||
                                                                    list.getClass().getSimpleName() == 'Date'     ||
                                                                    list.getClass().getSimpleName() == 'Boolean'}">
                                                    <span style="color:black"> ${list} </span>
                                                </c:when>
                                                <c:when test="${list.getClass().getSimpleName() == 'StoichiometryObject'}">
                                                    <c:set var="id" value="${list.object.getDbId()}"/>
                                                    <c:if test="${!empty list.object.getStId()}">
                                                        <c:set var="id" value="${list.object.getStId()}"/>
                                                    </c:if>
                                                    <c:if test="${list.stoichiometry gt 1}"> <span title="Stoichiometry">${list.stoichiometry} &times;</span></c:if> <a href="./${id}" title="${list.object.getDisplayName()}">[${list.object.getSchemaClass()}:${id}] ${list.object.getDisplayName()}<c:catch><c:if test="${not empty list.getSpeciesName()}"> - ${list.getSpeciesName()}</c:if></c:catch> </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:catch>
                                                        <c:if test="${!empty list.getDbId()}">
                                                            <c:set var="id" value="${list.getDbId()}"/>
                                                            <c:if test="${!empty list.getStId()}">
                                                                <c:set var="id" value="${list.getStId()}"/>
                                                            </c:if>
                                                            <a href="./${id}" title="${list.getDisplayName()}">[${list.getSchemaClass()}:${id}] ${list.getDisplayName()}<c:catch><c:if test="${not empty list.getSpeciesName()}"> - ${list.getSpeciesName()}</c:if></c:catch></a>
                                                        </c:if>
                                                    </c:catch>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <c:catch>
                                    <c:if test="${!empty entry.value.dbId}">
                                        <c:set var="id" value="${entry.value.dbId}"/>
                                        <c:if test="${!empty entry.value.stId}">
                                            <c:set var="id" value="${entry.value.stId}"/>
                                        </c:if>
                                        <a href="./${id}" title="${entry.value.getDisplayName()}">[${entry.value.getSchemaClass()}:${id}] ${entry.value.getDisplayName()}<c:catch><c:if test="${not empty list.getSpeciesName()}"> - ${list.getSpeciesName()}</c:if></c:catch></a>
                                    </c:if>
                                </c:catch>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <c:if test="${not empty referrals}">
        <div id="r-responsive-table">
            <h3>Referrals</h3>
            <table class="reactome instance-table margin0">
                <tbody>
                    <c:forEach var="entry" items="${referrals}">
                        <tr>
                            <td class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2">
                                <u>(${entry.referral})</u>
                            </td>
                            <td class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10">
                                <ul class="list">
                                    <c:forEach var="list" items="${entry.objects}">
                                        <c:if test="${!empty list.getDbId()}">
                                            <c:set var="id" value="${list.getDbId()}"/>
                                            <c:if test="${!empty list.getStId()}">
                                                <c:set var="id" value="${list.getStId()}"/>
                                            </c:if>
                                            <li><a href="./${id}" title="${list.getDisplayName()}">[${list.getSchemaClass()}:${id}] ${list.getDisplayName()}<c:catch><c:if test="${not empty list.getSpeciesName()}"> - ${list.getSpeciesName()}</c:if></c:catch></a></li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>

<c:import url="../footer.jsp"/>