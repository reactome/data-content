<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../header.jsp"/>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">

<h3 class="details-title">
    <i class="sprite sprite-${entry.exactType}" title="${entry.exactType}"></i> ${entry.name}
</h3>

<div class="extended-header favth-clearfix">
    <c:if test="${not empty entry.iconGroup}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Group</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span><a href="${pageContext.request.contextPath}/icon-lib/${entry.iconGroup}">${entry.iconGroup}</a></span>
        </div>
    </c:if>

    <c:if test="${not empty entry.iconCuratorName}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Curator</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${entry.iconCuratorName}</span>
        </div>
    </c:if>

    <c:if test="${not empty entry.iconDesignerName}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Designer</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${entry.iconDesignerName}</span>
        </div>
    </c:if>

    <c:if test="${not empty entry.iconDesignerName}">
        <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
            <span>Description</span>
        </div>
        <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
            <span>${entry.summation}</span>
        </div>
    </c:if>
</div>

<fieldset class="fieldset-details">
    <legend>Icon preview</legend>
    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-3 favth-col-xs-12 text-center">
        <a href="#">
            <img class="icon-preview" src="/ehld-icons/lib/${entry.iconGroup}/${fn:escapeXml(entry.name)}.svg" alt="${entry.name}" />
        </a>
    </div>
    <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-9 favth-col-xs-12">
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
            <span><a href="${pageContext.request.contextPath}/icon-lib/download/${entry.iconName}.svg"><i class="fa fa-download"></i> SVG</a></span>
        </div>
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
            <span><a href="${pageContext.request.contextPath}/icon-lib/download/${entry.iconName}.png"><i class="fa fa-download"></i> PNG</a></span>
        </div>
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
            <span><a href="${pageContext.request.contextPath}/icon-lib/download/${entry.iconName}.emf"><i class="fa fa-download"></i> EMF</a></span>
        </div>
    </div>
</fieldset>

<c:if test="${not empty entry.iconEhlds}">
    <fieldset class="fieldset-details">
        <legend>Pathways</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="ehld" items="${entry.iconEhlds}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                            <a href="../${ehld}">${ehld}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty entry.iconCVTerms}">
    <fieldset class="fieldset-details">
        <legend>CV Terms</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="term" items="${entry.iconCVTerms}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                            <a href="">${term}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty entry.iconXRefs}">
    <fieldset class="fieldset-details">
        <legend>Cross References</legend>
        <div class="fieldset-pair-container">
            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <div class="wrap">
                    <c:forEach var="xref" items="${entry.iconXRefs}">
                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                            <a href="">${xref}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </fieldset>
</c:if>


<%--<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">--%>
    <%--<c:import url="disclaimer.jsp"/>--%>
<%--</div>--%>

<c:import url="../footer.jsp"/>