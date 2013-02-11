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
<title>Выбор типа накладной</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js" ></script>
</head>
<body>
<div data-role="page" id="Choose_DocType_Page" data-url="/choose_doc_type">
	  
   	<c:choose>
	    <c:when test="${shop != null}">
	    	<div data-role="header"> 
	    	<h1>
		 		<c:out value="${shop.code}"/>&nbsp;
 				<c:out value="${shop.name}"/>&nbsp;
 				<c:out value="${shop.address}"/>&nbsp;
		 	</h1>
		 	</div>
	    </c:when>
	    <c:otherwise>
	    	<div data-role="header">
				<h1>Нужна авторизация!!</h1>
			</div><!-- /header -->
	    </c:otherwise>
    </c:choose>
    
    <c:if test="${save_result != null}">
    	<div id="save_res" class="msgblock">
    		<c:out value="${save_result}"/>
	 	</div>
	 	
    </c:if>
    
	<a href="designdoc" data-role="button" data-theme="b" data-inline="false">Реализация</a>
	<a href="return_back" data-role="button" data-theme="b" data-inline="false">Возврат</a>
	<a href="cabinet" data-role="button" data-theme="a" data-inline="false">Завершить работу с ТТ</a>
</div>
</body>
</html>