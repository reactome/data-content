<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/tags/customTag.tld"%>

<c:import url="../header.jsp"/>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
    <c:choose>
        <c:when test="${empty q}">
            <h3>No search has been specified.</h3>
            <p class="favth-h5">Please consider refining your terms:</p>
            <ul class="list">
                <li>Start typing few letters in the search and look at the suggested options</li>
                <li>Type words and click the Search for a full search</li>
            </ul>
        </c:when>
        <c:otherwise>
            <h3>No results found for ${q}</h3>
            <c:choose>
                <c:when test="${empty suggestions}">
                    <%--<p class="alert">Sorry we could not find any entry matching '${q}'</p>--%>
                    <p>Please consider refining your terms:</p>
                    <div class="padding0 left30">
                    <ul class="list lower-alpha">
                        <li>Make sure all words are spelled correctly</li>
                        <li>Try different keywords</li>
                        <li>Be more precise: use gene or protein IDs, e.g. Ndc80 or Q04571</li>
                        <li>Remove quotes around phrases to search for each word individually</li>
                    </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="padding0 left">
                    <h4>Did you mean...</h4>
                    <div class="padding0 left">
                        <ul class="list">
                            <c:forEach var="suggestion" items="${suggestions}">
                                <c:url var="url" value="">
                                    <c:param name="q" value="${suggestion}"/>
                                </c:url>
                                <li><a href="./query${url}<mytag:linkEscape name="species" value="${species}"/><mytag:linkEscape name="types" value="${types}"/><mytag:linkEscape name="compartments" value="${compartments}"/><mytag:linkEscape name="keywords" value="${keywords}"/>&amp;cluster=${cluster}" title="search for ${suggestion}" >${suggestion}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>

    <%-- Only shows the contact us form if q is not empty or greater than 1 --%>
    <c:if test="${not empty q && fn:length(q) gt 1}">
        <c:import url="contactForm.jsp">
            <c:param name="source" value="W"/>
        </c:import>
    </c:if>
</div>

<c:import url="../footer.jsp"/>