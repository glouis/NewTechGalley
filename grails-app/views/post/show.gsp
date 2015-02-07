<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils; com.newtechgalley.Post" %>
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
            <span class="property-value" aria-labelledby="creationDate-label"><g:formatDate type="MEDIUM"
                                                                                            date="${postInstance?.creationDate}"/></span>
            <span class="property-value" aria-labelledby="categories-label">
                <g:each in="${postInstance.categories}" var="c">
                    <g:link controller="category" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link>
                </g:each>
            </span>
        </li>


        <li class="fieldcontain">
            <div class="property-label">
                <div class="voter">
                    <g:link class="upvote" controller="post" action="upvote" id="${postInstance?.id}"/>
                    <span aria-labelledby="note-label"><g:fieldValue bean="${postInstance}" field="note"/></span>
                    <g:link class="downvote" controller="post" action="downvote" id="${postInstance?.id}"/>
                </div>
            </div>
            <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${postInstance}"
                                                                                     field="title"/></span>

        </li>

        <li class="fieldcontain">
            <span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${postInstance}"
                                                                                       field="content"/></span>

            <sec:ifLoggedIn>
                <g:if test="${postInstance?.user?.id == sec.loggedInUserInfo(field: "id").toLong() || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")}">
                    <g:form class="property-value" url="[resource: postInstance, action: 'edit']">
                        <input class="shortBtn" type="submit"
                               value="${message(code: "default.edit.label", default: "Edit")}"/>
                    </g:form>
                </g:if>
            </sec:ifLoggedIn>
        </li>

        <g:if test="${postInstance?.lastEditDate}">
            <small>
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="post.lastEditDate.label"
                                                            default="Last Edit Date"/></span>

                    <span class="property-value" aria-labelledby="lastEditDate-label"><g:formatDate
                            date="${postInstance?.lastEditDate}"/></span>
                </li>
            </small>
        </g:if>

        <g:if test="${postInstance?.comments}">
            <li class="fieldcontain">
                <span id="comments-label" class="property-label"><g:message code="post.comments.label"
                                                                            default="Comments"/></span>
            </li>
            <li class="fieldcontain">

                <g:each in="${postInstance.comments.sort { a, b -> ((b.note <=> a.note) ?: (a.creationDate <=> b.creationDate)) }}"
                        var="c">
                    <div class="property-label">
                        <div class="voter">
                            <g:link class="upvote" controller="comment" action="upvote" id="${c?.id}"/>
                            <span aria-labelledby="note-label"><g:fieldValue bean="${c}" field="note"/></span>
                            <g:link class="downvote" controller="comment" action="downvote" id="${c?.id}"/>
                        </div>
                    </div>
                    <blockquote class="property-value" aria-labelledby="comments-label">${c?.encodeAsHTML()}
                        <cite>
                            <g:link controller="user" action="show"
                                    id="${c?.user.encodeAsHTML()}">${c?.user.encodeAsHTML()}</g:link>
                            <g:formatDate type="MEDIUM" date="${c?.creationDate}"/>
                            <g:if test="${c?.lastEditDate}">
                                <small>
                                    <span id="lastEditDate-label">- <g:message code="comment.lastEditDateShort.label"
                                                                               default="Modified"/></span>
                                    <g:formatDate type="MEDIUM" date="${c?.lastEditDate}"/>
                                </small>
                            </g:if>
                        </cite>
                        <sec:ifLoggedIn>
                            <g:if test="${c?.user?.id == sec.loggedInUserInfo(field: "id").toLong() || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")}">
                                <g:form url="[resource: c, action: 'delete']" method="DELETE">
                                    <g:actionSubmit class="shortBtn" action="delete"
                                                    value="${message(code: 'default.delete.label', default: 'Delete')}"
                                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                                </g:form>
                                <g:form url="[resource: c, action: 'edit']">
                                    <input class="shortBtn" type="submit"
                                           value="${message(code: "default.edit.label", default: "Edit")}"/>
                                </g:form>
                            </g:if>
                        </sec:ifLoggedIn>
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
