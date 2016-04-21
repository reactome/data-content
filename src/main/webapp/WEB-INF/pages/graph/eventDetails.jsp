<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<c:if test="${not empty databaseObject.goBiologicalProcess}">
    <div class="grid_23  padding  margin">
        <h5>Additional Information</h5>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td></td>
                <td></td>
            </tr>
            </thead>
            <tbody>

            <c:if test="${not empty databaseObject.goBiologicalProcess}">
                <tr>
                    <td><strong>GO Biological Process</strong></td>
                    <td><a href="${databaseObject.goBiologicalProcess.url}" class=""  title="go to ${databaseObject.goBiologicalProcess.databaseName}" rel="nofollow">${databaseObject.goBiologicalProcess.displayName} (${databaseObject.goBiologicalProcess.accession})</a></td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</c:if>



<c:if test="${databaseObject.schemaClass == 'Pathway' || databaseObject.schemaClass == 'BlackBoxEvent'}">
    <c:if test="${not empty databaseObject.hasEvent}">
        <div class="grid_23  padding  margin">
            <h5>Sub events of this entry</h5>
            <table class="fixedTable">
                <thead>
                <tr class="tableHead">
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><strong>entries</strong></td>
                    <td>
                        <ul class="list overflowAuto">
                            <c:forEach var="hasEvent" items="${databaseObject.hasEvent}">
                                <li><a href="../detail/${hasEvent.stableIdentifier}" class="" title="Show Details" rel="nofollow">${hasEvent.displayName} <c:if test="${not empty hasEvent.speciesName}">(${hasEvent.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
            </table>
        </div>
    </c:if>
</c:if>

<c:if test="${databaseObject.schemaClass == 'Reaction' || databaseObject.schemaClass == 'BlackBoxEvent' || databaseObject.schemaClass == 'FailedReaction' || databaseObject.schemaClass == 'Polymerisation'|| databaseObject.schemaClass == 'Depolymerisation'}">
    <c:if test="${not empty databaseObject.input || not empty databaseObject.output}">
        <div class="grid_23  padding  margin">
            <h5>Sub events of this entry</h5>
            <table class="fixedTable">
                <thead>
                <tr class="tableHead">
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody>
                <c:if test="${not empty databaseObject.input}">
                <tr>
                    <td><strong>Input entries</strong></td>
                    <td>
                        <ul class="list overflowAuto">
                            <c:forEach var="input" items="${databaseObject.input}">
                                <li><a href="../detail/${input.stableIdentifier}" class="" title="Show Details" rel="nofollow">${input.displayName} <c:if test="${not empty input.speciesName}">(${input.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
                </c:if>
                <c:if test="${not empty databaseObject.output}">
                <tr>
                    <td><strong>output entries</strong></td>
                    <td>
                        <ul class="list overflowAuto">
                            <c:forEach var="output" items="${databaseObject.output}">
                                <li><a href="../detail/${output.stableIdentifier}" class="" title="Show Details" rel="nofollow">${output.displayName} <c:if test="${not empty output.speciesName}">(${output.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
                </c:if>
                <c:if test="${not empty databaseObject.entityOnOtherCell}">
                <tr>
                    <td><strong>output entries</strong></td>
                    <td>
                        <ul class="list overflowAuto">
                            <c:forEach var="entityOnOtherCell" items="${databaseObject.entityOnOtherCell}">
                                <li><a href="../detail/${entityOnOtherCell.stableIdentifier}" class="" title="Show Details" rel="nofollow">${entityOnOtherCell.displayName} <c:if test="${not empty entityOnOtherCell.speciesName}">(${entityOnOtherCell.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
                </c:if>
            </table>
        </div>
    </c:if>
</c:if>

<c:if test="${not empty databaseObject.inferredFrom || not empty databaseObject.orthologousEvent}">
    <div class="grid_23  padding  margin">
        <h5>Inferred Entries</h5>
        <table  class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td></td>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty databaseObject.inferredFrom}">
                <tr>
                    <td><strong>Inferred From</strong></td>
                    <td>
                        <ul class="list overflowList">
                            <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                                <li><a href="../detail/${inferredFrom.stableIdentifier}" class="" title="Show Details" rel="nofollow">${inferredFrom.displayName} (${inferredFrom.speciesName})</a></li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty databaseObject.orthologousEvent}">
                <tr>
                    <td><strong>Orthologous events</strong></td>
                    <td>
                        <ul class="list overflowList">
                            <c:forEach var="orthologousEvent" items="${databaseObject.orthologousEvent}">
                                <li><a href="../detail/${orthologousEvent.stableIdentifier}" class="" title="Show Details" rel="nofollow">${orthologousEvent.displayName} (${orthologousEvent.speciesName})</a></li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</c:if>



<c:if test="${databaseObject.schemaClass == 'Reaction'}">
    <c:if test="${not empty databaseObject.reverseReaction}">
        <div class="grid_23  padding  margin">
            <h5>ReverseReaction</h5>
            <table class="fixedTable">
                <thead>
                <tr class="tableHead">
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><strong>entries</strong></td>
                    <td>
                        <a href="../detail/${databaseObject.reverseReaction.stableIdentifier}" class="" title="Show Details" rel="nofollow">${databaseObject.reverseReaction.displayName} <c:if test="${not empty databaseObject.reverseReaction.speciesName}">(${databaseObject.reverseReaction.speciesName})</c:if></a></li>
                    </td>
                </tr>
            </table>
        </div>
    </c:if>
</c:if>


<%--<c:if test="${not empty entry.regulatedEvents}">--%>
<c:if test="${not empty databaseObject.negativelyRegulatedBy || not empty databaseObject.positivelyRegulatedBy}">
    <div class="grid_23  padding  margin">
        <h5>This entry is regulated by</h5>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td>Regulation type</td>
                <td>Name</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="negativelyRegulatedBy" items="${databaseObject.negativelyRegulatedBy}">
                <tr>
                    <td><strong>${negativelyRegulatedBy.schemaClass}</strong></td>
                    <td>
                        <ul class="list overflowList">
                            <%--<c:forEach var="value" items="${negativelyRegulatedBy}" varStatus="loop">--%>
                                <li><c:if test="${not empty negativelyRegulatedBy.regulator.stableIdentifier}"><a href="../detail/${negativelyRegulatedBy.regulator.stableIdentifier}" class="" title="Show Details" rel="nofollow">${negativelyRegulatedBy.regulator.displayName}<c:if test="${not empty negativelyRegulatedBy.regulator.speciesName}"> (${negativelyRegulatedBy.regulator.speciesName})</c:if></a></c:if></li>
                            <%--</c:forEach>--%>
                        </ul>
                    </td>
                </tr>
            </c:forEach>
            <c:forEach var="positivelyRegulatedBy" items="${databaseObject.positivelyRegulatedBy}">
                <tr>
                    <td><strong>${positivelyRegulatedBy.schemaClass}</strong></td>
                    <td>
                        <ul class="list overflowList">
                            <%--<c:forEach var="value" items="${positivelyRegulatedBy}" varStatus="loop">--%>
                                <li><c:if test="${not empty positivelyRegulatedBy.regulator.stableIdentifier}"><a href="../detail/${positivelyRegulatedBy.regulator.stableIdentifier}" class="" title="Show Details" rel="nofollow">${positivelyRegulatedBy.regulator.displayName}<c:if test="${not empty positivelyRegulatedBy.regulator.speciesName}"> (${positivelyRegulatedBy.regulator.speciesName})</c:if></a></c:if></li>
                            <%--</c:forEach>--%>
                        </ul>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>