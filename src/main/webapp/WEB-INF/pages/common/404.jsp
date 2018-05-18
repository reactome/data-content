<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="baseURL" value="${fn:replace(req.requestURL, req.requestURI, req.contextPath)}" />
<c:set var="forwardReqURI" value="${fn:replace(requestScope['javax.servlet.forward.request_uri'],req.contextPath, '')}" />
<c:set var="reqURL" value="${baseURL}${forwardReqURI}" />
<c:if test="${not empty requestScope['javax.servlet.forward.query_string']}">
    <c:set var="reqURL" value="${reqURL}?${requestScope['javax.servlet.forward.query_string']}" />
</c:if>
<c:import url="../header.jsp"/>
<script>document.title = "Reactome | (404) Not found";</script>
<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
    <div class="moduletable">
        <div class="custom">
            <div class="favth-container">
                <div class="favth-row">
                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                        <h2>The requested page can't be found.</h2>
                        <hr>
                        <p>If difficulties persist, please contact the <a href="mailto:help@reactome.org">help@reactome.org</a> and report the error below.</p>
                        <p><span class="favth-label favth-label-default">404</span>Page not Found!</p>
                        <pre><code>${reqURL}</code></pre>
                        <br>
                        <a href="/" class="btn"><span class="icon-home"></span>Home Page</a>
                    </div>
                </div>
            </div>
            <p>&nbsp;</p>
        </div>
    </div>
</div>
<c:import url="../footer.jsp"/>