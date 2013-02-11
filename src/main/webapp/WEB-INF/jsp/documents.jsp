<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" />
<title>Список документов</title>
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js" ></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-ui.min.js" ></script>
</head>
<body>

<div data-role="page" id="documents_Page" data-url="/documents">
<div data-role="header">
	<h1>Список документов</h1>
</div>
<a href="#popupFilter"  data-overlay-theme="a" data-rel="popup" id="filter" style="text-decoration:none;" data-position-to="window"><input type="button" data-theme="b" name="FilterBtn" id="FilterBtn" readonly="readonly" value="Фильтр"/></a>

<form:form methodParam="POST" modelAttribute="atribute" action="#" method='POST'>
	<table border="1" width="100%">
	<tr>
	<th style="display: none;">Id</th>
	<th>Дата</th>
	<th>Название</th>
	<th>Заказчик</th>
	<th>Тип</th>
	<th>Статус</th>
	</tr>
	<c:forEach var="row" items="${docList}">
	<c:choose>
	    <c:when test="${row.status == 'Передан'}">
	    	<tr id="trow_doc" class="test" style="background-color: greenyellow">
				<td style="display: none;"><input type="text" name="docId" value='<c:out value="${row.id}"/>' /></td>
				<td><c:out value="${row.date}"/></td>
				<td><c:out value="${row.add1}"/></td>
				<td><c:out value="${row.add2}"/></td>
				<td><c:out value="${row.type}"/></td>
				<td><c:out value="${row.status}"/></td>
		    </tr>
	    </c:when>
	    <c:otherwise>
	    	<tr id="trow_doc" class="test" style="cursor:pointer">
				<td style="display: none;"><input type="text" name="docId" value='<c:out value="${row.id}"/>' /></td>
				<td><c:out value="${row.date}"/></td>
				<td><c:out value="${row.add1}"/></td>
				<td><c:out value="${row.add2}"/></td>
				<td><c:out value="${row.type}"/></td>
				<td><c:out value="${row.status}"/></td>
		    </tr>
	    </c:otherwise>
    </c:choose>
		
	</c:forEach>
	</table>
	<a href="#popupClose"  data-rel="popup" id="quit_real" data-position-to="window" style="text-decoration: none;"><input type="button" data-theme="a" value="Назад"/></a>
</form:form>


<div data-role="popup" id="popupFilter" class="ui-content" data-overlay-theme="a">      
	<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Закрыть</a>
    <form:form methodParam="POST" modelAttribute="filterAtribute" action="filterDoc" method='POST'>
		<center>
				<label for="add1">Название:</label>
				<input type="text" name="add1" />
				<label for="add2">Заказчик:</label>
				<input type="text" name="add2" />
				<label for="from">Дата с:</label>
				<input class="i-txt" name='from' id='from'  />
				<label for="to">Дата по:</label>
				<input class="i-txt" name='to' id='to' />
				<label for="docType">Тип:</label>
				<select class="selement" name='docType'>
					<option></option>
					<option value="0">Реализация</option>
					<option value="1">Возврат</option>
				</select>
				<input type="submit" data-theme="b" class="selement" value="OK">
		</center>
	</form:form>
 </div>  
 
<div data-role="popup" id="popupClose" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Покинуть страницу?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 class="ui-title">Вернуться в главное меню?</h3>
				<center>
				  <a href="cabinet" data-role="button" data-inline="true"  data-theme="b">Да</a>
				  <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Нет</a>
				</center>      
		   </div>
</div>

<div data-role="popup" id="popupGoEdit" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Выбрать документ?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 id="doc_pophead" class="ui-title"></h3>
				<center>
 					 <a href="#" id="go_edit_doc" data-role="button"  data-inline="true" data-theme="b">Да</a>
 				     <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Нет</a>
				</center>      
			</div>
	</div> 


</div>
</body>
</html>