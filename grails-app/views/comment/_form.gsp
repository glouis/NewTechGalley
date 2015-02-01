<%@ page import="com.newtechgalley.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="comment.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="content" required="" value="${commentInstance?.content}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="comment.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.newtechgalley.User.list()}" optionKey="id" required="" value="${commentInstance?.user?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'creationDate', 'error')} required">
	<label for="creationDate">
		<g:message code="comment.creationDate.label" default="Creation Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="creationDate" precision="day"  value="${commentInstance?.creationDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'lastEditDate', 'error')} ">
	<label for="lastEditDate">
		<g:message code="comment.lastEditDate.label" default="Last Edit Date" />
		
	</label>
	<g:datePicker name="lastEditDate" precision="day"  value="${commentInstance?.lastEditDate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'note', 'error')} required">
	<label for="note">
		<g:message code="comment.note.label" default="Note" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="note" type="number" value="${commentInstance.note}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'post', 'error')} required">
	<label for="post">
		<g:message code="comment.post.label" default="Post" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="post" name="post.id" from="${com.newtechgalley.Post.list()}" optionKey="id" required="" value="${commentInstance?.post?.id}" class="many-to-one"/>

</div>

