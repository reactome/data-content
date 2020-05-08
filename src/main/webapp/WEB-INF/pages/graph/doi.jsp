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

<c:if test="${not empty doiPathways}">
    <div id="r-responsive-table" class="padding0 top30">
        <table width="100%" class="reactome" border="0" cellpadding="0" cellspacing="0">
            <thead>
            <tr>
                <th scope="col">Topic</th>
                <th scope="col">DOI</th>
                <th scope="col" width="20%">Authors</th>
                <th scope="col">Released</th>
                <th scope="col">Revised</th>
                <th scope="col" width="20%">Reviewers</th>
                <th scope="col" width="20%">Editors</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="pathway" items="${doiPathways}">
                <tr>
                    <td data-label="Topic">
                        <a href="/content/detail/${pathway.stId}" target="_blank"
                           title="Show ${pathway.displayName}">${pathway.displayName}</a>[${pathway.species}]
                    </td>
                    <td data-label="DOI">${pathway.doi}</td>

                    <td data-label="Authors">
                        <c:forEach var="person" items="${pathway.authors}" varStatus="status">
                            <c:set var="fullname" value="${person.surname}, ${person.firstname}"/>
                            <a href="/content/detail/person/${person.dbId}" target="_blank">${fullname}</a>
                            <c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </td>

                    <td data-label="Released">${pathway.releaseDate} ${pathway.releaseStatus}</td>

                    <td data-label="Revised">
                        <c:if test="${not empty pathway.reviseDate}">
                            <c:set var="date" value="${pathway.reviseDate}"/>
                            <fmt:parseDate value="${date}" var="parsedDate"  pattern="yyyy-MM-dd HH:mm:ss.S" />
                            <fmt:formatDate value="${parsedDate}" var= "formatDate" pattern="yyyy-MM-dd" />
                            <c:out value = "${formatDate}" />
                        </c:if>
                    </td>

                    <td data-label="Reviewers">
                        <c:forEach var="person" items="${pathway.reviewers}" varStatus="status">
                            <c:set var="fullname" value="${person.surname}, ${person.firstname}"/>
                            <a href="/content/detail/person/${person.dbId}" target="_blank">${fullname}</a>
                            <c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </td>

                    <td data-label="Editors">
                        <c:forEach var="person" items="${pathway.editors}" varStatus="status">
                            <c:set var="fullname" value="${person.surname}, ${person.firstname}"/>
                            <a href="/content/detail/person/${person.dbId}" target="_blank">${fullname}</a>
                            <c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</c:if>
<c:import url="../footer.jsp"/>
