<%@ page import="com.newtechgalley.WelcomeController" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="NewTechGalley"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>
	</head>
	<body>
		<div id="NTGLogo" role="banner"><a href="${createLink(uri: '/')}"><asset:image class="NTGImage" src="Crimson_Galley_by_crimson_galley_resized.jpg" alt="NewTechGalley"/></a><h1 class="bannerText">NewTechGalley</h1></div>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="unanswered" href="${createLink(uri: '/')}"><g:message code="default.unanswered.label" default="Unanswered"/></a></li>
				<li><a class="categories" href="${createLink(controller: 'category')}"><g:message code="default.categories.label" default="Categories"/></a></li>
				<li><a class="top100" href="${createLink(uri: '/')}"><g:message code="default.tophundred.label" default="Top 100"/></a></li>
				<li><a class="users" href="${createLink(controller: 'user')}"><g:message code="default.users.label" default="Users"/></a></li>
				<li><a class="badges" href="${createLink(uri: '/')}"><g:message code="default.badges.label" default="Badges"/></a></li>
				<li><a class="askQuestion" href="${createLink(controller: 'post')}"><g:message code="default.aksQuestion.label" default="Ask Question"/></a></li>
				<g:if test="${isLogInView}"><li><a class="logOut" href="${createLink(controller: 'logout')}"><g:message code="default.logout.label" default="Log Out"/></a></li></g:if>
				<g:else><li><a class="logIn" href="${createLink(controller: 'login')}"><g:message code="default.login.label" default="Log In"/></a></li></g:else>
			</ul>
		</div>
		<g:layoutBody/>
		<div class="footer" role="contentinfo"><p>Louis & Stefany</p></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	</body>
</html>
