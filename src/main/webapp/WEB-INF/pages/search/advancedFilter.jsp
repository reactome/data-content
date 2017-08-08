<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="favth-col-lg-3 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 clearfix">
    <div>
        <h4>Species</h4>
        <ul class="adv-list">
            <c:forEach var="available" items="${species_facet.available}">
                <li class="term-item">
                    <label>
                        <input type="checkbox" name="species" value="${available.name}"> ${available.name} (${available.count})
                    </label>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<div class="favth-col-lg-3 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 clearfix">
    <div>
        <h4>Types</h4>
        <ul class="adv-list">
            <c:forEach var="available" items="${type_facet.available}">
                <li class="term-item">
                    <label>
                        <input type="checkbox" name="types" value="${available.name}"> ${available.name} (${available.count})
                    </label>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<div class="favth-col-lg-3 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 clearfix">
    <div>
        <h4>Compartments</h4>
        <ul class="adv-list">
            <c:forEach var="available" items="${compartment_facet.available}">
                <li class="term-item">
                    <label>
                        <input type="checkbox" name="compartments" value="${available.name}"> ${available.name} (${available.count})
                    </label>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<div class="favth-col-lg-3 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 clearfix">
    <div>
        <h4>Reaction types</h4>
        <ul class="adv-list">
            <c:forEach var="available" items="${keyword_facet.available}">
                <li class="term-item">
                    <label>
                        <input type="checkbox" name="keywords" value="${available.name}"> ${available.name} (${available.count})
                    </label>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>