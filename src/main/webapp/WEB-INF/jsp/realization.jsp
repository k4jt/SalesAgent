<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Выбор типа накладной</title>

<script>
$(document).ready(function () {
	
	
    $("#closebtn").click(function () {
      $("#dlg").hide('800', "swing", function () { $("#bkg").fadeOut("500"); });
    });
    
    
    $("#filter").click(function () {
      if (document.getElementById('bkg').style.visibility == 'hidden') {
        document.getElementById('bkg').style.visibility = '';
        $("#bkg").hide();
      }
      if (document.getElementById('dlg').style.visibility == 'hidden') {
        document.getElementById('dlg').style.visibility = '';
        $("#dlg").hide();
      }
      $("#bkg").fadeIn(500, "linear", function () { $("#dlg").show(800, "swing"); });
    });
        
 
	 $(".test").click(function(){
		$(".test").children(".amount").removeClass("selected");
		$(this).children(".amount").addClass("selected");
	    if (document.getElementById('bkg_calc').style.visibility == 'hidden') {
	        document.getElementById('bkg_calc').style.visibility = '';
	        $("#bkg_calc").hide();
	      }
	      if (document.getElementById('dlg_calc').style.visibility == 'hidden') {
	        document.getElementById('dlg_calc').style.visibility = '';
	        $("#dlg_calc").hide();
	      }
	      $("#bkg_calc").fadeIn(500, "linear", function () { $("#dlg_calc").show(800, "swing"); });
	 });
 
 
     $("#closebtn_calc").click(function () {
    	 var text = $("#calc_output").val();
    	 $(".test").children(".selected").val(text);
		document.getElementById('calc_output').value = '';
       $("#dlg_calc").hide('800', "swing", function () { $("#bkg_calc").fadeOut("500"); });
     });
 
 
 
 
 
    
});

</script>
<style>
	.filter_button{
		float: right;
		width: 31%;
		font-size: larger;
		text-align: center;
		border-radius: 10px;
		background-color: #666;
		color: white;
		padding: 1% 0;
		margin-bottom: 1%;
	}
	
	.selected{}
	.amount{
		width: 99%;
	}
	
	.test{}
	
	.line{
		float: left;
	}
</style>
</head>
<body>

<c:if test="${shop != null}">
 	<div class="line">
 		<c:out value="${shop.code}"/>&nbsp;
 		<c:out value="${shop.name}"/>&nbsp;
 		<c:out value="${shop.address}"/>&nbsp;
 		<br>[Тип накладной]: <c:out value="${docType}"/>
 	</div>
 </c:if>

<a href="#" id="filter"><center><div class="filter_button">Фильтр</div></center></a>

<form:form methodParam="POST" modelAttribute="atribute" action="procDoc" method='POST'>
	<table border="1" width="100%">
	<tr>
	<th style="display: none;">Id</th>
	<th>Name</th>
	<th>Amount</th>
	
	</tr>
	<c:forEach var="row" items="${productList}">
		<tr>
			<td style="display: none;"><input type="text" name="prodId" value='<c:out value="${row.id}"/>' /></td>
			<td><c:out value="${row.name}"/></td>
			<td><a href="#" class="test"><input type="text" class="amount" name="amount" readonly="readonly" /></a></td>
		</tr>
	</c:forEach>
	</table>
	<input type="submit" class="filter_button" value="Сохранить" />
	<a href="choose_doc_type"><div class="filter_button" style="float: left;">Назад</div></a>
</form:form>



<div class="blockbkg" id="bkg" style="visibility: hidden;">
    <div class="cont" id="dlg" style="visibility: hidden;">
    <div class="closebtn" title="Close" id="closebtn" color="red">[закрыть]</div>
    <form:form methodParam="POST" modelAttribute="filterAtribute" action="realization" method='POST'>
		<center>
				<div class="justtext">Name:</div>
				<input type='text' class="selement" name='prodName' />
				<div class="justtext">Brand:</div>
				<select class="selement" name='brand'>
					<option></option>
					<c:forEach var="op" items="${brandList}">
						<option value='<c:out  value="${op.id}" />' ><c:out  value="${op.name}" /></option>
					</c:forEach>
				</select>
				<input type="submit" class="selement" value="OK">
		</center>
	</form:form>
    
    </div>
 </div>  
  




  <div class="blockbkg" id="bkg_calc" style="visibility: hidden;">
    <div class="cont" id="dlg_calc" style="visibility: hidden;">
      	
      
<form name="Calc">  
<TABLE width="100%" style="padding: 2% 4%;">
<TR>
<TD colspan="3">
<INPUT TYPE="text"   NAME="Input" id="calc_output" readonly="readonly" style="width: 100%; height: 100%; font-size: larger;">
</TD>
<td><center><div class="closebtn" title="Close" id="closebtn_calc" color="red">ОК</div></center></td>
</TR>
<TR>
<TD><INPUT class="calc_but" TYPE="button" NAME="one"   VALUE="  1  " OnClick="Calc.Input.value += '1'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="two"   VALUE="  2  " OnCLick="Calc.Input.value += '2'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="three" VALUE="  3  " OnClick="Calc.Input.value += '3'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="plus"  VALUE="  +  " OnClick="Calc.Input.value += ' + '"></td>
</tr>
<tr>
<td><INPUT class="calc_but" TYPE="button" NAME="four"  VALUE="  4  " OnClick="Calc.Input.value += '4'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="five"  VALUE="  5  " OnCLick="Calc.Input.value += '5'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="six"   VALUE="  6  " OnClick="Calc.Input.value += '6'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="minus" VALUE="  -  " OnClick="Calc.Input.value += ' - '"></td>
</tr>
<tr>
<td><INPUT class="calc_but" TYPE="button" NAME="seven" VALUE="  7  " OnClick="Calc.Input.value += '7'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="eight" VALUE="  8  " OnCLick="Calc.Input.value += '8'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="nine"  VALUE="  9  " OnClick="Calc.Input.value += '9'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="times" VALUE="  x  " OnClick="Calc.Input.value += ' * '"></td>
</tr>
<tr>
<td><INPUT class="calc_but" TYPE="button" NAME="clear" VALUE="  c  " OnClick="Calc.Input.value = ''"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="zero"  VALUE="  0  " OnClick="Calc.Input.value += '0'"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="DoIt"  VALUE="  =  " OnClick="Calc.Input.value = eval(Calc.Input.value)"></td>
<td><INPUT class="calc_but" TYPE="button" NAME="div"   VALUE="  /  " OnClick="Calc.Input.value += ' / '"></td>
</tr>
</TABLE></form>
      
      
    </div>
  </div>





</body>
</html>