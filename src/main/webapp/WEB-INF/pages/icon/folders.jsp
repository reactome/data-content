<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../header.jsp"/>

<div class="intro-message text-justify favth-clearfix">
    <h3>
        <!-- Library with all the different components used to generate the Reactome Enhanced High Level Diagrams (EHLD) -->
        Library of icons for Reactome Enhanced High Level Diagrams (EHLD)
    </h3>
</div>
<div class="intro-explanation favth-clearfix">
    <h4>
        The icons are organised in different folders based on their types:
    </h4>
</div>

<c:if test="${not empty icons.available || not empty icons.selected }">
<div class="favth-row">
    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
        <c:forEach var="available" items="${icons.available}">
            <div class="favth-col-lg-3 favth-col-md-4 favth-col-sm-4 favth-col-xs-12 favth-text-center">
                <div class="folder">
                    <a href="${pageContext.request.contextPath}/icon-lib/${available.name}">
                        <i class="fa fa-folder" aria-hidden="true"></i>
                        <div class="folder-label">${available.name}</div><div class="folder-size">(${available.count} components)</div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</c:if>

<%--<div class="download-lib">--%>
    <%--<a><i class="fa fa-download" aria-hidden="true"></i>Download all library components</a>--%>
    <%--<div class="tooltip-download-lib">--%>
        <%--<a href="./icon-lib-svg.tgz">Download all SVG components</a><br/>--%>
        <%--<a href="./icon-lib-emf.tgz">Download all EMF components</a><br/>--%>
        <%--<a href="./icon-lib-png.tgz">Download all PNG components</a>--%>
    <%--</div>--%>
<%--</div>--%>
<div class="total-size favth-clearfix">Icon library contains: <b>${totalIcons}</b> components</div>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
<c:import url="disclaimer.jsp"/>
</div>

<c:import url="../footer.jsp"/>