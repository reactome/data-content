<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="filter-wrapper">
    <form  action="./query" method="get">
        <input type="hidden" name="q" value="<c:out value='${q}'/>"/>
        <%-- SPECIES --%>
        <div class="facet" >
            <h4>Species</h4>
            <ul class="term-list">
                <c:forEach var="selected" items="${species_facet.selected}">
                    <li class="term-item">
                        <label><input type="checkbox" onclick="this.form.submit();" name="species" value="${selected.name}" checked> ${selected.name} (${selected.count})</label></li>
                </c:forEach>
                <c:forEach var="available" items="${species_facet.available}">
                    <li class="term-item">
                        <label>
                            <input type="checkbox" onclick="this.form.submit();" name="species" value="${available.name}"> ${available.name} (${available.count})
                        </label>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <%-- TYPES --%>
        <c:if test="${not empty type_facet.available || not empty type_facet.selected }">
            <div class="facet" >
                <h4>Types</h4>
                <ul class="term-list">
                    <c:forEach var="selected" items="${type_facet.selected}">
                        <li class="term-item">
                            <label>
                                <input type="checkbox" onclick="this.form.submit();" name="types" value="${selected.name}" checked> ${selected.name} (${selected.count})
                            </label>
                        </li>
                    </c:forEach>
                    <c:forEach var="available" items="${type_facet.available}">
                        <li class="term-item">
                            <label>
                                <input type="checkbox" onclick="this.form.submit();" name="types" value="${available.name}"> ${available.name} (${available.count})
                            </label>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <%-- COMPARTMENT --%>
        <c:if test="${not empty compartment_facet.available || not empty compartment_facet.selected }">
            <div class="facet">
                <h4>Compartments</h4>
                <ul class="term-list">
                    <c:forEach var="selected" items="${compartment_facet.selected}">
                        <li class="term-item">
                            <label>
                                <input type="checkbox" onclick="this.form.submit();" name="compartments" value="${selected.name}" checked> ${selected.name} (${selected.count})
                            </label>
                        </li>
                    </c:forEach>
                    <c:forEach var="available" items="${compartment_facet.available}">
                        <li class="term-item">
                            <label>
                                <input type="checkbox" onclick="this.form.submit();" name="compartments" value="${available.name}"> ${available.name} (${available.count})
                            </label>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <%-- REACTION TYPES --%>
        <c:if test="${not empty keyword_facet.available || not empty keyword_facet.selected }">
            <div class="facet">
                <h4>Reaction types</h4>
                <ul class="term-list">
                    <c:forEach var="selected" items="${keyword_facet.selected}">
                        <li class="term-item">
                            <label>
                                <input type="checkbox" onclick="this.form.submit();" name="keywords" value="${selected.name}" checked> ${selected.name} (${selected.count})
                            </label>
                        </li>
                    </c:forEach>
                    <c:forEach var="available" items="${keyword_facet.available}">
                        <li class="term-item">
                            <label>
                                <input type="checkbox" onclick="this.form.submit();" name="keywords" value="${available.name}"> ${available.name} (${available.count})
                            </label>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        <%-- CLUSTERED --%>
        <div class="facet">
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
</div> <%-- class="filter-wrapper"--%>
