<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:import url="../common/widgetStyle.jsp"/>
<c:set var="preUrl" value="${pageContext.request.getHeader('Referer')}"/>

<div id="fav-container" class="fav-container">
    <div class="favth-container" style="margin: 0; width:100%">
        <c:if test="${not empty person}">
            <c:choose>
                <c:when test="${not empty person.orcidId}">
                    <c:if test="${(not empty preUrl) and (fn:contains(preUrl, 'reactome.org'))}">
                        <a href="#" onclick="history.go(-1)"> <<< Go Back</a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <c:if test="${(not empty preUrl) and (fn:contains(preUrl, 'reactome.org'))}">
                        <a href="#" onclick="history.go(-1)"> <<< Go Back</a>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <%-- Person Page--%>
            <c:import url="perShowAllCommon.jsp"/>
        </c:if>

        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <c:import url="personCommon.jsp"/>
    </div>
</div>