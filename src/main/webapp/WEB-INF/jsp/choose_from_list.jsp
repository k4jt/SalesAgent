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
<title>Выбор ТТ из списка</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js" ></script>
</head>
<body>

<div data-role="page" id="chooseFromList_Page" data-url="/choose_from_list">
	
   	<div data-role="header">
		<h1>Выбор ТТ из списка</h1>
   	</div>

	<a href="#popupFilter"  data-overlay-theme="a" data-rel="popup" id="filter" style="text-decoration:none;" data-position-to="window"><input type="button" data-theme="b" name="FilterBtn" id="FilterBtn" readonly="readonly" value="Фильтр"/></a>
	
	<form:form methodParam="POST" modelAttribute="atribute" action="#" method='POST'>
		<table border="1" width="100%">
		<tr>
			<th style="display: none;">Id</th>
			<th>Код</th>
			<th>Название точки</th>
			<th>Адрес</th>
		</tr>
		<c:forEach var="row" items="${shopList}">
			<tr id="trow_cfl" class="test" style="cursor:pointer">
				<td style="display: none;"><input type="text" name="shopId" value='<c:out value="${row.id}"/>' /></td>
				<td><c:out value="${row.code}"/></td>
				<td><c:out value="${row.name}"/></td>
				<td><c:out value="${row.address}"/></td>
			</tr>
		</c:forEach>
		</table>
		<a href="#popupClose"  data-rel="popup" id="quit_real" data-position-to="window" style="text-decoration: none;"><input type="button" data-theme="a" value="Назад"/></a>
	</form:form>
	
	
	<div data-role="popup" id="popupFilter" class="ui-content" data-overlay-theme="a">
		<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Закрыть</a>
	    <form:form methodParam="POST" modelAttribute="filterAtribute" action="filterTP" method='POST'>
			<center>
					<label for="code">Код:</label>
					<input type="text" name="code" />
					<label for="name">Название:</label>
					<input type="text" name="name" />
					<label for="address">Адрес:</label>
					<input type="text" name="address" />
					<input type="submit" data-theme="b" value="OK">
			</center>
		</form:form>
	</div>
	
	<div data-role="popup" id="popupClose" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Покинуть страницу?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 class="ui-title">Несохраненные данные будут утеряны</h3>
				<center>
				  <a href="/tasks_with_tp" data-role="button" data-inline="true"  data-theme="b">Ок</a>
				  <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Отмена</a>
				</center>      
			</div>
    </div>
	
	<div data-role="popup" id="popupGoEdit" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Выбрать ТТ?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 id="cfl_pophead" class="ui-title"></h3>
				<center>
 					 <a href="#" id="savebtn_dialog_cfl" data-role="button"  data-inline="true" data-theme="b">Да</a>
 				     <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Нет</a>
				</center>      
			</div>
	</div> 
	
</div>
</body>
</html>