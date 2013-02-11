<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Редактор документа</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js" ></script>
</head>
<body>
<div data-role="page" id="designdoc_Page" data-url="/designdoc">
<c:choose>
	    <c:when test="${shop != null}">
	    	<div data-role="header"> 
	    	<h1>
		 		<c:out value="${shop.code}"/>&nbsp;
 				<c:out value="${shop.name}"/>&nbsp;
 				<c:out value="${shop.address}"/>&nbsp;
 				<br>[<c:out value="${docType}"/>]
 				<c:if test="${docId != null }">
 					[Редактирование]
 				</c:if>
		 	</h1>
		 	</div>
	    </c:when>
	    <c:otherwise>
	    	<div data-role="header">
				<h1>Нужна авторизация!!</h1>
			</div><!-- /header -->
	    </c:otherwise>
    </c:choose>
    <div class="ui-grid-a">
    	<div class="ui-block-a">
    	    <c:if test="${docId != null}">
    	    	<input name="docDateDes" id="docDateDes" readonly="readonly" class="i-txt" style="display:none"/>
    	   		<a href="#" data-role="button" data-theme="b" id="showDate" class="btn btn-blue">
    	   			<span class="btn-i">
    	   			    <c:out value="${fn:substring(selDocDate,8,10)}-${fn:substring(selDocDate,5,7)}-${fn:substring(selDocDate,2,4)}"/>
    	   			</span>
    	   	    </a>
    	   	</c:if>
    	   	<c:if test="${docId == null}">
    	   		<input name="docDateDesGlobal" id="docDateDesGlobal" readonly="readonly" class="i-txt" style="display:none"/>
    	   		<a href="#" data-role="button" data-theme="b" id="showDateGlobal" class="btn btn-blue">
    	   		    <span class="btn-i">
    	   		    	<c:out value="${fn:substring(docGlobalDate,8,10)}-${fn:substring(docGlobalDate,5,7)}-${fn:substring(docGlobalDate,2,4)}"/>
    	   		    </span>
    	   		</a>
    	   	</c:if>
		</div>	 
		
		<div class="ui-block-b">
            <a href="#popupFilter"  data-overlay-theme="a" data-rel="popup" id="filter" style="text-decoration:none;" data-position-to="window"><input type="button" data-theme="b" name="FilterBtn" id="FilterBtn" readonly="readonly" value="Фильтр"/></a>
		</div>
		
	</div>
<form:form id="form_real" methodParam="POST" modelAttribute="atribute" action="procDoc" method='POST' >
	<c:if test="${docTypeId == 1}">
 	<div class="ui-grid-solo">
			<select name="docType1" id="docType1" data-native-menu="false" data-theme="c">
					<option value="1">На завод</option>
					<option value="2">На склад №1</option>
					<option value="3">Бой</option>
					<option value="4">Порча до срока</option>
					<option selected value="5">По срокам</option>
					<option value="6">На склад №2</option>
					<option value="7">На склад №3</option>
	       </select>
	   </div>
	</c:if>
	<table border="1" width="100%">
	<tr>
		<th style="display: none;">Id</th>
		<th>Наименование</th>
		<th>Дата 1</th>
		<th>Дата 2</th>
		<th>Дата 3</th>
		<th>Заказ</th>
	</tr>
	<c:forEach var="row" items="${productList}">
		<tr id="trow_real" class="test">
			<td style="display: none;"><input type="text" name="prodId" value='<c:out value="${row.id}"/>' /></td>
			<td><center><c:out value="${row.name}"/></center></td>
			<td><center>000</center></td>
			<td><center>000</center></td>
			<td><center>000</center></td>
			<td class="amount"><input type="number" id="amount" name="amount" value='<c:out value="${row.amount}"/>' /></td>
		</tr>
	</c:forEach>
	</table>
	<a href="#popupSave"   data-rel="popup" id="save_real" data-position-to="window" style="text-decoration: none;"><input type="button"  data-theme="b" id="save_doc" value="Сохранить"/></a>
	<c:if test="${docTypeId == 1 && docId == null}">
		<a href="#popupSave2"   data-rel="popup" id="save_real2" data-position-to="window" style="text-decoration: none;"><input type="button"  data-theme="b" id="save_doc2" value="Сохранить+Обмен"/></a>
	</c:if>
	<a href="#popupClose"  data-rel="popup" id="quit_real" data-position-to="window" style="text-decoration: none;"><input type="button" data-theme="a" value="Назад"/></a>
	<div data-role="popup" id="popupSave" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Сохранить документ?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 class="ui-title">Данные будут записаны в документ</h3>
				<center>
 					 <a href="#" id="savebtn_dialog_real" data-role="button"  data-inline="true" data-theme="b" onclick="$('#form_real').submit();">Ок</a>
 				     <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Отмена</a>
				</center>      
			</div>
		</div>
		
		<div data-role="popup" id="popupSave2" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Сохранить документ?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 class="ui-title">Будут созданы возвратный и обменный документы</h3>
				<center>
 					 <a href="#" id="savebtn_chng" data-role="button"  data-inline="true" data-theme="b">Ок</a>
 				     <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Отмена</a>
				</center>      
			</div>
		</div>	 
</form:form>
<!-- FILTER POPUP BEGIN -->  
	 <div data-role="popup" id="popupFilter" class="ui-content" data-overlay-theme="a">      
	<a href="#" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Закрыть</a>
	<form:form methodParam="POST" modelAttribute="filterAtribute" action="designdoc" method='POST'>
			<center>
					<label for="prodName">Наименование:</label>
					<input type="text" name="prodName" />
					<label for="brand">Производитель:</label>
					<select id="brand" name="brand" data-native-menu="false">
						<option></option>
						<c:forEach var="op" items="${brandList}">
							<option value='<c:out  value="${op.id}" />' ><c:out  value="${op.name}" /></option>
						</c:forEach>
					</select>
					<input type="submit" data-theme="b" class="selement" value="OK">
			</center>
		</form:form>  
	</div>
<!-- FILTER POPUP END -->
  
<div data-role="popup" id="popupClose" data-overlay-theme="a" data-theme="c" class="ui-corner-all">
			<div data-role="header" data-theme="a" class="ui-corner-top">
				<h1>Покинуть страницу?</h1>
			</div>
			<div data-role="content" data-theme="d" class="ui-corner-bottom ui-content">
				<h3 class="ui-title">Несохраненные данные будут утеряны</h3>
				<center>
				  <c:if test="${docId == null}">
				      <a href="choose_doc_type" data-role="button" data-inline="true"  data-theme="b">Ок</a>
				 </c:if>
				 <c:if test="${docId != null}">
				      <a href="documents" data-role="button" data-inline="true"  data-theme="b">Ок</a>
				 </c:if>
				  <a href="#" data-role="button" data-inline="true" data-rel="back" data-theme="c">Отмена</a>
				</center>      
			</div>
</div>
</div> 
 </body>
</html>