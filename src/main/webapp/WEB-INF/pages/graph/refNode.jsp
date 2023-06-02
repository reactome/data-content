<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="m" uri="/WEB-INF/tld/modelTags.tld" %>


<%--
   The class attribute is used as a jQuery selector. This class is not present in the css.
   Specially for chemical, it is present in all species, instead of showing a big list we just show Human as the default
   and let the user select the desired species in a dropdown list.
--%>
<div id="tpla_${entity.stId}">
<span class="plus tree-root" title="click here to expand or collapse the tree">
<i class="fa fa-plus-square-o" title="click here to expand or collapse the tree"
   style="vertical-align: middle"></i>
<m:link object="${entity}" detailRequestPrefix="${detailRequestPrefix}"/>
</span>
    <div class="tree-lpwb no-max">
        <ul class="tree">
            <li>
                <ul>
                    <c:forEach var="ref" items="${markerMapping.get(entity)}">
                        <li>
                            <m:ref publication="${ref}"/>
                        </li>
                    </c:forEach>
                </ul>
            </li>

        </ul>
    </div>
</div>