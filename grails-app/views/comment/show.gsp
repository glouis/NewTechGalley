
<%@ page import="com.newtechgalley.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-comment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="show-comment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list comment">
			
				<g:if test="${commentInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="comment.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${commentInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="comment.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${commentInstance?.user?.id}">${commentInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.creationDate}">
				<li class="fieldcontain">
					<span id="creationDate-label" class="property-label"><g:message code="comment.creationDate.label" default="Creation Date" /></span>
					
						<span class="property-value" aria-labelledby="creationDate-label"><g:formatDate date="${commentInstance?.creationDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.lastEditDate}">
				<li class="fieldcontain">
					<span id="lastEditDate-label" class="property-label"><g:message code="comment.lastEditDate.label" default="Last Edit Date" /></span>
					
						<span class="property-value" aria-labelledby="lastEditDate-label"><g:formatDate date="${commentInstance?.lastEditDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.note}">
				<li class="fieldcontain">
					<span id="note-label" class="property-label"><g:message code="comment.note.label" default="Note" /></span>
					
						<span class="property-value" aria-labelledby="note-label"><g:fieldValue bean="${commentInstance}" field="note"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.post}">
				<li class="fieldcontain">
					<span id="post-label" class="property-label"><g:message code="comment.post.label" default="Post" /></span>
					
						<span class="property-value" aria-labelledby="post-label"><g:link controller="post" action="show" id="${commentInstance?.post?.id}">${commentInstance?.post?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:commentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${commentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
