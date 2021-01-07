<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:import url="../common/widgetStyle.jsp"/>
<c:set var="preUrl" value="${pageContext.request.getHeader('Referer')}"/>

<div id="fav-container" class="fav-container">
    <div class="favth-container" style="margin: 0; width:100%">
            <c:if test="${not empty preUrl}">
                <a href="#" onclick="history.go(-1)"> <<< Go Back</a>
            </c:if>
            <c:import url="detailsCommon.jsp"/>
    </div>
</div>