<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/modelTags.tld" prefix="m" %>

<c:choose>
    <c:when test="${not empty widget}">
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>
    </c:when>
    <c:otherwise>
        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>
    </c:otherwise>
</c:choose>

<div class="favth-col-xs-12 ">
    <h3 class="details-title">
        <i class="sprite sprite-Interactor" title="${referenceEntity.displayName}"></i>
        ${referenceEntity.displayName}
    </h3>
    <div class="extended-header favth-clearfix">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Type</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>Interactor (${referenceEntityType})</span>
        </div>
        <c:catch var="hasSpeciesException">
            <c:set value="${referenceEntity.species.displayName}" var="species" scope="request"/>
        </c:catch>
        <c:if test="${empty hasSpeciesException && not empty referenceEntity.species}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Species</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <span>${species}</span>
            </div>
        </c:if>
        <c:if test="${not empty referenceEntitySynonym}">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Synonyms</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div>
                    <c:forEach var="synonym" items="${referenceEntitySynonym}" varStatus="loop">
                        ${synonym}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <fieldset class="fieldset-details">
        <div class="alert alert-info" style="margin: 5px;">
            <i class="fa fa-info-circle"></i>List of interactors in Reactome
        </div>
        <legend>Interactors (${fn:length(interactions)})</legend>
        <div id="r-responsive-table" class="interactors-table">
            <table class="reactome interactor-detail-table">
                <thead>
                <tr>
                    <th scope="col">Accession</th>
                    <th scope="col">#Entities</th>
                    <th scope="col">Reactome Entity</th>
                    <th scope="col">Confidence Score</th>
                    <th scope="col">Evidence (IntAct)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="interaction" items="${interactions}">
                    <tr>
                        <td data-label="Accession">
                            <a href="${interaction.accessionURL}" class="" target="_blank"
                               title="Show ${interaction.accession}">${interaction.accession}</a>
                        </td>
                        <td data-label="#Entities" style="text-align: right;">
                                ${fn:length(interaction.physicalEntity)}
                        </td>
                        <td data-label="Reactome Entry">
                            <ul class="list">
                                <c:forEach var="interactor" items="${interaction.physicalEntity}">
                                    <li>
                                        <m:link object="${interactor}" detailRequestPrefix="${detailRequestPrefix}"
                                                   displayStId="true"
                                                   getParameters="interactor=${referenceEntity.displayName}"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </td>
                        <td data-label="Confidence Score">${interaction.score}</td>
                        <td data-label="Evidence (IntAct)">
                            <a href="${interaction.url}" title="Open evidence in IntAct"
                               target="_blank">${interaction.evidences}</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>
