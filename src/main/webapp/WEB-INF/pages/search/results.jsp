<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/tags/customTag.tld"%>

<c:import url="../header.jsp"/>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12" id="search-headers">
    <div>
        <h2>Search results for <span class="searchterm">${q}</span></h2>
        <p class="favth-hidden-xs favth-hidden-sm">Showing <strong>${groupedResult.rowCount}</strong> results out of <strong>${groupedResult.numberOfMatches}</strong></p>
    </div>
</div>

<%-- MAX-WIDTH 768px --%>
<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 favth-visible-xs favth-visible-sm">
    <div style="margin-top: 10px;">
        <a><i class="fa fa-filter"></i><span onclick="openSideNav()">Filter your results (<strong>${groupedResult.rowCount}</strong>  of <strong>${groupedResult.numberOfMatches}</strong>)</span></a>
    </div>
</div>
<div id="search-filter-sidenav" class="sidenav favth-visible-xs favth-visible-sm">
    <div class="sidenav-panel">
        <a href="javascript:void(0);" class="closebtn" onclick="closeSideNav();">&times;</a>
        <c:import url="searchFilter.jsp" />
    </div>
    <c:import url="resetFilter.jsp" />
</div>
<%-- VISIBLE ON MOBILE --%>

<%-- FILTERS --%>
<div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 favth-hidden-xs favth-hidden-sm" id="search-filters">
    <c:import url="searchFilter.jsp" />
    <c:import url="resetFilter.jsp" />
</div>

<div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-12 favth-col-xs-12" id="search-results">
    <c:choose>
        <c:when test="${not empty groupedResult.results}">
            <div class="favth-rows groupedResult favth-clearfix">
                <c:forEach var="result" items="${groupedResult.results}">
                    <div class="result-category">
                        <div class="favth-rows">
                            <input type="hidden" id="js_search-term" name="js_search-term" value="${q}" />
                            <c:url var="url" value="">
                                <c:param name="q" value="${q}"/>
                            </c:url>
                            <c:choose>
                                <c:when test="${cluster}">
                                    <h3><a href="./query${url}<mytag:linkEscape name="species" value="${species}"/>&amp;types=${result.typeName}<mytag:linkEscape name="compartments" value="${compartments}"/><mytag:linkEscape name="keywords" value="${keywords}"/>&amp;cluster=${cluster}" title="show all ${result.typeName}" >${result.typeName}</a> <span>(${result.rowCount} results from a total of ${result.entriesCount})</span></h3>
                                </c:when>
                                <c:otherwise>
                                    <h3>${result.typeName} <span>(${result.rowCount} results from a total of ${result.entriesCount})</span></h3>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:forEach var="entry" items="${result.entries}">
                            <div class="favth-rows result clearfix">
                                <div class="result-title">
                                    <h4 class="title">
                                        <i class="sprite-resize sprite sprite-${entry.exactType}" title="${entry.exactType}"></i>
                                        <c:if test="${entry.isDisease}">
                                            <i class="sprite-resize sprite sprite-isDisease" title="Disease related entry"></i>
                                        </c:if>

                                        <c:choose>
                                            <c:when test="${entry.exactType == 'Interactor'}" >
                                                <a href="./detail/interactor/${entry.id}" class="" title="Show Interactor Details" >${entry.name}</a>
                                            </c:when>
                                            <c:when test="${entry.exactType == 'Person'}" >
                                                <c:choose>
                                                    <c:when test="${not empty entry.orcidId}">
                                                        <a href="./detail/person/${entry.orcidId}" class="" title="Show Person Details" >${entry.name}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="./detail/person/${entry.id}" class="" title="Show Person Details" >${entry.name}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${entry.exactType == 'Icon'}" >
                                                <a href="./detail/icon/${entry.iconName}" class="" title="Show Icon Details" >${entry.name}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="./detail/${entry.id}" class="" title="Show Details" >${entry.name}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </h4>
                                </div>

                                <div class="result-detail">
                                    <c:if test="${not empty entry.stId}">
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <div>
                                                <strong>Identifier: </strong>${entry.stId}
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty entry.species && entry.species[0] != 'Entries without species'}">
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <div>
                                                <strong>Species: </strong>
                                                <c:forEach var="species" items="${entry.species}" varStatus="loop">
                                                    ${species}<c:if test="${!loop.last}">,</c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty entry.compartmentNames}">
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <div>
                                                <strong>Compartment: </strong>
                                                <c:forEach var="compartment" items="${entry.compartmentNames}" varStatus="loop">
                                                    ${compartment}<c:if test="${!loop.last}">,</c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty entry.referenceIdentifier}">
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Primary external reference:</strong> ${entry.databaseName}: <a href="${entry.referenceURL}"  target="_blank"><c:if test="${not empty entry.referenceName}">${entry.referenceName}: </c:if>${entry.referenceIdentifier}</a></div>
                                    </c:if>

                                    <%-- REGULATION --%>
                                    <c:if test="${not empty entry.regulator}">
                                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Regulator:</strong> <a href="./detail/${entry.regulatorId}" class="" title="Show Details" >${entry.regulator}</a></div>
                                    </c:if>
                                    <c:if test="${not empty entry.regulatedEntity}">
                                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Regulated entity:</strong> <a href="./detail/${entry.regulatedEntityId}" class="" title="Show Details" >${entry.regulatedEntity}</a></div>
                                    </c:if>

                                    <%-- PERSON --%>
                                    <c:if test="${entry.exactType == 'Person'}">
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <strong>Authored Pathways:</strong> <c:choose><c:when test="${not empty entry.authoredPathways}">${entry.authoredPathways}</c:when><c:otherwise>0</c:otherwise></c:choose>
                                        </div>
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <strong>Reviewed Pathways:</strong> <c:choose><c:when test="${not empty entry.reviewedPathways}">${entry.reviewedPathways}</c:when><c:otherwise>0</c:otherwise></c:choose>
                                        </div>
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <strong>Authored Reactions:</strong> <c:choose><c:when test="${not empty entry.authoredReactions}">${entry.authoredReactions}</c:when><c:otherwise>0</c:otherwise></c:choose>
                                        </div>
                                        <div class="favth-col-lg-6 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                            <strong>Reviewed Reactions:</strong> <c:choose><c:when test="${not empty entry.reviewedReactions}">${entry.reviewedReactions}</c:when><c:otherwise>0</c:otherwise></c:choose>
                                        </div>
                                        <c:if test="${not empty entry.orcidId}">
                                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>OrcidID:</strong> <a href="https://orcid.org/${entry.orcidId}" rel="nofollow noindex" target="_blank">${entry.orcidId}</a></div>
                                        </c:if>
                                    </c:if>

                                    <%-- ICON --%>
                                    <c:if test="${entry.exactType == 'Icon'}">
                                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
                                            <div class="favth-col-lg-8 favth-col-md-8 favth-col-sm-8 favth-col-xs-8 padding0">
                                                <c:if test="${not empty entry.iconCuratorName}">
                                                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                                        <strong>Curator:</strong> ${entry.iconCuratorName}
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty entry.iconDesignerName}">
                                                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                                                        <strong>Designer:</strong>
                                                        <a href="${entry.iconDesignerUrl}" class="">${entry.iconDesignerName}</a>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="favth-col-lg-4 favth-col-md-4 favth-col-sm-4 favth-col-xs-4">
                                                <img src="/ehld-icons/lib/${entry.iconGroup}/${entry.iconName}.svg" alt="${entry.iconName}" style="width: 50px; height: 50px;"/>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty entry.summation}">
                                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 summation">${entry.summation}</div>
                                    </c:if>
                                </div>
                            </div> <%-- result --%>
                        </c:forEach>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${maxpage>1}">
            <div id="pagination" class="pagination">
                <ul class="pagination-list">
                <c:choose>
                    <c:when test="${maxpage>1}">
                        <c:choose>
                            <c:when test="${1 == page}">
                                <li class="active"><a>first</a></li>
                            </c:when>
                            <c:otherwise>
                                <c:url var="url" value="">
                                    <c:param name="q" value="${q}"/>
                                </c:url>
                                <li><a class="pagenav" href="./query${url}<mytag:linkEscape name="species" value="${species}"/><mytag:linkEscape name="types" value="${types}"/><mytag:linkEscape name="compartments" value="${compartments}"/><mytag:linkEscape name="keywords" value="${keywords}"/>&amp;cluster=${cluster}&amp;page=1">first</a></li>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="val" begin="2" end="${maxpage - 1}" >
                            <c:if test="${val > page-3 && val < page+3}">
                                <c:choose>
                                    <c:when test="${val == page}">
                                        <li class="active"><a>${val}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:url var="url" value="">
                                            <c:param name="q" value="${q}"/>
                                        </c:url>
                                        <li>
                                            <a class="pagenav" href="./query${url}<mytag:linkEscape name="species" value="${species}"/><mytag:linkEscape name="types" value="${types}"/><mytag:linkEscape name="compartments" value="${compartments}"/><mytag:linkEscape name="keywords" value="${keywords}"/>&amp;cluster=${cluster}&amp;page=${val}">${val}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${maxpage == page}">
                                <li class="active"><a>last</a></li>
                            </c:when>
                            <c:otherwise>
                                <c:url var="url" value="">
                                    <c:param name="q" value="${q}"/>
                                </c:url>
                                <li>
                                    <a class="pagenav" href="./query${url}<mytag:linkEscape name="species" value="${species}"/><mytag:linkEscape name="types" value="${types}"/><mytag:linkEscape name="compartments" value="${compartments}"/><mytag:linkEscape name="keywords" value="${keywords}"/>&amp;cluster=${cluster}&amp;page=${maxpage}">last</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                </c:choose>
                </ul>
            </div>
            </c:if>
        </c:when>
        <c:otherwise>
            <p class="alert">Sorry we could not find any entry matching "${q}" with the currently selected filters</p>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="../footer.jsp"/>