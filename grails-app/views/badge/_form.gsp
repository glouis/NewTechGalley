<%@ page import="com.newtechgalley.Badge" %>



<div class="fieldcontain ${hasErrors(bean: badgeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="badge.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${badgeInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: badgeInstance, field: 'image', 'error')} required">
	<label for="image">
		<g:message code="badge.image.label" default="Image" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

