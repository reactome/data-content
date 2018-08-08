<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../header.jsp"/>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
    <div class="margin0 bottom">
        <h3 class="details-title favth-hidden-xs"><i class="sprite sprite-Icon"></i> Library of icons for Enhanced High Level Diagrams (EHLD)</h3>
        <h3 class="details-title favth-visible-xs"><i class="sprite sprite-Icon"></i> Library of icons for EHLD</h3>
    </div>

    <c:if test="${not empty icons.available || not empty icons.selected }">
        <fieldset class="fieldset-details favth-clearfix">
            <legend>Library - ${totalIcons} icons</legend>
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 favth-hidden-xs favth-hidden-sm">
                <h4 class="margin0 top bottom">The icons are organised in different folders based on their types</h4>
            </div>
            <div class="favth-row">
                <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                    <c:forEach var="available" items="${icons.available}">
                        <div class="favth-col-lg-3 favth-col-md-4 favth-col-sm-6 favth-col-xs-12 favth-text-center">
                            <div class="folder">
                                <%-- To be used in the url, so it doesn't go with space --%>
                                <c:set var="folder" value="${fn:replace(available.name, ' ', '_')}" />
                                <c:set var="folderDisplay" value="${available.name}" />
                                <a href="${pageContext.request.contextPath}/icon-lib/${folder}">
                                    <i class="fa fa-folder" aria-hidden="true"></i>
                                    <div class="folder-label">${folderDisplay}</div><div class="folder-size">(${available.count} components)</div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0 text-center">
                <div class="favth-col-lg-offset-8 favth-col-lg-4 favth-col-md-5 favth-col-md-offset-7 favth-col-sm-6 favth-col-sm-offset-6 favth-col-xs-12 padding0">
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-12 favth-hidden-xs folder-size">
                        Download:
                    </div>
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-4" title="Download ALL icons in SVG format">
                        <a href="/ehld-icons/icon-lib-svg.tgz"><i class="fa fa-download" aria-hidden="true"></i>SVG</a>
                    </div>
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-4" title="Download ALL icons in EMF format">
                        <a href="/ehld-icons/icon-lib-emf.tgz"><i class="fa fa-download" aria-hidden="true"></i>EMF</a>
                    </div>
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-4" title="Download ALL icons in PNG format">
                        <a href="/ehld-icons/icon-lib-png.tgz"><i class="fa fa-download" aria-hidden="true"></i>PNG</a>
                    </div>
                </div>
            </div>

        </fieldset>
    </c:if>

    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
        <c:import url="disclaimer.jsp"/>
    </div>


</div>

<c:import url="../footer.jsp"/>