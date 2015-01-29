<%--
  Created by IntelliJ IDEA.
  User: Louis
  Date: 29/01/2015
  Time: 15:42
--%>

<%@ page import="com.newtechgalley.UserController" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'welcome.label', default: 'Welcome')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><a class="logIn" href="${createLink(controller: 'login')}"><g:message code="default.login.label" default="Log In"/></a></li>
        <li><a class="signIn" href="${createLink(controller: 'user')}"><g:message code="default.signin.label" default="Sign In"/></a></li>
        <li><a class="logOut" href="${createLink(controller: 'logout')}"><g:message code="default.logout.label" default="Log Out"/></a></li>
    </ul>
</div>
</body>
</html>