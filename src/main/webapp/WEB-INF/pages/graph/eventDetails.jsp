<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<fieldset class="fieldset-details">
    <legend>Components/Components of </legend>
    <c:if test="${databaseObject.schemaClass == 'Pathway' || databaseObject.schemaClass == 'BlackBoxEvent' || databaseObject.schemaClass == 'TopLevelPathway'}">
        <c:if test="${not empty databaseObject.hasEvent}">
            <div class="fieldset-pair-container">
                <div class="label">
                    <span><strong>contained events:</strong></span>
                </div>
                <div class="field">
                    <ul class="list overflowAuto">
                        <c:forEach var="hasEvent" items="${databaseObject.hasEvent}">
                            <li><a href="../detail/${hasEvent.stableIdentifier}" class="" title="Show Details" rel="nofollow">${hasEvent.displayName} <c:if test="${not empty hasEvent.speciesName}">(${hasEvent.speciesName})</c:if></a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
    </c:if>
    <c:if test="${isReactionLikeEvent}">
        <c:if test="${not empty databaseObject.input}">
            <div class="fieldset-pair-container">
                <div class="label">
                    <span><strong>contained inputs:</strong></span>
                </div>
                <div class="field">
                    <ul class="list overflowAuto">
                        <c:forEach var="input" items="${databaseObject.input}">
                            <li><a href="../detail/${input.stableIdentifier}" class="" title="Show Details" rel="nofollow">${input.displayName} <c:if test="${not empty input.speciesName}">(${input.speciesName})</c:if></a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.output}">
            <div class="fieldset-pair-container">
                <div class="label">
                    <span><strong>contained output:</strong></span>
                </div>
                <div class="field">
                    <ul class="list overflowAuto">
                        <c:forEach var="output" items="${databaseObject.output}">
                            <li><a href="../detail/${output.stableIdentifier}" class="" title="Show Details" rel="nofollow">${output.displayName} <c:if test="${not empty output.speciesName}">(${output.speciesName})</c:if></a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.entityOnOtherCell}">
            <div class="fieldset-pair-container">
                <div class="label">
                    <span><strong>entityOnOtherCell</strong></span>
                </div>
                <div class="field">
                    <ul class="list overflowAuto">
                        <c:forEach var="entityOnOtherCell" items="${databaseObject.entityOnOtherCell}">
                            <li><a href="../detail/${entityOnOtherCell.stableIdentifier}" class="" title="Show Details" rel="nofollow">${entityOnOtherCell.displayName} <c:if test="${not empty entityOnOtherCell.speciesName}">(${entityOnOtherCell.speciesName})</c:if></a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
    </c:if>
    <c:import url="componentOf.jsp"/>
</fieldset>

<c:if test="${not empty databaseObject.goBiologicalProcess} || ${databaseObject.schemaClass == 'Reaction'}">
    <fieldset class="fieldset-details">
        <legend>Event Information</legend>
        <div class="fieldset-pair-container">
            <c:if test="${not empty databaseObject.goBiologicalProcess}">
                <div class="label">
                    <span><strong>Go Biological Process</strong></span>
                </div>
                <div class="field">
                    <span><a href="${databaseObject.goBiologicalProcess.url}" class=""  title="go to ${databaseObject.goBiologicalProcess.databaseName}" rel="nofollow">${databaseObject.goBiologicalProcess.displayName} (${databaseObject.goBiologicalProcess.accession})</a></span>
                </div>
                <div class="clear"></div>
            </c:if>
            <c:if test="${databaseObject.schemaClass == 'Reaction'}">
                <c:if test="${not empty databaseObject.reverseReaction}">
                    <div class="label">
                        <span><strong>Reverse Reaction</strong></span>
                    </div>
                    <div class="field">
                        <span><a href="../detail/${databaseObject.reverseReaction.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.reverseReaction.displayName} <c:if test="${not empty databaseObject.reverseReaction.speciesName}">(${databaseObject.reverseReaction.speciesName})</c:if></a></span>
                    </div>
                    <div class="clear"></div>
                </c:if>
            </c:if>
        </div>
    </fieldset>
</c:if>

<%--<c:if test="${not empty databaseObject.goBiologicalProcess}">--%>
<%--<div class="grid_23  padding  margin">--%>
<%--<h5>Additional Information</h5>--%>
<%--<table class="fixedTable">--%>
<%--<thead>--%>
<%--<tr class="tableHead">--%>
<%--<td></td>--%>
<%--<td></td>--%>
<%--</tr>--%>
<%--</thead>--%>
<%--<tbody>--%>

<%--<c:if test="${not empty databaseObject.goBiologicalProcess}">--%>
<%--<tr>--%>
<%--<td><strong>GO Biological Process</strong></td>--%>
<%--<td><a href="${databaseObject.goBiologicalProcess.url}" class=""  title="go to ${databaseObject.goBiologicalProcess.databaseName}" rel="nofollow">${databaseObject.goBiologicalProcess.displayName} (${databaseObject.goBiologicalProcess.accession})</a></td>--%>
<%--</tr>--%>
<%--</c:if>--%>
<%--</tbody>--%>
<%--</table>--%>
<%--</div>--%>
<%--</c:if>--%>
<%--<c:if test="${databaseObject.schemaClass == 'Reaction'}">--%>
<%--<c:if test="${not empty databaseObject.reverseReaction}">--%>
<%--<div class="grid_23  padding  margin">--%>
<%--<h5>ReverseReaction</h5>--%>
<%--<table class="fixedTable">--%>
<%--<thead>--%>
<%--<tr class="tableHead">--%>
<%--<td></td>--%>
<%--<td></td>--%>
<%--</tr>--%>
<%--</thead>--%>
<%--<tbody>--%>
<%--<tr>--%>
<%--<td><strong>entries</strong></td>--%>
<%--<td>--%>
<%--<a href="../detail/${databaseObject.reverseReaction.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.reverseReaction.displayName} <c:if test="${not empty databaseObject.reverseReaction.speciesName}">(${databaseObject.reverseReaction.speciesName})</c:if></a>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</table>--%>
<%--</div>--%>
<%--</c:if>--%>
<%--</c:if>--%>


<c:if test="${not empty databaseObject.negativelyRegulatedBy || not empty databaseObject.positivelyRegulatedBy || isReactionLikeEvent && not empty databaseObject.catalystActivity}">

    <fieldset class="fieldset-details">
        <legend>This entity is regulated by: </legend>

        <c:if test="${isReactionLikeEvent}">
            <c:if test="${not empty databaseObject.catalystActivity}">
                <div class="wrap">
                    <h5>Catalyst Activity</h5>
                    <table class="dt-fixed-header">
                        <thead>
                        <tr>
                            <th style="">Physical Entity</th>
                            <th style="">Title</th>
                            <th style="">Activity</th>
                        </tr>
                        </thead>
                    </table>
                    <div class="dt-content">
                        <table>
                            <tbody>
                                <c:forEach var="catalystActivity" items="${databaseObject.catalystActivity}">
                                    <tr>
                                        <c:if test="${not empty catalystActivity.physicalEntity}">
                                            <td><a href="../detail/${catalystActivity.physicalEntity.stableIdentifier}" class="" title="show Reactome ${catalystActivity.physicalEntity.stableIdentifier}" rel="nofollow">${catalystActivity.physicalEntity.displayName}</a></td>
                                        </c:if>
                                        <c:if test="${not empty catalystActivity.activity}">
                                            <td><a href="${catalystActivity.activity.url}" class=""  title="show ${catalystActivity.activity.databaseName}" rel="nofollow">${catalystActivity.activity.displayName} (${catalystActivity.activity.accession})</a></td>
                                        </c:if>

                                        <c:choose>
                                            <c:when test="${not empty catalystActivity.activeUnit}">
                                                <td>
                                                    <ul class="list overflowList">
                                                        <c:forEach var="activeUnit" items="${catalystActivity.activeUnit}">
                                                            <li><a href="../detail/${activeUnit.stableIdentifier}" class="" title="show Reactome ${activeUnit.stableIdentifier}" rel="nofollow">${activeUnit.displayName}</a></li>
                                                        </c:forEach>
                                                    </ul>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>&nbsp;</td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>
        </c:if>

            <%--<c:if test="${not empty entry.regulatedEvents}">--%>
        <c:if test="${not empty databaseObject.negativelyRegulatedBy || not empty databaseObject.positivelyRegulatedBy}">
            <div class="wrap">
                <h5>Regulation</h5>
                <table class="dt-fixed-header">
                    <thead>
                    <tr>
                        <th style="width:50px;">Regulation type</th>
                        <th style="width:250px;">Name</th>
                    </tr>
                    </thead>
                </table>
                <div class="dt-content">
                    <table>
                        <tbody>
                            <c:forEach var="negativelyRegulatedBy" items="${databaseObject.negativelyRegulatedBy}">
                                <tr>
                                    <td style="width:55px;"><strong>${negativelyRegulatedBy.schemaClass}</strong></td>
                                    <td style="width:255px;">
                                        <ul class="list overflowList">
                                            <li><c:if test="${not empty negativelyRegulatedBy.regulator.stableIdentifier}"><a href="../detail/${negativelyRegulatedBy.regulator.stableIdentifier}" class="" title="Show Details" rel="nofollow">${negativelyRegulatedBy.regulator.displayName}<c:if test="${not empty negativelyRegulatedBy.regulator.speciesName}"> (${negativelyRegulatedBy.regulator.speciesName})</c:if></a></c:if></li>
                                        </ul>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:forEach var="positivelyRegulatedBy" items="${databaseObject.positivelyRegulatedBy}">
                                <tr>
                                    <td style="width:55px;"><strong>${positivelyRegulatedBy.schemaClass}</strong></td>
                                    <td style="width:255px;">
                                        <ul class="list overflowList">
                                            <li><c:if test="${not empty positivelyRegulatedBy.regulator.stableIdentifier}"><a href="../detail/${positivelyRegulatedBy.regulator.stableIdentifier}" class="" title="Show Details" rel="nofollow">${positivelyRegulatedBy.regulator.displayName}<c:if test="${not empty positivelyRegulatedBy.regulator.speciesName}"> (${positivelyRegulatedBy.regulator.speciesName})</c:if></a></c:if></li>
                                        </ul>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.inferredFrom || not empty databaseObject.orthologousEvent}">
    <div class="grid_24">
        <fieldset class="fieldset-details">
            <legend>Inferred Entries</legend>
            <c:if test="${not empty databaseObject.inferredFrom}">
                <div class="fieldset-pair-container">
                    <div class="label">Inferred From</div>
                    <div class="field">
                        <ul class="list overflowList">
                            <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                                <li><a href="../detail/${inferredFrom.stableIdentifier}" class="" title="Show Details" rel="nofollow">${inferredFrom.displayName} (${inferredFrom.speciesName})</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
            <c:if test="${not empty databaseObject.orthologousEvent}">
                <div class="fieldset-pair-container">
                    <div class="label">Orthologous events</div>
                    <div class="field">
                        <ul class="list overflowList">
                            <c:forEach var="orthologousEvent" items="${databaseObject.orthologousEvent}">
                                <li><a href="../detail/${orthologousEvent.stableIdentifier}" class="" title="Show Details" rel="nofollow">${orthologousEvent.displayName} (${orthologousEvent.speciesName})</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
        </fieldset>
    </div>
</c:if>