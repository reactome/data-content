<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/tld/customTag.tld"%>

<c:import url="../header.jsp"/>

<div class="favth-col-xs-12">
    <c:choose>
        <c:when test="${empty q}">
            <h3>No icon name has been specified.</h3>
            <p class="favth-h5">Please consider refining your terms:</p>
            <ul class="list">
                <li>Start typing few letters in the search and look at the suggested options</li>
                <li>Type words and click the Search for a full search</li>
            </ul>
        </c:when>
        <c:otherwise>
            <h3>No results found for ${q}</h3>

            <p>Please consider refining your terms:</p>
            <div class="padding0 left30">
                <ul class="list lower-alpha">
                    <li>Make sure all words are spelled correctly</li>
                    <li>Try different keywords</li>
                    <li>Remove quotes around phrases to search for each word individually</li>
                </ul>
            </div>

        </c:otherwise>
    </c:choose>
</div>

<c:import url="../footer.jsp"/>