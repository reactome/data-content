<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/sortTag.tld" prefix="do"%>


<c:choose>
    <c:when test="${not empty widget}">
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
    </c:when>
    <c:otherwise>
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
    </c:otherwise>
</c:choose>
<div class="favth-col-xs-12">
    <h3 class="details-title">
        <i class="fa fa-puzzle-piece title-icon" title="${entry.exactType}"></i> ${entry.iconName}
    </h3>

    <div class="extended-header favth-clearfix">
        <c:if test="${not empty entry.iconCategories}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Categories</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:forEach var="category" items="${categories}" varStatus="loop">
                    <c:set var="categoryLink"
                           value="${fn:replace(category, ' ', '_')}"/> <%-- replace spaces so the url doens't need to be encoded --%>
                    <span><a href="/icon-lib/${fn:toLowerCase(categoryLink)}"
                             title="Go to ${category}" <c:if
                            test="${not empty widget}"> target="_blank" </c:if>>${category}
                    </a>
                                <c:if test="${not loop.last}">, </c:if></span>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${not empty entry.iconCuratorName}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Curator</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:choose>
                    <c:when test="${not empty entry.iconCuratorOrcidId}">
                                <span><a
                                        href="https://orcid.org/${entry.iconCuratorOrcidId}" target="_blank">${entry.iconCuratorName}</a></span>
                    </c:when>
                    <c:otherwise>
                        <span><a href="${entry.iconCuratorUrl}" target="_blank">${entry.iconCuratorName}</a></span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${not empty entry.iconDesignerName}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Designer</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:choose>
                    <c:when test="${not empty entry.iconDesignerOrcidId}">
                                <span><a
                                        href="https://orcid.org/${entry.iconDesignerOrcidId}" target="_blank">${entry.iconDesignerName}</a></span>
                    </c:when>
                    <c:otherwise>
                        <span><a href="${entry.iconDesignerUrl}" target="_blank">${entry.iconDesignerName}</a></span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${not empty entry.summation}">
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
        <div class="text-center margin0 top" id="icon-preview-container">
            <img class="icon-preview ${do:join(entry.iconCategories, " ")}" src="/icon/${entry.stId}.svg" alt="Icon ${entry.iconName}"/>
            <div class="favth-col-sm-2 favth-col-xs-12 margin0 align-middle top">
                <div class="favth-col-sm-12 favth-col-xs-4 padding0 bottom">
                        <span><a href="/icon/${entry.stId}.svg" download="${entry.stId}.svg"
                                 title="Click to download the icon in SVG format"><i class="fa fa-download"></i> SVG</a></span>
                </div>
                <div class="favth-col-sm-12 favth-col-xs-4 padding0 bottom">
                        <span><a href="/icon/${entry.stId}.png" download="${entry.stId}.png"
                                 title="Click to download the icon in PNG format"><i class="fa fa-download"></i> PNG</a></span>
                </div>
                <div class="favth-col-sm-12 favth-col-xs-4 padding0 bottom">
                        <span><a href="/icon/${entry.stId}.emf" download="${entry.stId}.emf"
                                 title="Click to download the icon in EMF format"><i class="fa fa-download"></i> EMF</a></span>
                </div>
            </div>
        </div>
    </fieldset>

    <c:if test="${not empty pwbTree && fn:length(pwbTree[0]) > 0 && not fn:containsIgnoreCase(entry.iconCategories, 'arrow')}">
        <div class="clearfix">
            <fieldset class="fieldset-details">
                <legend>Locations in the PathwayBrowser</legend>
                <c:if test="${not empty pwbTree}">
                    <c:set var="suggestExpandAll" scope="request" value="false"/>
                    <c:forEach items="${pwbTree}" var="ehldPWB">
                        <c:forEach var="topLvl" items="${ehldPWB}">
                            <c:if test="${not suggestExpandAll && not empty topLvl.children}">
                                <c:set var="suggestExpandAll" scope="request" value="true"/>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                    <c:if test="${suggestExpandAll}">
                        <div class="favth-col-xs-12 favth-text-right">
                            <a id="pwb_toggle" class="expand-all">Expand all</a>
                        </div>
                    </c:if>
                </c:if>

                <div class="favth-col-xs-12">
                    <c:forEach var="ehldPWB" items="${pwbTree}">
                        <c:forEach var="topLvl" items="${ehldPWB}">
                            <c:choose>
                                <c:when test="${empty topLvl.children}">
                                    <div id="tpla_${topLvl.stId}" class="tplSpe_">
                                        <span class="tree-root tree-root-overflow"
                                              title="click here to expand or collapse the tree">
                                            <i class="fa fa-square-o" style="vertical-align: middle"></i>
                                            <i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"
                                               style="vertical-align: middle"></i>
                                            <a href="${topLvl.url}"
                                               <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if>
                                               title="goto Reactome Pathway Browser" <c:if
                                                    test="${not empty widget}"> target="_blank" </c:if> >${topLvl.name} (${topLvl.stId})</a>
                                        </span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <%--
                                        The class attribute is used as a jQuery selector. This class is not present in the css.
                                        Specially for chemical, it is present in all species, instead of showing a big list we just show Human as the default
                                        and let the user select the desired species in a dropdown list.
                                     --%>
                                    <div id="tpla_${topLvl.stId}" class="tplSpe_" style="display: none">
                                    <span class="plus tree-root" title="click here to expand or collapse the tree">
                                        <i class="fa fa-plus-square-o" title="click here to expand or collapse the tree"
                                           style="vertical-align: middle"></i>
                                        <i class="sprite-resize sprite sprite-Pathway"
                                           style="vertical-align: middle"></i>
                                        <a href="${topLvl.url}"
                                           <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if>
                                           title="goto Reactome Pathway Browser" <c:if
                                                test="${not empty widget}"> target="_blank" </c:if> >${topLvl.name} (${topLvl.stId})</a>
                                    </span>
                                        <div class="tree-lpwb">
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

    <%-- Mapping an icon to its instance in Reactome --%>
    <c:if test="${not empty entry.iconPhysicalEntities}">
        <fieldset class="fieldset-details">
            <legend>Entries for ${entry.name}</legend>
            <div class="fieldset-pair-container">
                <div class="favth-col-xs-12">
                    <div class="wrap overflow">
                        <c:forEach var="iconPE" items="${entry.iconPhysicalEntities}">
                            <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-12 text-overflow">
                                    <%-- index: 0=ST_ID, 1=Type, 2=Name, 3=Compartment --%>
                                <a href="${detailRequestPrefix}${iconPE.stId}" title="Open ${iconPE.stId}"><i
                                        class="sprite sprite-${iconPE.type}" title="${iconPE.type}"
                                        style="vertical-align: middle; height: 18px;"></i> ${iconPE.displayName}
                                </a>
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
                                        <c:set var="accessUrl" value="${urlMapping[entry.key.toUpperCase()]}"/>
                                        <c:choose>
                                            <c:when test="${not empty accessUrl}">
                                                <a href="${fn:replace(accessUrl, '###ID###', value)}"
                                                   target="_blank"
                                                   title="show ${entry.key}:${value}">${value}</a><c:if
                                                    test="${!loop.last}">, </c:if>
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

</div>

