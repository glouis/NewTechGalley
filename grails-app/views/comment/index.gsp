
<%@ page import="com.newtechgalley.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-comment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="list-comment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="content" title="${message(code: 'comment.content.label', default: 'Content')}" />
					
						<th><g:message code="comment.user.label" default="User" /></th>
					
						<g:sortableColumn property="creationDate" title="${message(code: 'comment.creationDate.label', default: 'Creation Date')}" />
					
						<g:sortableColumn property="lastEditDate" title="${message(code: 'comment.lastEditDate.label', default: 'Last Edit Date')}" />
					
						<g:sortableColumn property="note" title="${message(code: 'comment.note.label', default: 'Note')}" />
					
						<th><g:message code="comment.post.label" default="Post" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${commentInstanceList}" status="i" var="commentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${commentInstance.id}">${fieldValue(bean: commentInstance, field: "content")}</g:link></td>
					
						<td>${fieldValue(bean: commentInstance, field: "user")}</td>
					
						<td><g:formatDate date="${commentInstance.creationDate}" /></td>
					
						<td><g:formatDate date="${commentInstance.lastEditDate}" /></td>
					
						<td>${fieldValue(bean: commentInstance, field: "note")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "post")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${commentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
