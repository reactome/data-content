<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h4>Please report to us and we will get back shortly.</h4>

<form class="favth-form-horizontal" id="contact-form" action="/content/contact">
    <p>&nbsp;</p>
    <input type="hidden" name="source" id="source" value="${param.source}"/>
    <input type="hidden" name="exception" id="exception" value="${param.exception}"/>
    <input type="hidden" name="url" id="url" value="${url}"/>

    <div class="favth-form-group">
        <label for="contactName" class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2 favth-col-xs-12 favth-control-label">Name </label>
        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10 favth-col-xs-12">
            <input type="text" class="favth-form-control" name="contactName" id="contactName" placeholder="your name">
        </div>
    </div>
    <div class="favth-form-group mail-required">
        <label for="mailAddress" class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2 favth-col-xs-12 favth-control-label">From* </label>
        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10 favth-col-xs-12">
            <input type="email" class="favth-form-control" name="mailAddress" id="mailAddress" placeholder="your-mail@domain.com">
        </div>
    </div>
    <div class="favth-form-group">
        <label for="to" class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2 favth-col-xs-12 favth-control-label">To </label>
        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10 favth-col-xs-12">
            <input type="text" class="favth-form-control" id="to" placeholder="Reactome Helpdesk" readonly>
        </div>
    </div>
    <div class="favth-form-group">
        <label for="subject" class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2 favth-col-xs-12 favth-control-label">Subject </label>
        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10 favth-col-xs-12">
            <c:choose>
                <c:when test="${not empty subject}">
                    <input type="text" id="subject" name="subject" class="favth-form-control" value="${subject}" readonly/>
                </c:when>
                <c:otherwise>
                    <input type="text" id="subject" name="subject" class="favth-form-control" value="URL Bad Request" readonly/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="favth-form-group message-required">
        <label for="message" class="favth-col-lg-2 favth-col-md-2 favth-col-sm-2 favth-col-xs-12 favth-control-label">Message* </label>
        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-10 favth-col-xs-12">
            <c:choose>
                <c:when test="${not empty message}">
                    <textarea id="message" name="message" class="favth-form-control" rows="5">${message}</textarea>
                </c:when>
                <c:otherwise>
                    <textarea id="message" name="message" class="favth-form-control" rows="5">Dear Helpdesk,&#13;&#10;Reactome does not process my request properly.&#13;&#10;Thank you&#13;&#10;</textarea>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="favth-form-group">
        <div class="favth-col-sm-offset-2 favth-col-sm-10">
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="sendEmailCopy" name="sendEmailCopy" checked> Send me a copy
                </label>
            </div>
        </div>
    </div>
    <div class="favth-form-group">
        <div class="favth-col-sm-offset-2 favth-col-sm-10">
            <button id="send" class="btn btn-default">Send</button>
        </div>
    </div>
</form>

<%-- Validation placeholder --%>
<p id="msg"></p>


<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery('#send').click(function(e) {
            e.preventDefault();

            var email = jQuery('#mailAddress').val();
            var ok = true;
            if(email == "") {
                jQuery(".mail-required").addClass("favth-has-error");
                ok = false;
            }else {
                jQuery(".mail-required").removeClass("favth-has-error");
            }
            if(jQuery('#message').val() == "" ) {
                jQuery(".message-required").addClass("favth-has-error");
                ok = false;
            }else {
                jQuery(".message-required").removeClass("favth-has-error");
            }

            if(!isEmailValid(email)){
                ok = false;
            }

            if(ok){
                jQuery(".message-required").removeClass("favth-has-error");
                jQuery(".mail-required").removeClass("favth-has-error");

                jQuery('#send').prop("disabled", true);
                var msg = jQuery("#msg");
                var formData = jQuery("#contact-form");

                jQuery.ajax({
                    url: formData.attr("action"),
                    type: "POST",
                    data: formData.serialize(),
                    success: function (data, textStatus, jqXHR) {
                        formData.remove();
                        msg.replaceWith("<p id='msg' class='alert alert-info'><span style='color:#3a87ad;'><strong>Thank you</strong> for contacting us.&nbsp;We will get back to you shortly.</span></p>");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        jQuery('#send').prop("disabled", false);
                        msg.replaceWith("<p id='msg' class='alert alert-danger'><span style='color:#b94a48;'>Could not send your email. Try again or please email us at <a href='mailto:help@reactome.org'>help@reactome.org</a></p>");
                    }
                });
            }
        });
    });

    function isEmailValid(mail){
        var status = true;
        var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
        if(mail != "" ) {
            if (mail.search(emailRegEx) == -1) {
                jQuery(".mail-required").addClass("favth-has-error");
                status = false;
            }
        }
        return status;
    }
</script>