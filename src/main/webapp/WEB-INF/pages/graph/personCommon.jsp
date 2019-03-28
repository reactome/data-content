<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession" />

<%-- Orcid requires a metadata of the authenticated user --%>
<c:if test="${not empty tokenSession && (person.orcidId == tokenSession.orcid) || (not empty param['orcidtest'] && tokenSession.orcid == param['orcidtest'])}">
    <script type="application/ld+json">
      <c:out value="${METADATA}" escapeXml="false"/>
    </script>
</c:if>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/hot-sneaks/jquery-ui.min.css" />

<c:if test="${not empty tokenSession}">
    <div id="dialog" title="Claiming works..." style="display: none;">
        <p><span style="font-size: 1.2em;">Please wait while works are claimed</span></p>
        <p class="text-center"><span style="font-size: 0.7em;">Note: This may take few seconds. Do not close this window.</span></p>
        <p></p>
        <div id="progressbar"></div>
    </div>

    <div id="dialog-summary" title="Claiming Summary" style="display: none;">
        <h3>Synchronization has finished</h3>
        <div style="background: #f0f0f0; padding: 8px; border: 1px solid darkgray; border-radius: 0 10px 0 10px;">
            <span>Claimed: </span><span class="total"></span><br/>
            <span>&nbsp;&nbsp;Created: </span><span class="total-created"></span><br/>
            <span>&nbsp;&nbsp;Existing: </span><span class="total-conflict"></span><br/>
            <span style="display: none;">&nbsp;&nbsp;Errors: </span><span class="total-errors"></span><br/>
        </div>
        <div style="text-align:right;">
            <img alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="16" height="16" hspace="4" /><a href="https://orcid.org/${tokenSession.orcid}" target="_blank" rel="nofollow noindex"><span style="font-size:12px;">Visit your Orcid page</span></a></p>
        </div>
    </div>

    <div id="dialog-error" title="Error" style="display: none;">
        <span style="font-size: 1.2em;" class="err-msg"></span>
    </div>
</c:if>

<div id="dialog-expired" title="Session Expired" style="display: none;">
    <h4>Please log in again</h4>
</div>

<script type="text/javascript">
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

    var errDialog =
        jQuery('#dialog-error').dialog({
            autoOpen: false, // Do not open on page load
            modal: true, // Freeze the background behind the overlay
            width: 350,
            height: "auto",
            draggable: false,
            closeOnEscape: false,
            resizable: false,
            buttons: [ {
                text: "OK", click: function() {
                    jQuery(this).dialog("close");
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
            height: 315,
            draggable: false,
            resizable: false,
            fluid: true,
            buttons: [ { text: "OK", click: function() { jQuery(this).dialog("close"); } } ]
        });

    jQuery("#connect-orcid-button").click(function () {
        window.open("/orcid/login", "_blank", "toolbar=no, scrollbars=yes, width=500, height=600, top=500, left=500");
    });

    <c:if test="${(not empty tokenSession && (person.orcidId == tokenSession.orcid)) || tokenSession.orcid == param['orcidtest']}">
        jQuery('button[id^="claim-your-work"]').click(function (e) {
            e.preventDefault();
            var path = '/' + jQuery(this).attr('name');

            jQuery.ajax({
                url: "/content/orcid/authenticated",
                type: "GET",
                success: function (isAuthenticated) {
                    if(isAuthenticated) {
                        jQuery(".ui-front").css("z-index", "98888");
                        pgDialog.dialog("open");
                        jQuery("#progressbar").progressbar({ value: false });

                        jQuery.ajax({
                            url: '/content/orcid/claim'+path+'<c:if test="${not empty param['orcidtest']}">?orcidtest=${param['orcidtest']}</c:if>',
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
                                if(data.totalErrors > 0) {
                                    jQuery(".total-errors").show();
                                    jQuery(".total-errors").text(data.totalErrors);
                                }
                            },
                            error: function (data) {
                                pgDialog.dialog("close");
                                jQuery("#progressbar").progressbar("destroy");
                                errDialog.dialog("open");
                                jQuery(".err-msg").text(data.responseJSON["user-message"]);
                            }
                        });
                    } else {
                        expiredDialog.dialog("open");
                    }
                },
                error: function () {}
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