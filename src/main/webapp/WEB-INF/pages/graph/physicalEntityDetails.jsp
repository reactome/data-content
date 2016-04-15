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
                </tbody>
            </table>
        </div>
    </div>
</c:if>





<%--<c:if test="${not empty databaseObject.referenceEntity || not empty databaseObject.goMolecularComponent}">--%>
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
        <c:if test="${databaseObject.schemaClass == 'EntityWithAccessionedSequence' || databaseObject.schemaClass == 'SimpleEntity' || databaseObject.schemaClass == 'OpenSet'}">
            <c:if test="${not empty databaseObject.referenceEntity}">
                <c:if test="${not empty databaseObject.referenceEntity.name}">
                    <tr>
                        <td><strong>External reference names</strong></td>
                        <td class="block">
                            <c:forEach var="name" items="${databaseObject.referenceEntity.name}"
                                       varStatus="loop">${name}<c:if test="${!loop.last}">, </c:if></c:forEach>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not empty databaseObject.referenceEntity.identifier}">
                    <tr>
                        <td><strong>External reference id</strong></td>
                        <td><a href="${databaseObject.referenceEntity.url}" class="" title="Show Details"
                               rel="show ${databaseObject.referenceEntity.identifier}"> ${databaseObject.referenceEntity.identifier}</a>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not empty databaseObject.name}">
                    <tr>
                        <td><strong>Synonyms</strong></td>
                        <td class="block">
                            <c:forEach var="synonym" items="${databaseObject.name}" varStatus="loop">${synonym}<c:if test="${!loop.last}">, </c:if></c:forEach>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not empty databaseObject.referenceEntity.otherIdentifier}">
                    <tr>
                        <td><strong>Other Identifiers</strong></td>
                        <td style="padding: 0px;">
                            <div style="height: auto; max-height: 120px; overflow: auto; padding-top: 1px; padding-left: 2px;">
                                <table border="0" width="100%" style="border: 0px;">
                                    <tr>
                                        <c:forEach var="otherIdentifier"
                                                   items="${databaseObject.referenceEntity.otherIdentifier}"
                                                   varStatus="loop">
                                        <c:if test="${not loop.first and loop.index % 5 == 0}">
                                    </tr>
                                    <tr>
                                        </c:if>
                                        <td class="overme_5c">
                                            <span title="${otherIdentifier}">&nbsp;${otherIdentifier}</span>
                                        </td>
                                        </c:forEach>
                                </table>
                            </div>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${databaseObject.referenceType == 'ReferenceDNASequence' ||
                              databaseObject.referenceType == 'ReferenceGeneProduct' ||
                              databaseObject.referenceType == 'ReferenceIsoform'  ||
                              databaseObject.referenceType == 'ReferenceRNASequence'}">
                    <c:if test="${not empty databaseObject.referenceEntity.secondaryIdentifier}">
                        <tr>
                            <td><strong>Secondary Identifiers</strong></td>
                            <td>
                                <c:forEach var="secondaryIdentifier"
                                           items="${databaseObject.referenceEntity.secondaryIdentifier}"
                                           varStatus="loop">${secondaryIdentifier}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty databaseObject.referenceEntity.geneName}">
                        <tr>
                            <td><strong>Gene Names</strong></td>
                            <td>
                                <c:forEach var="geneName" items="${databaseObject.referenceEntity.geneName}"
                                           varStatus="loop">${geneName}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                </c:if>
                <c:if test="${databaseObject.referenceType == 'ReferenceGeneProduct'}">
                    <c:if test="${not empty databaseObject.referenceEntity.chain}">
                        <tr>
                            <td><strong>Chain</strong></td>
                            <td>
                                <c:forEach var="chain" items="${databaseObject.referenceEntity.chain}"
                                           varStatus="loop">${chain}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                </c:if>
            </c:if>
        </c:if>
        <c:if test="${not empty databaseObject.goCellularComponent}">
            <tr>
                <td><strong>GO Molecular Component</strong></td>
                <td>
                    <ul class="list overflowList">
                        <c:forEach var="goMolecularComponent" items="${databaseObject.goCellularComponent}">
                            <li><a href="${goMolecularComponent.database.url}" class="" title="show "
                                   rel="nofollow">${goMolecularComponent.name}</a>( ${goMolecularComponent.accession})
                            </li>
                        </c:forEach>
                    </ul>
                </td>
            </tr>
        </c:if>


        </tbody>
    </table>
</div>
<%--</c:if>--%>

<c:if test="${databaseObject.referenceType == 'ReferenceGeneProduct'}">
    <c:if test="${not empty databaseObject.referenceEntity.referenceGene}">
        <div class="grid_23  padding  margin">
            <h5>Reference Genes</h5>
            <table class="fixedTable">
                <thead>
                <tr class="tableHead">
                    <td>Database</td>
                    <td>Identifier</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="referenceGene" items="${databaseObject.referenceEntity.referenceGene}">
                    <tr>
                        <td><strong>${referenceGene.databaseName}</strong></td>
                        <td>
                            <%--<c:forEach var="value" items="${referenceGenes.value}" varStatus="loop">--%>
                                <%--<a href="${value.database.url}" title="show ${value.database.name}"--%>
                                   <%--rel="nofollow">${value.identifier}</a><c:if test="${!loop.last}">, </c:if>--%>
                            <%--</c:forEach>--%>
                            <a href="${referenceGene.url}" title="show ${referenceGene.displayName}"
                                   rel="nofollow">${referenceGene.identifier}</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>



    <c:if test="${not empty databaseObject.referenceEntity.referenceTranscript}">
        <div class="grid_23  padding  margin">
            <h5>Reference Transcripts</h5>
            <table class="fixedTable">
                <thead>
                <tr class="tableHead">
                    <td>Database</td>
                    <td>Identifier</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="referenceTranscript" items="${databaseObject.referenceEntity.referenceTranscript}">
                    <tr>
                        <td><strong>${referenceTranscript.databaseName}</strong></td>
                        <td>
                            <%--<c:forEach var="value" items="${referenceTranscript.value}" varStatus="loop">--%>
                                <%--<a href="${value.database.url}" title="show ${value.database.name}"--%>
                                   <%--rel="nofollow">${value.identifier}</a><c:if test="${!loop.last}">, </c:if>--%>
                            <%--</c:forEach>--%>
                            <%--<c:forEach var="value" items="${referenceTranscript.value}" varStatus="loop">--%>
                                <a href="${referenceTranscript.url}" title="show ${referenceTranscript.displayName}"
                                   rel="nofollow">${referenceTranscript.identifier}</a>
                            <%--</c:forEach>--%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</c:if>

<%--<c:if test="${databaseObject.schemaClass == 'Complex'}">--%>
    <%--<c:if test="${not empty databaseObject.hasComponent}">--%>
        <%--<div class="grid_23  padding  margin">--%>
            <%--<h5>Components of this databaseObject</h5>--%>
            <%--<table class="fixedTable">--%>
                <%--<thead>--%>
                <%--<tr class="tableHead">--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <%--<tbody>--%>
                <%--<tr>--%>
                    <%--<td><strong>Components entries</strong></td>--%>
                    <%--<td>--%>
                        <%--<ul class="list overflowList">--%>
                            <%--<c:forEach var="component" items="${databaseObject.hasComponent}">--%>
                                <%--<li><a href="../detail/${component.stableIdentifier}" class="" title="show Reactome"--%>
                                       <%--rel="nofollow">${component.name} <c:if--%>
                                        <%--test="${not empty component.species}">(${component.species})</c:if></a></li>--%>
                            <%--</c:forEach>--%>
                        <%--</ul>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</div>--%>
    <%--</c:if>--%>
<%--</c:if>--%>

<%--<c:if test="${databaseObject.schemaClass == 'CandidateSet'}">--%>
    <%--<c:if test="${not empty databaseObject.hasCandidate}">--%>
        <%--<div class="grid_23  padding  margin">--%>
            <%--<h5>Components of this databaseObject</h5>--%>
            <%--<table class="fixedTable">--%>
                <%--<thead>--%>
                <%--<tr class="tableHead">--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <%--<tbody>--%>
                <%--<tr>--%>
                    <%--<td><strong>CandidateSet entries</strong></td>--%>
                    <%--<td>--%>
                        <%--<ul class="list overflowList">--%>
                            <%--<c:forEach var="candidates" items="${databaseObject.hasCandidate}">--%>
                                <%--<li><a href="../detail/${candidates.stableIdentifier}" class=""--%>
                                       <%--title="show Reactome ${candidates.stableIdentifier}"--%>
                                       <%--rel="nofollow">${candidates.name} <c:if--%>
                                        <%--test="${not empty candidates.species}">(${candidates.species})</c:if></a></li>--%>
                            <%--</c:forEach>--%>
                        <%--</ul>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</div>--%>
    <%--</c:if>--%>
<%--</c:if>--%>


<%--<c:if test="${databaseObject.schemaClass == 'CandidateSet'  || databaseObject.schemaClass == 'DefinedSet' || databaseObject.schemaClass == 'OpenSet'}">--%>
    <%--<c:if test="${not empty databaseObject.hasMember}">--%>
        <%--<div class="grid_23  padding  margin">--%>
            <%--<h5>Components of this databaseObject</h5>--%>
            <%--<table class="fixedTable">--%>
                <%--<thead>--%>
                <%--<tr class="tableHead">--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <%--<tbody>--%>
                <%--<tr>--%>
                    <%--<td><strong>Member</strong></td>--%>
                    <%--<td>--%>
                        <%--<ul class="list overflowList">--%>
                            <%--<c:forEach var="member" items="${databaseObject.hasMember}">--%>
                                <%--<li><a href="../detail/${member.stableIdentifier}" class=""--%>
                                       <%--title="show Reactome ${member.stableIdentifier}" rel="nofollow">${member.name}--%>
                                    <%--<c:if test="${not empty member.species}">(${member.species})</c:if></a></li>--%>
                            <%--</c:forEach>--%>
                        <%--</ul>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</div>--%>
    <%--</c:if>--%>
<%--</c:if>--%>


<%--<c:if test="${databaseObject.schemaClass == 'RepeatedUnit'}">--%>
    <%--<c:if test="${not empty databaseObject.repeatedUnit}">--%>
        <%--<div class="grid_23  padding  margin">--%>
            <%--<h5>Components of this databaseObject</h5>--%>
            <%--<table class="fixedTable">--%>
                <%--<thead>--%>
                <%--<tr class="tableHead">--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <%--<tbody>--%>
                <%--<tr>--%>
                    <%--<td><strong>repeatedUnits</strong></td>--%>
                    <%--<td>--%>
                        <%--<ul class="list overflowList">--%>
                            <%--<c:forEach var="repeatedUnit" items="${databaseObject.repeatedUnit}">--%>
                                <%--<li><a href="../detail/${repeatedUnit.stableIdentifier}" class=""--%>
                                       <%--title="show Reactome ${repeatedUnit.stableIdentifier}"--%>
                                       <%--rel="nofollow">${repeatedUnit.name}</a></li>--%>
                            <%--</c:forEach>--%>
                        <%--</ul>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</div>--%>
    <%--</c:if>--%>
<%--</c:if>--%>
