<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script type="text/javascript" charset="utf-8">

$( document ).ready( function() {
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Работа с ТТ</title>

 <style>
    .blockbkg {
      background-color: black;
      opacity: 90%;
      filter:alpha(opacity=90);
      background-color: rgba(0,0,0,0.90);
      width: 100%;
      min-height: 100%;
      overflow: hidden;
      float: absolute;
      position: fixed;
      top: 0;
      left: 0;
      color: white;
    }
	.cont {
		background-color: white;
		color: black;
		font-size: xx-large;
		border: 2px solid gray;
		padding: 1%;
		top: 5%;
		width: auto;
		height: auto;
		border-radius: 10px;
	}
	
    .closebtn {
      
    }
    .closebtn:hover {
      cursor: pointer;
    }
    .normal {
    }
  </style>

  <script>
    $(document).ready(function () {
      $("#closebtn").click(function () {
        $("#dlg").hide('800', "swing", function () { $("#bkg").fadeOut("500"); });
        $("#code").value = $("#calc_output").value;
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

    });
  </script>
  
  
  <style type="text/css">
   	.tblCalc{
 		border:1px solid gray;
 		margin:0;
 		padding:0;
 		width:250px;
 		text-align:center;
 	}
 	.tblCalc input{
 		border:1px solid gray;
 		width:30px;
 		margin:4px;
 	}
	 	#btnWide{
 		width:80px;
 	}
 	#editWide{
 		width:250px;
 	}
</style>
</head>

<body>
  <div class="normal">
    <p><a href="#" id="opn"><input type="text" id="code"></a> 
  </div>
  
  <div class="blockbkg" id="bkg" style="visibility: hidden;">
    <div class="cont" id="dlg" style="visibility: hidden;">
      	<div class="closebtn" title="Close" id="closebtn" color="red">ОК</div>
      
    <form name="Calc">  
<TABLE BORDER=4>
<TR>
<TD>
<INPUT TYPE="text"   NAME="Input" id="calc_output" Size="16">
<br>
</TD>
</TR>
<TR>
<TD>
<INPUT TYPE="button" NAME="one"   VALUE="  1  " OnClick="Calc.Input.value += '1'">
<INPUT TYPE="button" NAME="two"   VALUE="  2  " OnCLick="Calc.Input.value += '2'">
<INPUT TYPE="button" NAME="three" VALUE="  3  " OnClick="Calc.Input.value += '3'">
<INPUT TYPE="button" NAME="plus"  VALUE="  +  " OnClick="Calc.Input.value += ' + '">
<br>
<INPUT TYPE="button" NAME="four"  VALUE="  4  " OnClick="Calc.Input.value += '4'">
<INPUT TYPE="button" NAME="five"  VALUE="  5  " OnCLick="Calc.Input.value += '5'">
<INPUT TYPE="button" NAME="six"   VALUE="  6  " OnClick="Calc.Input.value += '6'">
<INPUT TYPE="button" NAME="minus" VALUE="  -  " OnClick="Calc.Input.value += ' - '">
<br>
<INPUT TYPE="button" NAME="seven" VALUE="  7  " OnClick="Calc.Input.value += '7'">
<INPUT TYPE="button" NAME="eight" VALUE="  8  " OnCLick="Calc.Input.value += '8'">
<INPUT TYPE="button" NAME="nine"  VALUE="  9  " OnClick="Calc.Input.value += '9'">
<INPUT TYPE="button" NAME="times" VALUE="  x  " OnClick="Calc.Input.value += ' * '">
<br>
<INPUT TYPE="button" NAME="clear" VALUE="  c  " OnClick="Calc.Input.value = ''">
<INPUT TYPE="button" NAME="zero"  VALUE="  0  " OnClick="Calc.Input.value += '0'">
<INPUT TYPE="button" NAME="DoIt"  VALUE="  =  " OnClick="Calc.Input.value = eval(Calc.Input.value); #code.value = Calc.Input.value">
<INPUT TYPE="button" NAME="div"   VALUE="  /  " OnClick="Calc.Input.value += ' / '">
<br>
</TD>
</TR>
</TABLE></form>
      
      
    </div>
  </div>


</body>
</html>