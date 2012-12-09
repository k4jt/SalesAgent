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
<!-- script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.min.js" ></script> -->
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-ui.min.js" ></script>
<link href="${pageContext.request.contextPath}/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Выбор типа накладной</title>

<script>
$(document).ready(function () {
	
	$.datepicker.regional['ru'] = {
			clearText: 'Очистить', clearStatus: '',
			closeText: 'Закрыть', closeStatus: 'Закрыть без изменений',
			prevText: '<Пред', prevStatus: 'Показать предыдующий месяц',
			nextText: 'След>', nextStatus: 'Показать следующий месяц',
			currentText: 'Текущий', currentStatus: 'Показать текущий месяц',
			monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
			'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
			monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн',
			'Июл','Авг','Сен','Окт','Ноя','Дек'],
			monthStatus: 'Показать месяц', yearStatus: 'Показать год',
			weekHeader: 'Нд', weekStatus: '',
			dayNames: ['Воскресенье','Понедельник','Вторник','Среда','Четверг','Пятница','Суббота'],
			dayNamesShort: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
			dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
			dayStatus: 'Utiliser DD comme premier jour de la semaine', dateStatus: 'Choisir le DD, MM d',
			dateFormat: 'yy-mm-dd', firstDay: 1, 
			initStatus: 'Выберите дату', isRTL: false
	};
    $.datepicker.setDefaults($.datepicker.regional['ru']);
    $("#datepicker_field_1").datepicker();
	$("#datepicker_field_2").datepicker();
	
    $("#closebtn").click(function () {
      $("#dlg").hide('200', "swing", function () { $("#bkg").fadeOut("100"); });
    });
    $("#closebtn_simple").click(function () {
      $("#dlg_calc").hide('200', "swing", function () { $("#bkg_calc").fadeOut("100"); });
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
      $("#bkg").fadeIn(100, "linear", function () { $("#dlg").show(200, "swing"); });
    });
        
 
	 $(".test_click").click(function(){
		var str = $(this).children().get(0).innerHTML;
		var id = $(this).children().get(0).innerHTML.substring(str.indexOf("value=") + 7);
		id = id.substring(0, id.length - 2);
		var name = $(this).children().get(2).innerHTML;
		/*var	address = $(this).children().get(3).innerHTML; */

		if(confirm("Вы действительно хотите выбрать документ #" + name + "# ?")){
			window.location.replace("edit_doc?docId=" + id);
			/* $.ajax({
	  		    url: "selectShop.html",
	      		type: "GET",
	      		data: ({code: id}),
	      		dataType: "text",
	      		success: function(){
					window.location.replace("realization?docId=" + id);
	      			}
	   			}
	  		); */
			
			
		} else {
			return false;
		}
		
	 });
 
 
     $("#closebtn_calc").click(function () {
    	 var amount = $("#calc_output").val();
    	 $(".test").children(".selected").val(amount);
		document.getElementById('calc_output').value = '';
		
		var str = $(".test").children(".selected").parent().parent().parent().children().get(0).innerHTML;
		var prodId = $(".test").children(".selected").parent().parent().parent().children().get(0).innerHTML.substring(str.indexOf("value=") + 7);
		prodId = prodId.substring(0, prodId.length - 2);
		var prodName = $(".test").children(".selected").parent().parent().parent().children().get(1).innerHTML;
		var output = prodId + " " + amount;
		
		$.ajax({
  		    url: "addItem.html",
      		type: "GET",
      		data: ({idAmount: output}),
      		dataType: "text"
   			}
  		);
		
		
		
       $("#dlg_calc").hide('100', "swing", function () { $("#bkg_calc").fadeOut("200"); });
     });
 
 
     var $body = $('body'); //Cache this for performance

     var setBodyScale = function() {
    	 var scaleFactor = 0.25,
         scaleSource = $(window).height()*$(window).width(),
         maxScale = 3600,
         minScale = 100;

	     var fontSize = Math.sqrt(scaleSource) * scaleFactor; //Multiply the width of the body by the scaling factor:
	     var fontSizeDate = 0.8*Math.sqrt(scaleSource) * scaleFactor; //Multiply the width of the body by the scaling factor:
	     if (fontSize > maxScale) fontSize = Math.sqrt(maxScale);
	     //if (fontSize < minScale) fontSize = Math.sqrt(minScale); //Enforce the minimum and maximums
	
	     $("#dlg_calc, #dlg").css('font-size', fontSize + '%');
	     $("#ui-datepicker-div").css('font-size', fontSizeDate + '%');
     }

     $(window).resize(function(){
         setBodyScale();
     });

     //Fire it when the page first loads:
     setBodyScale();
 
     $("#quit").click(function(){
    	return confirm("Вы точно хотите вернуться на главную страницу?");
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
		font-family: Times New Roman; 
	}
	
	.selected{}
	.amount{
		width: 99%;
	}
	.closebtn_simple{
		text-align: right;
		padding: 0.5% 3%;
		cursor: pointer;
	}
	.test{}

	.test_click{
		cursor: pointer;
	}
	
	.line{
		float: left;
	}
</style>
</head>
<body>


<a href="#" id="filter"><center><div class="filter_button">Фильтр</div></center></a>

<form:form methodParam="POST" modelAttribute="atribute" action="#" method='POST'>
	<table border="1" width="100%">
	<tr>
	<th style="display: none;">Id</th>
	<th>Дата</th>
	<th>Название</th>
	<th>Заказчик</th>
	<th>Тип</th>
	
	</tr>
	<c:forEach var="row" items="${shopList}">
		<tr class="test_click">
			<td style="display: none;"><input type="text" name="shopId" value='<c:out value="${row.id}"/>' /></td>
			<td><c:out value="${row.date}"/></td>
			<td><c:out value="${row.add1}"/></td>
			<td><c:out value="${row.add2}"/></td>
			<td><c:out value="${row.type}"/></td>
		</tr>
	</c:forEach>
	</table>
	<a href="cabinet" id="quit"><div class="filter_button" style="float: left; margin-top: 5px;">Выйти</div></a>
</form:form>



<div class="blockbkg" id="bkg" style="visibility: hidden;">
    <div class="closebtn_simple" title="Закрыть" id="closebtn" color="red">[отмена]</div>
    <div class="cont" id="dlg" style="visibility: hidden;">
    <form:form methodParam="POST" modelAttribute="filterAtribute" action="filterDoc" method='POST'>
		<center>
				<div class="justtext">Название:</div><input type='text' class="selement" name='add1' />
				<div class="justtext">Заказчик:</div><input type='text' class="selement" name='add2' />
				<div class="justtext">Дата с:</div><input type='text' class="selement" name='from' id='datepicker_field_1' />
				<div class="justtext">Дата по:</div><input type='text' class="selement" name='to' id='datepicker_field_2'/>
				
				<div class="justtext">Тип:</div>
				<select class="selement" name='docType'>
					<option></option>
					<option value="0">Реализация</option>
					<option value="1">Возврат</option>
				</select>
				<input type="submit" class="selement" value="OK">
		</center>
	</form:form>
    
    </div>
 </div>  
  



<%-- 
  <div class="blockbkg" id="bkg_calc" style="visibility: hidden;">
      <div class="closebtn_simple" title="Закрыть" id="closebtn_simple" color="red">[отмена]</div>
    <div class="cont" id="dlg_calc" style="visibility: hidden;">
<form name="Calc">  
<TABLE width="100%" style="padding: 0% 4%;">
<tr><td colspan="4"><p id="productName" style="font-size: smaller;"/></td></tr>
<TR>
<TD colspan="3">
<INPUT TYPE="text"   NAME="Input" id="calc_output" readonly="readonly" style="width: 100%; height: 100%; font-size: larger;">
</TD>
<td><center><div class="closebtn" title="ОК" id="closebtn_calc" color="red">ОК</div></center></td>
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

 --%>



</body>
</html>