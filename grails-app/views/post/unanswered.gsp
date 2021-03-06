
<%@ page import="com.newtechgalley.Post" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}" />
    <title><g:message code="post.unanswered.list.label" /></title>
</head>
<body>
<a href="#list-post" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div id="list-post" class="content scaffold-list" role="main">
    <h1><g:message code="post.unanswered.list.label" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="title" title="${message(code: 'post.title.label', default: 'Title')}" />

            <g:sortableColumn property="content" title="${message(code: 'post.content.label', default: 'Content')}" />

            <th><g:message code="post.user.label" default="User" /></th>

            <g:sortableColumn property="creationDate" title="${message(code: 'post.creationDate.label', default: 'Creation Date')}" />

            <g:sortableColumn property="lastEditDate" title="${message(code: 'post.lastEditDate.label', default: 'Last Edit Date')}" />

            <g:sortableColumn property="note" title="${message(code: 'post.note.label', default: 'Note')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${postInstanceList}" status="i" var="postInstance">
            <g:if test="${postInstance?.validated != true}">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show" id="${postInstance.id}">${fieldValue(bean: postInstance, field: "title")}</g:link></td>

                    <td>${fieldValue(bean: postInstance, field: "content")}</td>

                    <td>${fieldValue(bean: postInstance, field: "user")}</td>

                    <td><g:formatDate date="${postInstance.creationDate}" /></td>

                    <td><g:formatDate date="${postInstance.lastEditDate}" /></td>

                    <td>${fieldValue(bean: postInstance, field: "note")}</td>

                </tr>
                </g:if>
        </g:each>
        </tbody>
    </table>
</div>
</body>
</html>
