<%@ page import="com.newtechgalley.Comment" %>

<g:hiddenField name="user.id" value="${commentInstance?.user?.id}" class="many-to-one" />

<g:hiddenField name="lastEditDate" precision="minute" value="${commentInstance?.lastEditDate}" default="none" />

<g:hiddenField name="post.id" value="${commentInstance?.post?.id}" default="none" />

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="comment.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="content" required="" value="${commentInstance?.content}"/>

</div>



