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
	<g:textArea name="content" required="" value="${postInstance?.content}"/>

</div>

<g:hiddenField name="user.id" value="${postInstance?.user?.id}" class="many-to-one" />

<g:hiddenField name="lastEditDate" precision="minute" value="${postInstance?.lastEditDate}" default="none" />

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

