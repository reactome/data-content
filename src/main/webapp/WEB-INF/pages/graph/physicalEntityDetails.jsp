



<c:if test="${not empty entry.referenceEntity || not empty entry.compartments || not empty entry.synonyms || not empty entry.reverseReaction || not empty entry.goBiologicalProcess || not empty entry.goMolecularComponent}">
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
            <c:if test="${not empty entry.referenceEntity}">
                <c:if test="${not empty entry.referenceEntity.referenceName}">
                    <tr>
                        <td><strong>External reference name</strong></td>
                        <td><a href="${entry.referenceEntity.database.url}" class="" title="Show Details" rel="show ${entry.referenceEntity.database.url}"> ${entry.referenceEntity.referenceName}</a></td>
                    </tr>
                </c:if>
                <c:if test="${not empty entry.referenceEntity.referenceIdentifier}">
                    <tr>
                        <td><strong>External reference id</strong></td>
                        <td><a href="${entry.referenceEntity.database.url}" class="" title="Show Details" rel="show ${entry.referenceEntity.database.url}"> ${entry.referenceEntity.referenceIdentifier}</a></td>
                    </tr>
                </c:if>
                <c:if test="${not empty entry.referenceEntity.referenceSynonyms}">
                    <tr>
                        <td><strong>external Synonyms</strong></td>
                        <td class="block">
                            <c:forEach var="synonym" items="${entry.referenceEntity.referenceSynonyms}" varStatus="loop">${synonym}<c:if test="${!loop.last}">, </c:if></c:forEach>
                        </td>
                    </tr>
                </c:if>
            </c:if>
            <c:if test="${not empty entry.synonyms}">
                <tr>
                    <td><strong>Synonyms</strong></td>
                    <td class="block">
                        <c:forEach var="synonym" items="${entry.synonyms}" varStatus="loop">${synonym}<c:if test="${!loop.last}">, </c:if></c:forEach>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty entry.compartments}">
                <tr>
                    <td><strong>Compartment</strong></td>
                    <td>
                        <c:forEach var="compartment" items="${entry.compartments}" varStatus="loop">
                            <span><a href="${compartment.database.url}" title="show ${compartment.database.name}" rel="nofollow">${compartment.name}</a></span>
                            <c:if test="${!loop.last}">, </c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty entry.reverseReaction}">
                <tr>
                    <td><strong>Reverse Reaction</strong></td>
                    <td>
                        <a href="../detail/${entry.reverseReaction.stId}" class="" title="show Reactome ${entry.reverseReaction.stId}" rel="nofollow">${entry.reverseReaction.name}</a>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty entry.referenceEntity}">
                <c:if test="${not empty entry.referenceEntity.otherIdentifier}">
                    <tr>
                        <td><strong>Other Identifiers</strong></td>
                        <td style="padding: 0px;">
                            <div style="height: auto; max-height: 120px; overflow: auto; padding-top: 1px; padding-left: 2px;">
                                <table border="0" width="100%" style="border: 0px;">
                                    <tr>
                                        <c:forEach var="otherIdentifier" items="${entry.referenceEntity.otherIdentifier}" varStatus="loop">
                                        <c:if test="${not loop.first and loop.index % 5 == 0}">
                                    </tr><tr>
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
                <c:if test="${not empty entry.referenceEntity.secondaryIdentifier}">
                    <tr>
                        <td><strong>Secondary Identifiers</strong></td>
                        <td>
                            <c:forEach var="secondaryIdentifier" items="${entry.referenceEntity.secondaryIdentifier}" varStatus="loop">${secondaryIdentifier}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not empty entry.referenceEntity.geneNames}">
                    <tr>
                        <td><strong>Gene Names</strong></td>
                        <td>
                            <c:forEach var="geneNames" items="${entry.referenceEntity.geneNames}" varStatus="loop">${geneNames}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${not empty entry.referenceEntity.chain}">
                    <tr>
                        <td><strong>Chain</strong></td>
                        <td>
                            <c:forEach var="chain" items="${entry.referenceEntity.chain}" varStatus="loop">${chain}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                </c:if>
            </c:if>
            <c:if test="${not empty entry.goMolecularComponent}">
                <tr>
                    <td><strong>GO Molecular Component</strong></td>
                    <td>
                        <ul class="list overflowList">
                            <c:forEach var="goMolecularComponent" items="${entry.goMolecularComponent}">
                                <li><a href="${goMolecularComponent.database.url}" class=""  title="show ${goMolecularComponent.database.name}" rel="nofollow">${goMolecularComponent.name}</a>( ${goMolecularComponent.accession})</li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty entry.goBiologicalProcess}">
                <tr>
                    <td><strong>GO Biological Process</strong></td>
                    <td><a href="${entry.goBiologicalProcess.database.url}" class=""  title="go to ${entry.goBiologicalProcess.database.name}" rel="nofollow">${entry.goBiologicalProcess.name} (${entry.goBiologicalProcess.accession})</a></td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</c:if>