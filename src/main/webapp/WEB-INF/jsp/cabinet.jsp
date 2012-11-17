<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Cabinet</title>
<style type="text/css">
	.menu_button{
		border-radius: 10px;
		background-color:#666666;
		color:white;
		margin:0.3%;
		padding:3% 0%;
		text-align:center;
		font-size:xx-large;
	}
	.menu_button a{
		color: white;
		text-decoration:none;
	}
</style>

</head>
<body>
	<p>Welcome, ${user.login}</p>
	
	<div class="menu_button"><a href="tasks_with_tp">Работа с ТТ</a></div>
	<div class="menu_button"><a href="documents">Документы</a></div>
	<div class="menu_button"><a href="synchronisation">Синхронизация</a></div>
	<div class="menu_button"><a href="reports">Отчеты</a></div>
	
</body>
</html>