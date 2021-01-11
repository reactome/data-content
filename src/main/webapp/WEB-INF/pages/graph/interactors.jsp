<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:import url="../header.jsp"/>
<%-- Interactors Intermediate Page--%>
<c:if test="${not empty interactions}">
    <c:import url="interactorsCommon.jsp"/>
</c:if>
<c:import url="../footer.jsp"/>