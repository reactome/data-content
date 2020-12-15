<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

    <link href="/templates/favourite/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon"/>
    <link href="/plugins/system/jce/css/content.css?187a710698aa64b0eb900d4ce9391c44" rel="stylesheet" type="text/css"/>

    <%--needed for header style--%>
    <link href="/media/jui/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="/media/jui/css/bootstrap-responsive.css" rel="stylesheet" type="text/css"/>
    <link href="/templates/favourite/bootstrap/favth-bootstrap.css" rel="stylesheet" type="text/css"/>

    <link href="/modules/mod_favsocial/theme/css/favsocial.css" rel="stylesheet" type="text/css"/>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
          type="text/css"/>

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

    <link rel="stylesheet" href="/content/resources/css/main.css?v=20180710" type="text/css"/>
    <link rel="stylesheet" href="/content/resources/css/icon-lib.css?v=20180712" type="text/css"/>

    <%--    <jsp:include page="json-ld.jsp"/>--%>

    <script type="text/javascript" src="/content/resources/js/data-content.js?v=3.2"></script>
</head>

<div id="fav-container" class="fav-container">
    <div class="favth-container" style="margin: 0; width:100%">
        <%-- Interactors Intermediate Page--%>
        <c:if test="${not empty interactions}">

            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>

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
                                                    <i class="sprite sprite-${interactor.schemaClass}"
                                                       title="${interactor.schemaClass}"></i>
                                                    <a href=${detailRequestPrefix}${interactor.stId}?interactor=${referenceEntity.displayName}"
                                                       title="Show Details" <c:if test="${not empty widget}">target="_blank"</c:if>>${interactor.displayName}<span> (${interactor.stId})</span></a>
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
        </c:if>
    </div>
</div>
