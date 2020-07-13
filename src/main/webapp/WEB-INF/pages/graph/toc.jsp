<%--
  Created by IntelliJ IDEA.
  User: cgong
  Date: 05/05/2020
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="../header.jsp"/>
<div class="favth-col-lg-12">
<c:if test="${not empty tocPathways}">
    <div id="r-responsive-table" class="padding0 top30">
        <table width="100%" class="reactome" border="0" cellpadding="0" cellspacing="0">
            <thead>
            <tr>
                <th scope="col">Topic</th>
                <th scope="col" width="19%">Authors</th>
                <th scope="col" width="10%">Released</th>
                <th scope="col" width="9%">Revised</th>
                <th scope="col" width="19%">Reviewers</th>
                <th scope="col" width="19%">Editors</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="pathway" items="${tocPathways}">
                <tr>
                    <td data-label="Topic">
                        <ul class="level0">
                            <li>
                                <a class="sidebar" href="/content/detail/${pathway.stId}"
                                   title="Show ${pathway.displayName}">
                                        ${pathway.displayName}[${pathway.species}]</a>
                                <span class="DOI"><c:if test="${not empty pathway.doi}">(DOI)</c:if></span></li>
                            <ul class="level1">
                                <c:forEach var="childPathway" items="${pathway.subPathway}">
                                    <li>
                                        -<a class="sidebar" href="/content/detail/${childPathway.stId}"
                                           title="Show ${childPathway.displayName}">
                                                ${childPathway.displayName}[${childPathway.speciesName}]</a>
                                        <span class="DOI"><c:if test="${not empty childPathway.doi}">(DOI)</c:if></span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </ul>
                    </td>

                    <td data-label="Authors">
                        <c:forEach var="person" items="${pathway.authors}" varStatus="status">
                            <c:set var="fullname" value="${person.surname}, ${not empty person.firstname ? person.firstname  : person.initial}"/>
                            <a href="/content/detail/person/${person.dbId}" >${fullname}</a><c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </td>

                    <td data-label="Released">
                        <c:choose>
                            <c:when test="${pathway.releaseStatus =='UPDATED'}"><img alt="Update" src="${pageContext.request.contextPath}/resources/images/update.png"/></c:when>
                            <c:when test="${pathway.releaseStatus =='NEW'}"><img alt="Update" src="${pageContext.request.contextPath}/resources/images/new.png"/></c:when>
                            <c:otherwise>${pathway.releaseStatus}</c:otherwise>
                        </c:choose>
                        ${pathway.releaseDate}
                    </td>

                    <td data-label="Revised">
                        <c:choose>
                            <c:when test="${not empty pathway.reviseDate}">
                                <c:set var="date" value="${pathway.reviseDate}"/>
                                <fmt:parseDate value="${date}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss.S"/>
                                <fmt:formatDate value="${parsedDate}" var="formatDate" pattern="yyyy-MM-dd"/>
                                <c:out value="${formatDate}"/>
                            </c:when>
                            <c:otherwise>
                                ${"&nbsp;"}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td data-label="Reviewers">
                        <c:forEach var="person" items="${pathway.reviewers}" varStatus="status">
                            <c:set var="fullname" value="${person.surname}, ${not empty person.firstname ? person.firstname  : person.initial}"/>
                            <a href="/content/detail/person/${person.dbId}" >${fullname}</a><c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </td>

                    <td data-label="Editors">
                        <c:forEach var="person" items="${pathway.editors}" varStatus="status">
                            <c:set var="fullname" value="${person.surname}, ${not empty person.firstname ? person.firstname  : person.initial}"/>
                            <a href="/content/detail/person/${person.dbId}" >${fullname}</a><c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</c:if>
</div>
<c:import url="../footer.jsp"/>
