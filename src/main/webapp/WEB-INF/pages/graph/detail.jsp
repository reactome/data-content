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
                                <div class="">
                                    <i class="fa fa-file-code-o" style="color: #2F9EC2"></i>
                                    <a href="/ContentService/exporter/event/${databaseObject.stId}.sbml" download="${databaseObject.stId}.sbml" title="Export diagram to SBML">SBML</a>&nbsp;|&nbsp;
                                    <div class="biopax-dropdown">
                                        <a style="cursor: pointer">BioPAX</a>
                                        <div class="biopax-version-tooltip">
                                            <a href="/ReactomeRESTfulAPI/RESTfulWS/biopaxExporter/Level2/${databaseObject.dbId}">Level 2</a>
                                            <a href="/ReactomeRESTfulAPI/RESTfulWS/biopaxExporter/Level3/${databaseObject.dbId}">Level 3</a>
                                        </div>
                                    </div>&nbsp;|&nbsp;
                                    <a href="/ContentService/exporter/document/event/${databaseObject.stId}.pdf" download="${databaseObject.stId}.pdf" title="Export diagram to PDF">PDF</a>
                                </div>
                            </div>
                        </div>

                        <c:set var="url" value="${fn:replace(downloadURL, '_stId_', databaseObject.stId)}" />
                        <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-6 padding0">
                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
                                <div class="pull-right">
                                    <i class="fa fa-download" style="color: #2F9EC2"></i>
                                    <a href="${fn:replace(url, "_ext_", "svg")}" download="${databaseObject.stId}.svg">SVG</a>&nbsp;|&nbsp;
                                    <div class="png-dropdown">
                                    <a style="cursor: pointer">PNG</a>
                                        <div class="png-resolution-tooltip<c:if test="${isEHLD}"> png-resolution-tooltip-noEHLD</c:if>">
                                            <a href="${fn:replace(url, "_ext_", "png")}?quality=2" download="${databaseObject.stId}.png">Low</a><br/>
                                            <a href="${fn:replace(url, "_ext_", "png")}?quality=5" download="${databaseObject.stId}.png">Medium</a><br/>
                                            <a href="${fn:replace(url, "_ext_", "png")}?quality=7" download="${databaseObject.stId}.png">High</a>
                                        </div>
                                    </div>
                                    <c:if test="${not isEHLD}">
                                        &nbsp;|&nbsp;<a href="${fn:replace(url, "_ext_", "pptx")}">PPTX</a>
                                        &nbsp;|&nbsp;<a href="/ContentService/exporter/event/${databaseObject.stId}.sbgn">SBGN</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0 text-center">
                            <c:choose>
                                <c:when test="${empty topLevelNodes}">
                                    <div class="text-center margin0 top" style="min-height: 300px;">
                                        <img src="${previewURL}?title=false" alt="${databaseObject.displayName}" title="'${databaseObject.displayName}' is an orphan event and cannot be opened in the Pathway Browser" class="diagram-rxn-preview">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center margin0 top" style="min-height: 300px;">
                                        <a href="/PathwayBrowser/#/${databaseObject.stId}">
                                            <img src="${previewURL}?title=false" alt="${databaseObject.displayName}" title="Open '${databaseObject.displayName}' in the Pathway Browser" class="diagram-rxn-preview">
                                        </a>
                                    </div>
                                    <div class="text-center margin0 bottom">
                                        <span style="font-size: smaller">
                                            Click the image above or <a href="/PathwayBrowser/#/${databaseObject.stId}">here</a> to open this ${fn:toLowerCase(fn:replace(databaseObject.className, "TopLevel", ""))} in the Pathway Browser
                                            <c:if test="${databaseObject.className == 'Reaction'}">
                                                <br/><i class="fa fa-info-circle" style="color: #2F9EC2; font-size: 15px;"></i>The layout of this reaction may differ from that in the pathway view due to the constraints in pathway layout
                                            </c:if>
                                        </span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
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