<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Выбор ТТ по коду</title>
  <script>
    $(document).ready(function () {
      $("#closebtn").click(function () {
        //document.getElementById('code').value =  document.getElementById('calc_output').value;
		$.ajax({
  		    url: "calc.html",
      		type: "GET",
      		data: ({code: document.getElementById('calc_output').value}),
      		dataType: "text",
      		contentType: "text/html; charset=iso-8859-1",
      		
      		success: function(msg){
         			/* alert("succ" + msg);
         			alert("succ" + encodeURIComponent(msg)); */
         			document.getElementById('code').value = msg;
         			if(msg.length() > 26){
         				$("#errorMsg").addStyle("hideErrBlock");
         			}
      			}
   			}
  		)
  		/*$.post('calc.html', {}, function(msg){   
					alert(msg);
         			document.getElementById('code').value = msg;                 
        }, 'text'); */ 
		document.getElementById('calc_output').value = '';
        $("#dlg").hide('800', "swing", function () { $("#bkg").fadeOut("500"); });
      });
      $("#opn").click(function () {
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
	
    var $body = $('body'); //Cache this for performance

    var setBodyScale = function() {
        var scaleFactor = 0.55,
            scaleSource = $(window).height(),
            maxScale = 600,
            minScale = 10;

        var fontSize = scaleSource * scaleFactor; //Multiply the width of the body by the scaling factor:

        if (fontSize > maxScale) fontSize = maxScale;
        if (fontSize < minScale) fontSize = minScale; //Enforce the minimum and maximums

        $('body').css('font-size', fontSize + '%');
    }

    $(window).resize(function(){
        setBodyScale();
    });

    //Fire it when the page first loads:
    setBodyScale();

	
    });
</script>
  
  <style>
  	.hideErrBlock{
  		visibility: hidden;
  	}
  </style>
  
</head>

<body>
	<c:if test="${errorMsg != null}">
		<div class="errorblock" id="errorMsg">
			<c:out value="${errorMsg}"/>
		</div>
	</c:if>

  <div class="normal">
  <center>
  		<form:form methodParam="POST" modelAttribute="atribute" action="choose_by_code" method="POST">
			<a href="#" id="opn"><input type="text" class="box" name="code" id="code" readonly="readonly" size="10" maxlength="30"/></a>
			<input type="submit" class="okbtn" value="OK" />
		</form:form>
	</center>
  </div>
  
  <div class="blockbkg" id="bkg" style="visibility: hidden;">
    <div class="cont" id="dlg" style="visibility: hidden;">
      	
      
<form name="Calc">  
<TABLE width="100%" style="padding: 2% 4%;">
<TR>
<TD colspan="3">
<INPUT TYPE="text"   NAME="Input" id="calc_output" readonly="readonly" style="width: 100%; height: 100%; font-size: larger;">
</TD>
<td><center><div class="closebtn" title="Close" id="closebtn" color="red">ОК</div></center></td>
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