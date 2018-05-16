<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="../header.jsp"/>
<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
    <%-- Combine stackTrace and cause stacktrace, pass to contactForm.jsp then /contact controller --%>
    <c:forEach items="${exception.stackTrace}" var="currentItem" varStatus="index">
        <c:set var="stacktrace" value="${index.first ? '' : stacktrace}#${currentItem}" />
    </c:forEach>
    <c:forEach items="${exception.cause.stackTrace}" var="currentItem" varStatus="index">
        <c:set var="cause" value="${index.first ? '' : cause}##C##${currentItem}" />
    </c:forEach>

    <c:import url="contactForm.jsp">
        <c:param name="source" value="E"/>
        <c:param name="exception" value="${stacktrace}#Caused by:${cause}"/>
    </c:import>
</div>
<c:import url="../footer.jsp"/>