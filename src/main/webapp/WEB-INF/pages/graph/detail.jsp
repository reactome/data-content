<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
        <c:import url="title.jsp"/>

        <c:if test="${not empty topLevelNodes}">
            <c:import url="locationsInThePWB.jsp"/>
        </c:if>

        <c:if test="${not empty previewURL || not empty databaseObject.summation}" >
            <fieldset class="fieldset-details">
                <legend>General</legend>
                <c:if test="${not empty previewURL}" >

                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 favth-hidden-xs">
                        <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-6">
                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0" title="">
                                    <a href="/ContentService/exporter/event/${databaseObject.stId}.sbml" download="${databaseObject.stId}.sbml" title="Export diagram to SBML"><i class="fa fa-download"></i> SBML</a>
                                </div>
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0 biopax-dropdown" title="Export diagram to BioPAX Level or BioPAX Level 3">
                                    <a><i class="fa fa-download"></i> BioPAX</a>
                                    <div class="biopax-version-tooltip">
                                        <a href="/ReactomeRESTfulAPI/RESTfulWS/biopaxExporter/Level2/${databaseObject.dbId}">BioPAX 2</a>
                                        <a href="/ReactomeRESTfulAPI/RESTfulWS/biopaxExporter/Level3/${databaseObject.dbId}">BioPAX 3</a>
                                    </div>
                                </div>
                                <%-- UNCOMMENT TO EXPORT TO PDF --%>
                                <%--<div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0">--%>
                                    <%--<a href="/ContentService/exporter/diagram/${databaseObject.stId}.pdf" download="${databaseObject.stId}.pdf" title="Export diagram to PDF"><i class="fa fa-download"></i> PDF</a>--%>
                                <%--</div>--%>
                            </div>
                        </div>

                        <c:set var="url" value="${fn:replace(downloadURL, '_stId_', databaseObject.stId)}" />
                        <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-6 padding0">
                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
                                <div class="favth-col-lg-2 favth-col-lg-offset-4 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0" title="Download diagram in SVG">
                                    <a href="${fn:replace(url, "_ext_", "svg")}" download="${databaseObject.stId}.svg"><i class="fa fa-download"></i> SVG</a>
                                </div>
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0 png-dropdown" title="Download diagram in PNG">
                                    <a><i class="fa fa-download"></i> PNG</a>
                                    <div class="png-resolution-tooltip">
                                        <a href="${fn:replace(url, "_ext_", "png")}?quality=2" download="${databaseObject.stId}.png">Low</a><br/>
                                        <a href="${fn:replace(url, "_ext_", "png")}?quality=5" download="${databaseObject.stId}.png">Medium</a><br/>
                                        <a href="${fn:replace(url, "_ext_", "png")}?quality=7" download="${databaseObject.stId}.png">High</a>
                                    </div>
                                </div>
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0" title="Export to PowerPoint">
                                    <a href="${fn:replace(url, "_ext_", "pptx")}"><i class="fa fa-download"></i> PPTX</a>
                                </div>
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-3 favth-col-xs-4 padding0" title="Export to SBGN">
                                    <a href="${fn:replace(url, "_ext_", "sbgn")}"><i class="fa fa-download"></i> SBGN</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0 text-center">
                            <div class="text-center">
                                <a href="/PathwayBrowser/#/${databaseObject.stId}">
                                    <img src="${previewURL}?title=false" alt="${databaseObject.displayName}" class="ehld">
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty databaseObject.summation}">
                    <div class="details-summation">
                        <c:forEach var="summation" items="${databaseObject.summation}">
                            <p>${summation.text}</p>
                        </c:forEach>
                    </div>
                </c:if>
            </fieldset>
        </c:if>

        <c:if test="${not empty databaseObject.literatureReference}">
            <c:import url="literatureReferences.jsp"/>
        </c:if>

        <c:if test="${clazz == 'PhysicalEntity'}">
            <c:import url="physicalEntityDetails.jsp"/>
        </c:if>

        <c:if test="${clazz == 'Event'}">
            <c:import url="eventDetails.jsp"/>
        </c:if>

        <c:import url="generalAttributes.jsp"/>

        <c:if test="${clazz == 'Regulation'}">
            <c:import url="regulationDetails.jsp"/>
        </c:if>

        <%--For those that ARE in Reactome, for those that ARE NOT in Reactome, check graph/interactors.jsp--%>
        <c:if test="${not empty interactions}">
            <c:import url="interactionDetails.jsp"/>
        </c:if>
    </div>
<c:import url="../footer.jsp"/>