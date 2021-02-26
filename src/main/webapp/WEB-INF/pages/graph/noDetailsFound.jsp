<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="../header.jsp"/>
<div class="favth-col-xs-12">
    <h2>No details found for ${term}</h2>
    <div class="alert alert-danger">
        Sorry we could not find any entry matching '${term}'

        <c:if test="${ not empty notFoundClassName}">
            , Check Class ${notFoundClassName} exists or not.
        </c:if>
    </div>

</div>
<c:import url="../footer.jsp"/>