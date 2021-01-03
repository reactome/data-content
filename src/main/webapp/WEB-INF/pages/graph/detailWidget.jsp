<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

    <%--needed for header style--%>
    <link href="/media/jui/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="/media/jui/css/bootstrap-responsive.css" rel="stylesheet" type="text/css"/>
    <link href="/templates/favourite/bootstrap/favth-bootstrap.css" rel="stylesheet" type="text/css"/>

    <%-- Expand All function--%>
    <script src="/media/jui/js/jquery.min.js?187a710698aa64b0eb900d4ce9391c44" type="text/javascript"></script>
    <script src="/templates/favourite/bootstrap/favth-bootstrap.js" type="text/javascript"></script>
    <script src="/templates/favourite/js/clipboard.min.js" type="text/javascript"></script>
    <script src="/media/jui/js/jquery.autocomplete.min.js?187a710698aa64b0eb900d4ce9391c44"
            type="text/javascript"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- STYLESHEETS -->
    <!-- Custom: type is not needed, remove it -->
    <!-- icons -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <!-- admin -->
    <link rel="stylesheet" href="/templates/favourite/admin/admin.css"/>
    <!-- cms -->
    <link rel="stylesheet" href="/templates/favourite/css/cms.css"/>
    <!-- theme -->
    <link rel="stylesheet" href="/templates/favourite/css/theme.css"/>
    <!-- style -->
    <link rel="stylesheet" href="/templates/favourite/css/style.css"/>
    <!-- styles -->
    <link rel="stylesheet" href="/templates/favourite/css/styles/style2.css"/>
    <!-- Custom: Our custom css -->
    <link rel="stylesheet" href="/templates/favourite/css/custom.css?v=1.1.1"/>
    <!-- Custom: Stylying the autocomplete div-->
    <link rel="stylesheet" href="/templates/favourite/css/autocomplete/autocomplete.css"/>
    <!-- Custom: rglyph fonts -->
    <link rel="stylesheet" href="/templates/favourite/rglyph/rglyph.css"/>


    <!-- GOOGLE FONT -->
    <!-- navigation -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:400' rel='stylesheet'/>
    <!-- titles -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet'/>
    <!-- text logo -->
    <link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:700' rel='stylesheet'/>
    <!-- default -->
    <link href="//fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet"/>
    <!-- custom: icon for phone app -->
    <link rel="apple-touch-icon" sizes="128x128" href="/templates/favourite/images/logo/icon.png">

    <!-- PARAMETERS -->

    <!-- Custom: remove type -->
    <style>

        @media (min-width: 1200px) {
            .favth-container,
            #fav-headerwrap.fav-fixed .favth-container-block {
                width: 1190px;
            }
        }

        .favnav ul.nav > li > a,
        .favnav ul.nav > li > .nav-header,
        .favnav ul.nav ul.nav-child a,
        .favnav ul.nav ul.nav-child .nav-header,
        ul.menufavth-horizontal li a,
        ul.menufavth-horizontal li .nav-header {
            text-transform: uppercase;
        }

        .favnav ul.nav > li > a,
        .favnav ul.nav > li > .nav-header,
        .favnav ul.nav ul.nav-child a,
        .favnav ul.nav ul.nav-child .nav-header,
        ul.menufavth-horizontal li a,
        ul.menufavth-horizontal li .nav-header {
            font-family: 'Open Sans', sans-serif;
        }

        .favnav ul.nav > li > a,
        .favnav ul.nav > li > .nav-header,
        .favnav ul.nav ul.nav-child a,
        .favnav ul.nav ul.nav-child .nav-header,
        ul.menufavth-horizontal li a,
        ul.menufavth-horizontal li .nav-header {
            font-weight: 400;
        }

        .favnav ul.nav > li > a,
        .favnav ul.nav > li > .nav-header,
        .favnav ul.nav ul.nav-child a,
        .favnav ul.nav ul.nav-child .nav-header,
        ul.menufavth-horizontal li a,
        ul.menufavth-horizontal li .nav-header {
            font-style: normal;
        }

        .fav-container h3:first-of-type,
        .fav-container .page-header h2,
        .fav-container h2.item-title,
        .fav-container .hikashop_product_page h1 {
            text-align: left;
        }

        .fav-container h3:first-of-type,
        .fav-container .page-header h2,
        .fav-container h2.item-title,
        .fav-container .hikashop_product_page h1 {
            text-transform: uppercase;
        }

        .fav-container h1,
        .fav-container h2,
        .fav-container h3,
        .fav-container h4,
        .fav-container h5,
        .fav-container h6,
        .fav-container legend {
            font-family: 'Open Sans', sans-serif;
        }

        .fav-container h1,
        .fav-container h2,
        .fav-container h3,
        .fav-container h4,
        .fav-container h5,
        .fav-container h6,
        .fav-container legend {
            font-weight: 300;
        }

        .fav-container h1,
        .fav-container h2,
        .fav-container h3,
        .fav-container h4,
        .fav-container h5,
        .fav-container h6,
        .fav-container legend {
            font-style: normal;
        }

        body {
            background-repeat: repeat;
            background-attachment: initial;
            -webkit-background-size: auto;
            -moz-background-size: auto;
            -o-background-size: auto;
            background-size: auto;;
        }

        #fav-noticewrap p {
            color: #8A6D3B;
        }

        #fav-topbarwrap p {
            color: #A94442;
        }

        #fav-screenwrap h3:first-of-type {
            color: #444444;
        }

        #fav-topwrap h3:first-of-type {
            color: #444444;
        }

        #fav-footerwrap p {
            color: #FFFFFF;
        }

        #fav-footerwrap a {
            color: #FFFFFF;
        }

        .fav-container a.text-logo,
        .fav-container a.text-logo:hover,
        .fav-container a.text-logo:focus {
            color: #58C3E5;
        }

        .fav-container a.text-logo {
            font-size: 42px;
        }

        .fav-container a.text-logo,
        #fav-logo h1 {
            font-family: 'Source Sans Pro', sans-serif;
        }

        .fav-container a.text-logo,
        #fav-logo h1 {
            font-weight: 700;
        }

        .fav-container a.text-logo,
        #fav-logo h1 {
            font-style: normal;
        }

        .fav-container a.text-logo {
            margin: 6px 0 0 0;
        }

        @media (max-width: 480px) {
            p {
                font-size: 12px;
            }
        }

    </style>

    <!-- FAVTH SCRIPTS -->
    <script src="/templates/favourite/js/favth-scripts.js"></script>
    <link rel="stylesheet" href="/content/resources/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="/content/resources/css/icon-lib.css" type="text/css"/>

    <%--    <jsp:include page="json-ld.jsp"/>--%>

    <script type="text/javascript" src="/content/resources/js/data-content.js?v=3.2"></script>
</head>

<div id="fav-container" class="fav-container">
    <div class="favth-container" style="margin: 0; width:100%">
        <div class="favth-col-xs-12">

            <c:set var="pre" value="${pageContext.request.getHeader('Referer')}"/>
            <c:set var ="forw" value="${pageContext.request.getAttribute('javax.servlet.forward.request_uri')}" />
            <c:out value="pre: ${pre}"/>
            <c:out value="forward: ${forw}"/>

            <c:if test="${not empty pre}">
                <c:if test="${not empty forw}">
                <a href="#" onclick="history.go(-1)"> <<< Go Back</a>
                    </c:if>
            </c:if>

            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>

            <c:import url="title.jsp"/>

            <c:if test="${not empty topLevelNodes}">
                <c:import url="locationsInThePWB.jsp"/>
            </c:if>

            <c:if test="${not empty previewURL || not empty databaseObject.summation}">
                <fieldset class="fieldset-details">
                    <legend>General</legend>
                    <c:if test="${not empty previewURL}">

                        <div class="favth-col-xs-12 favth-hidden-xs">
                            <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-6">
                                <div class="favth-col-xs-12 padding0">
                                    <div class="">
                                        <i class="fa fa-file-code-o" style="color: #2F9EC2"></i>
                                        <a href="/ContentService/exporter/event/${databaseObject.stId}.sbml"
                                           download="${databaseObject.stId}.sbml"
                                           title="Export diagram to SBML">SBML</a>&nbsp;|&nbsp;
                                        <div class="biopax-dropdown">
                                            <a style="cursor: pointer">BioPAX</a>
                                            <div class="biopax-version-tooltip">
                                                <a href="/ReactomeRESTfulAPI/RESTfulWS/biopaxExporter/Level2/${databaseObject.dbId}">Level
                                                    2</a>
                                                <a href="/ReactomeRESTfulAPI/RESTfulWS/biopaxExporter/Level3/${databaseObject.dbId}">Level
                                                    3</a>
                                            </div>
                                        </div>
                                        <c:if test="${not (empty topLevelNodes && databaseObject.schemaClass=='Pathway')}">
                                            &nbsp;|&nbsp;
                                            <a href="/ContentService/exporter/document/event/${databaseObject.stId}.pdf"
                                               download="${databaseObject.stId}.pdf"
                                               title="Export diagram to PDF">PDF</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not (empty topLevelNodes && databaseObject.schemaClass=='Pathway')}">
                                <c:set var="url" value="${fn:replace(downloadURL, '_stId_', databaseObject.stId)}"/>
                                <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-6 padding0">
                                    <div class="favth-col-xs-12 padding0">
                                        <div class="pull-right">
                                            <i class="fa fa-download" style="color: #2F9EC2"></i>
                                            <a href="${fn:replace(url, "_ext_", "svg")}"
                                               download="${databaseObject.stId}.svg">SVG</a>&nbsp;|&nbsp;
                                            <div class="png-dropdown">
                                                <a style="cursor: pointer">PNG</a>
                                                <div class="png-resolution-tooltip<c:if test="${isEHLD}"> png-resolution-tooltip-noEHLD</c:if>">
                                                    <a href="${fn:replace(url, "_ext_", "png")}?quality=2"
                                                       download="${databaseObject.stId}.png">Low</a><br/>
                                                    <a href="${fn:replace(url, "_ext_", "png")}?quality=5"
                                                       download="${databaseObject.stId}.png">Medium</a><br/>
                                                    <a href="${fn:replace(url, "_ext_", "png")}?quality=7"
                                                       download="${databaseObject.stId}.png">High</a>
                                                </div>
                                            </div>
                                            <c:if test="${not isEHLD}">
                                                &nbsp;|&nbsp;<a href="${fn:replace(url, "_ext_", "pptx")}">PPTX</a>
                                                &nbsp;|&nbsp;<a href="/ContentService/exporter/event/${databaseObject.stId}.sbgn">SBGN</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <c:if test="${not (empty topLevelNodes && databaseObject.schemaClass=='Pathway')}">
                            <div>
                                <div class="favth-col-xs-12 padding0 text-center">
                                    <c:choose>
                                        <c:when test="${empty topLevelNodes}">
                                            <div class="text-center margin0 top" style="min-height: 300px;">
                                                <img src="${previewURL}?title=false" alt="${databaseObject.displayName}"
                                                     title="'${databaseObject.displayName}' is an orphan event and cannot be opened in the Pathway Browser"
                                                     class="diagram-rxn-preview">
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center margin0 top" style="min-height: 300px;">
                                                <a href="/PathwayBrowser/#/${databaseObject.stId}"
                                                   <c:if test="${not empty widget}">target="_blank"</c:if>>
                                                    <img src="${previewURL}?title=false"
                                                         alt="${databaseObject.displayName}"
                                                         title="Open '${databaseObject.displayName}' in the Pathway Browser"
                                                         class="diagram-rxn-preview">
                                                </a>
                                            </div>
                                            <div class="text-center margin0 bottom">
                                            <span style="font-size: smaller">
                                                Click the image above or <a
                                                    href="/PathwayBrowser/#/${databaseObject.stId}"
                                                    <c:if test="${not empty widget}">target="_blank"</c:if>>here</a> to open this ${fn:toLowerCase(fn:replace(databaseObject.className, "TopLevel", ""))} in the Pathway Browser
                                                <c:if test="${databaseObject.className == 'Reaction'}">
                                                    <br/><i class="fa fa-info-circle"
                                                            style="color: #2F9EC2; font-size: 15px;"></i>The layout of this reaction may differ from that in the pathway view due to the constraints in pathway layout
                                                </c:if>
                                            </span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${not empty databaseObject.summation}">
                        <div class="details-summation">
                            <c:forEach var="summation" items="${databaseObject.summation}">
                                <p>${summation.text}</p>
                            </c:forEach>
                        </div>
                    </c:if>
                </fieldset>
            </c:if>

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

            <%--For those that ARE in Reactome, for those that ARE NOT in Reactome, check graph/interactors.jsp--%>
            <c:if test="${not empty interactions}">
                <c:import url="interactionDetails.jsp"/>
            </c:if>
        </div>
    </div>
</div>


