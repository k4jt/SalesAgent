<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Login form</title>
</head>
<body>
	
	
	<c:if test="${invalidUser != null}">
		<div class="errorblock">
			<c:out value="${invalidUser}"/>
		</div>
	</c:if>
	
	
	<form:form methodParam="POST" modelAttribute="atribute" action="login" method='POST'>
		<table cellspacing="0">
			<tr>
				<th>Login:</th>
				<td><input type='text' name='username' /></td>
			</tr>
			<tr>
				<th>Password:</th>
				<td><input type='password' name='password' /></td>
			</tr>
			<tr>
				<td colspan="2"><input name="submit" type="submit"	value="submit" /></td>
			</tr>
		</table>
	</form:form>
	
	
	
</body>
</html>