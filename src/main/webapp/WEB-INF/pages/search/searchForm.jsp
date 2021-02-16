<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="placeholder" value="e.g. O95631, NTN1, signaling by EGFR, glucose, GO:0043293" />
<c:if test="${iconsSearch}">
    <c:set var="placeholder" value="e.g. P06241, liver, CFTR, protein" />
</c:if>

<div class="search">
    <form action="/content/query" method="get" class="clean-form form-inline" id="search_form">
        <label for="local-searchbox" class="element-invisible">Search ...</label>
        <input id="local-searchbox" type="search" class="inputbox search-query alt-searchbox" name="q" placeholder="${placeholder}" value="${fn:escapeXml(q)}"  maxlength="200" autocomplete="off" />
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
        <c:if test="${iconsSearch}">
            <input type="hidden" name="types" value="Icon"/>
        </c:if>
    </form>
</div>