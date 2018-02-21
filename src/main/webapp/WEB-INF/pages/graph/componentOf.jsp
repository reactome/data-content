<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${not empty componentOf}">

    <%-- TODO: Separate them into complex, entity set, etc --%>
    <fieldset class="fieldset-details">
        <legend>Participant Of</legend>
        <c:forEach var="component" items="${componentOf}">
            <div class="fieldset-pair-container">
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        ${component.type}
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="names" items="${component.names}" varStatus="loop">
                                    <li>
                                        <i class="sprite sprite-resize sprite-${component.schemaClasses.get(loop.index)} sprite-position" title="${component.schemaClasses.get(loop.index)}"></i>
                                        <c:if test="${not empty component.stIds}"><a href="../detail/${component.stIds.get(loop.index)}" class="" title="Show Details" >${names}</a></c:if>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </fieldset>

</c:if>