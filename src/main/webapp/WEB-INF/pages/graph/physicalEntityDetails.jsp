<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<c:if test="${hasReferenceEntity}">
    <c:if test="${not empty databaseObject.referenceEntity}">
        <fieldset class="fieldset-details">
            <legend>External Reference Information</legend>

                <%--  NEW FORMAT--%>
            <div class="fieldset-pair-container">
                <div class="label">External Reference</div>
                <div class="field">
                    <a href="${databaseObject.referenceEntity.url}" class="" title="Go to External Reference">${databaseObject.referenceEntity.displayName}</a>
                </div>
                <div class="clear"></div>

                <c:if test="${isReferenceSequence}">
                    <c:if test="${not empty databaseObject.referenceEntity.geneName}">
                        <div class="label">Gene Names</div>
                        <div class="field">
                            <c:forEach var="geneName" items="${databaseObject.referenceEntity.geneName}" varStatus="loop">
                                ${geneName}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        </div>
                        <div class="clear"></div>
                    </c:if>
                </c:if>

                <c:if test="${databaseObject.referenceType == 'ReferenceGeneProduct'}">
                    <c:if test="${not empty databaseObject.referenceEntity.chain}">
                        <div class="label">Chain</div>
                        <div class="field">
                            <c:forEach var="chain" items="${databaseObject.referenceEntity.chain}" varStatus="loop">
                                ${chain}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        </div>
                        <div class="clear"></div>
                    </c:if>
                    <c:if test="${not empty databaseObject.referenceEntity.referenceGene}">
                        <div class="label">Reference Genes</div>
                        <div class="field">
                            <c:forEach var="referenceGene" items="${databaseObject.referenceEntity.referenceGene}" varStatus="loop">
                                <a href="${referenceGene.url}" title="show ${referenceGene.displayName}" rel="nofollow">${referenceGene.displayName}</a><c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        </div>
                        <div class="clear"></div>
                    </c:if>
                    <c:if test="${not empty databaseObject.referenceEntity.referenceTranscript}">
                        <div class="label">Reference Transcript</div>
                        <div class="field">
                            <ul class="list">
                                <c:forEach var="referenceTranscript" items="${databaseObject.referenceEntity.referenceTranscript}">
                                    <li><a href="${referenceTranscript.url}" title="show ${referenceTranscript.displayName}" rel="nofollow">${referenceTranscript.displayName}</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="clear"></div>
                    </c:if>
                </c:if>

                <c:if test="${not empty databaseObject.referenceEntity.otherIdentifier}">
                    <div class="label">Other Identifiers</div>
                    <div class="field">
                        <div class="wrap overflow">
                            <table class="tabular">
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
                    <div class="clear"></div>
                </c:if>
            </div>
        </fieldset>
    </c:if>
</c:if>

<c:if test="${ databaseObject.schemaClass == 'Complex' &&  not empty databaseObject.hasComponent || databaseObject.schemaClass == 'Polymer' && not empty databaseObject.repeatedUnit || isEntitySet && not empty databaseObject.hasMember || databaseObject.schemaClass == 'CandidateSet' && not empty databaseObject.hasCandidate }">
    <fieldset class="fieldset-details">
        <legend>Components</legend>
        <c:if test="${databaseObject.schemaClass == 'Complex'}">
            <c:if test="${not empty databaseObject.hasComponent}">
                <div class="fieldset-pair-container">
                    <div class="label">Components of this complex</div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="hasComponent" items="${databaseObject.hasComponent}">
                                <li><a href="../detail/${hasComponent.stId}" class="" title="Show Details" rel="nofollow">${hasComponent.displayName} <c:if test="${not empty hasComponent.speciesName}">(${hasComponent.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'Polymer'}">
            <c:if test="${not empty databaseObject.repeatedUnit}">
                <div class="fieldset-pair-container">
                    <div class="label">Repeated Units of this Polymer</div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="repeatedUnit" items="${databaseObject.repeatedUnit}">
                                <li><a href="../detail/${repeatedUnit.stId}" class="" title="Show Details" rel="nofollow">${repeatedUnit.displayName} <c:if test="${not empty repeatedUnit.speciesName}">(${repeatedUnit.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${isEntitySet}">
            <c:if test="${not empty databaseObject.hasMember}">
                <div class="fieldset-pair-container">
                    <div class="label">Members of this Set</div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="hasMember" items="${databaseObject.hasMember}">
                                <li><a href="../detail/${hasMember.stId}" class="" title="Show Details" rel="nofollow">${hasMember.displayName} <c:if test="${not empty hasMember.speciesName}">(${hasMember.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'CandidateSet'}">
            <c:if test="${not empty databaseObject.hasCandidate}">
                <div class="fieldset-pair-container">
                    <div class="label">Candidates of this Set</div>
                    <div class="field">
                        <ul class="list">
                            <c:forEach var="hasCandidate" items="${databaseObject.hasCandidate}">
                                <li><a href="../detail/${hasCandidate.stId}" class="" title="Show Details" rel="nofollow">${hasCandidate.displayName} <c:if test="${not empty hasCandidate.speciesName}">(${hasCandidate.speciesName})</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:if>
        </c:if>
    </fieldset>
</c:if>

<%-- This entry is a component of --%>
<c:import url="componentOf.jsp"/>

<c:if test="${not empty databaseObject.negativelyRegulates || not empty databaseObject.positivelyRegulates}">
    <fieldset class="fieldset-details">
        <legend>This entity regulates</legend>
        <c:if test="${not empty databaseObject.negativelyRegulates}">
            <div class="fieldset-pair-container">
                <div class="label">Negative Regulation</div>
                <div class="field">
                    <ul class="list">
                        <c:forEach var="negativelyRegulates" items="${databaseObject.negativelyRegulates}">
                            <li>
                                <a href="../detail/${negativelyRegulates.stId}" class="" title="Show Details" rel="nofollow">${negativelyRegulates.displayName}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.positivelyRegulates}">
            <div class="fieldset-pair-container">
                <div class="label">Positive Regulation</div>
                <div class="field">
                    <ul class="list">
                        <c:forEach var="positivelyRegulates" items="${databaseObject.positivelyRegulates}">
                            <li>
                                <a href="../detail/${positivelyRegulates.stId}" class="" title="Show Details" rel="nofollow">${positivelyRegulates.displayName}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
    </fieldset>
</c:if>



<c:if test="${not empty otherFormsOfThisMolecule}">
    <fieldset class="fieldset-details">
        <legend>Other forms of this molecule</legend>

            <%--<div style="height: auto; max-height: 120px; overflow:auto;" class="padding">--%>
        <div class="wrap overflow">
            <table class="tabular">
                <tbody >
                <tr>
                    <c:forEach var="derivedEwas" items="${otherFormsOfThisMolecule}" varStatus="loop">
                    <c:if test="${not loop.first and loop.index % 4 == 0}">
                </tr><tr>
                    </c:if>

                    <td class="overme_3c"> <%--(${derivedEwas.compartment}) --%>
                        <a href="../detail/${derivedEwas.stId}" title="Open ${derivedEwas.displayName}" rel="nofollow">${derivedEwas.displayName}</a>
                    </td>
                    </c:forEach>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
</c:if>


<c:if test="${not empty databaseObject.inferredFrom}">
    <fieldset class="fieldset-details">
        <legend>Inferred From</legend>
        <div class="wrap">
            <ul class="overflow list">
                <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                    <li><a href="../detail/${inferredFrom.stId}" class="" title="Show Details" rel="nofollow">${inferredFrom.displayName} (${inferredFrom.speciesName})</a></li>
                </c:forEach>
            </ul>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.inferredTo}">
    <fieldset class="fieldset-details">
        <legend>Inferred To</legend>
        <div class="wrap">
            <ul class="overflow list">
                <c:forEach var="inferredTo" items="${databaseObject.inferredTo}">
                    <li><a href="../detail/${inferredTo.stId}" class="" title="Show Details" rel="nofollow">${inferredTo.displayName} (${inferredTo.speciesName})</a></li>
                </c:forEach>
            </ul>
        </div>
    </fieldset>

</c:if>



<c:if test="${databaseObject.schemaClass == 'EntityWithAccessionedSequence'}">
    <c:if test="${not empty databaseObject.hasModifiedResidue}">
        <fieldset class="fieldset-details">
            <legend>Modified Residues</legend>
            <div class="wrap">
                <table class="dt-fixed-header">
                    <thead>
                    <tr>
                        <th style="width:20px;">Name</th>
                        <th style="width:20px;">Coordinate</th>
                        <th style="width:20px;">Modification</th>
                        <th style="width:200px;">PsiMod</th>
                    </tr>
                    </thead>
                </table>
                <div class="dt-content-ovf">
                    <table>
                        <tbody>
                        <c:forEach var="modifiedResidue" items="${databaseObject.hasModifiedResidue}">
                            <tr>
                                <td style="vertical-align: middle; width:25px;">${modifiedResidue.displayName}</td>
                                <c:if test="${modifiedResidue.schemaClass != 'FragmentReplacedModification' && modifiedResidue.schemaClass != 'FragmentDeletionModification' && modifiedResidue.schemaClass != 'FragmentInsertionModification'}">
                                    <td style="vertical-align: middle; width:25px;">${modifiedResidue.coordinate}</td>
                                    <c:choose>
                                        <c:when test="${modifiedResidue.schemaClass == 'InterChainCrosslinkedResidue' || modifiedResidue.schemaClass == 'IntraChainCrosslinkedResidue' || modifiedResidue.schemaClass == 'GroupModifiedResidue'}">
                                            <td style="width:25px;"><c:if test="${not empty modifiedResidue.modification.displayName}"><a href="../detail/${modifiedResidue.modification.stId}" class="" title="Show Details" rel="nofollow">${modifiedResidue.modification.displayName}</a></c:if></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td style="width:25px;"></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td style="padding: 0px; width:225px;">
                                        <table border="0" class="psiModTable">
                                            <tbody>
                                                <%-- TODO: Improve here, the question is - how ? --%>
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
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </fieldset>
    </c:if>
</c:if>