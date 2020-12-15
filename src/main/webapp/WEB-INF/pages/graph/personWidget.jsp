<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


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


<c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession"/>
<c:set value="${showOrcidBtn && not empty tokenSession && (person.orcidId == tokenSession.orcid)}"
       var="isAuthenticated"/>

<div id="fav-container" class="fav-container">
    <div class="favth-container" style="margin: 0; width:100%">

      <%--  <a href="#" onclick="history.go(-1)"> <<< Go Back</a>--%>

        <%-- Person Page--%>
        <c:if test="${not empty person}">

            <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>

            <div class="favth-col-xs-12 ">
                <h3 class="details-title">
                    <i class="sprite sprite-Person"></i>
                    <c:set var="personName" value="${person.displayName}"/>
                    <c:choose>
                        <c:when test="${not empty person.firstname && not empty person.surname}">
                            <c:set var="personName" value="${person.firstname}&nbsp;${person.surname}"/>
                            <span>${personName}</span>
                        </c:when>
                        <c:otherwise>
                            <span>${person.displayName}</span>
                        </c:otherwise>
                    </c:choose>
                </h3>

                <div class="extended-header favth-clearfix">
                    <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12"
                         style="line-height:22px; <c:if test="${isAuthenticated}">line-height:30px;</c:if>">
                        <span><a href="/orcid" title="Click here to know more about Orcid Integration"><i
                                class="fa fa-info-circle" aria-hidden="true"
                                style="font-size: 12px; padding-right: 0;"></i></a>&nbsp;ORCID</span>
                    </div>
                    <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                        <c:if test="${isAuthenticated}">
                            <a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank"><img
                                    alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="13"
                                    height="13" hspace="4" title="You are logged in with your ORCID account"/></a>
                        </c:if>
                        <c:if test="${not empty person.orcidId}">
                            <span><a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank">https://orcid.org/${person.orcidId}</a></span>
                        </c:if>

                        <c:if test="${empty tokenSession && showOrcidBtn}">
                            <button id="connect-orcid-button"><img id="orcid-id-icon" alt="ORCID logo"
                                                                   src="/content/resources/images/orcid_16x16.png"
                                                                   width="16" height="16" hspace="4"
                                                                   title="ORCID provides a persistent digital identifier that distinguishes you from other researchers. Learn more at orcid.org"/>Are
                                you ${personName} ? Register or Connect your ORCID
                            </button>
                        </c:if>

                        <c:choose>
                            <c:when test="${isAuthenticated}">
                                <c:set var="allWorks"
                                       value="${authoredPathwaysSize + authoredReactionsSize + reviewedPathwaysSize + reviewedReactionsSize}"/>
                                <button id="claim-your-work" name="all"><img id="orcid-id-icon-all" alt="ORCID logo"
                                                                             src="/content/resources/images/orcid_16x16.png"
                                                                             width="16" height="16" hspace="4"/>Claim
                                    all work (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                value="${allWorks}"/>)
                                </button>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${showOrcidBtn && (empty person.orcidId && not empty tokenSession)}">
                                    <div>
                                        <span><a href="/content/orcid/let-us-know-your-orcid" rel="nofollow noindex">Let us know your <img
                                                alt="ORCID logo" src="/content/resources/images/orcid_16x16.png"
                                                width="16" height="16" hspace="4" class="margin margin0"
                                                style="margin-bottom: 3px; margin-right: 1px;"/>ORCID.</a> </span>
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
                            <legend>Authored Pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                         value="${fn:length(authoredPathways)}"/>/<fmt:formatNumber
                                    type="number" maxFractionDigits="3" value="${authoredPathwaysSize}"/>)
                            </legend>
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
                                                <fmt:parseDate pattern="yyyy-MM-dd H:m:s.S"
                                                               value="${item.authored[0].dateTime}" var="date"/>
                                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                            </td>
                                            <td data-label="Identifier">
                                                <a href="${detailRequestPrefix}${item.stId}"
                                                   title="Go to Pathway bhbh ${item.stId}"  <c:if test="${not empty widget}">target="_blank"</c:if> > ${item.stId}</a>
                                            </td>
                                            <td data-label="Pathway">
                                                <span>${item.displayName}</span>
                                            </td>
                                            <td data-label="Reference">
                                                <a href="/cgi-bin/bibtex?DB_ID=${item.dbId};personId=${person.dbId}"
                                                   title="Export to BibTex" target="_blank">BibTex</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not param['showAll']}">
                                <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                                     style="padding: 5px 0 0 14px;">
                                    <c:choose>
                                        <c:when test="${not empty person.orcidId}">
                                            <a href="./${person.orcidId}/pathways/authored" class="" title="Show all">Show
                                                all authored pathways...</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="./${person.dbId}/pathways/authored" class="" title="Show all">Show
                                                all authored pathways...</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${isAuthenticated}">
                                <c:set var="columns"
                                       value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                                <c:if test="${param['showAll']}">
                                    <c:set var="columns" value="favth-col-xs-12"/>
                                </c:if>
                                <div class="${columns} text-right text-xs-center">
                                    <button id="claim-your-work-pa" name="pa"><img id="orcid-id-icon-pa"
                                                                                   alt="ORCID logo"
                                                                                   src="/content/resources/images/orcid_16x16.png"
                                                                                   width="16" height="16" hspace="4"/>Claim
                                        authored pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                             value="${authoredPathwaysSize}"/>)
                                    </button>
                                </div>
                            </c:if>
                        </fieldset>
                    </div>
                </c:if>

                <c:if test="${not empty authoredReactions}">
                    <div class="favth-clearfix">
                        <fieldset class="fieldset-details">
                            <legend>Authored Reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                          value="${fn:length(authoredReactions)}"/>/<fmt:formatNumber
                                    type="number" maxFractionDigits="3" value="${authoredReactionsSize}"/>)
                            </legend>
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
                                                <fmt:parseDate pattern="yyyy-MM-dd H:m:s.S"
                                                               value="${authoredReaction.authored[0].dateTime}"
                                                               var="date"/>
                                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                            </td>
                                            <td data-label="Identifier">
                                                <a href="/${authoredReaction.stId}"
                                                   title="Go to Pathway ${authoredReaction.stId}"> ${authoredReaction.stId}</a>
                                            </td>
                                            <td data-label="Reaction">
                                                <span>${authoredReaction.displayName}</span>
                                            </td>
                                            <td data-label="Reference">
                                                <a href="/cgi-bin/bibtex?DB_ID=${authoredReaction.dbId};personId=${person.dbId}"
                                                   title="Export to BibTex" target="_blank">BibTex</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not param['showAll']}">
                                <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                                     style="padding: 5px 0 0 14px;">
                                    <c:choose>
                                        <c:when test="${not empty person.orcidId}">
                                            <a href="./${person.orcidId}/reactions/authored" class="" title="Show all">Show
                                                all authored reactions...</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="./${person.dbId}/reactions/authored" class="" title="Show all">Show
                                                all authored reactions...</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${isAuthenticated}">
                                <c:set var="columns"
                                       value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                                <c:if test="${param['showAll']}">
                                    <c:set var="columns" value="avth-col-xs-12"/>
                                </c:if>
                                <div class="${columns} text-right text-xs-center">
                                    <button id="claim-your-work-ra" name="ra"><img id="orcid-id-icon-pr"
                                                                                   alt="ORCID logo"
                                                                                   src="/content/resources/images/orcid_16x16.png"
                                                                                   width="16" height="16" hspace="4"/>Claim
                                        authored reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                              value="${authoredReactionsSize}"/>)
                                    </button>
                                </div>
                            </c:if>
                        </fieldset>
                    </div>
                </c:if>

                <c:if test="${not empty reviewedPathways}">
                    <div class="favth-clearfix">
                        <fieldset class="fieldset-details">
                            <legend>Reviewed Pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                         value="${fn:length(reviewedPathways)}"/>/<fmt:formatNumber
                                    type="number" maxFractionDigits="3" value="${reviewedPathwaysSize}"/>)
                            </legend>
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
                                                <fmt:parseDate pattern="yyyy-MM-dd H:m:s.S"
                                                               value="${reviewedPathway.reviewed[0].dateTime}"
                                                               var="date"/>
                                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                            </td>
                                            <td data-label="Identifier">
                                                <a href="/${reviewedPathway.stId}"
                                                   title="Go to Pathway ${reviewedPathway.stId}">${reviewedPathway.stId}</a>
                                            </td>
                                            <td data-label="Pathway">
                                                <span>${reviewedPathway.displayName}</span>
                                            </td>
                                            <td data-label="Reference">
                                                <a href="/cgi-bin/bibtex?DB_ID=${reviewedPathway.dbId};personId=${person.dbId}"
                                                   title="Export to BibTex" target="_blank">BibTex</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not param['showAll']}">
                                <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                                     style="padding: 5px 0 0 14px;">
                                    <c:choose>
                                        <c:when test="${not empty person.orcidId}">
                                            <a href="./${person.orcidId}/pathways/reviewed" class="" title="Show all">Show
                                                all reviewed pathways...</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="./${person.dbId}/pathways/reviewed" class="" title="Show all">Show
                                                all reviewed pathways...</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${isAuthenticated}">
                                <c:set var="columns"
                                       value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                                <c:if test="${param['showAll']}">
                                    <c:set var="columns" value="favth-col-xs-12"/>
                                </c:if>
                                <div class="${columns} text-right text-xs-center">
                                    <button id="claim-your-work-pr" name="pr"><img id="orcid-id-icon-ra"
                                                                                   alt="ORCID logo"
                                                                                   src="/content/resources/images/orcid_16x16.png"
                                                                                   width="16" height="16" hspace="4"/>Claim
                                        reviewed pathways (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                             value="${reviewedPathwaysSize}"/>)
                                    </button>
                                </div>
                            </c:if>

                        </fieldset>
                    </div>
                </c:if>

                <c:if test="${not empty reviewedReactions}">
                    <div class="favth-clearfix">
                        <fieldset class="fieldset-details">
                            <legend>Reviewed Reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                          value="${fn:length(reviewedReactions)}"/>/<fmt:formatNumber
                                    type="number" maxFractionDigits="3" value="${reviewedReactionsSize}"/>)
                            </legend>
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
                                                <fmt:parseDate pattern="yyyy-MM-dd H:m:s.S"
                                                               value="${reviewedReaction.reviewed[0].dateTime}"
                                                               var="date"/>
                                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                            </td>
                                            <td data-label="Identifier">
                                                <a href="/${reviewedReaction.stId}"
                                                   title="Go to Pathway ${reviewedReaction.stId}">${reviewedReaction.stId}</a>
                                            </td>
                                            <td data-label="Reaction">
                                                <span>${reviewedReaction.displayName}</span>
                                            </td>
                                            <td data-label="Reference">
                                                <a href="/cgi-bin/bibtex?DB_ID=${reviewedReaction.dbId};personId=${person.dbId}"
                                                   title="Export to BibTex" target="_blank">BibTex</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not param['showAll']}">
                                <div class="favth-col-lg-9 favth-col-md-9 favth-col-sm-6 favth-col-xs-12"
                                     style="padding: 5px 0 0 14px;">
                                    <c:choose>
                                        <c:when test="${not empty person.orcidId}">
                                            <a href="./${person.orcidId}/reactions/reviewed" class="" title="Show all">Show
                                                all reviewed reactions...</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="./${person.dbId}/reactions/reviewed" class="" title="Show all">Show
                                                all reviewed reactions...</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${isAuthenticated}">
                                <c:set var="columns"
                                       value="favth-col-lg-3 favth-col-md-3 favth-col-sm-6 favth-col-xs-12"/>
                                <c:if test="${param['showAll']}">
                                    <c:set var="columns" value="favth-col-xs-12"/>
                                </c:if>
                                <div class="${columns} text-right text-xs-center">
                                    <button id="claim-your-work-rr" name="rr"><img id="orcid-id-icon-rr"
                                                                                   alt="ORCID logo"
                                                                                   src="/content/resources/images/orcid_16x16.png"
                                                                                   width="16" height="16" hspace="4"/>Claim
                                        reviewed reactions (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                                              value="${reviewedReactionsSize}"/>)
                                    </button>
                                </div>
                            </c:if>

                        </fieldset>
                    </div>
                </c:if>
            </div>
        </c:if>


        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <c:import url="personCommon.jsp"/>

    </div>
</div>