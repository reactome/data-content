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

<c:if test="${not empty pwbTree && entry.iconGroup != 'arrows'}">
   <div class="clearfix">
        <fieldset class="fieldset-details">
        <legend>EHLD in the PathwayBrowser</legend>
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                 <c:forEach var="ehldPWB" items="${pwbTree}">
                    <c:forEach var="topLvl" items="${ehldPWB}">
                    <c:choose>
                        <c:when test="${empty topLvl.children}">
                        <div id="tplasss_${topLvl.stId}" class="tplsSpe_${fn:replace(topLvl.species, ' ', '_')}">
                            <span style="font-size:13px; padding-left: 10px;"><i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"></i></span>
                            <a href="${topLvl.url}" <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if> title="goto Reactome Pathway Browser" >${topLvl.name} (${topLvl.species})</a>
                        </div>
                        </c:when>
                        <c:otherwise>
                            <%--
                                The class attribute is used as a jQuery selector. This class is not present in the css.
                                Specially for chemical, it is present in all species, instead of showing a big list we just show Human as the default
                                and let the user select the desired species in a dropdown list.
                             --%>
                            <div id="tpla_${topLvl.stId}" class="tplSpe_${fn:replace(topLvl.species, ' ', '_')}" style="display: none">
                                    <span class="plus tree-root" title="click here to expand or collapse the tree">
                                        <i class="fa fa-plus-square-o" title="click here to expand or collapse the tree" style="vertical-align: middle"></i>
                                        <i class="sprite-resize sprite sprite-Pathway" style="vertical-align: middle"></i>
                                        <a href="${topLvl.url}" <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if> title="goto Reactome Pathway Browser" >${topLvl.name} (${topLvl.stId})</a>
                                        <%--<span <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if>>${topLvl.name} (${topLvl.species})</span>--%>
                                    </span>
                                <div class="tree-lpwb">
                                    <ul class="tree">
                                        <c:set var="node" value="${topLvl}" scope="request"/>
                                        <li> <c:import url="node.jsp"/></li>
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

<%-- Mapping an icon to its instance in Reactome --%>
<c:if test="${not empty entry.iconPhysicalEntities}">
    <fieldset class="fieldset-details">
        <legend>Entries for ${entry.name}</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <div class="wrap overflow">
                    <c:forEach var="iconPE" items="${entry.iconPhysicalEntities}">
                        <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-12 text-overflow">
                            <%-- index: 0=ST_ID, 1=Type, 2=Name, 3=Compartment --%>
                            <a href="${pageContext.request.contextPath}/detail/${iconPE.stId}" title="Open ${iconPE.stId}"><i class="sprite sprite-${iconPE.type}" title="${iconPE.type}"></i> ${iconPE.displayName}</a>
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