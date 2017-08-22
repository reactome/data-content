<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${not empty jsonLd}">
    <script type="application/ld+json">
        <c:out value="${jsonLd}" escapeXml="false"></c:out>
    </script>
</c:if>

