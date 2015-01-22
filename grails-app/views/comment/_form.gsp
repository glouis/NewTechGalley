<%@ page import="com.newtechgalley.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="comment.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="content" required="" value="${commentInstance?.content}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'note', 'error')} required">
	<label for="note">
		<g:message code="comment.note.label" default="Note" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="note" type="number" value="${commentInstance.note}" required=""/>

</div>

