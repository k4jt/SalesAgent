<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Главное меню</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js"></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
</head>
<body>
<div data-role="page" id="Cabinet_Page" data-url="/cabinet">

	<div data-role="header">
		<h1>Главное меню</h1>
	</div><!-- /header -->
	<c:if test="${exp_result!=null}">
	     <div id="exp_result" class="msgblock">
    		<c:out value="${exp_result}"/>
	 	</div>
	</c:if>
	<a href="tasks_with_tp" data-role="button" data-theme="b" data-inline="false">Работа с ТТ</a>
	<a href="documents" data-role="button" data-theme="b" data-inline="false">Документы</a>
	<a href="sync_type" data-role="button" data-theme="b" data-inline="false">Синхронизация</a>
	<a href="reports" data-role="button" data-theme="b" data-inline="false">Отчеты</a>
</div>

	
</body>
</html>