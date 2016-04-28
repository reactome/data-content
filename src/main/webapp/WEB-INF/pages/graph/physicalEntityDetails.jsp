<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:if test="${not empty otherFormsOfThisMolecule}">
    <div class="grid_23  padding  margin">
        <h5>Other forms of this molecule</h5>

        <div style="height: auto; max-height: 120px; overflow:auto;" class="paddingleft">
            <table border="0" width="100%" style="border: 0px;">
                <tbody>
                <tr>
                    <c:forEach var="derivedEwas" items="${otherFormsOfThisMolecule}" varStatus="loop">
                    <c:if test="${not loop.first and loop.index % 3 == 0}">
                </tr><tr>
                    </c:if>

                    <td class="overme_3c"> <%--(${derivedEwas.compartment}) --%>
                        <a href="../detail/${derivedEwas.stableIdentifier}" title="Open ${derivedEwas.displayName}" rel="nofollow">${derivedEwas.displayName}</a>
                    </td>
                    </c:forEach>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</c:if>

<c:if test="${hasReferenceEntity}">
    <c:if test="${not empty databaseObject.referenceEntity}">
        <%--<div class="grid_24">--%>
            <fieldset class="fieldset-details">
                <legend>External Reference Information</legend>


                    <%--  NEW FORMAT--%>
                <div class="fieldset-pair-container">
                    <div class="label">
                        <span>External Reference</span>
                    </div>
                    <div class="field">
                        <a href="${databaseObject.referenceEntity.url}" class="" title="Show Details" rel="show ${databaseObject.referenceEntity.identifier}">
                                ${databaseObject.referenceEntity.displayName}
                        </a>
                    </div>
                    <div class="clear"></div>

                    <c:if test="${isReferenceSequence}">
                        <c:if test="${not empty databaseObject.referenceEntity.geneName}">
                            <div class="label">
                                <span>Gene Names</span>
                            </div>
                            <div class="field">
                                <c:forEach var="geneName" items="${databaseObject.referenceEntity.geneName}" varStatus="loop">${geneName}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </div>
                            <div class="clear"></div>
                        </c:if>
                    </c:if>

                    <c:if test="${databaseObject.referenceType == 'ReferenceGeneProduct'}">
                        <c:if test="${not empty databaseObject.referenceEntity.chain}">
                            <div class="label">
                                <span>Chain</span>
                            </div>
                            <div class="field">
                                <c:forEach var="chain" items="${databaseObject.referenceEntity.chain}"
                                           varStatus="loop">${chain}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </div>
                            <div class="clear"></div>
                        </c:if>
                        <c:if test="${not empty databaseObject.referenceEntity.referenceGene}">
                            <div class="label">
                                <span>Reference Genes</span>
                            </div>
                            <div class="field">
                                <%--<ul class="list overflowAuto">--%>
                                    <c:forEach var="referenceGene" items="${databaseObject.referenceEntity.referenceGene}" varStatus="loop">
                                        <a href="${referenceGene.url}" title="show ${referenceGene.displayName}" rel="nofollow">${referenceGene.displayName}</a><c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                <%--</ul>--%>
                            </div>
                            <div class="clear"></div>
                        </c:if>
                        <c:if test="${not empty databaseObject.referenceEntity.referenceTranscript}">
                            <div class="label">
                                <span>Reference Transcript</span>
                            </div>
                            <div class="field">
                                <ul class="list overflowAuto">
                                    <c:forEach var="referenceTranscript" items="${databaseObject.referenceEntity.referenceTranscript}">
                                        <li><a href="${referenceTranscript.url}" title="show ${referenceTranscript.displayName}" rel="nofollow">${referenceTranscript.displayName}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="clear"></div>
                        </c:if>
                    </c:if>
                </div>

                <c:if test="${not empty referenceCrossReference}">
                    <div class="padding">
                        <h5>Cross References</h5>
                        <table border="0" width="100%" class="fixedTable">
                            <thead class="tableHead">
                                <th>Database</th>
                                <th>Identifier</th>
                            </thead>
                            <tbody class="tableBody">
                            <c:forEach var="crossReference" items="${referenceCrossReference}">
                                <tr>
                                    <td><strong>${crossReference.key}</strong></td>
                                    <td>
                                        <c:forEach var="value" items="${crossReference.value}" varStatus="loop">
                                            <a href="${value.url}" title="show ${value.displayName}" rel="nofollow">${value.identifier}</a><c:if test="${!loop.last}">, </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <br/>
                <c:if test="${not empty databaseObject.referenceEntity.otherIdentifier}">
                    <div class="padding">
                        <h5>Other Identifiers</h5>

                        <div class="overflow-content-div">
                            <table border="0" width="100%" style="border: none">
                                <tbody>
                                <tr>
                                    <c:forEach var="otherIdentifier" items="${databaseObject.referenceEntity.otherIdentifier}" varStatus="loop">
                                    <c:if test="${not loop.first and loop.index % 5 == 0}">
                                </tr>
                                <tr>
                                    </c:if>
                                    <td class="overme_5c">
                                        <span title="${otherIdentifier}">&nbsp;${otherIdentifier}</span>
                                    </td>
                                    </c:forEach>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </fieldset>
        <%--</div>--%>
    </c:if>
</c:if>

<c:if test="${not empty databaseObject.goCellularComponent}">
    <div class="grid_23  padding  margin">
        <h5>Go Cellular Component</h5>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td></td>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><a href="${databaseObject.goCellularComponent.url}" class="" title="show ${databaseObject.goCellularComponent.name}"
                       rel="nofollow">${databaseObject.goCellularComponent.name}</a> (${databaseObject.goCellularComponent.accession})
                </td>
                <td>${databaseObject.definition}</td> <%-- Gui added it --%>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>

<c:if test="${not empty databaseObject.inferredFrom || not empty databaseObject.inferredTo}">
    <fieldset class="fieldset-details">
        <legend>Inferred</legend>
        <div class="grid_23  padding  margin">
            <h5>Inferred Entries</h5>
            <table  class="fixedTable">
                <%--<thead>--%>
                <%--<tr class="tableHead">--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <%--</thead>--%>
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
                <c:if test="${not empty databaseObject.inferredTo}">
                    <tr>
                        <td><strong>Inferred To</strong></td>
                        <td>
                            <ul class="list overflowList">
                                <c:forEach var="inferredTo" items="${databaseObject.inferredTo}">
                                    <li><a href="../detail/${inferredTo.stableIdentifier}" class="" title="Show Details" rel="nofollow">${inferredTo.displayName} (${inferredTo.speciesName})</a></li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </fieldset>
</c:if>

<%--
    The field is not inside the if-tag because a database object has
    one of this entries below, unless it is an orphan
--%>
<fieldset class="fieldset-details">
    <legend>Components / Components of </legend>
    <c:if test="${databaseObject.schemaClass == 'EntityWithAccessionedSequence'}">
        <c:if test="${not empty databaseObject.hasModifiedResidue}">
            <div class="grid_23  padding  margin">
                <h5>Modified Residues</h5>
                <table>
                    <thead>
                    <tr class="tableHead">
                        <td>Name</td>
                        <td>Coordinate</td>
                        <td>Modification</td>
                        <td>PsiMod</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="modifiedResidue" items="${databaseObject.hasModifiedResidue}">
                        <tr>
                            <td style="vertical-align: middle; width: 170px;">${modifiedResidue.displayName}</td>
                            <td style="vertical-align: middle;">${modifiedResidue.coordinate}</td>
                            <c:choose>
                                <c:when test="${modifiedResidue.schemaClass == 'InterChainCrosslinkedResidue' || modifiedResidue.schemaClass == 'IntraChainCrosslinkedResidue' || modifiedResidue.schemaClass == 'GroupModifiedResidue'}">
                                    <td style="vertical-align: middle;"><c:if test="${not empty modifiedResidue.modification.displayName}"><a href="../detail/${modifiedResidue.modification.stableIdentifier}" class="" title="Show Details" rel="nofollow">${modifiedResidue.modification.displayName}</a></c:if></td>
                                </c:when>
                                <c:otherwise>
                                    <td></td>
                                </c:otherwise>
                            </c:choose>
                            <td style="padding: 0px;">
                                <table border="0" class="psiModTable">
                                    <tbody>
                                        <%--todo improve--%>
                                    <c:choose>
                                        <c:when test="${modifiedResidue.psiMod.getClass().getSimpleName() == 'ArrayList'}">
                                            <c:forEach var="psiMod" items="${modifiedResidue.psiMod}" varStatus="loop">
                                                <tr>
                                                    <td <c:if test="${loop.index % 2 == 0}">class="specialborder"</c:if>>
                                                        <c:if test="${not empty psiMod.displayName}"><a href="${psiMod.url}" class="" title="Show Details" rel="nofollow">${psiMod.displayName}</a></c:if>
                                                    </td>
                                                    <td <c:if test="${loop.index % 2 == 0}">class="specialborder"</c:if>>
                                                        <c:if test="${not empty psiMod.definition}">${psiMod.definition}</c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td>
                                                    <c:if test="${not empty modifiedResidue.psiMod.displayName}"><a href="${modifiedResidue.psiMod.url}" class="" title="Show Details" rel="nofollow">${modifiedResidue.psiMod.displayName}</a></c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty modifiedResidue.psiMod.definition}">${modifiedResidue.psiMod.definition}</c:if>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>


                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </c:if>

    <c:if test="${databaseObject.schemaClass == 'Complex'}">
        <c:if test="${not empty databaseObject.hasComponent}">
            <div class="grid_23  padding  margin">
                <h5>Components of this complex</h5>
                <table class="fixedTable">
                    <thead>
                    <tr class="tableHead">
                        <td></td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty databaseObject.hasComponent}">
                    <tr>
                        <td><strong>output entries</strong></td>
                        <td>
                            <ul class="list overflowAuto">
                                <c:forEach var="hasComponent" items="${databaseObject.hasComponent}">
                                    <li><a href="../detail/${hasComponent.stableIdentifier}" class="" title="Show Details" rel="nofollow">${hasComponent.displayName} <c:if test="${not empty hasComponent.speciesName}">(${hasComponent.speciesName})</c:if></a></li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                    </c:if>
                </table>
            </div>
        </c:if>
    </c:if>

    <c:if test="${databaseObject.schemaClass == 'Polymer'}">
        <c:if test="${not empty databaseObject.repeatedUnit}">
            <div class="grid_23  padding  margin">
                <h5>Repeated Units of this Polymer</h5>
                <table class="fixedTable">
                    <thead>
                    <tr class="tableHead">
                        <td></td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty databaseObject.repeatedUnit}">
                    <tr>
                        <td><strong>output entries</strong></td>
                        <td>
                            <ul class="list overflowAuto">
                                <c:forEach var="repeatedUnit" items="${databaseObject.repeatedUnit}">
                                    <li><a href="../detail/${repeatedUnit.stableIdentifier}" class="" title="Show Details" rel="nofollow">${repeatedUnit.displayName} <c:if test="${not empty repeatedUnit.speciesName}">(${repeatedUnit.speciesName})</c:if></a></li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                    </c:if>
                </table>
            </div>
        </c:if>
    </c:if>

    <c:if test="${isEntitySet}">
        <c:if test="${not empty databaseObject.hasMember}">
            <div class="grid_23  padding  margin">
                <h5>Members of this Set</h5>
                <table class="fixedTable">
                    <thead>
                    <tr class="tableHead">
                        <td></td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty databaseObject.hasMember}">
                    <tr>
                        <td><strong>output entries</strong></td>
                        <td>
                            <ul class="list overflowAuto">
                                <c:forEach var="hasMember" items="${databaseObject.hasMember}">
                                    <li><a href="../detail/${hasMember.stableIdentifier}" class="" title="Show Details" rel="nofollow">${hasMember.displayName} <c:if test="${not empty hasMember.speciesName}">(${hasMember.speciesName})</c:if></a></li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                    </c:if>
                </table>
            </div>
        </c:if>
    </c:if>

    <c:if test="${databaseObject.schemaClass == 'CandidateSet'}">
        <c:if test="${not empty databaseObject.hasCandidate}">
            <div class="grid_23  padding  margin">
                <h5>Candidates of this Set</h5>
                <table class="fixedTable">
                    <thead>
                    <tr class="tableHead">
                        <td></td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty databaseObject.hasCandidate}">
                    <tr>
                        <td><strong>output entries</strong></td>
                        <td>
                            <ul class="list overflowAuto">
                                <c:forEach var="hasCandidate" items="${databaseObject.hasCandidate}">
                                    <li><a href="../detail/${hasCandidate.stableIdentifier}" class="" title="Show Details" rel="nofollow">${hasCandidate.displayName} <c:if test="${not empty hasCandidate.speciesName}">(${hasCandidate.speciesName})</c:if></a></li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                    </c:if>
                </table>
            </div>
        </c:if>
    </c:if>

    <c:import url="componentOf.jsp"/>
</fieldset>

<c:if test="${not empty databaseObject.negativelyRegulates || not empty databaseObject.positivelyRegulates}">
    <div class="grid_23  padding  margin">
        <h5>This entity regulates</h5>
        <table class="fixedTable">
            <thead>
            <tr class="tableHead">
                <td>Regulation type</td>
                <td>Name</td>
            </tr>
            </thead>
            <tbody>

                <tr>
                    <td><strong>NegativeRegulation</strong></td>
                    <td>
                        <c:forEach var="negativeRegulation" items="${databaseObject.negativelyRegulates}">
                            <ul class="list overflowList">
                                <li><c:if test="${not empty negativeRegulation.regulatedEntity.stableIdentifier}"><a href="../detail/${negativeRegulation.regulatedEntity.stableIdentifier}" class="" title="Show Details" rel="nofollow">${negativeRegulation.regulatedEntity.displayName}<c:if test="${not empty negativeRegulation.regulatedEntity.speciesName}"> (${negativeRegulation.regulatedEntity.speciesName})</c:if></a></c:if></li>
                            </ul>
                        </c:forEach>
                    </td>
                </tr>

                <tr>
                    <td><strong>PositiveRegulation</strong></td>
                    <td>
                        <c:forEach var="positiveRegulation" items="${databaseObject.positivelyRegulates}">
                            <ul class="list overflowList">
                                <li><c:if test="${not empty positiveRegulation.regulatedEntity.stableIdentifier}"><a href="../detail/${positiveRegulation.regulatedEntity.stableIdentifier}" class="" title="Show Details" rel="nofollow">${positiveRegulation.regulatedEntity.displayName}<c:if test="${not empty positiveRegulation.regulatedEntity.speciesName}"> (${positiveRegulation.regulatedEntity.speciesName})</c:if></a></c:if></li>
                            </ul>
                        </c:forEach>
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
</c:if>


