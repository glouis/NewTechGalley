<%@ page import="com.newtechgalley.User" %>


<g:if test="${request.getRequestURI().contains("create")}">
<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="username" required="" value="${userInstance?.username}"/>

</div>
</g:if>
<g:else>
	<g:if test="${userInstance?.username}">
		<div class="fieldcontain">
			<span id="username-label" class="property-label"><g:message code="user.username.label" default="Username" /></span>

			<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></span>

		</div>
	</g:if>
</g:else>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:passwordField id="passwordInput" name="password" required="" value="${userInstance?.password}"/>

</div>

<div class="fieldcontain">
	<label for="passwordConfirm">
		<g:message code="user.passwordConfirm.label" default="Confirm Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:passwordField id="passwordConfirmInput" name="passwordConfirm" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'mailAddress', 'error')} ">
	<label for="mailAddress">
		<g:message code="user.mailAddress.label" default="Mail Address" />
		
	</label>
	<g:field type="mailAddress" name="mailAddress" value="${userInstance?.mailAddress}"/>
</div>
