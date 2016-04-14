



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

      <c:if test="${not empty entry.reverseReaction}">
        <tr>
          <td><strong>Reverse Reaction</strong></td>
          <td>
            <a href="../detail/${entry.reverseReaction.stId}" class="" title="show Reactome ${entry.reverseReaction.stId}" rel="nofollow">${entry.reverseReaction.name}</a>
          </td>
        </tr>
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