<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<fieldset class="fieldset-details">
    <legend>Participants</legend>

    <c:if test="${databaseObject.schemaClass == 'Pathway' || databaseObject.schemaClass == 'BlackBoxEvent' || databaseObject.schemaClass == 'TopLevelPathway'}">
        <c:if test="${not empty databaseObject.hasEvent}">

            <div class="fieldset-pair-container">
                <div class="label">
                     events
                </div>
                <div class="field">
                    <ul class="list">
                        <c:forEach var="hasEvent" items="${databaseObject.hasEvent}">
                            <li>
                                <i class="sprite sprite-resize sprite-${hasEvent.schemaClass} sprite-position" title="${hasEvent.schemaClass}"></i>
                                <a href="../detail/${hasEvent.stId}" class="" title="Show Details" rel="nofollow">${hasEvent.displayName} <c:if test="${not empty hasEvent.speciesName}">(${hasEvent.speciesName})</c:if></a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
    </c:if>

    <c:if test="${isReactionLikeEvent}">

        <c:if test="${not empty databaseObject.input || not empty databaseObject.output || not empty databaseObject.entityOnOtherCell}">
            <c:if test="${not empty databaseObject.input}">
                <div class="fieldset-pair-container">
                    <div class="label">
                        input
                    </div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="input" items="${databaseObject.fetchInput()}">
                                <li>
                                    <i class="sprite sprite-resize sprite-${input.object.schemaClass} sprite-position" title="${input.object.schemaClass}"></i>
                                    <c:if test="${input.stoichiometry gt 1}">${input.stoichiometry} x </c:if>
                                    <a href="../detail/${input.object.stId}" class="" title="Show Details" rel="nofollow">${input.object.displayName} <c:if test="${not empty input.object.speciesName}">(${input.object.speciesName})</c:if></a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
            <c:if test="${not empty databaseObject.output}">
                <div class="fieldset-pair-container">
                    <div class="label">
                        output
                    </div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="output" items="${databaseObject.fetchOutput()}">
                                <li>
                                    <i class="sprite sprite-resize sprite-${output.object.schemaClass} sprite-position" title="${output.object.schemaClass}"></i>
                                    <c:if test="${output.stoichiometry gt 1}">${output.stoichiometry} x </c:if>
                                    <a href="../detail/${output.object.stId}" class="" title="Show Details" rel="nofollow">${output.object.displayName} <c:if test="${not empty output.object.speciesName}">(${output.object.speciesName})</c:if></a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
            <c:if test="${not empty databaseObject.entityOnOtherCell}">
                <div class="fieldset-pair-container">
                    <div class="label">
                        entityOnOtherCell
                    </div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="entityOnOtherCell" items="${databaseObject.entityOnOtherCell}">
                                <li>
                                    <i class="sprite sprite-resize sprite-${entityOnOtherCell.schemaClass} sprite-position" title="${entityOnOtherCell.schemaClass}"></i>
                                    <a href="../detail/${entityOnOtherCell.stId}" class="" title="Show Details" rel="nofollow">${entityOnOtherCell.displayName} <c:if test="${not empty entityOnOtherCell.speciesName}">(${entityOnOtherCell.speciesName})</c:if></a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
        </c:if>

    </c:if>

</fieldset>

<c:import url="componentOf.jsp"/>

<c:if test="${not empty databaseObject.goBiologicalProcess} || ${databaseObject.schemaClass == 'Reaction'}">
    <fieldset class="fieldset-details">
        <legend>Event Information</legend>
        <div class="fieldset-pair-container">
            <c:if test="${not empty databaseObject.goBiologicalProcess}">
                <div class="label">
                    Go Biological Process
                </div>
                <div class="field">
                    <span><a href="${databaseObject.goBiologicalProcess.url}" class=""  title="go to ${databaseObject.goBiologicalProcess.databaseName}" rel="nofollow">${databaseObject.goBiologicalProcess.displayName} (${databaseObject.goBiologicalProcess.accession})</a></span>
                </div>
                <div class="clear"></div>
            </c:if>
            <c:if test="${databaseObject.schemaClass == 'Reaction'}">
                <c:if test="${not empty databaseObject.reverseReaction}">
                    <div class="label">
                        Reverse Reaction
                    </div>
                    <div class="field">
                        <span><a href="../detail/${databaseObject.reverseReaction.stId}" class="" title="Show Details" rel="nofollow">${databaseObject.reverseReaction.displayName} <c:if test="${not empty databaseObject.reverseReaction.speciesName}">(${databaseObject.reverseReaction.speciesName})</c:if></a></span>
                    </div>
                    <div class="clear"></div>
                </c:if>
            </c:if>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.negativelyRegulatedBy || not empty databaseObject.positivelyRegulatedBy || isReactionLikeEvent && not empty databaseObject.catalystActivity}">

    <fieldset class="fieldset-details">
        <legend>This entity is regulated by: </legend>

        <c:if test="${isReactionLikeEvent}">
            <c:if test="${not empty databaseObject.catalystActivity}">
                <div class="wrap">
                    <table class="dt-fixed-header">
                        <thead>
                        <tr>
                            <th style="">Title</th>
                            <th style="">Physical Entity</th>
                            <th style="">Activity</th>
                        </tr>
                        </thead>
                    </table>
                    <div class="dt-content-ovf">
                        <table>
                            <tbody>
                            <c:forEach var="catalystActivity" items="${databaseObject.catalystActivity}">
                                <tr>
                                    <td>${catalystActivity.displayName}</td>
                                    <td>
                                        <c:if test="${not empty catalystActivity.physicalEntity}">
                                            <i class="sprite sprite-resize sprite-${catalystActivity.physicalEntity.schemaClass} sprite-position" title="${catalystActivity.physicalEntity.schemaClass}"></i>
                                            <a href="../detail/${catalystActivity.physicalEntity.stId}" class="" title="show Reactome ${catalystActivity.physicalEntity.stId}" rel="nofollow">${catalystActivity.physicalEntity.displayName}</a>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${not empty catalystActivity.activity}">
                                            <a href="${catalystActivity.activity.url}" class=""  title="show ${catalystActivity.activity.databaseName}" rel="nofollow">${catalystActivity.activity.displayName} (${catalystActivity.activity.accession})</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>
        </c:if>


            <%--<c:if test="${not empty entry.regulatedEvents}">--%>
        <c:if test="${not empty databaseObject.negativelyRegulatedBy}">
            <div class="fieldset-pair-container">
                <div class="label">Negative Regulation</div>
                <div class="field">
                    <ul class="list">
                        <c:forEach var="negativelyRegulatedBy" items="${databaseObject.negativelyRegulatedBy}">
                            <li>
                                <a href="../detail/${negativelyRegulatedBy.stId}" class="" title="Show Details" rel="nofollow">${negativelyRegulatedBy.displayName}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.positivelyRegulatedBy}">
            <div class="fieldset-pair-container">
                <div class="label">Positive Regulation</div>
                <div class="field">
                    <ul class="list">
                        <c:forEach var="positivelyRegulatedBy" items="${databaseObject.positivelyRegulatedBy}">
                            <li>
                                <a href="../detail/${positivelyRegulatedBy.stId}" class="" title="Show Details" rel="nofollow">${positivelyRegulatedBy.displayName}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
    </fieldset>
</c:if>


<c:if test="${not empty databaseObject.inferredFrom}">
    <fieldset class="fieldset-details">
        <legend>Inferred From</legend>
        <div class="wrap overflow">
            <ul class="list">
                <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                    <li><a href="../detail/${inferredFrom.stId}" class="" title="Show Details" rel="nofollow">${inferredFrom.displayName} (${inferredFrom.speciesName})</a></li>
                </c:forEach>
            </ul>
        </div>
    </fieldset>
</c:if>
<c:if test="${not empty databaseObject.orthologousEvent}">
    <fieldset class="fieldset-details">
        <legend>Orthologous Events</legend>
        <div class="wrap overflow">
            <ul class="list">
                <c:forEach var="orthologousEvent" items="${databaseObject.orthologousEvent}">
                    <li><a href="../detail/${orthologousEvent.stId}" class="" title="Show Details" rel="nofollow">${orthologousEvent.displayName} (${orthologousEvent.speciesName})</a></li>
                </c:forEach>
            </ul>
        </div>
    </fieldset>
</c:if>
