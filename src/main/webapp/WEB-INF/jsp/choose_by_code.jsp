<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Выбор ТТ</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js"></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>

</head>

<body>
<div data-role="page" id="ChooseByCode_Page" data-url="/choose_by_code">
		<div data-role="header">
			<h1>Выбор ТТ</h1>
		</div><!-- /header -->
		
	<c:if test="${errorMsg != null}">
		<div class="errorblock" id="errorMsg">
			<c:out value="${errorMsg}"/>
		</div>
	</c:if>

  <div class="normal">
  <center>
  		<form:form methodParam="POST" modelAttribute="atribute" action="choose_by_code" method="POST">
			<!-- a href="#popupCalc" data-rel="popup" id="opn" style="text-decoration:none;" data-position-to="window"><input type="text" class="box" name="code" id="code" readonly="readonly" placeholder="Нажмите для ввода" size="10" maxlength="30"/></a> -->
			<label for="code">Введите код ТТ:</label>
			<input type="number" name="code" id="code"/>
			<label for="Name">Название ТТ:</label>
			<input type="text" readonly="readonly" name="Name" id="Name"/>
			<input type="submit" data-theme="b" class="okbtn" value="OK" />
			<a href="#"  data-rel="back" id="quit_code" style="text-decoration: none;"><input type="button" data-theme="a" value="Назад"/></a>
		</form:form>
	</center>
  </div>
  </div>
</body>
</html>