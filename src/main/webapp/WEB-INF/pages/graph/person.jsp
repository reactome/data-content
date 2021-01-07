<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="../header.jsp"/>
<%-- Person Page--%>
<c:if test="${not empty person}">
    <c:import url="personTableCommon.jsp"/>
</c:if>

<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<c:import url="personCommon.jsp"/>

<c:import url="../footer.jsp"/>