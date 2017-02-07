<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fieldset class="fieldset-details">
    <legend>Locations in the PathwayBrowser

        <c:if test="${not empty param['interactor']}"> for interactor ${param['interactor']}</c:if>

        <c:if test="${fn:length(availableSpecies) gt 1}">
            <%--<div class="padding">--%>
            for Species:
                <select name="availableSpecies" id="availableSpeciesSel" class="speciesSelection" >
                    <c:forEach items="${availableSpecies}" var="species">
                        <option value="${fn:replace(species, ' ', '_')}" ${species == 'Homo_sapiens' ? 'selected' : ''}>${species}</option>
                    </c:forEach>
                </select>
            <%--</div>--%>
        </c:if>

    </legend>

<%--<h5 style="font-size: 17px; margin-left: 23px">Locations in the PathwayBrowser</h5>--%>
    <div style="text-align: right; padding: 0px 10px 0px 0px;float: right;">
        <a style="text-align:right; cursor: pointer;" id="pwb_toggle" class="expand">Expand all</a>
    </div>

    <div class="wrap">
        <c:forEach var="topLvl" items="${topLevelNodes}">
            <c:choose>
                <c:when test="${empty topLvl.children}">
                    <span style="font-size:13px"><i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"></i></span>
                    <a href="${topLvl.url}" <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if> title="goto Reactome Pathway Browser" rel="nofollow">${topLvl.name} (${topLvl.species})</a>
                </c:when>
                <c:otherwise>
                    <%--
                        The class attribute is used as a jQuery selector. This class is not present in the css.
                        Specially for chemical, it is present in all species, instead of showing a big list we just show Human as the default
                        and let the user select the desired species in a dropdown list.
                     --%>
                    <div id="tpla_${topLvl.stId}" class="tplSpe_${fn:replace(topLvl.species, ' ', '_')}" style="display: none">
                        <span class="plus tree-root" title="click here to expand or collapse the tree">
                            <i class="sprite-resize-small sprite sprite-plus" title="click here to expand or collapse the tree" style="vertical-align: middle"></i>
                            <i class="sprite-resize sprite sprite-Pathway" style="vertical-align: middle"></i>
                            <%--<a href="${topLvl.url}" class="" title="goto Reactome Pathway Browser" rel="nofollow">${topLvl.name} (${topLvl.species})</a>--%>
                            ${topLvl.name} (${topLvl.species})
                        </span>
                        <div class="treeContent">
                            <ul class="tree">
                                <c:set var="node" value="${topLvl}" scope="request"/>
                                <li> <c:import url="node.jsp"/></li>
                            </ul>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</fieldset>