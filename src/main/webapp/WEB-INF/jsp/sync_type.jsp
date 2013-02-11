<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Синхронизация</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js"></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
</head>
<body>
	<div data-role="page" id="Tasks_TP_Page" data-url="/sync_type">
		<div data-role="header">
			<h1>Синхронизация</h1>
		</div><!-- /header -->
		<a href="import" data-role="button" data-theme="b" data-inline="false">Загрузка</a>
		<a href="export" data-role="button" data-theme="b" data-inline="false">Выгрузка</a>
		<a href="cabinet" data-role="button" data-theme="b" data-inline="false">Назад</a>
	</div>
</body>
</html>