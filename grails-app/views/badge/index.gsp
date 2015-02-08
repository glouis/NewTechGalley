
<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils; com.newtechgalley.Badge" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'badge.label', default: 'Badge')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-badge" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="list-badge" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'badge.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="image" title="${message(code: 'badge.image.label', default: 'Image')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${badgeInstanceList}" status="i" var="badgeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${badgeInstance.id}">${fieldValue(bean: badgeInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: badgeInstance, field: "image")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
		<g:if test="${SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")}">
			<div class="nav" role="navigation">
				<ul>
					<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
				</ul>
			</div>
		</g:if>
	</body>
</html>
