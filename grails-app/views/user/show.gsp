<%@ page import="com.newtechgalley.User" %>
<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils; com.newtechgalley.Post" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>
					
				</li>
				</g:if>

				<g:if test="${userInstance?.points}">
				<li class="fieldcontain">
					<span id="points-label" class="property-label"><g:message code="user.points.label" default="Points" /></span>
					
						<span class="property-value" aria-labelledby="points-label"><g:fieldValue bean="${userInstance}" field="points"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.mailAddress}">
				<li class="fieldcontain">
					<span id="mailAddress-label" class="property-label"><g:message code="user.mailAddress.label" default="Mail Address" /></span>
					
						<li class="property-value" aria-labelledby="mailAddress-label"><g:fieldValue bean="${userInstance}" field="mailAddress"/></li>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.accountExpired}">
				<li class="fieldcontain">
					<span id="accountExpired-label" class="property-label"><g:message code="user.accountExpired.label" default="Account Expired" /></span>
					
						<span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${userInstance?.accountExpired}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.accountLocked}">
				<li class="fieldcontain">
					<span id="accountLocked-label" class="property-label"><g:message code="user.accountLocked.label" default="Account Locked" /></span>
					
						<span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${userInstance?.accountLocked}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.badges}">
				<li class="fieldcontain">
					<span id="badges-label" class="property-label"><g:message code="user.badges.label" default="Badges" /></span>
					
						<g:each in="${userInstance.badges}" var="b">
						<span class="property-value" aria-labelledby="badges-label"><g:link controller="badge" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.enabled}">
				<li class="fieldcontain">
					<span id="enabled-label" class="property-label"><g:message code="user.enabled.label" default="Enabled" /></span>
					
						<span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${userInstance?.enabled}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.passwordExpired}">
				<li class="fieldcontain">
					<span id="passwordExpired-label" class="property-label"><g:message code="user.passwordExpired.label" default="Password Expired" /></span>
					
						<span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${userInstance?.passwordExpired}" /></span>
					
				</li>
				</g:if>

				<g:if test="${userInstance?.actionList}">
				<li class="fieldcontain">
					<span id="actionList-label" class="property-label"><g:message code="user.actionList.label" /></span>
					<g:each var="action" in="${userInstance.actionList}">
						<li class="fieldcontain">
							<span class="property-value" aria-labelledby="action-label"><g:message message="${action.key + " : " + action.value}"/></span>
						</li>
					</g:each>
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:userInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
				<g:if test="${userInstance?.id == sec.loggedInUserInfo(field: "id").toLong() || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")}">
					<g:link class="edit" action="edit" resource="${userInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
				</g:if>
			</g:form>
		</div>
	</body>
</html>
