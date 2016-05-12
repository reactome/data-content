<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="databaseObject" type="org.reactome.server.graph.domain.model.Pathway"--%>
<%--@elvariable id="literature" type="org.reactome.server.graph.domain.model.LiteratureReference"--%>

<c:import url="../header.jsp"/>

<div class="ebi-content">

    <c:import url="title.jsp"/>


    <div class="grid_24">


        <c:if test="${not empty databaseObject.literatureReference}">
            <c:import url="literatureReferences.jsp"/>
        </c:if>

        <c:if test="${clazz == 'PhysicalEntity'}">
            <c:import url="physicalEntityDetails.jsp"/>
        </c:if>

        <c:if test="${clazz == 'Event'}">
            <c:import url="eventDetails.jsp"/>
        </c:if>

        <c:import url="generalAttributes.jsp"/>

        <c:if test="${clazz == 'Regulation'}">
            <c:import url="regulationDetails.jsp"/>
        </c:if>

        <c:if test="${not empty interactions}">
            <c:import url="interactionDetails.jsp"/>
        </c:if>
    </div>
</div>


<div class="clear"></div>

<%-- Adding some fixed spaces between last content panel and footer --%>
<div style="height: 40px;">&nbsp;</div>

</div>            <%--A weird thing to avoid problems--%>
<c:import url="../footer.jsp"/>


<%--
ALIGNED DIV MODEL WITH ORANGE BORDER

<div class="fieldset-pair-container">
    <div class="label"></div>
    <div class="field"></div>
    <div class="clear"></div>
</div>
--%>