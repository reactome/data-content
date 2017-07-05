<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/tags/customTag.tld"%>

<c:import url="../header-n.jsp"/>

<%--<div class="ebi-content">--%>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12" id="search-headers">
    <div>
        <h2>Search results for <span class="searchterm">${q}</span></h2>
        <p>Showing <strong>${groupedResult.rowCount}</strong>  of <strong>${groupedResult.numberOfMatches}</strong></p>
    </div>
</div>

<%-- VISIBLE ON MOBILE --%>
<div class="favth-visible-xs">
    <span onclick="openNav()">Filters...</span>
</div>
<div id="mySidenav" class="sidenav favth-visible-xs">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <div class="filter-wrapper">
        <form id="form_facets" action="./query" method="get">
            <input type="hidden" name="q" value="<c:out value='${q}'/>"/>
            <%-- SPECIES --%>
            <div class="facet" id="species">
                <h4>Species</h4>
                <ul class="term-list">
                    <c:forEach var="selected" items="${species_facet.selected}">
                        <li class="term-item">
                            <label><input type="checkbox" onclick="this.form.submit();" name="species" value="${selected.name}" checked></label> ${selected.name} (${selected.count})</li>
                    </c:forEach>
                    <c:forEach var="available" items="${species_facet.available}">
                        <li class="term-item"><label>
                            <input type="checkbox" onclick="this.form.submit();" name="species"
                                   value="${available.name}">
                        </label> ${available.name} (${available.count})</li>
                    </c:forEach>
                </ul>
            </div>

            <%-- TYPES --%>
            <c:if test="${not empty type_facet.available || not empty type_facet.selected }">
                <div class="facet" id="type">
                    <h4>Types</h4>
                    <ul class="term-list">
                        <c:forEach var="selected" items="${type_facet.selected}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="types"
                                       value="${selected.name}" checked>
                            </label> ${selected.name} (${selected.count})</li>
                        </c:forEach>
                        <c:forEach var="available" items="${type_facet.available}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="types"
                                       value="${available.name}">
                            </label> ${available.name} (${available.count})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <%-- COMPARTMENT --%>
            <c:if test="${not empty compartment_facet.available || not empty compartment_facet.selected }">
                <div class="facet" id="compartment">
                    <h4>Compartments</h4>
                    <ul class="term-list">
                        <c:forEach var="selected" items="${compartment_facet.selected}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="compartments"
                                       value="${selected.name}" checked>
                            </label> ${selected.name} (${selected.count})</li>
                        </c:forEach>
                        <c:forEach var="available" items="${compartment_facet.available}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="compartments"
                                       value="${available.name}">
                            </label> ${available.name} (${available.count})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <%-- REACTION TYPES --%>
            <c:if test="${not empty keyword_facet.available || not empty keyword_facet.selected }">
                <div class="facet" id="keywords">
                    <h4>Reaction types</h4>
                    <ul class="term-list">
                        <c:forEach var="selected" items="${keyword_facet.selected}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="keywords"
                                       value="${selected.name}" checked>
                            </label> ${selected.name} (${selected.count})</li>
                        </c:forEach>
                        <c:forEach var="available" items="${keyword_facet.available}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="keywords"
                                       value="${available.name}">
                            </label> ${available.name} (${available.count})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <%-- CLUSTERED --%>
            <div class="facet" id="cluster">
                <h4>Search properties</h4>
                <ul class="term-list">
                    <c:choose>
                        <c:when test="${cluster}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="cluster"
                                       value="true" checked></label> clustered Search</li>
                        </c:when>
                        <c:otherwise>
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="cluster"
                                       value="true" ></label> clustered Search</li>
                        </c:otherwise>
                    </c:choose>

                </ul>
            </div>
        </form>

        <form id="facetReset" action="./query" method="get">
            <div class="filterButtons">
                <input type="hidden" name="q" value="<c:out value='${q}'/>"/>
                <input type="hidden" name="species" value="Homo sapiens"/>
                <input type="hidden" name="species" value="Entries without species"/>
                <input type="hidden" name="cluster" value="true"/>
                <input type="submit" class="btn btn-info reset-filter" value="Reset filters"  />
            </div>
        </form>
    </div> <%-- id="filter-wrapper"--%>
</div>
<%-- VISIBLE ON MOBILE --%>





<%-- FILTERS --%>
<div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-12 favth-hidden-xs" id="search-filters">
    <div class="filter-wrapper">
        <form id="form_facets" action="./query" method="get">
            <input type="hidden" name="q" value="<c:out value='${q}'/>"/>
            <%-- SPECIES --%>
            <div class="facet" id="species">
                <h4>Species</h4>
                <ul class="term-list">
                    <c:forEach var="selected" items="${species_facet.selected}">
                        <li class="term-item">
                            <label><input type="checkbox" onclick="this.form.submit();"  name="species" value="${selected.name}" checked></label> ${selected.name} (${selected.count})</li>
                    </c:forEach>
                    <c:forEach var="available" items="${species_facet.available}">
                        <li class="term-item"><label>
                            <input type="checkbox" onclick="this.form.submit();" name="species"
                                   value="${available.name}">
                        </label> ${available.name} (${available.count})</li>
                    </c:forEach>
                </ul>
            </div>

            <%-- TYPES --%>
            <c:if test="${not empty type_facet.available || not empty type_facet.selected }">
                <div class="facet" id="type">
                    <h4>Types</h4>
                    <ul class="term-list">
                        <c:forEach var="selected" items="${type_facet.selected}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="types"
                                       value="${selected.name}" checked>
                            </label> ${selected.name} (${selected.count})</li>
                        </c:forEach>
                        <c:forEach var="available" items="${type_facet.available}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="types"
                                       value="${available.name}">
                            </label> ${available.name} (${available.count})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <%-- COMPARTMENT --%>
            <c:if test="${not empty compartment_facet.available || not empty compartment_facet.selected }">
                <div class="facet" id="compartment">
                    <h4>Compartments</h4>
                    <ul class="term-list">
                        <c:forEach var="selected" items="${compartment_facet.selected}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="compartments"
                                       value="${selected.name}" checked>
                            </label> ${selected.name} (${selected.count})</li>
                        </c:forEach>
                        <c:forEach var="available" items="${compartment_facet.available}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="compartments"
                                       value="${available.name}">
                            </label> ${available.name} (${available.count})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <%-- REACTION TYPES --%>
            <c:if test="${not empty keyword_facet.available || not empty keyword_facet.selected }">
                <div class="facet" id="keywords">
                    <h4>Reaction types</h4>
                    <ul class="term-list">
                        <c:forEach var="selected" items="${keyword_facet.selected}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="keywords"
                                       value="${selected.name}" checked>
                            </label> ${selected.name} (${selected.count})</li>
                        </c:forEach>
                        <c:forEach var="available" items="${keyword_facet.available}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="keywords"
                                       value="${available.name}">
                            </label> ${available.name} (${available.count})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <%-- CLUSTERED --%>
            <div class="facet" id="cluster">
                <h4>Search properties</h4>
                <ul class="term-list">
                    <c:choose>
                        <c:when test="${cluster}">
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="cluster"
                                       value="true" checked></label> clustered Search</li>
                        </c:when>
                        <c:otherwise>
                            <li class="term-item"><label>
                                <input type="checkbox" onclick="this.form.submit();" name="cluster"
                                       value="true" ></label> clustered Search</li>
                        </c:otherwise>
                    </c:choose>

                </ul>
            </div>
        </form>

        <form id="facetReset" action="./query" method="get">
            <div class="filterButtons">
                <input type="hidden" name="q" value="<c:out value='${q}'/>"/>
                <input type="hidden" name="species" value="Homo sapiens"/>
                <input type="hidden" name="species" value="Entries without species"/>
                <input type="hidden" name="cluster" value="true"/>
                <input type="submit" class="btn btn-info reset-filter" value="Reset filters"  />
            </div>
        </form>
    </div> <%-- id="filter-wrapper"--%>
</div> <%-- id="favth-col-*"--%>


<div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-9 favth-col-xs-12" id="search-results">
    <c:choose>
        <c:when test="${not empty groupedResult.results}">
            <div class="favth-rows groupedResult favth-clearfix">
                <c:forEach var="result" items="${groupedResult.results}">
                    <div class="result-category">
                        <div class="favth-rows">
                            <c:url var="url" value="">
                                <c:param name="q" value="${q}"/>
                            </c:url>
                            <c:choose>
                                <c:when test="${cluster}">
                                    <h3><a href="./query${url}<mytag:linkEscape name="species" value="${species}"/>&amp;types=${result.typeName}<mytag:linkEscape name="compartments" value="${compartments}"/><mytag:linkEscape name="keywords" value="${keywords}"/>&amp;cluster=${cluster}" title="show all ${result.typeName}" rel="nofollow">${result.typeName}</a> <span>(${result.rowCount} results from a total of ${result.entriesCount})</span></h3>
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
                                                    <a href="./detail/interactor/${entry.id}" class="" title="Show Interactor Details" rel="nofollow">${entry.name}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <%--<a href="./detail/${entry.id}" class="" title="Show Details" rel="nofollow">${entry.name}</a>--%>
                                                    <%--<c:choose>--%>
                                                    <%--<c:when test="${entry.species == 'Entries without species'}" >--%>
                                                        <%--<a href="./detail/${entry.id}" class="" title="Show Details" rel="nofollow">${entry.name}</a>--%>
                                                    <%--</c:when>--%>
                                                    <%--<c:otherwise>--%>
                                                        <%--<a href="./detail/${entry.id}" class="" title="Show Details" rel="nofollow">${entry.name}</a>--%>
                                                    <%--</c:otherwise>--%>
                                                    <%--</c:choose>--%>



                                                    <a href="./detail/${entry.id}" class="" title="Show Details" rel="nofollow">${entry.name}</a>

                                                </c:otherwise>
                                        </c:choose>
                                    </h4>
                                </div>

                                <%-- Preparing comparment and species list --%>
                                <c:if test="${not empty entry.species && entry.species[0] != 'Entries without species'}">
                                    <c:forEach var="species" items="${entry.species}" varStatus="loop">
                                        <c:set var="speciesList" value="${loop.first ? '' : speciesList.concat(',')} ${species}" />
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty entry.compartmentNames}">
                                    <c:forEach var="compartment" items="${entry.compartmentNames}" varStatus="loop">
                                        <c:set var="compartmentList" value="${loop.first ? '' : compartmentList.concat(',')} ${compartment}" />
                                    </c:forEach>
                                </c:if>

                                <div class="result-detail">
                                    <%--<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">--%>
                                        <c:if test="${not empty speciesList || not empty compartmentList}">
                                            <c:if test="${not empty speciesList}">
                                                <div class="favth-col-lg-5 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Species:</strong> ${speciesList}</div>
                                            </c:if>
                                            <c:if test="${not empty compartmentList}">
                                                <div class="favth-col-lg-7 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Compartment:</strong> ${compartmentList}</div>
                                            </c:if>
                                        </c:if>

                                        <c:if test="${not empty entry.regulator}">
                                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Regulator:</strong> <a href="./detail/${entry.regulatorId}" class="" title="Show Details" rel="nofollow">${entry.regulator}</a></div>
                                        </c:if>
                                        <c:if test="${not empty entry.regulatedEntity}">
                                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Regulated entity:</strong> <a href="./detail/${entry.regulatedEntityId}" class="" title="Show Details" rel="nofollow">${entry.regulatedEntity}</a></div>
                                        </c:if>
                                        <c:if test="${not empty entry.referenceIdentifier}">
                                            <%--<span>Primary external reference: ${entry.databaseName} <a href="${entry.referenceURL}" class="" title="show: ${entry.databaseName}" rel="nofollow">${entry.referenceName}: ${entry.referenceIdentifier}</a></span>--%>
                                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12"><strong>Primary external reference:</strong> ${entry.databaseName} <a href="${entry.referenceURL}" rel="nofollow" target="_blank">${entry.referenceName}: ${entry.referenceIdentifier}</a></div>
                                        </c:if>
                                        <c:if test="${not empty entry.summation}">
                                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 summation">${entry.summation} </div>
                                        </c:if>
                                    <%--</div>--%>
                                </div>
                            </div> <%-- result --%>
                        </c:forEach>
                    </div>
                </c:forEach>
            </div>
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
        </c:when>
        <c:otherwise>
            <p class="alert">Sorry we could not find any entry matching "${q}" with the currently selected filters</p>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="../footer-n.jsp"/>