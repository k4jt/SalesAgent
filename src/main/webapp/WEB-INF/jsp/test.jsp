<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>jsTree v.1.0 - Demo</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/_lib/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/_lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/_lib/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.jstree.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/js/_docs/syntax/!style.css"/>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/js/_docs/!style.css"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/_docs/syntax/!script.js"></script>
</head>

<script type="text/javascript">

$(function () {
	$("#demo").jstree({ 
		"core" : { "initially_open" : [ "root2" ] },
		"html_data" : {
			/* "data" : "<li class='jstree-closed' id='root2'><a href='#'>Root node</a></li>", */
			"ajax" : { 
				"url" : "testAjax.jsp" 
			}
		},
		"plugins" : [ "themes", "html_data" ]
	});
});

</script>

<body id="demo_body">


<div id="container">

	
		<div id="demo"  >
			
		</div>


</div>



</body>
</html>