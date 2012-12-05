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
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.jstree.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Выбор типа накладной</title>
<!-- script type="text/javascript" charset="utf-8">

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


	    $("#demo1")
	        .jstree({
	            // the `plugins` array allows you to configure the active plugins on this instance
	            "plugins" : ["themes","html_data","ui","crrm","hotkeys"],
	            // each plugin you have included can have its own config object
	            "core" : { "initially_open" : [ "phtml_1" ] }
	            // it makes sense to configure a plugin only if overriding the defaults
	        })
	        // EVENTS
	        // each instance triggers its own events - to process those listen on the container
	        // all events are in the `.jstree` namespace
	        // so listen for `function_name`.`jstree` - you can function names from the docs
	        .bind("loaded.jstree", function (event, data) {
	            // you get two params - event & data - check the core docs for a detailed description
	        });
	    // INSTANCES
	    // 1) you can call most functions just by selecting the container and calling `.jstree("func",`
	    setTimeout(function () { $("#demo1").jstree("set_focus"); }, 500);
	    // with the methods below you can call even private functions (prefixed with `_`)
	    // 2) you can get the focused instance using `$.jstree._focused()`.
	    setTimeout(function () { $.jstree._focused().select_node("#phtml_1"); }, 1000);
	    // 3) you can use $.jstree._reference - just pass the container, a node inside it, or a selector
	    setTimeout(function () { $.jstree._reference("#phtml_1").close_node("#phtml_1"); }, 1500);
	    // 4) when you are working with an event you can use a shortcut
	    $("#demo1").bind("open_node.jstree", function (e, data) {
	        // data.inst is the instance which triggered this event
	        data.inst.select_node("#phtml_2", true);
	    });
	    setTimeout(function () { $.jstree._reference("#phtml_1").open_node("#phtml_1"); }, 2500);

});
</script -->

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
    
    /* var $body = $('body'); //Cache this for performance

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
 */
    
    
});

</script>
<style>
	.filter_button{
		background-color: aqua;
	}
</style>
</head>
<body>

<c:if test="${shop != null}">
 	<div class="line">
 		<c:out value="${shop.code}"/>&nbsp;
 		<c:out value="${shop.name}"/>&nbsp;
 		<c:out value="${shop.address}"/>&nbsp;
 		<br>[Тип накладной]:<c:out value="${docType}"/>
 	</div>
 </c:if>

<a href="#" id="filter"><center><div class="filter_button">Фильтр</div></center></a>

<form:form methodParam="POST" modelAttribute="atribute" action="procDoc" method='POST'>
	<table border="1" width="100%">
	<tr>
	<th style="display: none;">Id</th>
	<th>Name</th>
	<!-- th>Group</th>
	<th>Sub Group</th>
	<th>Brand</th>
	<th>Code</th-->
	<th>Amount</th>
	
	</tr>
	<c:forEach var="row" items="${productList}">
		<tr>
			<td style="display: none;"><input type="text" name="prodId" value='<c:out value="${row.id}"/>' /></td>
			<td><c:out value="${row.name}"/></td>
			<!-- td><c:out value="${row.group}"/></td>
			<td><c:out value="${row.subgroup}"/></td>
			<td><c:out value="${row.brand}"/></td>
			<td><c:out value="${row.code}"/></td-->
			<td><input type="text" name="amount" /></td>
		</tr>
	</c:forEach>
	</table>
	<input type="submit" value="submit" />
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
  





</body>
</html>