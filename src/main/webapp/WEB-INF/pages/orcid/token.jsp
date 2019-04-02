<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="robots" content="noindex, nofollow" />
    <meta name="description" content="Reactome is pathway database which provides intuitive bioinformatics tools for the visualisation, interpretation and analysis of pathway knowledge." />
    <title>Reactome | Authenticating ...</title>
    <link href="/templates/favourite/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon" />
    <script src="/media/jui/js/jquery.min.js?97ad68e2b82f1d3065eec557567289fb" type="text/javascript"></script>
    <script src="/media/jui/js/jquery-noconflict.js?97ad68e2b82f1d3065eec557567289fb" type="text/javascript"></script>
    <script src="/media/jui/js/jquery-migrate.min.js?97ad68e2b82f1d3065eec557567289fb" type="text/javascript"></script>
    <style>
        .sk-circle {
            margin: 50px auto;
            width: 40px;
            height: 40px;
            position: relative;
        }
        .sk-circle .sk-child {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
        }
        .sk-circle .sk-child:before {
            content: '';
            display: block;
            margin: 0 auto;
            width: 15%;
            height: 15%;
            background-color: #333;
            border-radius: 100%;
            -webkit-animation: sk-circleBounceDelay 1.2s infinite ease-in-out both;
            animation: sk-circleBounceDelay 1.2s infinite ease-in-out both;
        }
        .sk-circle .sk-circle2 {
            -webkit-transform: rotate(30deg);
            -ms-transform: rotate(30deg);
            transform: rotate(30deg); }
        .sk-circle .sk-circle3 {
            -webkit-transform: rotate(60deg);
            -ms-transform: rotate(60deg);
            transform: rotate(60deg); }
        .sk-circle .sk-circle4 {
            -webkit-transform: rotate(90deg);
            -ms-transform: rotate(90deg);
            transform: rotate(90deg); }
        .sk-circle .sk-circle5 {
            -webkit-transform: rotate(120deg);
            -ms-transform: rotate(120deg);
            transform: rotate(120deg); }
        .sk-circle .sk-circle6 {
            -webkit-transform: rotate(150deg);
            -ms-transform: rotate(150deg);
            transform: rotate(150deg); }
        .sk-circle .sk-circle7 {
            -webkit-transform: rotate(180deg);
            -ms-transform: rotate(180deg);
            transform: rotate(180deg); }
        .sk-circle .sk-circle8 {
            -webkit-transform: rotate(210deg);
            -ms-transform: rotate(210deg);
            transform: rotate(210deg); }
        .sk-circle .sk-circle9 {
            -webkit-transform: rotate(240deg);
            -ms-transform: rotate(240deg);
            transform: rotate(240deg); }
        .sk-circle .sk-circle10 {
            -webkit-transform: rotate(270deg);
            -ms-transform: rotate(270deg);
            transform: rotate(270deg); }
        .sk-circle .sk-circle11 {
            -webkit-transform: rotate(300deg);
            -ms-transform: rotate(300deg);
            transform: rotate(300deg); }
        .sk-circle .sk-circle12 {
            -webkit-transform: rotate(330deg);
            -ms-transform: rotate(330deg);
            transform: rotate(330deg); }
        .sk-circle .sk-circle2:before {
            -webkit-animation-delay: -1.1s;
            animation-delay: -1.1s; }
        .sk-circle .sk-circle3:before {
            -webkit-animation-delay: -1s;
            animation-delay: -1s; }
        .sk-circle .sk-circle4:before {
            -webkit-animation-delay: -0.9s;
            animation-delay: -0.9s; }
        .sk-circle .sk-circle5:before {
            -webkit-animation-delay: -0.8s;
            animation-delay: -0.8s; }
        .sk-circle .sk-circle6:before {
            -webkit-animation-delay: -0.7s;
            animation-delay: -0.7s; }
        .sk-circle .sk-circle7:before {
            -webkit-animation-delay: -0.6s;
            animation-delay: -0.6s; }
        .sk-circle .sk-circle8:before {
            -webkit-animation-delay: -0.5s;
            animation-delay: -0.5s; }
        .sk-circle .sk-circle9:before {
            -webkit-animation-delay: -0.4s;
            animation-delay: -0.4s; }
        .sk-circle .sk-circle10:before {
            -webkit-animation-delay: -0.3s;
            animation-delay: -0.3s; }
        .sk-circle .sk-circle11:before {
            -webkit-animation-delay: -0.2s;
            animation-delay: -0.2s; }
        .sk-circle .sk-circle12:before {
            -webkit-animation-delay: -0.1s;
            animation-delay: -0.1s; }

        @-webkit-keyframes sk-circleBounceDelay {
            0%, 80%, 100% {
                -webkit-transform: scale(0);
                transform: scale(0);
            } 40% {
                  -webkit-transform: scale(1);
                  transform: scale(1);
              }
        }

        @keyframes sk-circleBounceDelay {
            0%, 80%, 100% {
                -webkit-transform: scale(0);
                transform: scale(0);
            } 40% {
                  -webkit-transform: scale(1);
                  transform: scale(1);
              }
        }
    </style>
</head>
<body>

    <div class="waiting" style="display:none; border: 1px solid #c8c8c8; background-color: #e1e1e1; border-radius: 4px; padding: 4px;">
        <h3 style="text-align: center;">Retrieving access token from ORCID</h3>
        <div class="sk-circle">
            <div class="sk-circle1 sk-child"></div>
            <div class="sk-circle2 sk-child"></div>
            <div class="sk-circle3 sk-child"></div>
            <div class="sk-circle4 sk-child"></div>
            <div class="sk-circle5 sk-child"></div>
            <div class="sk-circle6 sk-child"></div>
            <div class="sk-circle7 sk-child"></div>
            <div class="sk-circle8 sk-child"></div>
            <div class="sk-circle9 sk-child"></div>
            <div class="sk-circle10 sk-child"></div>
            <div class="sk-circle11 sk-child"></div>
            <div class="sk-circle12 sk-child"></div>
        </div>
    </div>

    <div class="thankyou" style="display: none; border: 1px solid #c8c8c8; background-color: #fff; border-radius: 4px; padding: 4px; text-align:center;">
        <h3>Thank you for connecting your ORCID <img id="orcid-id-icon-rr" alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="16" height="16" hspace="4" /></h3>
        <h4>You will now be directed back to the submission system website.</h4>
    </div>

    <script type=text/javascript>
        jQuery(document).ajaxStart(function(){
            jQuery(".waiting").show();
        });

        jQuery(function(){
            jQuery.ajax({
                url: "/content/orcid/token?code=${code}",
                type: "GET",
                success: function(auth){
                    if (auth) {
                        jQuery(".waiting").hide();
                        jQuery(".thankyou").show();

                        setInterval(
                            function () {
                                try {
                                    window.opener.location.reload(true);
                                    window.close();
                                } catch (err) {
                                    window.open('/', '_self', '');
                                    window.close();
                                }
                            }, 3500
                        );
                    }
                },
                error: function (data) {
                    alert(data.responseJSON["user-message"]);
                    window.open('/', '_self', '');
                    window.close();
                }
            });
        });
    </script>
</body>
</html>