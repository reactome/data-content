<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
        <div class="favth-col-xs-12">

            <%--backslash breaks the links here, the out put is //detail/widget/--%>
            <%--  <c:set var="detailRequestPrefix" value="${pageContext.request.contextPath}/detail/widget/"/>--%>

            <h3 class="details-title">
                <i class="fa fa-puzzle-piece title-icon" title="${entry.exactType}"></i> ${entry.iconName}
            </h3>

            <div class="extended-header favth-clearfix">
                <c:if test="${not empty entry.iconCategories}">
                    <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                        <span>Categories</span>
                    </div>
                    <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                        <c:forEach var="category" items="${categories}" varStatus="loop">
                            <c:set var="categoryLink"
                                   value="${fn:replace(category, ' ', '_')}"/> <%-- replace spaces so the url doens't need to be encoded --%>
                            <span><a href="/icon-lib/${fn:toLowerCase(categoryLink)}"
                                     title="Go to ${category}">${category}
                                    <c:if test="${not empty widget}"> target="_blank" </c:if></a>
                                <c:if test="${not loop.last}">, </c:if></span>
                        </c:forEach>
                    </div>
                </c:if>

                <c:if test="${not empty entry.iconCuratorName}">
                    <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                        <span>Curator</span>
                    </div>
                    <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                        <c:choose>
                            <c:when test="${not empty entry.iconCuratorOrcidId}">
                                <span><a
                                        href="https://orcid.org/${entry.iconCuratorOrcidId}">${entry.iconCuratorName}</a></span>
                            </c:when>
                            <c:otherwise>
                                <span><a href="${entry.iconCuratorUrl}">${entry.iconCuratorName}</a></span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <c:if test="${not empty entry.iconDesignerName}">
                    <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                        <span>Designer</span>
                    </div>
                    <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                        <c:choose>
                            <c:when test="${not empty entry.iconDesignerOrcidId}">
                                <span><a
                                        href="https://orcid.org/${entry.iconDesignerOrcidId}">${entry.iconDesignerName}</a></span>
                            </c:when>
                            <c:otherwise>
                                <span><a href="${entry.iconDesignerUrl}">${entry.iconDesignerName}</a></span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <c:if test="${not empty entry.iconDesignerName}">
                    <div class="details-label favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12">
                        <span>Description</span>
                    </div>
                    <div class="details-field favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12">
                        <span>${entry.summation}</span>
                    </div>
                </c:if>
            </div>

            <fieldset class="fieldset-details">
                <legend>Icon preview</legend>
                <div class="favth-col-lg-3 favth-col-md-4 favth-col-sm-5 favth-col-xs-12 text-center margin0 top">
                    <img class="icon-preview" src="/icon/${entry.stId}.svg" alt="Icon ${entry.iconName}"/>
                </div>
                <div class="favth-col-lg-9 favth-col-md-6 favth-col-sm-5 favth-col-xs-12 text-xs-center margin0 top">
                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
                        <span><a href="/icon/${entry.stId}.svg" download="${entry.stId}.svg"
                                 title="Click to download the icon in SVG format"><i class="fa fa-download"></i> SVG</a></span>
                    </div>
                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
                        <span><a href="/icon/${entry.stId}.png" download="${entry.stId}.png"
                                 title="Click to download the icon in PNG format"><i class="fa fa-download"></i> PNG</a></span>
                    </div>
                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-4 padding0 bottom">
                        <span><a href="/icon/${entry.stId}.emf" download="${entry.stId}.emf"
                                 title="Click to download the icon in EMF format"><i class="fa fa-download"></i> EMF</a></span>
                    </div>
                </div>
            </fieldset>

            <c:if test="${not empty pwbTree && not fn:containsIgnoreCase(entry.iconCategories, 'arrow')}">
                <div class="clearfix">
                    <fieldset class="fieldset-details">
                        <legend>Locations in the PathwayBrowser</legend>
                        <c:if test="${not empty pwbTree}">
                            <c:set var="suggestExpandAll" scope="request" value="false"/>
                            <c:forEach items="${pwbTree}" var="ehldPWB">
                                <c:forEach var="topLvl" items="${ehldPWB}">
                                    <c:if test="${not suggestExpandAll && not empty topLvl.children}">
                                        <c:set var="suggestExpandAll" scope="request" value="true"/>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                            <c:if test="${suggestExpandAll}">
                                <div class="favth-col-xs-12 favth-text-right">
                                    <a id="pwb_toggle" class="expand-all">Expand all</a>
                                </div>
                            </c:if>
                        </c:if>

                        <div class="favth-col-xs-12">
                            <c:forEach var="ehldPWB" items="${pwbTree}">
                                <c:forEach var="topLvl" items="${ehldPWB}">
                                    <c:choose>
                                        <c:when test="${empty topLvl.children}">
                                            <div id="tpla_${topLvl.stId}" class="tplSpe_">
                            <span class="tree-root tree-root-overflow"
                                  title="click here to expand or collapse the tree">
                                <i class="fa fa-square-o" style="vertical-align: middle"></i>
                                <i class="sprite-resize sprite sprite-Pathway" title="${topLvl.type}"
                                   style="vertical-align: middle"></i>
                                <a href="${topLvl.url}"
                                   <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if>
                                   title="goto Reactome Pathway Browser" <c:if
                                        test="${not empty widget}"> target="_blank" </c:if> >${topLvl.name} (${topLvl.stId})</a>
                            </span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <%--
                                                The class attribute is used as a jQuery selector. This class is not present in the css.
                                                Specially for chemical, it is present in all species, instead of showing a big list we just show Human as the default
                                                and let the user select the desired species in a dropdown list.
                                             --%>
                                            <div id="tpla_${topLvl.stId}" class="tplSpe_" style="display: none">
                                    <span class="plus tree-root" title="click here to expand or collapse the tree">
                                        <i class="fa fa-plus-square-o" title="click here to expand or collapse the tree"
                                           style="vertical-align: middle"></i>
                                        <i class="sprite-resize sprite sprite-Pathway"
                                           style="vertical-align: middle"></i>
                                        <a href="${topLvl.url}"
                                           <c:if test="${topLvl.highlighted}">class="tree-highlighted-item"</c:if>
                                           title="goto Reactome Pathway Browser" <c:if
                                                test="${not empty widget}"> target="_blank" </c:if> >${topLvl.name} (${topLvl.stId})</a>
                                    </span>
                                                <div class="tree-lpwb">
                                                    <ul class="tree">
                                                        <c:set var="node" value="${topLvl}" scope="request"/>
                                                        <li><c:import url="node.jsp"/></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:forEach>
                        </div>
                    </fieldset>
                </div>
            </c:if>

            <%-- Mapping an icon to its instance in Reactome --%>
            <c:if test="${not empty entry.iconPhysicalEntities}">
                <fieldset class="fieldset-details">
                    <legend>Entries for ${entry.name}</legend>
                    <div class="fieldset-pair-container">
                        <div class="favth-col-xs-12">
                            <div class="wrap overflow">
                                <c:forEach var="iconPE" items="${entry.iconPhysicalEntities}">
                                    <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-6 favth-col-xs-12 text-overflow">
                                            <%-- index: 0=ST_ID, 1=Type, 2=Name, 3=Compartment --%>
                                        <a href="${iconPE.stId}" title="Open ${iconPE.stId}"><i
                                                class="sprite sprite-${iconPE.type}" title="${iconPE.type}"
                                                style="vertical-align: middle; height: 18px;"></i> ${iconPE.displayName}
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </c:if>

            <c:if test="${not empty references}">
                <div class="favth-clearfix">
                    <fieldset class="fieldset-details">
                        <legend>External References</legend>
                        <c:forEach var="entry" items="${references}">
                            <div class="fieldset-pair-container">
                                <div class="favth-clearfix">
                                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">${entry.key}</div>
                                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                        <div>
                                            <c:forEach var="value" items="${entry.value}" varStatus="loop">
                                                <c:set var="accessUrl" value="${urlMapping[entry.key.toUpperCase()]}"/>
                                                <c:choose>
                                                    <c:when test="${not empty accessUrl}">
                                                        <a href="${fn:replace(accessUrl, '###ID###', value)}"
                                                           target="_blank"
                                                           title="show ${entry.key}:${value}">${value}</a><c:if
                                                            test="${!loop.last}">, </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${value}<c:if test="${!loop.last}">, </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </fieldset>
                </div>
            </c:if>

        </div>
    </div>
</div>