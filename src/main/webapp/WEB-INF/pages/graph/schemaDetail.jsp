<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>

<link rel="stylesheet" href="/css/main.css" type="text/css">
<link rel="stylesheet" href="/css/ebi-fluid.css" type="text/css">

<div class="ebi-content">
    <div class="grid_24">
        <h2>Details  ${map.get('DisplayName')}</h2>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td style="width: 20%">Name</td>
                <td style="width: 80%">Value</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${map}">
                <tr>
                    <td>${entry.key}</td>
                    <td>
                        <c:choose>
                            <c:when test="${entry.value.getClass().getSimpleName() == 'String' ||
                                                entry.value.getClass().getSimpleName() == 'Long'   ||
                                                entry.value.getClass().getSimpleName() == 'Integer'   ||
                                                entry.value.getClass().getSimpleName() == 'Date'   ||
                                                entry.value.getClass().getSimpleName() == 'Boolean'}">
                                ${entry.value}
                            </c:when>
                            <c:when test="${entry.value.getClass().getSimpleName() == 'ArrayList'}">
                                <ul class="list overflow">
                                    <c:forEach var="list" items="${entry.value}">
                                        <li>
                                            <c:choose>
                                                <c:when test="${list.getClass().getSimpleName() == 'String' ||
                                                                    list.getClass().getSimpleName() == 'Long'   ||
                                                                    list.getClass().getSimpleName() == 'Integer'   ||
                                                                    list.getClass().getSimpleName() == 'Date'   ||
                                                                    list.getClass().getSimpleName() == 'Boolean'}">
                                                    ${list}
                                                </c:when>
                                                <c:otherwise>
                                                    <c:catch>
                                                        <c:if test="${!empty list.getDbId()}">
                                                            <a href="/object/detail/${list.getDbId()}">[${list.getDbId()}]</a>
                                                            ${list.getDisplayName()}
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
                                        <a href="/object/detail/${entry.value.getDbId()}">${entry.value.getDisplayName()}</a>
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
<div class="clear"></div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="../footer.jsp"/>