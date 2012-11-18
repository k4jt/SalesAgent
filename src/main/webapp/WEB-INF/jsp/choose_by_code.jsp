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
<style type = "text/css" > 
.box{
	width: 100%;
	font-size: xx-large;
}

.box:hover{
	border-color: red;
}

.okbtn{
	width: 100%;
	font-size: xx-large;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Выбор ТТ по коду</title>

</head>
<body>
	<center>
		<input type="text" class="box" readonly="readonly" size="10" maxlength="30">
		<input type="submit" class="okbtn" value="OK">
	</center>
</body>
</html>