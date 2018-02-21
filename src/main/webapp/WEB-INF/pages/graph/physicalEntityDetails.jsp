<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="do" uri="/WEB-INF/tags/sortTag.tld" %>

<c:if test="${hasReferenceEntity}">
    <c:if test="${not empty databaseObject.referenceEntity}">
        <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>External Reference Information</legend>

                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">External Reference</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <a href="${databaseObject.referenceEntity.url}" class="" title="Go to External Reference">${databaseObject.referenceEntity.displayName}</a>
                        </div>
                    </div>

                    <c:if test="${isReferenceSequence}">
                        <c:if test="${not empty databaseObject.referenceEntity.geneName}">
                            <div>
                                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Gene Names</div>
                                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                    <div>
                                    <c:forEach var="geneName" items="${databaseObject.referenceEntity.geneName}" varStatus="loop">
                                        ${geneName}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:if>

                    <c:if test="${databaseObject.referenceType == 'ReferenceGeneProduct'}">
                        <c:if test="${not empty databaseObject.referenceEntity.chain}">
                            <div class="favth-clearfix">
                                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Chain</div>
                                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                    <div>
                                    <c:forEach var="chain" items="${databaseObject.referenceEntity.chain}" varStatus="loop">
                                        ${chain}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty databaseObject.referenceEntity.referenceGene}">
                            <div class="favth-clearfix">
                                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Reference Genes</div>
                                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                    <div class="wrap">
                                        <c:forEach var="referenceGene" items="${do:sortByDisplayName(databaseObject.referenceEntity.referenceGene)}" varStatus="loop">
                                            <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                                                <a href="${referenceGene.url}" title="show ${referenceGene.displayName}" >${referenceGene.displayName}</a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty databaseObject.referenceEntity.referenceTranscript}">
                            <div class="favth-clearfix">
                                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Reference Transcript</div>
                                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                    <div>
                                        <ul class="list">
                                            <c:forEach var="referenceTranscript" items="${databaseObject.referenceEntity.referenceTranscript}">
                                                <li><a href="${referenceTranscript.url}" title="show ${referenceTranscript.displayName}" >${referenceTranscript.displayName}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:if>

                    <c:if test="${not empty databaseObject.referenceEntity.otherIdentifier}">
                        <div class="favth-clearfix">
                            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Other Identifiers</div>
                            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                <div class="wrap">
                                    <c:forEach var="otherIdentifier" items="${databaseObject.referenceEntity.otherIdentifier}">
                                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                                            ${otherIdentifier}
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </fieldset>
        </div>
    </c:if>
</c:if>

<c:if test="${ databaseObject.schemaClass == 'Complex' &&  not empty databaseObject.hasComponent || databaseObject.schemaClass == 'Polymer' && not empty databaseObject.repeatedUnit || isEntitySet && not empty databaseObject.hasMember || databaseObject.schemaClass == 'CandidateSet' && not empty databaseObject.hasCandidate }">
    <fieldset class="fieldset-details">
        <legend>Participants</legend>
        <c:if test="${databaseObject.schemaClass == 'Complex'}">
            <c:if test="${not empty databaseObject.hasComponent}">
                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">components</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div>
                                <ul class="list">
                                    <c:forEach var="hasComponent" items="${databaseObject.fetchHasComponent()}">
                                        <li>
                                            <i class="sprite sprite-resize sprite-${hasComponent.object.schemaClass} sprite-position" title="${hasComponent.object.schemaClass}"></i>
                                            <c:if test="${hasComponent.stoichiometry gt 1}">${hasComponent.stoichiometry} x </c:if>
                                            <a href="../detail/${hasComponent.object.stId}" class="" title="Show Details" >${hasComponent.object.displayName} <c:if test="${not empty hasComponent.object.speciesName}">(${hasComponent.object.speciesName})</c:if></a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'Polymer'}">
            <c:if test="${not empty databaseObject.repeatedUnit}">
                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">repeated unit</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div>
                                <ul class="list">
                                    <li>
                                        <i class="sprite sprite-resize sprite-${databaseObject.fetchRepeatedUnit().object.schemaClass} sprite-position" title="${databaseObject.fetchRepeatedUnit().object.schemaClass}"></i>
                                        <c:if test="${databaseObject.fetchRepeatedUnit().stoichiometry gt 1}">${databaseObject.fetchRepeatedUnit().stoichiometry} x </c:if>
                                        <a href="../detail/${databaseObject.fetchRepeatedUnit().object.stId}" class="" title="Show Details" >${databaseObject.fetchRepeatedUnit().object.displayName} <c:if test="${not empty databaseObject.fetchRepeatedUnit().object.speciesName}">(${databaseObject.fetchRepeatedUnit().object.speciesName})</c:if></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${isEntitySet}">
            <c:if test="${not empty databaseObject.hasMember}">
                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">members</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div>
                                <ul class="list">
                                    <c:forEach var="hasMember" items="${databaseObject.hasMember}">
                                        <li>
                                            <i class="sprite sprite-resize sprite-${hasMember.schemaClass} sprite-position" title="${hasMember.schemaClass}"></i>
                                            <a href="../detail/${hasMember.stId}" class="" title="Show Details" >${hasMember.displayName} <c:if test="${not empty hasMember.speciesName}">(${hasMember.speciesName})</c:if></a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'CandidateSet'}">
            <c:if test="${not empty databaseObject.hasCandidate}">
                <div class="fieldset-pair-container">
                    <div class="favth-clearfix">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">candidates</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div>
                                <ul class="list">
                                    <c:forEach var="hasCandidate" items="${databaseObject.hasCandidate}">
                                        <li>
                                            <i class="sprite sprite-resize sprite-${hasCandidate.schemaClass} sprite-position" title="${hasCandidate.schemaClass}"></i>
                                            <a href="../detail/${hasCandidate.stId}" title="Show Details" >${hasCandidate.displayName} <c:if test="${not empty hasCandidate.speciesName}">(${hasCandidate.speciesName})</c:if></a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
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
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Negative Regulation</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="negativelyRegulates" items="${databaseObject.negativelyRegulates}">
                                    <li>
                                        <a href="../detail/${negativelyRegulates.stId}" class="" title="Show Details" >${negativelyRegulates.displayName}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.positivelyRegulates}">
            <div class="fieldset-pair-container">
                <div class="favth-clearfix">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Positive Regulation</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="positivelyRegulates" items="${databaseObject.positivelyRegulates}">
                                    <li>
                                        <a href="../detail/${positivelyRegulates.stId}" class="" title="Show Details" >${positivelyRegulates.displayName}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </fieldset>
</c:if>

<c:if test="${not empty otherFormsOfThisMolecule}">
    <fieldset class="fieldset-details">
        <legend>Other forms of this molecule</legend>
        <div class="wrap overflow favth-clearfix">
            <c:forEach var="derivedEwas" items="${otherFormsOfThisMolecule}" varStatus="loop">
                <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                    <a href="../detail/${derivedEwas.stId}" title="Open ${derivedEwas.displayName}" >${derivedEwas.displayName}</a>
                </div>
            </c:forEach>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.inferredFrom}">
    <fieldset class="fieldset-details">
        <legend>Inferred From</legend>
        <div class="wrap overflow favth-clearfix">
            <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                    <a href="../detail/${inferredFrom.stId}" class="" title="Show Details" >${inferredFrom.displayName} <c:if test="${not empty inferredFrom.speciesName}"> (${inferredFrom.speciesName})</c:if></a>
                </div>
            </c:forEach>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty inferredTo}">
    <fieldset class="fieldset-details">
        <legend>Inferred To</legend>
        <div class="wrap overflow favth-clearfix">
            <c:forEach items="${inferredTo}" var="inferredToMap">
                <c:forEach items="${inferredToMap.value}" var="inferredTo">
                    <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                        <a href="../detail/${inferredTo.stId}" class="" title="Show Details" >${inferredTo.displayName} <c:if test="${not empty inferredTo.speciesName}"> (${inferredTo.speciesName})</c:if></a>
                    </div>
                </c:forEach>
            </c:forEach>
        </div>
    </fieldset>
</c:if>

<c:if test="${databaseObject.schemaClass == 'EntityWithAccessionedSequence'}">
    <c:if test="${not empty databaseObject.hasModifiedResidue}">
        <fieldset class="fieldset-details">
            <legend>Modified Residues</legend>
            <div class="fieldset-pair-container overflow300">
                <c:forEach var="modifiedResidue" items="${databaseObject.hasModifiedResidue}">
                    <div class="favth-clearfix modified-residue">
                        <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">Name</div>
                        <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">${modifiedResidue.displayName}</div>

                        <c:if test="${modifiedResidue.schemaClass != 'FragmentReplacedModification' &&
                                      modifiedResidue.schemaClass != 'FragmentDeletionModification' &&
                                      modifiedResidue.schemaClass != 'FragmentInsertionModification'}">

                            <c:if test="${not empty modifiedResidue.coordinate}">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">Coordinate</div>
                                <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">${modifiedResidue.coordinate}</div>
                            </c:if>

                            <c:if test="${modifiedResidue.schemaClass == 'CrosslinkedResidue' || modifiedResidue.schemaClass == 'GroupModifiedResidue'}">
                                <c:if test="${not empty modifiedResidue.modification.displayName}">
                                    <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">Modification</div>
                                    <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                        <c:catch var="hasUrl">
                                            <c:set value="${modifiedResidue.modification.url}" var="url" />
                                        </c:catch>
                                        <c:choose>
                                            <c:when test="${empty hasUrl}">
                                                <a href="../detail/${url}" class="" title="Show Details" >${modifiedResidue.modification.displayName}</a>
                                            </c:when>
                                            <c:otherwise>
                                                ${modifiedResidue.modification.displayName}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>
                            </c:if>

                            <c:choose>
                                <c:when test="${modifiedResidue.psiMod.getClass().getSimpleName() == 'ArrayList'}">
                                    <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">PsiMod HEY</div>
                                    <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                    <c:forEach var="psiMod" items="${modifiedResidue.psiMod}" varStatus="loop">
                                        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 details-field mr-field mr-psi-field" style="border-top: 1px dotted #c8c8c8;">
                                            <div class="favth-col-lg-4 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 details-field mr-field  mr-psi-field">
                                                <c:if test="${not empty psiMod.displayName}">
                                                    <a href="${psiMod.url}" class="" title="Show Details" >${psiMod.displayName}</a>
                                                </c:if>
                                            </div>
                                            <div class="favth-col-lg-8 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 details-field mr-field  mr-psi-field">
                                                <c:if test="${not empty psiMod.definition}">
                                                    ${psiMod.definition}
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </div>

                                </c:when>
                                <c:otherwise>
                                    <div class="favth-row favth-clearfix">
                                        <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">PsiMod Name</div>
                                        <div class="favth-col-lg-10 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                            <c:if test="${not empty modifiedResidue.psiMod.displayName}">
                                                <a href="${modifiedResidue.psiMod.url}" class="" title="Show Details" >${modifiedResidue.psiMod.displayName}</a>
                                            </c:if>
                                        </div>
                                        <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">PsiMod Definition</div>
                                        <div class="favth-col-lg-10 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 details-field mr-field">
                                            <c:if test="${not empty modifiedResidue.psiMod.definition}">
                                                ${modifiedResidue.psiMod.definition}
                                            </c:if>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                        <c:if test="${modifiedResidue.schemaClass == 'FragmentInsertionModification'}">
                            <c:if test="${not empty modifiedResidue.coordinate}">
                                <div class="favth-col-lg-2 favth-col-md-3 favth-col-sm-12 favth-col-xs-12 details-label mr-label">Coordinate</div>
                                <div class="favth-col-lg-10 favth-col-md-9 favth-col-sm-12 favth-col-xs-12 details-field mr-field">${modifiedResidue.coordinate}</div>
                            </c:if>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </fieldset>
    </c:if>
</c:if>