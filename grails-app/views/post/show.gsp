<%@ page import="com.newtechgalley.Post" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-post" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                           default="Skip to content&hellip;"/></a>

<div id="show-post" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list post">

        <li class="fieldcontain">

            <span class="property-label" aria-labelledby="user-label"><g:link controller="user" action="show"
                                                                              id="${postInstance?.user?.id}">${postInstance?.user?.encodeAsHTML()}</g:link></span>
            <span class="property-value" aria-labelledby="creationDate-label"><g:formatDate
                    date="${postInstance?.creationDate}"/></span>
            <span class="property-value" aria-labelledby="categories-label">
                <g:each in="${postInstance.categories}" var="c">
                    <g:link controller="category" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link>
                </g:each>
            </span>
        </li>


        <li class="fieldcontain">
            <span class="property-label" aria-labelledby="note-label"><g:fieldValue bean="${postInstance}"
                                                                                    field="note"/></span>
            <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${postInstance}"
                                                                                     field="title"/></span>

        </li>

        <li class="fieldcontain">
            <span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${postInstance}"
                                                                                       field="content"/></span>
        </li>


        <g:if test="${postInstance?.lastEditDate}">
            <li class="fieldcontain">
                <span id="lastEditDate-label" class="property-label"><g:message code="post.lastEditDate.label"
                                                                                default="Last Edit Date"/></span>

                <span class="property-value" aria-labelledby="lastEditDate-label"><g:formatDate
                        date="${postInstance?.lastEditDate}"/></span>

            </li>
        </g:if>

        <g:if test="${postInstance?.comments}">
            <li class="fieldcontain">
                <span id="comments-label" class="property-label"><g:message code="post.comments.label"
                                                                            default="Comments"/></span>

                <g:each in="${postInstance.comments}" var="c">
                    <blockquote class="property-value" aria-labelledby="comments-label">
                        ${c?.encodeAsHTML()}
                        <cite>
                            <g:link controller="user" action="show" id="${c?.user.encodeAsHTML()}">${c?.user.encodeAsHTML()}</g:link>
                            <g:fieldValue bean="${c}" field="creationDate"/>
                        </cite>
                    </blockquote>
                </g:each>

            </li>
        </g:if>

        <div class="fieldcontain">
            <span class="property-value">
                <g:link controller="comment" action="create"
                        params="['post.id': postInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
            </span>
        </div>
    </ol>

    <g:form url="[resource: postInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${postInstance}"><g:message code="default.button.edit.label"
                                                                                     default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
