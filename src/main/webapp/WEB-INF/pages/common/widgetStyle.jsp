<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html xmlns="//www.w3.org/1999/xhtml" xml:lang="en-gb" lang="en-gb" dir="ltr" >
<%--This is used to style the detail widget page, a copy of <head> in the herader.jsp and a data-content js file from footer.jsp--%>
<head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="pathway,reactions,graph,bioinformatics" />
    <meta name="robots" content="index, follow" />
    <meta name="description" content="Reactome is pathway database which provides intuitive bioinformatics tools for the visualisation, interpretation and analysis of pathway knowledge." />
    <meta name="generator" content="Joomla! - Open Source Content Management" />
    <title>Reactome | ${title}</title>
    <link href="/templates/favourite/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon" />
    <link href="/plugins/system/jce/css/content.css?2d6e41bd42b1170002be6c6f0ead79b2" rel="stylesheet" type="text/css" />
    <link href="/media/jui/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/media/jui/css/bootstrap-responsive.css" rel="stylesheet" type="text/css" />
    <link href="/templates/favourite/bootstrap/favth-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="/modules/mod_favsocial/theme/css/favsocial.css" rel="stylesheet" type="text/css" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script type="application/json" class="joomla-script-options new">{"csrf.token":"415d25ffab4ff28a995c2a5afe8907f3","system.paths":{"root":"","base":""}}</script>
    <script src="/media/jui/js/jquery.min.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script src="/media/jui/js/jquery-noconflict.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script src="/media/jui/js/jquery-migrate.min.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script src="/media/system/js/caption.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script src="/media/system/js/core.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script src="/media/jui/js/bootstrap.min.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script src="/templates/favourite/bootstrap/favth-bootstrap.js" type="text/javascript"></script>
    <script src="/templates/favourite/js/clipboard.min.js" type="text/javascript"></script>
    <script src="/templates/favourite/js/citation-query.js" type="text/javascript"></script>
    <script src="/media/jui/js/jquery.autocomplete.min.js?2d6e41bd42b1170002be6c6f0ead79b2" type="text/javascript"></script>
    <script type="text/javascript">
        jQuery(window).on('load',  function() {
            new JCaption('img.caption');
        });
    </script>


    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- STYLESHEETS -->
    <!-- Custom: type is not needed, remove it -->
    <!-- icons -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <!-- admin -->
    <link rel="stylesheet" href="/templates/favourite/admin/admin.css" />
    <!-- cms -->
    <link rel="stylesheet" href="/templates/favourite/css/cms.css" />
    <!-- theme -->
    <link rel="stylesheet" href="/templates/favourite/css/theme.css" />
    <!-- style -->
    <link rel="stylesheet" href="/templates/favourite/css/style.css" />
    <!-- styles -->
    <link rel="stylesheet" href="/templates/favourite/css/styles/style2.css" />
    <!-- Custom: Our custom css -->
    <link rel="stylesheet" href="/templates/favourite/css/custom.css?v=1.1.1" />
    <!-- Custom: Stylying the autocomplete div-->
    <link rel="stylesheet" href="/templates/favourite/css/autocomplete/autocomplete.css" />
    <!-- Custom: rglyph fonts -->
    <link rel="stylesheet" href="/templates/favourite/rglyph/rglyph.css" />

    <!-- GOOGLE FONT -->
    <!-- navigation -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:400' rel='stylesheet' />
    <!-- titles -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' />
    <!-- text logo -->
    <link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:700' rel='stylesheet' />
    <!-- default -->
    <link href="//fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet" />
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
        #fav-offlinewrap {
            background-repeat: no-repeat; background-attachment: fixed; -webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover;;
        }
        body {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-noticewrap.fav-module-block-color {
            background-color: #FCF8E3;
        }
        #fav-noticewrap p {
            color: #8A6D3B;
        }
        #fav-topbarwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-topbarwrap.fav-module-block-color {
            background-color: #F2DEDE;
        }
        #fav-topbarwrap p {
            color: #A94442;
        }
        #fav-slidewrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-slidewrap.fav-module-block-color {
            background-color: #F0F0F0;
        }
        #fav-introwrap.fav-module-block-clear {
            background-repeat: no-repeat; background-attachment: fixed; -webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover;;
        }
        #fav-breadcrumbswrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-leadwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-promowrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-primewrap.fav-module-block-clear {
            background-repeat: no-repeat; background-attachment: fixed; -webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover;;
        }
        #fav-primewrap.fav-module-block-color {
            background-color: #FFFFFF;
        }
        #fav-showcasewrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-showcasewrap.fav-module-block-color {
            background-color: #111111;
        }
        #fav-featurewrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-focuswrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-portfoliowrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-screenwrap.fav-module-block-clear {
            background-repeat: no-repeat; background-attachment: fixed; -webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover;;
        }
        #fav-screenwrap.fav-module-block-color {
            background-color: #F0F0F0;
        }
        #fav-screenwrap h3:first-of-type {
            color: #444444;
        }
        #fav-topwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-topwrap h3:first-of-type {
            color: #444444;
        }
        #fav-maintopwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-mainbottomwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-bottomwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-notewrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-basewrap.fav-module-block-clear {
            background-repeat: no-repeat; background-attachment: fixed; -webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover;;
        }
        #fav-blockwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-userwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-userwrap.fav-module-block-color {
            background-color: #F0F0F0;
        }
        #fav-footerwrap.fav-module-block-clear {
            background-repeat: repeat; background-attachment: initial; -webkit-background-size: auto; -moz-background-size: auto; -o-background-size: auto; background-size: auto;;
        }
        #fav-footerwrap.fav-module-block-color {
            background-color: #58C3E5;
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
        .slogan {
            line-height: 14px;
        }
        .retina-logo {
            height: 52px;
        }
        .retina-logo {
            width: 188px;
        }
        .retina-logo {
            padding: 0px;
        }
        .retina-logo {
            margin: 0px;
        }
        @media (max-width: 480px) {
            p {
                font-size: 12px;
            }
        }

    </style>


    <!-- GOOGLE ANALYTICS TRACKING CODE -->

    <!-- Custom: Global Site Tag (gtag.js) - Google Analytics -->
    <c:if test="${pageContext.request.serverName eq 'reactome.org'}">
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-42985898-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments)};
        gtag('js', new Date());
        gtag('config', 'UA-42985898-1');
    </script>
    </c:if>

    <!-- FAVTH SCRIPTS -->
    <script src="/templates/favourite/js/favth-scripts.js"></script>

    <!-- Google Webmaster Tools -->
    <meta name="google-site-verification" content="RTiL6uaaS_DH5XmjYzK76jixDNHfH2KicYr2jT2y1Cw" />
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "WebSite",
            "url": "https://reactome.org/",
            "potentialAction": {
                "@type": "SearchAction",
                "target": "https://reactome.org/content/query?q={term}",
                "query-input": "required name=term"
            }
        }
    </script>

    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "Organization",
            "url": "https://reactome.org",
            "logo": "https://reactome.org/templates/favourite/images/logo/logo.png",
            "email": "help@reactome.org"
        }
    </script>
    <link rel="stylesheet" href="/content/resources/css/main.css?v=20180710" type="text/css" />
    <link rel="stylesheet" href="/content/resources/css/icon-lib.css?v=20180712" type="text/css" />
    <jsp:include page="../graph/json-ld.jsp"/>

    <%--This js file is from footer.jsp--%>
    <script type="text/javascript" src="/content/resources/js/data-content.js?v=3.2"></script>
</head>



