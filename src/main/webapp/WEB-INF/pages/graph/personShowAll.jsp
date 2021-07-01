<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="../header.jsp"/>
<%-- Person Page--%>
<c:if test="${not empty person}">
    <c:choose>
        <c:when test="${not empty person.orcidId}">
            <a href="${pageContext.request.contextPath}/detail/person/${person.orcidId}" class=""
               title="Return to person details"> <<< Go back</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/detail/person/${person.dbId}" class=""
               title="Return to person details"> <<< Go back</a>
        </c:otherwise>
    </c:choose>
    <c:import url="personShowAllCommon.jsp"/>

</c:if>

<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<c:import url="personCommon.jsp"/>
<c:import url="../footer.jsp"/>