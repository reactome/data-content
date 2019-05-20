<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="../header.jsp"/>
<div class="favth-col-xs-12">
    <h2>No details found for ${term}</h2>
    <div class="alert alert-danger">
        Sorry we could not find any entry matching '${term}'
    </div>
</div>
<c:import url="../footer.jsp"/>