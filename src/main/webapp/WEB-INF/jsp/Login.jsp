<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login form</title>
<style type="text/css">
	.error{
		color: red;
	}
</style>
</head>
<body>
	<c:if test="${warnMsg != null}">
		<c:out value="${warnMsg}">Msg:</c:out>
	</c:if>
	<sf:form method="POST" modelAttribute="user" action="login/signup">
		<fieldset>
			<table cellspacing="0">
				<tr>
					<th><label for="login">Login:</label></th>
					<td>
						<sf:input path="login" size="10" maxlength="10"/><br/>
						<sf:errors path="login" cssClass="error"/>
						<small id="user_msg">No spaces, please.</small>
					</td>
				</tr>
				<tr>
					<th><label for="pass">Password:</label></th>
					<td>
						<sf:password path="pass" size="10" maxlength="10" showPassword="true" /><br>
						<sf:errors path="pass" cssClass="error"/>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit"/></td>
				</tr>
			</table>
		</fieldset>	
	</sf:form>
	
	
	
</body>
</html>