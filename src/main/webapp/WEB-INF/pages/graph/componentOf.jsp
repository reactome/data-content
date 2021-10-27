<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/modelTags.tld" prefix="m" %>

<c:if test="${not empty componentOf}">

    <c:choose>
        <c:when test="${not empty widget}">
            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
        </c:when>
        <c:otherwise>
            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
        </c:otherwise>
    </c:choose>

    <%-- TODO: Separate them into complex, entity set, etc --%>
    <fieldset class="fieldset-details">
        <legend>Participates</legend>
        <c:forEach var="component" items="${componentOf}">
            <div class="fieldset-pair-container">
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        <m:participant-of-type type="${component.type}"/>
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="name" items="${component.names}" varStatus="loop">
                                    <li>
                                        <i class="sprite sprite-resize sprite-${component.schemaClasses.get(loop.index)} sprite-position"
                                           title="${component.schemaClasses.get(loop.index)}"></i>
                                        <c:if test="${not empty component.stIds.get(loop.index)}">
                                            <a href="${detailRequestPrefix}${component.stIds.get(loop.index)}"
                                               title="Show Details"
                                            >${name}
                                                <c:if test="${not empty component.species.get(loop.index)}"
                                                > (${component.species.get(loop.index)})
                                                </c:if>
                                            </a>
                                        </c:if>
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