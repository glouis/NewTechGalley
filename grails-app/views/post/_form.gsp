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

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'categories', 'error')} ">
	<label for="categories">
		<g:message code="post.categories.label" default="Categories" />
		
	</label>
	<g:select name="categories" from="${com.newtechgalley.Categorie.list()}" multiple="multiple" optionKey="id" size="5" value="${postInstance?.categories*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="post.comments.label" default="Comments" />
		
	</label>
	<g:select name="comments" from="${com.newtechgalley.Comment.list()}" multiple="multiple" optionKey="id" size="5" value="${postInstance?.comments*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'note', 'error')} required">
	<label for="note">
		<g:message code="post.note.label" default="Note" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="note" type="number" value="${postInstance.note}" required=""/>

</div>

