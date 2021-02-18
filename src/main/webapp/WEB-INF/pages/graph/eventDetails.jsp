<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tags/modelTags.tld" prefix="m" %>
<c:choose>
    <c:when test="${not empty widget}">
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
    </c:when>
    <c:otherwise>
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
    </c:otherwise>
</c:choose>

<fieldset class="fieldset-details">
    <legend>Participants</legend>
    <c:if test="${databaseObject.schemaClass == 'Pathway' || databaseObject.schemaClass == 'TopLevelPathway'}">
        <c:if test="${not empty databaseObject.hasEvent}">

            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                    Events
                </div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <div>
                        <ul class="list">
                            <c:forEach var="hasEvent" items="${databaseObject.hasEvent}">
                                <li>
                                    <m:link object="${hasEvent}" detailRequestPrefix="${detailRequestPrefix}"/>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
    </c:if>

    <c:if test="${isReactionLikeEvent}">

        <c:if test="${not empty databaseObject.input || not empty databaseObject.output || not empty databaseObject.entityOnOtherCell}">
            <c:if test="${not empty databaseObject.input}">
                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        Input
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="input" items="${databaseObject.fetchInput()}">
                                    <li>
                                        <m:link object="${input.object}" detailRequestPrefix="${detailRequestPrefix}" amount="${input.stoichiometry}"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty databaseObject.output}">
                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        Output
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="output" items="${databaseObject.fetchOutput()}">
                                    <li>
                                        <m:link object="${output.object}" detailRequestPrefix="${detailRequestPrefix}" amount="${output.stoichiometry}"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty databaseObject.entityOnOtherCell}">
                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                            Entity On Other Cell
                        </div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div>
                                <ul class="list">
                                    <c:forEach var="entityOnOtherCell" items="${databaseObject.entityOnOtherCell}">
                                        <li>
                                            <m:link object="${entityOnOtherCell}" detailRequestPrefix="${detailRequestPrefix}"/>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

    </c:if>

</fieldset>

<c:import url="componentOf.jsp"/>

<c:if test="${not empty databaseObject.goBiologicalProcess || (databaseObject.schemaClass == 'Reaction' && not empty databaseObject.reverseReaction)}">
    <fieldset class="fieldset-details">
        <legend>Event Information</legend>
        <div class="fieldset-pair-container">
            <c:if test="${not empty databaseObject.goBiologicalProcess}">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                    Go Biological Process
                </div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <span><a href="${databaseObject.goBiologicalProcess.url}" class=""
                             title="go to ${databaseObject.goBiologicalProcess.databaseName}">${databaseObject.goBiologicalProcess.displayName} (${databaseObject.goBiologicalProcess.accession})</a></span>
                </div>
            </c:if>
            <c:if test="${databaseObject.schemaClass == 'Reaction'}">
                <c:if test="${not empty databaseObject.reverseReaction}">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        Reverse Reaction
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <span><a href="${detailRequestPrefix}${databaseObject.reverseReaction.stId}" class=""
                                 title="Show Details"
                        >${databaseObject.reverseReaction.displayName} <c:if
                                test="${not empty databaseObject.reverseReaction.speciesName}">(${databaseObject.reverseReaction.speciesName})</c:if></a></span>
                    </div>
                </c:if>
            </c:if>
        </div>
    </fieldset>
</c:if>

<c:if test="${isReactionLikeEvent && not empty databaseObject.catalystActivity}">
    <fieldset class="fieldset-details">
        <legend>Catalyst Activity</legend>
        <div class="fieldset-pair-container">
            <div class="favth-clearfix">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Catalyst
                    Activity
                </div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <c:forEach var="catalystActivity" items="${databaseObject.catalystActivity}">
                        <div class="favth-row">
                            <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label ca-label">
                                Title
                            </div>
                            <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field ca-field">
                                    ${catalystActivity.displayName}
                            </div>

                            <c:if test="${not empty catalystActivity.physicalEntity}">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label ca-label">
                                    Physical Entity
                                </div>
                                <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field ca-field">
                                    <i class="sprite sprite-resize sprite-${catalystActivity.physicalEntity.schemaClass} sprite-position"
                                       title="${catalystActivity.physicalEntity.schemaClass}"></i>
                                    <a href="${detailRequestPrefix}${catalystActivity.physicalEntity.stId}" class=""
                                       title="show Reactome ${catalystActivity.physicalEntity.stId}"
                                       > ${catalystActivity.physicalEntity.displayName}</a>
                                </div>
                            </c:if>

                            <c:if test="${not empty catalystActivity.activity}">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label ca-label">
                                    Activity
                                </div>
                                <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field ca-field">
                                    <a href="${catalystActivity.activity.url}" class=""
                                       title="show ${catalystActivity.activity.databaseName}">${catalystActivity.activity.displayName}
                                        (${catalystActivity.activity.accession})</a>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty negativelyRegulatedBy || not empty positivelyRegulatedBy || not empty requirements}">
    <fieldset class="fieldset-details">
        <legend>This event is regulated</legend>
        <c:if test="${not empty negativelyRegulatedBy}">
            <div class="fieldset-pair-container">
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        Negatively by
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <c:forEach var="negativelyRegulatedBy" items="${negativelyRegulatedBy}">
                            <div class="favth-clearfix modified-residue">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">
                                    Regulator
                                </div>
                                <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                    <m:link object="${negativelyRegulatedBy.regulator}" detailRequestPrefix="${detailRequestPrefix}"/>
                                </div>
                                <c:if test="${not empty negativelyRegulatedBy.summation}">
                                    <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">
                                        Summation
                                    </div>
                                    <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                        <div class="wrap">
                                            <c:forEach var="summation" items="${negativelyRegulatedBy.summation}">
                                                <p>${summation.text}</p>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty negativelyRegulatedBy.activeUnit}">
                                    <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">
                                        Active Unit
                                    </div>
                                    <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                        <div class="wrap">
                                            <c:forEach var="activeUnit"
                                                       items="${negativelyRegulatedBy.activeUnit}">
                                                <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                                                    <m:link object="${activeUnit}" detailRequestPrefix="${detailRequestPrefix}"/>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty positivelyRegulatedBy}">
            <div class="fieldset-pair-container">
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        Positively  by
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <c:forEach var="positivelyRegulatedBy" items="${positivelyRegulatedBy}">
                            <div class="favth-clearfix modified-residue">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">
                                    Regulator
                                </div>
                                <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                    <m:link object="${positivelyRegulatedBy.regulator}" detailRequestPrefix="${detailRequestPrefix}"/>

                                </div>
                                <c:if test="${not empty positivelyRegulatedBy.summation}">
                                    <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">
                                        Summation
                                    </div>
                                    <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                        <div class="wrap">
                                            <c:forEach var="summation" items="${positivelyRegulatedBy.summation}">
                                                <p>${summation.text}</p>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty positivelyRegulatedBy.activeUnit}">
                                    <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">
                                        Active Unit
                                    </div>
                                    <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                        <div class="wrap">
                                            <c:forEach var="activeUnit"
                                                       items="${positivelyRegulatedBy.activeUnit}">
                                                <m:link object="${activeUnit}" detailRequestPrefix="${detailRequestPrefix}"/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty requirements}">
            <div class="fieldset-pair-container">
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">
                        Requirements
                    </div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <ul class="list">
                            <c:forEach var="requirement" items="${requirements}">
                                <li>
                                    <a href="${detailRequestPrefix}${requirement.stId}" class="" title="Show Details"
                                    > ${requirement.displayName}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
    </fieldset>
</c:if>


<c:if test="${isReactionLikeEvent && not empty databaseObject.normalReaction}">
    <fieldset class="fieldset-details">
        <legend>Normal reaction</legend>
        <div class="wrap overflow">
            <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                <m:link object="${databaseObject.normalReaction}" detailRequestPrefix="${detailRequestPrefix}"/>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.inferredFrom}">
    <fieldset class="fieldset-details">
        <legend>Inferred From</legend>
        <div class="wrap overflow">
            <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                    <a href="${detailRequestPrefix}${inferredFrom.stId}" class=""
                       title="${inferredFrom.displayName} (${inferredFrom.speciesName})"
                    >${inferredFrom.displayName}
                        (${inferredFrom.speciesName})</a>
                </div>
            </c:forEach>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty orthologousEvents}">
    <fieldset class="fieldset-details">
        <legend>Orthologous Events</legend>
        <div class="wrap overflow">
            <c:forEach items="${orthologousEvents}" var="orthologousEvents">
                <c:forEach items="${orthologousEvents.value}" var="orthologousEvent">
                    <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                        <a href="${detailRequestPrefix}${orthologousEvent.stId}"
                           title="${orthologousEvent.displayName} (${orthologousEvent.speciesName})"
                        >${orthologousEvent.displayName}
                            (${orthologousEvent.speciesName})</a>
                    </div>
                </c:forEach>
            </c:forEach>
        </div>
    </fieldset>
</c:if>