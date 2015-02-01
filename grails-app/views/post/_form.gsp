<%@ page import="com.newtechgalley.Post" %>



<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="post.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${postInstance?.title}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'content', 'error')} required">
	<label for="content">
		<g:message code="post.content.label" default="Content" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="content" required="" value="${postInstance?.content}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="post.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.newtechgalley.User.list()}" optionKey="id" required="" value="${postInstance?.user?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'creationDate', 'error')} required">
	<label for="creationDate">
		<g:message code="post.creationDate.label" default="Creation Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="creationDate" precision="day"  value="${postInstance?.creationDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'lastEditDate', 'error')} ">
	<label for="lastEditDate">
		<g:message code="post.lastEditDate.label" default="Last Edit Date" />
		
	</label>
	<g:datePicker name="lastEditDate" precision="day"  value="${postInstance?.lastEditDate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'categories', 'error')} ">
	<label for="categories">
		<g:message code="post.categories.label" default="Categories" />
		
	</label>
	<g:select name="categories" from="${com.newtechgalley.Category.list()}" multiple="multiple" optionKey="id" size="5" value="${postInstance?.categories*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="post.comments.label" default="Comments" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${postInstance?.comments?}" var="c">
    <li><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="comment" action="create" params="['post.id': postInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'note', 'error')} required">
	<label for="note">
		<g:message code="post.note.label" default="Note" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="note" type="number" value="${postInstance.note}" required=""/>

</div>

