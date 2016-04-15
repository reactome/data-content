<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<%--<c:if test="${not empty entry.referenceEntity || not empty entry.compartments || not empty entry.synonyms || not empty entry.reverseReaction || not empty entry.goBiologicalProcess || not empty entry.goMolecularComponent}">--%>
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

<%--<c:if test="${not empty entry.reverseReaction}">--%>
<%--<tr>--%>
<%--<td><strong>Reverse Reaction</strong></td>--%>
<%--<td>--%>
<%--<a href="../detail/${entry.reverseReaction.stId}" class="" title="show Reactome ${entry.reverseReaction.stId}" rel="nofollow">${entry.reverseReaction.name}</a>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</c:if>--%>


<%--<c:if test="${not empty entry.goMolecularComponent}">--%>
<%--<tr>--%>
<%--<td><strong>GO Molecular Component</strong></td>--%>
<%--<td>--%>
<%--<ul class="list overflowList">--%>
<%--<c:forEach var="goMolecularComponent" items="${entry.goMolecularComponent}">--%>
<%--<li><a href="${goMolecularComponent.database.url}" class=""  title="show ${goMolecularComponent.database.name}" rel="nofollow">${goMolecularComponent.name}</a>( ${goMolecularComponent.accession})</li>--%>
<%--</c:forEach>--%>
<%--</ul>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</c:if>--%>
<%--<c:if test="${not empty entry.goBiologicalProcess}">--%>
<%--<tr>--%>
<%--<td><strong>GO Biological Process</strong></td>--%>
<%--<td><a href="${entry.goBiologicalProcess.database.url}" class=""  title="go to ${entry.goBiologicalProcess.database.name}" rel="nofollow">${entry.goBiologicalProcess.name} (${entry.goBiologicalProcess.accession})</a></td>--%>
<%--</tr>--%>
<%--</c:if>--%>
<%--</tbody>--%>
<%--</table>--%>
<%--</div>--%>
<%--</c:if>--%>



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
            </table>
        </div>
    </c:if>
</c:if>
