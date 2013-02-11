<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Работа с ТТ</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js"></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
</head>
<body>
	<div data-role="page" id="Tasks_TP_Page" data-url="/tasks_with_tp">
		<div data-role="header">
			<h1>Работа с ТТ</h1>
		</div><!-- /header -->
		<a href="choose_by_code" data-role="button" data-theme="b" data-inline="false">Выбор по коду</a>
		<a href="choose_from_list" data-role="button" data-theme="b" data-inline="false">Выбор из списка</a>
		<a href="cabinet" data-role="button" data-theme="a" data-inline="false">Назад</a>
	</div>
</body>
</html>