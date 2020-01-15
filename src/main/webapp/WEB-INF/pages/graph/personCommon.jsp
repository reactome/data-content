<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession" />
<c:set value="${showOrcidBtn && not empty tokenSession && (person.orcidId == tokenSession.orcid)}" var="isAuthenticated" />

<%-- Orcid requires a metadata of the authenticated user --%>
<c:if test="${isAuthenticated}">
    <script type="application/ld+json">
      <c:out value="${METADATA}" escapeXml="false"/>
    </script>
</c:if>

<c:if test="${showOrcidBtn}">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/hot-sneaks/jquery-ui.min.css" />

    <c:if test="${not empty tokenSession}">
        <div id="dialog" title="Claiming works..." style="display: none;">
            <p><span style="font-size: 1.2em;">Please wait while works are claimed</span></p>
            <p class="text-center"><span style="font-size: 0.7em;">Note: This may take a few seconds. Do not close this window.</span></p>
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
                <img alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="16" height="16" hspace="4" /><a href="https://orcid.org/${tokenSession.orcid}" target="_blank" rel="nofollow noindex"><span style="font-size:12px;">Visit your ORCID page</span></a></p>
            </div>
        </div>

        <div id="dialog-error" title="Error" style="display: none;">
            <span style="font-size: 1.2em;" class="err-msg"></span>
        </div>

        <div id="dialog-claim-confirm" title="Claim your works ?"  style="display: none;">
            <p>A total of <strong><span class="works-to-claim"></span></strong> will be added to your ORCID record. If you don't want to continue hit cancel.</p>
            <p class="alternate-msg" style="display:none"></p>
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
                height: 320,
                draggable: false,
                resizable: false,
                fluid: true,
                buttons: [ { text: "OK", click: function() { jQuery(this).dialog("close"); } } ]
            });

        var dialogClaimConfirm =
            jQuery( "#dialog-claim-confirm" ).dialog({
                autoOpen: false, // Do not open on page load
                height: "auto",
                width: 400,
                fluid: true,
                resizable: false,
                draggable: false,
                modal: true
            });

        jQuery("#connect-orcid-button").click(function (e) {
            e.preventDefault();
            var oauthpopup = window.open("about:blank", "_blank", "toolbar=no, scrollbars=yes, width=500, height=600, top=500, left=500");
            oauthpopup.location.href='/content/orcid/login';
        });

        <c:if test="${isAuthenticated}">
            jQuery('button[id^="claim-your-work"]').click(function (e) {
                var claimingAction = jQuery(this).attr('name')
                var path = '/' + claimingAction;
                jQuery(".works-to-claim").text(prepareConfirmationDialog(claimingAction));

                dialogClaimConfirm.dialog("open");
                dialogClaimConfirm.dialog({
                    buttons: [
                        {
                            text: "Claim",
                            click: function () {
                                jQuery( this ).dialog( "close" );
                                e.preventDefault();

                                jQuery.ajax({
                                    url: "/content/orcid/authenticated",
                                    type: "GET",
                                    success: function (isAuthenticatedinOrcid) {
                                        if(isAuthenticatedinOrcid) {
                                            jQuery(".ui-front").css("z-index", "98888");
                                            pgDialog.dialog("open");
                                            jQuery("#progressbar").progressbar({ value: false });

                                            jQuery.ajax({
                                                url: '/content/orcid/claim'+path,
                                                type: "POST",
                                                contentType: "text/plain",
                                                dataType: "json",
                                                <%--data: "<c:if test="${not empty person.orcidId}">0000-0002-6416-5619</c:if><c:if test="${empty person.orcidId}">${person.dbId}</c:if>",--%>
                                                data: "<c:if test="${not empty person.orcidId}">${person.orcidId}</c:if><c:if test="${empty person.orcidId}">${person.dbId}</c:if>",

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
                                                    try {
                                                        jQuery(".err-msg").text(data.responseJSON["user-message"]);
                                                    } catch(err) {
                                                        jQuery(".err-msg").text("Unexpected error. Please try again.");
                                                    }
                                                }
                                            });
                                        } else {
                                            expiredDialog.dialog("open");
                                        }
                                    },
                                    error: function () {
                                        errDialog.dialog("open");
                                        jQuery(".err-msg").text("Unexpected error. Please try again.");
                                    }
                                });
                            }
                        },
                        {
                            text: "Cancel",
                            click: function() {
                                jQuery(this).dialog("close");
                            }
                        }
                    ]
                });
            });

            function prepareConfirmationDialog(text) {
                var p = <c:out default="0" escapeXml="true" value="${not empty authoredPathwaysSize ? authoredPathwaysSize : 0}" /> + <c:out default="0" escapeXml="true" value="${not empty reviewedPathwaysSize ? reviewedPathwaysSize : 0}" />;
                var r = <c:out default="0" escapeXml="true" value="${not empty authoredReactionsSize ? authoredReactionsSize : 0}" /> + <c:out default="0" escapeXml="true" value="${not empty reviewedReactionsSize ? reviewedReactionsSize : 0}" />;
                var ret = "";
                var role = " reviewed";
                if (text === "ra" || text === "rr") {
                    r = <c:out default="0" escapeXml="true" value="${not empty reviewedReactionsSize ? reviewedReactionsSize : 0}" />;
                    if( text === "ra") {
                        role = " authored";
                        r = <c:out default="0" escapeXml="true" value="${not empty authoredReactionsSize ? authoredReactionsSize : 0}" />;
                    }
                    ret = r + role + " reactions";
                } else if (text === "pa" || text === "pr") {
                    p = <c:out default="0" escapeXml="true" value="${not empty reviewedPathwaysSize ? reviewedPathwaysSize : 0}" />;
                    if( text === "pa") {
                        role = " authored";
                        p = <c:out default="0" escapeXml="true" value="${not empty authoredPathwaysSize ? authoredPathwaysSize : 0}" />;
                    }
                    ret = p + role + " pathways";
                }

                if (text === "all") {
                    ret = p + " pathways and " + r + " reactions";
                    if(r === 0) {
                        ret = p + " pathways";
                    } else {
                        if (p === 0){
                            ret = r + " reactions";
                        }
                    }
                    jQuery(".alternate-msg").show();
                    jQuery(".alternate-msg").html("");
                    jQuery(".alternate-msg").html("Alternatively, you can opt to claim only pathways or only reactions that you have authored or reviewed as indicated below.");
                }else {
                    jQuery(".alternate-msg").hide();
                    jQuery(".alternate-msg").html("");
                }

                return ret;
            }
        </c:if>
    </script>
</c:if>