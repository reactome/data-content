<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/tags/customTag.tld"%>

<c:import url="../header.jsp"/>

<div class="favth-col-xs-12">
    <c:import url="../common/contactForm.jsp">
        <c:param name="source" value="O"/>
    </c:import>
</div>

<c:import url="../footer.jsp"/>