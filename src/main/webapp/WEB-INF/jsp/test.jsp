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
<style>
	.selected{
		font-size: larger;
	}
</style>
<script type="text/javascript">



 $(function () {
	
	var clickedId = 0; 
	 
	 /* $('#demo li a').click(function(){
			$('#demo li').removeClass('selected'); // remove all selected class values
			$(this).parent().addClass('selected');
		   alert("id = " + $("#demo li.selected").attr("id"));
		   clickedId = $("#demo li.selected").attr("id");
		}); */
	 
	$("#demo").jstree({ 
		"ui" : { "select_limit" : 1 },
		"core" : { "initially_open" : [ "root" ] },
		"html_data" : {
			"data" : "<li class='jstree-closed' id='root'><a href='#'>Root node</a></li>", 
			"ajax" : { 
				"url" : "tree.html",
				"data": ({id : $("#demo li a.jstree-clicked").parent().attr("id") ? $("#demo li a.jstree-clicked").parent().attr("id") : 0 })
				}
			
		},
		"plugins" : [ "themes", "html_data", "ui"]
	})
	.bind("select_node.jstree", function (event, data) {
		$.jstree._reference("3").open_node("3");
//		$.jstree._reference(data.rslt.obj.attr("id")).open_node(data.rslt.obj.attr("id"));
//		$("#demo").jstree("toggle_node", data.rslt.obj.attr("id"));
		// `data.rslt.obj` is the jquery extended node that was clicked
		//alert(data.rslt.obj.attr("id"));
		//clickedId = data.rslt.obj.attr("id");
	});
});

 
 
</script>



</head>


<!-- script>
function doAjax() {
    $.ajax({
      url: 'time.html',
      data: ({name : "me"}),
      success: function(data) {
        $('#time').html(data);
      }
    });
  }
</script-->

<body>
		<div id="demo">	</div>
</body>

<!--body>

<button id="demo" onclick="doAjax()" title="Button">Get the time!</button>
<div id="time">
</div>

</body-->

</html>