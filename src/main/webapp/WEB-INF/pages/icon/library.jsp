<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:import url="../header.jsp"/>

<div class="favth-col-xs-12">
    <div class="margin0 top alert alert-info" role="alert">
        <span class="favth-hidden-xs favth-hidden-sm"><i class="fa fa-info-circle"></i>Do you want to search for icons? <strong>Type</strong> e.g "<a href="/content/query?q=kidneys&species=Homo+sapiens&species=Entries+without+species&cluster=true&types=Icon">kidneys</a>" in the search box.</span>
        <span class="favth-visible-xs favth-visible-sm" style="font-size: 12px;">Do you want to search for icons? <br/><strong>Type</strong> e.g "<a href="/content/query?q=kidneys&species=Homo+sapiens&species=Entries+without+species&cluster=true&types=Icon">kidneys</a>" in the search box.</span>
    </div>
    <div class="margin0 bottom">
        <h3 class="details-title favth-hidden-xs"><i class="fa fa-archive"></i> Library of icons for Enhanced High Level Diagrams (EHLD)</h3>
        <h3 class="details-title favth-visible-xs"><i class="fa fa-archive"></i> Library of icons for EHLD</h3>
    </div>

    <c:if test="${not empty icons.available || not empty icons.selected }">
        <fieldset class="fieldset-details favth-clearfix">
            <legend>Library - <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${totalIcons}"/> unique icons</legend>
            <div class="favth-col-xs-12 favth-hidden-xs favth-hidden-sm">
                <h4 class="margin0 top bottom">The icons are organised based on their categories</h4>
            </div>
            <div class="favth-row">
                <div class="favth-col-xs-12">
                    <c:forEach var="available" items="${icons.available}">
                        <div class="favth-col-lg-2-4 favth-col-md-6 favth-col-xs-12 favth-text-center">
                            <div class="category">
                                <%-- To be used in the url, so it doesn't go with space --%>
                                <c:set var="category" value="${fn:replace(available.name, ' ', '_')}" />
                                <c:set var="categoryDisplay" value="${available.name}" />
                                <a href="/icon-lib/${fn:toLowerCase(category)}">
                                    <i class="fa fa-tag" aria-hidden="true"></i>
                                    <div class="folder-label">${categoryDisplay}</div><div class="category-size">(${available.count} components)</div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="favth-col-xs-12 padding0 text-center">
                <div class="favth-col-lg-offset-8 favth-col-lg-4 favth-col-md-5 favth-col-md-offset-7 favth-col-sm-6 favth-col-sm-offset-6 favth-col-xs-12 padding0">
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-12 favth-hidden-xs category-size">
                        Download:
                    </div>
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-4" title="Download ALL icons in SVG format">
                        <a href="/icon/icon-lib-svg.tgz"><i class="fa fa-download" aria-hidden="true"></i>SVG</a>
                    </div>
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-4" title="Download ALL icons in EMF format">
                        <a href="/icon/icon-lib-emf.tgz"><i class="fa fa-download" aria-hidden="true"></i>EMF</a>
                    </div>
                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-4" title="Download ALL icons in PNG format">
                        <a href="/icon/icon-lib-png.tgz"><i class="fa fa-download" aria-hidden="true"></i>PNG</a>
                    </div>
                </div>
            </div>

        </fieldset>
    </c:if>

    <div class="favth-col-xs-12 disclaimer-info padding0">
        <c:import url="disclaimer.jsp"/>
    </div>


</div>

<c:import url="../footer.jsp"/>