<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="../header.jsp"/>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 clearfix advanced-search">
    <h2>Advanced search</h2>
    <form id="adv-search" action="/content/query" method="get">
        <div>
            <p>This parser supports full <a href="http://lucene.apache.org/core/2_9_4/queryparsersyntax.html">Lucene QueryParser syntax</a>  including:</p>
            <ul>
                <li>Quotation marks for exact searches and brackets for grouping terms together</li>
                <li>Boolean operators: 'AND', 'OR', 'NOT', '+' and '-'</li>
                <li>Wildcard operators: '?' and '*'</li>
                <li> Proximity matching: "raf map"~4  searches for raf and map within 4 words from each other</li>
            </ul>
            <%--<p>Additionally you can specify the field you want to search in with:  </p>--%>
            <%--<ul>--%>
                <%--<li>Available fields: dbId, stId, name, type, species, synonyms, summation, compartmentName, compartmentAccession, goBiologicalProcessName, goBiologicalProcessAccession, goCellularComponentName, goCellularComponentAccession, goMolecularFunctionName, goMolecularFunctionAccession, literatureReferenceTitle, literatureReferenceAuthor, literatureReferencePubMedId, literatureReferenceIsbn, crossReferences, referenceCrossReferences, referenceName, referenceSynonyms, referenceIdentifier, referenceOtherIdentifier, referenceGeneNames</li>--%>
                <%--<li>Syntax: fieldname:searchterm</li>--%>
            <%--</ul>--%>
            <label for="querySearchBox"></label><textarea name="q" rows="10" id="querySearchBox">(raf AND map) OR (name:"PTEN S170N") OR (apoptosis) OR stID:"REACT_12858.1" OR stID:"R-HSA-198344.1"</textarea>
        </div>

        <%-- MOBILE VIEW --%>
        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 favth-visible-xs favth-visible-sm clearfix padding0 bottom">
            <div style="margin-top: 10px;">
                <a><i class="fa fa-filter"></i><span onclick="openSideNav();">Filtering Parameters</span></a>
            </div>
        </div>

        <div class="sidenav-bg" style="display: none;"></div>
        <div id="search-filter-sidenav" class="sidenav favth-visible-xs favth-visible-sm">
            <div class="sidenav-panel">
                <a href="javascript:void(0);" class="closebtn" onclick="closeSideNav();">&times;</a>
                <c:import url="advancedFilter.jsp" />
            </div>
            <div class="text-center clearfix">
                <input type="hidden" name="cluster" value="true"/>
                <input type="button" name="applyFilter" value="Apply" class="btn btn-info" onclick="closeSideNav();"  />
            </div>
        </div>

        <%-- DESKTOP VIEW --%>
        <div class="favth-hidden-xs favth-hidden-sm">
            <h3>Filtering Parameters</h3>
            <div class="favth-col-lg-12 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 advanced-filter clearfix">
                <c:import url="advancedFilter.jsp" />
            </div>
        </div>

        <div class="text-center">
            <input type="hidden" name="cluster" value="true"/>
            <input type="submit" name="submitSearch" value="Search" class="btn btn-info" />
        </div>

    </form>
</div>
<c:import url="../footer.jsp"/>
