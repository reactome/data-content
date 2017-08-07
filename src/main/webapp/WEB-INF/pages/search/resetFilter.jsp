<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form  action="./query" method="get">
    <div class="filterButtons favth-text-center">
        <input type="hidden" name="q" value="<c:out value='${q}'/>"/>
        <input type="hidden" name="species" value="Homo sapiens"/>
        <input type="hidden" name="species" value="Entries without species"/>
        <input type="hidden" name="cluster" value="true"/>
        <input type="submit" class="btn btn-info reset-filter" value="Reset filters"  />
    </div>
</form>