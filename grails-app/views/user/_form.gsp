<%@ page import="com.newtechgalley.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'points', 'error')} required">
	<label for="points">
		<g:message code="user.points.label" default="Points" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="points" type="number" value="${userInstance.points}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'mailAddress', 'error')} ">
	<label for="mailAddress">
		<g:message code="user.mailAddress.label" default="Mail Address" />
		
	</label>
	<g:textField name="mailAddress" value="${userInstance?.mailAddress}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'badges', 'error')} ">
	<label for="badges">
		<g:message code="user.badges.label" default="Badges" />
		
	</label>
	<g:select name="badges" from="${com.newtechgalley.Badge.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.badges*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${userInstance?.enabled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />

</div>

