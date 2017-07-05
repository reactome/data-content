<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="search">
    <form id="search_form" action="${pageContext.request.contextPath}/query" method="get" class="clean-form form-inline">
        <label for="mod-search-searchword" class="element-invisible">Search ...</label>
        <input id="mod-search-searchword" type="search" class="inputbox search-query alt-searchbox" name="q" placeholder="e.g. O95631, NTN1, signaling by EGFR, glucose" value="${q}"  maxlength="200"/>
        <c:choose>
            <c:when test="${not empty species}">
                <c:forEach var="item" items="${species}">
                    <input type="hidden" name="species" value="${item}"/>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <input type="hidden" name="species" value="Homo sapiens"/>
                <input type="hidden" name="species" value="Entries without species"/>
            </c:otherwise>
        </c:choose>
        <c:if test="${not empty types}">
            <c:forEach var="item" items="${types}">
                <input type="hidden" name="types" value="${item}"/>
            </c:forEach>
        </c:if>
        <c:if test="${not empty compartments}">
            <c:forEach var="item" items="${compartments}">
                <input type="hidden" name="compartments" value="${item}"/>
            </c:forEach>
        </c:if>
        <c:if test="${not empty keywords}">
            <c:forEach var="item" items="${keywords}">
                <input type="hidden" name="keywords" value="${item}"/>
            </c:forEach>
        </c:if>
        <input type="hidden" name="cluster" value="true"/>
        <button class="button btn btn-primary btn-info">Go!</button>
    </form>
</div>