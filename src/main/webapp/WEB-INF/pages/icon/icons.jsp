<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../header.jsp"/>

<c:choose>
    <c:when test="${not empty entries}">

        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
            <div class="ehld-breadcrumb">
                <a href="/icon-lib" class="icons-lib-home"><i class="icon-home"></i>Library home</a> > ${group}
            </div>
            <div class="ehld-result-title">
                <h3>
                    <i class="fa fa-folder"></i>${group}<span> (${totalIcons} components)</span>
                </h3>
            </div>
        </div>

        <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
        <c:forEach var="entry" items="${entries}" varStatus="loop">
            <div class="favth-col-lg-3 favth-col-md-4 favth-col-sm-6 favth-col-xs-12">
                <div class="favth-clearfix svg-container">
                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 svg-component">
                        <a href="${pageContext.request.contextPath}/detail/icon/${entry.iconName}">
                            <img src="/ehld-icons/lib/${folder}/${entry.iconName}.svg" alt="${entry.name}" />
                        </a>
                    </div>
                    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 svg-moreinfo">
                        <a href="${pageContext.request.contextPath}/detail/icon/${entry.iconName}" title="${entry.name}"><span class="text-lg-overflow">${entry.name}</span></a>
                    </div>
                </div>
            </div>
        </c:forEach>
        </div>

        <c:if test="${maxpage>1}">
            <div class="favth-row">
            <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12">
                <div id="pagination" class="pagination">
                    <ul class="pagination-list">
                        <c:choose>
                            <c:when test="${maxpage>1}">
                                <c:choose>
                                    <c:when test="${1 == page}">
                                        <li class="active"><a>1</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a class="pagenav" href="./${folder}?page=1">1</a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${page > 4}"><li><span style="border: none; padding: 15px 10px 0; color: #333;">...</span></li></c:if>
                                <c:forEach var="val" begin="2" end="${maxpage - 1}" >
                                    <c:if test="${val > page-3 && val < page+3}">
                                        <c:choose>
                                            <c:when test="${val == page}">
                                                <li class="active"><a>${val}</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a class="pagenav" href="./${folder}?page=${val}">${val}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${page < (maxpage - 3)}">
                                    <li><span style="border: none; padding: 15px 10px 0; color: #333;">...</span></li>
                                </c:if>
                                <c:choose>
                                    <c:when test="${maxpage == page}">
                                        <li class="active"><a>last</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a class="pagenav" href="./${folder}?page=${maxpage}">${maxpage}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </ul>
                </div>
            </div>
            </div>
        </c:if>
    </c:when>
    <c:otherwise>
        <p class="alert">Sorry we could not find any entry matching "${folder}" with the currently selected filters</p>
    </c:otherwise>
</c:choose>

<div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 padding0">
    <c:import url="disclaimer.jsp" />
</div>

<c:import url="../footer.jsp"/>