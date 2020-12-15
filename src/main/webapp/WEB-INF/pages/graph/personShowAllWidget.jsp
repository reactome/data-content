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


<div id="fav-container" class="fav-container">
    <div class="favth-container" style="margin: 0; width:100%">

        <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/"/>

        <c:set value="${pageContext.session.getAttribute('orcidToken')}" var="tokenSession"/>
        <c:set value="${showOrcidBtn && not empty tokenSession && (person.orcidId == tokenSession.orcid)}"
               var="isAuthenticated"/>

        <%-- Person Page--%>
        <c:if test="${not empty person}">
            <c:choose>
                <c:when test="${not empty person.orcidId}">
                    <a href="${detailRequestPrefix}/widget/person/${person.orcidId}" class="" title="Return to person details">
                        <<< Go back</a>
                </c:when>
                <c:otherwise>
                    <a href="${detailRequestPrefix}/widget/person/${person.dbId}" class="" title="Return to person details"> <<<
                        Go back</a>
                </c:otherwise>
            </c:choose>
            <div class="favth-col-xs-12">
                <h3 class="details-title">
                    <i class="sprite sprite-Person"></i>
                    <c:set var="personName" value="${person.displayName}"/>
                    <c:choose>
                        <c:when test="${not empty person.firstname && not empty person.surname}">
                            <c:set var="personName" value="${person.firstname}&nbsp;${person.surname}"/>
                            <span>${person.firstname}&nbsp;${person.surname}</span>
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
                            <img alt="ORCID logo" src="/content/resources/images/orcid_16x16.png" width="13" height="13"
                                 hspace="4" title="You are logged in with your ORCID account"/>
                        </c:if>
                        <c:if test="${not empty person.orcidId}">
                            <span><a href="https://orcid.org/${person.orcidId}" rel="nofollow noindex" target="_blank">https://orcid.org/${person.orcidId}</a></span>
                        </c:if>

                        <c:if test="${showOrcidBtn && empty tokenSession}">
                            <button id="connect-orcid-button"><img id="orcid-id-icon" alt="ORCID logo"
                                                                   src="/content/resources/images/orcid_16x16.png"
                                                                   width="16" height="16" hspace="4"
                                                                   title="ORCID provides a persistent digital identifier that distinguishes you from other researchers. Learn more at orcid.org"/>Are
                                you ${personName} ? Register or Connect your ORCID
                            </button>
                        </c:if>

                        <c:choose>
                            <c:when test="${isAuthenticated}">
                                <button id="claim-your-work-${claimyourworkpath}" name="${claimyourworkpath}"><img
                                        id="orcid-id-icon-${claimyourworkpath}" alt="ORCID logo"
                                        src="/content/resources/images/orcid_16x16.png" width="16" height="16"
                                        hspace="4"/>Claim ${fn:toLowerCase(label)} (<fmt:formatNumber type="number"
                                                                                                      maxFractionDigits="3"
                                                                                                      value="${fn:length(list)}"/>)
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

                <c:if test="${not empty list}">
                    <fieldset class="fieldset-details">
                        <legend>${label} (<fmt:formatNumber type="number" maxFractionDigits="3"
                                                            value="${fn:length(list)}"/>)
                        </legend>
                        <div id="r-responsive-table-ap" class="details-wrap" style="max-height: none;">
                            <table class="reactome">
                                <thead>
                                <tr>
                                    <th scope="col" style="width:10%;">Date</th>
                                    <th scope="col" style="width:15%;">Identifier</th>
                                    <th scope="col" style="width:70%;">${type}</th>
                                    <th scope="col" style="width:5%;">Reference</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="item" items="${list}">
                                    <tr>
                                        <td data-label="Date">
                                            <c:choose>
                                                <c:when test="${attribute eq 'authored'}">
                                                    <fmt:parseDate pattern="yyyy-MM-dd H:m:s.S"
                                                                   value="${item.authored[0].dateTime}" var="date"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:parseDate pattern="yyyy-MM-dd H:m:s.S"
                                                                   value="${item.reviewed[0].dateTime}" var="date"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <span><fmt:formatDate pattern="yyyy-MM-dd" value="${date}"/></span>
                                        </td>
                                        <td data-label="Identifier">
                                            <a href="${detailRequestPrefix}${item.stId}"
                                               title="Go to Pathway ${item.stId}"
                                               <c:if test="${not empty widget}">target="_blank"</c:if>> ${item.stId}</a>
                                        </td>
                                        <td data-label="${type}">
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
                    </fieldset>
                </c:if>

            </div>
        </c:if>

        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <c:import url="personCommon.jsp"/>

    </div>
</div>