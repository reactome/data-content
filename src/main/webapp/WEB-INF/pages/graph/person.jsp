<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<c:import url="../header.jsp"/>

<style>
    .ui-widget .ui-widget {
        font-size: 0.5em !important;
    }

    .ui-widget-overlay {
        background: repeat-x scroll 50% 50% #AAA !important;
        opacity:0.3;
    }

    .ui-widget-header {
        border: none !important;
        background: #2F9EC2 !important;
        color: #FFF !important;
        font-weight: bold !important;
    }

    .ui-progressbar .ui-progressbar-value {
        height: 104% !important;
        width: 101% !important;
    }
</style>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/hot-sneaks/jquery-ui.css" />

<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession" />

<c:if test="${not empty tokenSession}">
    <%--<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 text-right">--%>
        <%--<img src="https://orcid.org/sites/default/files/images/orcid_24x24.png" width="16" height="16" alt="ORCID iD icon"/> <span style="font-size: 10px;">${tokenSession.name} ( <a href="#" class="orcid-signout"><i class="fa fa-sign-out" style="font-size: 12px; padding: 0;" aria-hidden="true"></i> Logout</a> )</span>--%>
    <%--</div>--%>

    <div id="dialog" title="Claiming works..." style="display: none;">
        <p><span style="font-size: 1.2em;">Please wait while works are claimed</span></p>
        <p class="text-center"><span style="font-size: 0.7em;">Note: This may take few seconds. Do not close this window.</span></p>
        <p></p>
        <div id="progressbar"></div>
    </div>

    <div id="dialog-summary" title="Claiming Summary" style="display: none;">
        <h3>Synchronization has finished</h3>
        <div style="background: #f0f0f0; padding: 8px; border: 1px solid darkgray; border-radius: 0 10px 0 10px;">
            <span>Total: </span><span class="total"></span><br/>
            <span>&nbsp;&nbsp;New: </span><span class="total-created"></span><br/>
            <span>&nbsp;&nbsp;Conflict: </span><span class="total-conflict"></span><br/>
            <span>&nbsp;&nbsp;Errors: </span><span class="total-errors"></span><br/>
        </div>
        <p class="text-right"><a href="https://orcid.org/${tokenSession.orcid}" target="_blank" rel="nofollow noindex"><span style="font-size:12px;">Visit your Orcid page</span></a></p>
    </div>

</c:if>

<div id="dialog-expired" title="Session Expired" style="display: none;">
    <h4>Please log in again</h4>
</div>

<%-- Person Page--%>
<c:if test="${not empty person}">
    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 ">
        <h3 class="details-title">
            <i class="sprite sprite-Person"></i>
            <c:set var="personName" value="${person.displayName}" />
            <c:choose>
                <c:when test="${not empty person.firstname && not empty person.surname}">
                    <c:set var="personName" value="${person.firstname}&nbsp;${person.surname}" />
                    <span>${personName}</span>
                </c:when>
                <c:otherwise>
                    <span>${person.displayName}</span>
                </c:otherwise>
            </c:choose>
        </h3>

        <div class="extended-header favth-clearfix">
            <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                <span>Orcid</span>
            </div>
            <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                <c:if test="${not empty person.orcidId}">
                    <span><a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank">${person.orcidId}</a></span>
                </c:if>

                <c:if test="${empty tokenSession}">
                    <button id="connect-orcid-button"><img id="orcid-id-icon" src="https://orcid.org/sites/default/files/images/orcid_24x24.png" alt="ORCID iD icon"/>Are you ${personName} ? Register or Connect your ORCID iD</button>
                </c:if>

                <c:choose>
                    <%--<c:when test="${tokenSession.orcid == '0000-0002-5910-2066'}">--%>
                    <c:when test="${not empty tokenSession && (person.orcidId == tokenSession.orcid) || tokenSession.orcid == param['orcidtest']}">
                        <button id="claim-your-work"><img id="orcid-id-icon-a" src="https://orcid.org/sites/default/files/images/orcid_24x24.png" alt="ORCID iD icon"/>Claim your work</button>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${empty person.orcidId && not empty tokenSession}">
                            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                            <span class="alert alert-warning">Let us know your Orcid. Contact <a href="mailto:help@reactome.org?subject=[ORCID]I'd like my Orcid to be added in Reactome&body=Name: ${tokenSession.name}%0D%0AOrcid ID: ${tokenSession.orcid}">help@reactome.org</a></span>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty person.project}">
                <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                    <span>Project</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                    <span>${person.project}</span>
                </div>
            </c:if>
            <c:if test="${not empty person.affiliation}">
                <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                    <span>Affiliation</span>
                </div>
                <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                    <div>
                        <c:forEach var="aff" items="${person.affiliation}" varStatus="loop">
                            ${aff.displayName}<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="favth-clearfix">
        <c:choose>
            <c:when test="${param['showAll']}">
                <div>
                    <a href="?" class="btn btn-info person-switch-btn">Show Summary</a>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <a href="?showAll=true" class="btn btn-info person-switch-btn">Expand All</a>
                </div>
            </c:otherwise>
        </c:choose>
        </div>

        <c:if test="${not empty authoredPathways}">
            <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Authored Pathways (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(authoredPathways)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${authoredPathwaysSize}"/>)</legend>
                <div id="r-responsive-table-ap" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                            <tr>
                                <th scope="col" style="width:10%;">Date</th>
                                <th scope="col" style="width:15%;">Identifier</th>
                                <th scope="col" style="width:70%;">Pathway</th>
                                <th scope="col" style="width:5%;">Reference</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${authoredPathways}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${item.authored[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${item.stId}" title="Go to Pathway ${item.stId}"> ${item.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <span>${item.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${item.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="./${person.orcidId}/pathways/authored" class="" title="Show all">Show all authored pathways...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="./${person.dbId}/pathways/authored" class="" title="Show all">Show all authored pathways...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </fieldset>
            </div>
        </c:if>

        <c:if test="${not empty authoredReactions}">
            <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Authored Reactions (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(authoredReactions)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${authoredReactionsSize}"/>)</legend>
                <div id="r-responsive-table-ar" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                        <tr>
                            <th scope="col" style="width:10%;">Date</th>
                            <th scope="col" style="width:15%;">Identifier</th>
                            <th scope="col" style="width:70%;">Reaction</th>
                            <th scope="col" style="width:5%;">Reference</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="authoredReaction" items="${authoredReactions}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${authoredReaction.authored[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${authoredReaction.stId}" title="Go to Pathway ${authoredReaction.stId}"> ${authoredReaction.stId}</a>
                                </td>
                                <td data-label="Reaction">
                                    <span>${authoredReaction.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${authoredReaction.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="./${person.orcidId}/pathways/reviewed" class="" title="Show all" >Show all reviewed pathways...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="./${person.dbId}/pathways/reviewed" class="" title="Show all" >Show all reviewed pathways...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </fieldset>
            </div>
        </c:if>

        <c:if test="${not empty reviewedPathways}">
            <div class="favth-clearfix">
            <fieldset class="fieldset-details">
                <legend>Reviewed Pathways (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(reviewedPathways)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${reviewedPathwaysSize}"/>)</legend>
                <div id="r-responsive-table-reviewed-rp" class="details-wrap enlarge-table">
                    <table class="reactome">
                        <thead>
                        <tr>
                            <th scope="col" style="width:10%;">Date</th>
                            <th scope="col" style="width:15%;">Identifier</th>
                            <th scope="col" style="width:70%;">Pathway</th>
                            <th scope="col" style="width:5%;">Reference</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reviewedPathway" items="${reviewedPathways}">
                            <tr>
                                <td data-label="Date">
                                    <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${reviewedPathway.reviewed[0].dateTime}" var="date"/>
                                    <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                </td>
                                <td data-label="Identifier">
                                    <a href="./../${reviewedPathway.stId}" title="Go to Pathway ${reviewedPathway.stId}" >${reviewedPathway.stId}</a>
                                </td>
                                <td data-label="Pathway">
                                    <span>${reviewedPathway.displayName}</span>
                                </td>
                                <td data-label="Reference">
                                    <a href="/cgi-bin/bibtex?DB_ID=${reviewedPathway.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not param['showAll']}">
                    <div style="padding: 5px 0 0 14px;">
                        <c:choose>
                            <c:when test="${not empty person.orcidId}">
                                <a href="./${person.orcidId}/reactions/authored" class="" title="Show all" >Show all authored reactions...</a>
                            </c:when>
                            <c:otherwise>
                                <a href="./${person.dbId}/reactions/authored" class="" title="Show all" >Show all authored reactions...</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </fieldset>
            </div>
        </c:if>

        <c:if test="${not empty reviewedReactions}">
            <div class="favth-clearfix">
                <fieldset class="fieldset-details">
                    <legend>Reviewed Reactions (<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${fn:length(reviewedReactions)}"/>/<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${reviewedReactionsSize}"/>)</legend>
                    <div id="r-responsive-table-reviewed-rr" class="details-wrap enlarge-table">
                        <table class="reactome">
                            <thead>
                            <tr>
                                <th scope="col" style="width:10%;">Date</th>
                                <th scope="col" style="width:15%;">Identifier</th>
                                <th scope="col" style="width:70%;">Reaction</th>
                                <th scope="col" style="width:5%;">Reference</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="reviewedReaction" items="${reviewedReactions}">
                                <tr>
                                    <td data-label="Date">
                                        <fmt:parseDate pattern = "yyyy-MM-dd H:m:s.S" value = "${reviewedReaction.reviewed[0].dateTime}" var="date"/>
                                        <span><fmt:formatDate pattern = "yyyy-MM-dd" value = "${date}"/></span>
                                    </td>
                                    <td data-label="Identifier">
                                        <a href="./../${reviewedReaction.stId}" title="Go to Pathway ${reviewedReaction.stId}" >${reviewedReaction.stId}</a>
                                    </td>
                                    <td data-label="Reaction">
                                        <span>${reviewedReaction.displayName}</span>
                                    </td>
                                    <td data-label="Reference">
                                        <a href="/cgi-bin/bibtex?DB_ID=${reviewedReaction.dbId};personId=${person.dbId}" title="Export to BibTex" target="_blank">BibTex</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <c:if test="${not param['showAll']}">
                        <div style="padding: 5px 0 0 14px;">
                            <c:choose>
                                <c:when test="${not empty person.orcidId}">
                                    <a href="./${person.orcidId}/reactions/reviewed" class="" title="Show all" >Show all reviewed reactions...</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="./${person.dbId}/reactions/reviewed" class="" title="Show all" >Show all reviewed reactions...</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </fieldset>
            </div>
        </c:if>
    </div>
</c:if>
<c:import url="../footer.jsp"/>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type=text/javascript>
    var expiredDialog =
        jQuery('#dialog-expired').dialog({
            autoOpen: false, // Do not open on page load
            modal: true, // Freeze the background behind the overlay
            width: 350,
            height: 170,
            draggable: false,
            closeOnEscape: false,
            resizable: false,
            buttons: [ {
                text: "Reload", click: function() {
                    jQuery(this).dialog("close");
                    location.reload();
                }
            }],
            open: function() {
                jQuery(".ui-dialog-titlebar-close", this.parentNode).hide();
            }
        });

    var pgDialog =
        jQuery('#dialog').dialog({
            autoOpen: false, // Do not open on page load
            modal: true, // Freeze the background behind the overlay
            width: "auto",
            maxWidth: 600,
            height: 175,
            fluid: true,
            resizable: false,
            draggable: false,
            closeOnEscape: false,
            open: function(event, ui) {
                jQuery(".ui-dialog-titlebar-close", this.parentNode).hide();
            }
        });

    var summaryDialog =
        jQuery('#dialog-summary').dialog({
            autoOpen: false, // Do not open on page load
            modal: true, // Freeze the background behind the overlay
            width: "auto",
            maxWidth: 600,
            height: 295,
            draggable: false,
            resizable: false,
            fluid: true,
            buttons: [ { text: "OK", click: function() { jQuery(this).dialog("close"); } } ]
        });

    jQuery("#connect-orcid-button").click(function () {
        window.open("/orcid/login", "_blank", "toolbar=no, scrollbars=yes, width=500, height=600, top=500, left=500");
    });

    <c:if test="${not empty tokenSession && (person.orcidId == tokenSession.orcid) || tokenSession.orcid == param['orcidtest']}">
        jQuery("#claim-your-work").click(function (e) {
            e.preventDefault();
            jQuery.ajax({
                url: "/content/orcid/authenticated",
                type: "GET",
                success: function (isAuthenticated) {
                    if(isAuthenticated) {
                        jQuery(".ui-front").css("z-index", "98888");
                        pgDialog.dialog("open");
                        jQuery("#progressbar").progressbar({ value: false });

                        jQuery.ajax({
                            url: "/content/orcid/claiming/",
                            type: "POST",
                            contentType: "text/plain",
                            dataType: "json",
                            data: "${person.dbId}",
                            success: function(data){
                                pgDialog.dialog("close");
                                jQuery("#progressbar").progressbar("destroy");

                                // print summary
                                summaryDialog.dialog("open");
                                jQuery("[aria-describedby=dialog-summary]").css("z-index", "99999");
                                jQuery("[aria-describedby=dialog]").css("z-index", "99999");
                                jQuery(".total").text(data.total);
                                jQuery(".total-created").text(data.totalIncluded);
                                jQuery(".total-conflict").text(data.totalConflict);
                                jQuery(".total-errors").text(data.totalErrors);
                            },
                            error: function (data) {
                                pgDialog.dialog("close");
                                jQuery("#progressbar").progressbar("destroy");
                                console.log(data);
                            }
                        });
                    } else {
                        expiredDialog.dialog("open");
                    }
                },
                error: function () {

                }
            });
        });

        jQuery(".orcid-signout").click(function () {
           jQuery.ajax({
               url: "/content/orcid/signout",
               type: "GET",
               success: function(){

               },
               error: function() {

               }

           })
        });
    </c:if>
</script>


