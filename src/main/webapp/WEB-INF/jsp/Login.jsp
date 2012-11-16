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
	.errorblock {
		color: #ff0000;
		background-color: #ffEEEE;
		border: 3px solid #ff0000;
		padding: 8px;
		margin: 16px;
	}
</style>
</head>
<body onload='document.f.j_username.focus();'>
	<%-- <c:if test="${warnMsg != null}">
		<c:out value="${warnMsg}">Msg:</c:out>
	</c:if> --%>
	
	<c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> Caused :
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>
	
	<sf:form name='f' action="<c:url value='/j_spring_security_check' />"
		method='POST'>
		<fieldset>
			<table cellspacing="0">
				<tr>
					<th><label for="login">Login:</label></th>
					<td><input type='text' name='j_username' value=''>
						<%-- sf:input path="login" size="10" maxlength="10"/><br/>
						<sf:errors path="login" cssClass="error"/>
						<small id="user_msg">No spaces, please.</small> --%>
					</td>
				</tr>
				<tr>
					<th><label for="pass">Password:</label></th>
					<td><input type='password' name='j_password' />
						<%-- <sf:password path="pass" size="10" maxlength="10" showPassword="true" /><br>
						<sf:errors path="pass" cssClass="error"/> --%>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input name="submit" type="submit"
					value="submit" /></td>
				</tr>
				<tr>
					<td colspan='2'><input name="reset" type="reset" />
					</td>
				</tr>
			</table>
		</fieldset>	
	</sf:form>
	
	
	
</body>
</html>