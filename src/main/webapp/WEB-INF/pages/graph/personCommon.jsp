<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession" />

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
        // jQuery("#claim-your-work").click(function (e) {
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