<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="clearfix">
    <fieldset class="fieldset-details">
        <legend>Locations in the PathwayBrowser
            <c:if test="${not empty param['interactor']}"> for interactor ${param['interactor']}</c:if>

            <c:if test="${fn:length(availableSpecies) gt 1 && !isMobile}">
                <div style="display:inline;">
                    for Species:
                        <select name="availableSpecies" id="availableSpeciesSelLg" class="speciesSelection" >
                            <c:forEach items="${availableSpecies}" var="species">
                                <option value="${fn:replace(species, ' ', '_')}" ${species == 'Homo_sapiens' ? 'selected' : ''}>${species}</option>
                            </c:forEach>
                        </select>
                </div>
            </c:if>

        </legend>

        <c:if test="${not empty topLevelNodes}">
            <c:if test="${ (not empty topLevelNodes) && (not empty topLevelNodes.iterator().next().children)}">
                <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 favth-text-right">
                    <a id="pwb_toggle" class="expand-all">Expand all</a>
                </div>
            </c:if>
        </c:if>

        <c:if test="${fn:length(availableSpecies) gt 1  && isMobile}">
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <div class="species-selector">
                    Species:
                    <select name="availableSpecies" id="availableSpeciesSelSm" class="speciesSelection" >
                        <c:forEach items="${availableSpecies}" var="species">
                            <option value="${fn:replace(species, ' ', '_')}" ${species == 'Homo_sapiens' ? 'selected' : ''}>${species}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </c:if>

        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
            <c:forEach var="topLvl" items="${topLevelNodes}">
                <c:choose>
                    <c:when test="${empty topLvl.children}">
                        <span style="font-size:13px"><i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"></i></span>
                        <a href="${topLvl.url}" <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if> title="goto Reactome Pathway Browser" >${topLvl.name} (${topLvl.species})</a>
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
                                <%--<a href="${topLvl.url}" class="" title="goto Reactome Pathway Browser" >${topLvl.name} (${topLvl.species})</a>--%>
                                ${topLvl.name} (${topLvl.species})
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
        </div>
    </fieldset>
</div>