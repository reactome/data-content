<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>

<link rel="stylesheet" href="/css/main.css" type="text/css">
<link rel="stylesheet" href="/css/ebi-fluid.css" type="text/css">

<div class="ebi-content">
    <div class="grid_24">

        <h3 class="details-title">
            ${map.get('DisplayName')}
        </h3>
        <div class="schema-div">
            <table class="schema-detail-table">
                <tbody>

                <c:forEach var="entry" items="${map}" varStatus="loopStatus">
                    <tr class="${loopStatus.index % 2 == 0 ? 'even' : 'odd'}">
                        <td style="width: 20%">${entry.key}</td>
                        <td style="width: 80%">
                            <c:choose>
                                <c:when test="${entry.value.getClass().getSimpleName() == 'String' ||
                                                    entry.value.getClass().getSimpleName() == 'Long'   ||
                                                    entry.value.getClass().getSimpleName() == 'Integer'   ||
                                                    entry.value.getClass().getSimpleName() == 'Date'   ||
                                                    entry.value.getClass().getSimpleName() == 'Boolean'}">
                                    <span style="color:black"> ${entry.value} </span>
                                </c:when>
                                <c:when test="${entry.value.getClass().getSimpleName() == 'StoichiometryObject'}">
                                    <c:if test="${entry.value.stoichiometry gt 1}">${entry.value.stoichiometry} x </c:if><a href="/schema/object/detail/${entry.value.object.getDbId()}">[${entry.value.object.getSchemaClass()}:${entry.value.object.getDbId()}] ${entry.value.object.getDisplayName()}</a>
                                </c:when>
                                <c:when test="${entry.value.getClass().getSimpleName() == 'ArrayList' || entry.value.getClass().getSimpleName() == 'HashSet'}">
                                    <ul class="list overflow">
                                        <c:forEach var="list" items="${entry.value}">
                                            <li>
                                                <c:choose>
                                                    <c:when test="${list.getClass().getSimpleName() == 'String' ||
                                                                        list.getClass().getSimpleName() == 'Long'   ||
                                                                        list.getClass().getSimpleName() == 'Integer'   ||
                                                                        list.getClass().getSimpleName() == 'Date'   ||
                                                                        list.getClass().getSimpleName() == 'Boolean'}">
                                                        <span style="color:black"> ${list} </span>
                                                    </c:when>
                                                    <c:when test="${list.getClass().getSimpleName() == 'StoichiometryObject'}">
                                                        <c:if test="${list.stoichiometry gt 1}"> <span title="Stoichiometry">${list.stoichiometry} &times;</span></c:if> <a href="/schema/object/detail/${list.object.getDbId()}">[${list.object.getSchemaClass()}:${list.object.getDbId()}] ${list.object.getDisplayName()}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:catch>
                                                            <c:if test="${!empty list.getDbId()}">
                                                                <a href="/schema/object/detail/${list.getDbId()}">[${list.getSchemaClass()}:${list.getDbId()}] ${list.getDisplayName()}</a>
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
                                            <a href="/schema/object/detail/${entry.value.getDbId()}">[${entry.value.getSchemaClass()}:${entry.value.getDbId()}] ${entry.value.getDisplayName()}</a>
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
    </div>
</div>
<div class="clear"></div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="../footer.jsp"/>