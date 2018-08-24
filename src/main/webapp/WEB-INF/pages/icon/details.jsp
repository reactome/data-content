<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../header.jsp"/>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">

<h3 class="details-title">
    <i class="sprite sprite-${entry.exactType}" title="${entry.exactType}"></i> ${entry.name}
</h3>

<div class="extended-header favth-clearfix">
    <c:if test="${not empty entry.iconGroup}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Group</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span><a href="${pageContext.request.contextPath}/icon-lib/${entry.iconGroup}">${group}</a></span>
        </div>
    </c:if>

    <c:if test="${not empty entry.iconCuratorName}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Curator</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${entry.iconCuratorName}</span>
        </div>
    </c:if>

    <c:if test="${not empty entry.iconDesignerName}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Designer</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${entry.iconDesignerName}</span>
        </div>
    </c:if>

    <c:if test="${not empty entry.iconDesignerName}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Description</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${entry.summation}</span>
        </div>
    </c:if>
</div>

<fieldset class="fieldset-details">
    <legend>Icon preview</legend>
    <div class="favth-col-lg-3 favth-col-md-4 favth-col-sm-5 favth-col-xs-12 text-center margin0 top">
        <img class="icon-preview" src="/ehld-icons/lib/${entry.iconGroup}/${fn:escapeXml(entry.iconName)}.svg" alt="Icon ${entry.name}" />
    </div>
    <div class="favth-col-lg-9 favth-col-md-6 favth-col-sm-5 favth-col-xs-12 text-xs-center margin0 top">
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
            <span><a href="${pageContext.request.contextPath}/icon-lib/download/${entry.iconName}.svg"><i class="fa fa-download"></i> SVG</a></span>
        </div>
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
            <span><a href="${pageContext.request.contextPath}/icon-lib/download/${entry.iconName}.png"><i class="fa fa-download"></i> PNG</a></span>
        </div>
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
            <span><a href="${pageContext.request.contextPath}/icon-lib/download/${entry.iconName}.emf"><i class="fa fa-download"></i> EMF</a></span>
        </div>
    </div>
</fieldset>

<c:if test="${not empty pwbTree}">
    <div class="clearfix">
        <fieldset class="fieldset-details">
            <legend>EHLD in the PathwayBrowser</legend>
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <c:forEach var="ehldPWB" items="${pwbTree}">
                    <c:forEach var="topLvl" items="${ehldPWB}">
                        <c:choose>
                            <c:when test="${empty topLvl.children}">
                                <span style="font-size:13px; padding-left: 0;"><i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"></i></span>
                                <a href="${topLvl.url}" class="tree-sm-overflow" title="goto Reactome Pathway Browser">
                                    <span <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if>>${topLvl.name} (${topLvl.stId})</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div>
                                    <span class="plus tree-root" title="click here to expand or collapse the tree">
                                        <i class="fa fa-minus-square-o" title="click here to expand or collapse the tree" style="vertical-align: middle"></i>
                                        <i class="sprite-resize sprite sprite-Pathway" style="vertical-align: middle"></i><span class="tree-sm-overflow">${topLvl.name} (${topLvl.stId})</span>
                                    </span>
                                    <div>
                                        <ul class="tree">
                                            <c:set var="node" value="${topLvl}" scope="request"/>
                                            <li><c:import url="node.jsp"/></li>
                                        </ul>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:forEach>
            </div>
        </fieldset>
    </div>
</c:if>

<c:if test="${not empty entry.iconStIds}">
    <fieldset class="fieldset-details">
        <legend>Entries for ${entry.name}</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="stId" items="${entry.iconStIds}">
                        <div class="favth-col-lg-4 favth-col-md-4 favth-col-sm-3 favth-col-xs-6 text-overflow">
                            <a href="${pageContext.request.contextPath}/detail/${stId}" title="Open ${stId}">${stId}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty references}">
    <div class="favth-clearfix">
        <fieldset class="fieldset-details">
            <legend>External References</legend>
            <c:forEach var="entry" items="${references}">
                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">${entry.key}</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div>
                                <c:forEach var="value" items="${entry.value}" varStatus="loop">
                                    <c:set var="accessUrl" value="${urlMapping[entry.key.toUpperCase()]}" />
                                    <c:choose>
                                        <c:when test="${not empty accessUrl}">
                                            <a href="${fn:replace(accessUrl, '###ID###', value)}" target="_blank" title="show ${entry.key}:${value}" >${value}</a><c:if test="${!loop.last}">, </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            ${value}<c:if test="${!loop.last}">, </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </fieldset>
    </div>
</c:if>

<c:if test="${not empty entry.iconCVTerms}">
    <fieldset class="fieldset-details">
        <legend>GO Terms</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="term" items="${entry.iconCVTerms}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-6 text-overflow">
                             ${term}
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>


<c:import url="../footer.jsp"/>