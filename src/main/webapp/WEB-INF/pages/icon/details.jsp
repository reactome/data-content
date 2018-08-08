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
    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-12 text-center">
        <img class="icon-preview" src="/ehld-icons/lib/${entry.iconGroup}/${fn:escapeXml(entry.iconName)}.svg" alt="Icon ${entry.name}" />
    </div>
    <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
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

<c:if test="${not empty topLevelNodes}">
    <div class="clearfix">
        <fieldset class="fieldset-details">
            <legend>Locations in the PathwayBrowser</legend>

            <%--<c:if test="${not empty topLevelNodes}">--%>
                <%--<c:if test="${ (not empty topLevelNodes) && (not empty topLevelNodes.iterator().iterator().next().children)}">--%>
                    <%--<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 favth-text-right">--%>
                        <%--<a id="pwb_toggle" class="expand-all">Expand all</a>--%>
                    <%--</div>--%>
                <%--</c:if>--%>
            <%--</c:if>--%>

            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <c:forEach var="ehldPWB" items="${topLevelNodes}">
                    <c:forEach var="topLvl" items="${ehldPWB}">
                        <c:choose>
                            <c:when test="${empty topLvl.children}">
                                <span style="font-size:13px; padding-left: 20px;"><i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"></i></span>
                                <a href="${topLvl.url}" <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if> title="goto Reactome Pathway Browser" >${topLvl.name} (${topLvl.species})</a>
                            </c:when>
                            <c:otherwise>
                                <%--
                                    The class attribute is used as a jQuery selector. This class is not present in the css.
                                    Specially for chemical, it is present in all species, instead of showing a big list we just show Human as the default
                                    and let the user select the desired species in a dropdown list.
                                 --%>
                                <div>
                                    <span class="pljus tree-root" title="click here to expand or collapse the tree">
                                        <i class="fa fa-minus-square-o" title="click here to expand or collapse the tree" style="vertical-align: middle"></i>
                                        <i class="sprite-resize sprite sprite-Pathway" style="vertical-align: middle"></i>${topLvl.name} (${topLvl.stId})
                                    </span>
                                    <div>
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



<c:if test="${not empty entry.iconEhlds}">
    <fieldset class="fieldset-details">
        <legend>Pathways containing this icon</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="ehld" items="${entry.iconEhlds}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                            <a href="../${ehld}">${ehld}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty entry.iconCVTerms}">
    <fieldset class="fieldset-details">
        <legend>CV Terms</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="term" items="${entry.iconCVTerms}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                            <a href="">${term}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty entry.iconXRefs}">
    <fieldset class="fieldset-details">
        <legend>Cross References</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="xref" items="${entry.iconXRefs}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                            <a href="">${xref}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<%--<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">--%>
    <%--<c:import url="disclaimer.jsp"/>--%>
<%--</div>--%>

<c:import url="../footer.jsp"/>