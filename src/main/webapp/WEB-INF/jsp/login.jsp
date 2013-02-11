<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/mobiscroll.min.css" rel="stylesheet" media="all" />
<link href="${pageContext.request.contextPath}/css/jquery.mobile.min.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Авторизация</title>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script>
		$(document).bind('mobileinit',function(){
   			$.mobile.selectmenu.prototype.options.nativeMenu = false;
		});	
</script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/jquery.mobile.min.js"></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/js/mobiscroll.min.js"></script>
<script type="text/javascript" charset="utf-8">
    //SOME FUNCTIONS
      makeSQLDateString = function(D)//D is a JScript Date
	  {
		  var R = D.getFullYear()+"-";
		  var M = (D.getMonth()+1)+"";
		  var K = D.getDate()+"";
		  if(M.length==1)
		  {
			R+="0"+M+"-";  
		  }
		  else{
			R+=M+"-";
	      }
		  if(K.length==1)
		  {
			R+="0"+K;
		  }
		  else{
			R+=K;  
		  }
		  return R;
	  }
	/*CHOOSE BY CODE PAGE*/
	  $("#code").live("input", function(){
			if($("#errorMsg").length>0)
			{
				$("#errorMsg").css("display","none");
			}
	    $.ajax({
			    url: "calc.html",
			    async: false,
	  		type: "GET",
	  		data: ({code: document.getElementById('code').value}),
	  		dataType: "text",
	  		//contentType: "text/html; charset=iso-8859-1",
	  		
	  		success: function(msg){
	     			var arr = msg.split(' ');
	     			var rez = "";
	     			for (var i = 0; i < arr.length; i++) {
	     			   rez += String.fromCharCode(arr[i]);
	     			}
	     			document.getElementById('Name').value = rez;
	  			}
				}
			) 
	  });
	  /*DESIGNDOC PAGE*/ 
	 
	      $("#amount").live("focus", function(){
	    	  $("input#amount").removeClass("selected");
	    	  $(this).addClass("selected");
	      });
	      $("#amount").live("change", function(){
	    	 var amount = $(".selected")[0].value;
	    	 var prodId = $(".selected").parent().parent().children().children()[0].value;
	    	 $.ajax({
	 	  		    url: "addItem.html",
	 	      		type: "GET",
	 	      		async: false,
	 	      		data: ({idStr: prodId, colStr: amount}),
	 	      		dataType: "text"
	 	   			}
	 	  		);
	    	 $("input#amount").removeClass("selected");
	      });
	      
		   $("#designdoc_Page").live("pageshow", function(){
				  
				  $("#docDateDes, #docDateDesGlobal").mobiscroll().date({
		    		    theme: 'android',
		   		        display: 'modal',
		   		        mode: 'scroller',
		   		        maxDate: new Date(2099,11,31),
		   		        dateOrder: 'ddMy'
			    	    });
			  
				  $("#showDateGlobal").live('click',function(){
					    $.ajax({
			  			    url: "get_global_date.html",
			      			type: "GET",
			      			async: false,
			      			success: function(msg){
			      				$('#docDateDesGlobal').mobiscroll('setDate', new Date(msg), true);
			      			}
			   		 	}
			  			);
				        $('#docDateDesGlobal').mobiscroll('show'); 
				  });
				  
				  $('#docDateDesGlobal').live('change', function(){
					  var D = $('#docDateDesGlobal').mobiscroll('getDate');
					  var R = makeSQLDateString(D);
					  $.ajax({
				  		    url: "set_global_date.html",
				      		type: "GET",
				      		async: false,
				      		data: ({date: R}),
				      		dataType: "text",
				      		success: function(msg){
				      			var arr = R.split('-');
								var span= $("#showDateGlobal span")[0];
								span.replaceChild(document.createTextNode(arr[2]+"-"+arr[1]+"-"+arr[0][2]+arr[0][3]),span.firstChild);
				      		}
				   		 }
				  		);	
				  });
				  
				  $("#showDate").live('click',function(){
					    $.ajax({
			  			    url: "get_doc_date.html",
			      			type: "GET",
			      			async: false,
			      			success: function(msg){
			      				$('#docDateDes').mobiscroll('setDate', new Date(msg), true);
			      			}
			   		 	}
			  			);
				        $('#docDateDes').mobiscroll('show'); 
				  });
				  
				  $('#docDateDes').live('change', function(){
					  var D = $('#docDateDes').mobiscroll('getDate');
					  var R = makeSQLDateString(D);
					  $.ajax({
				  		    url: "set_doc_date.html",
				      		type: "GET",
				      		async: false,
				      		data: ({date: R}),
				      		dataType: "text",
				      		success: function(msg){
				      			var arr = R.split('-');
								var span= $("#showDate span")[0];
								span.replaceChild(document.createTextNode(arr[2]+"-"+arr[1]+"-"+arr[0][2]+arr[0][3]),span.firstChild);
				      		}
				   		 }
				  		);	
				  });
				  
			  });
		   
		   $("#savebtn_chng").live('click', function(){
			   $.ajax({
		  		    url: "set_change.html",
		      		type: "GET",
		      		async: false
		   		 }
		  		);
			   $('#form_real').submit();
		  });
		   
	   /*CHOOSE FROM LIST PAGE*/
	    $("#trow_cfl").live("click", function () {
	    	  $(".test").removeClass("selected");
	    	  $(this).addClass("selected");
	    	  var code = $(this).children()[1].innerHTML;
	    	  var name = $(this).children()[2].innerHTML; 
	    	  var adr  = $(this).children()[3].innerHTML;
	    	  $("#cfl_pophead").get(0).innerHTML = "Код: " + code +"<br />Название: "+ name +"<br />Адрес: "+ adr;
	    	  $( "#popupGoEdit" ).popup( "open" );
	      });

	     $("#savebtn_dialog_cfl").live("click", function (){
	    	 var code = $(".selected").children()[1].innerHTML;
		     $.ajax({
		  		    url: "selectShop.html",
		      		type: "GET",
		      		data: ({code: code}),
		      		dataType: "text",
		      		success: function(){
		      			 $.mobile.changePage("/choose_doc_type");
		      			}
		   			}
		  		);	 
	     });
	     

	     
	   /*DOCUMENTS PAGE*/
	   		$("#trow_doc").live("click", function () {
	    	  $(".test").removeClass("selected");
	    	  $(this).addClass("selected");
	    	  if($(this).children()[5].innerHTML != "Передан")
	    	  {
	    	  	var tt = $(this).children()[2].innerHTML;
	    	  	var client = $(this).children()[3].innerHTML; 
	    	  	var type  = $(this).children()[4].innerHTML;
	    	  	var date = $(this).children()[1].innerHTML;
	    	  	$.ajax({
		  		    url: "set_doc_date.html",
		      		type: "GET",
		      		async: false,
		      		data: ({date: date}),
		      		dataType: "text"
		   		 }
		  		);
	    	  	$("#doc_pophead").get(0).innerHTML = "ТТ: " + tt +"<br />Заказчик: "+ client +"<br />Тип: "+ type;
	    	  	$( "#popupGoEdit" ).popup( "open" );
	    	  }
	      });
		     
	      $("#go_edit_doc").live("click", function (){
		    	 var id = $(".selected").children()[0].children[0].value;
			     $.ajax({
			  		    url: "edit_doc.html",
			      		type: "GET",
			      		data: ({docId: id}),
			      		dataType: "text",
			      		success: function(){
			      			   $.mobile.changePage("/designdoc");
			      			}
			   			}
			  		);	 
		     });
		     
	       $("#documents_Page").live("pageshow", function(){
	    	   
	    	   $('#from').mobiscroll().date({
	   		        theme: 'android',
	   		        display: 'modal',
	   		        mode: 'scroller',
			        dateOrder: 'ddMy',
	      			onClose: function(){
	      				$( "#popupFilter" ).popup( "open" );
	      			},
	      			onBeforeShow: function(){
	      				$( "#popupFilter" ).popup( "close" );
	      			}
  	    	    });
	    	   
	    	   $('#to').mobiscroll().date({
	   		        theme: 'android',
	   		        display: 'modal',
	   		        mode: 'scroller',
	   		    	dateOrder: 'ddMy',
	      			onClose: function(){
	      				$( "#popupFilter" ).popup( "open" );
	      			},
	      			onBeforeShow: function(){
	      				$( "#popupFilter" ).popup( "close" );
	      			}
 	    	    });
	       });
	/* EXPORT PAGE */
	
	   $("#row_exp").live("click", function(e){
   		 if (e.target.type == "checkbox") {
            e.stopPropagation();
         } else {
            var cbox = $(this).find(':checkbox');
            if(cbox.length>0)
            cbox.get(0).checked = !cbox.get(0).checked;
         }
	   });
	
	   $("#export_Page").live("pageshow", function(){
    	   
    	   $('#from').mobiscroll().date({
   		        theme: 'android',
   		        display: 'modal',
   		        mode: 'scroller',
      			onClose: function(){
      				$( "#popupFilter" ).popup( "open" );
      			},
      			onBeforeShow: function(){
      				$( "#popupFilter" ).popup( "close" );
      			}
	    	    });
    	   
    	   $('#to').mobiscroll().date({
   		        theme: 'android',
   		        display: 'modal',
   		        mode: 'scroller',
      			onClose: function(){
      				$( "#popupFilter" ).popup( "open" );
      			},
      			onBeforeShow: function(){
      				$( "#popupFilter" ).popup( "close" );
      			}
	    	    });
       });
	   
	  //pickDocDate_Page
	  $("#pickDate_Page").live("pageshow", function(){
		  var D = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
		  $('#docDate').mobiscroll().date({
    		    theme: 'android',
   		        display: 'inline',
   		        mode: 'scroller',
   		        maxDate: new Date(2099,11,31),
		        dateOrder: 'ddMy'
	    	    });
		  $('#docDate').mobiscroll('setDate', D, true);
	  });
	  $('#docDate').live('change', function(){
		  var D = $('#docDate').mobiscroll('getDate');
		  var R = makeSQLDateString(D);
		  $.ajax({
	  		    url: "set_global_date.html",
	      		type: "GET",
	      		async: false,
	      		data: ({date: R}),
	      		dataType: "text"
	   		 }
	  		);	
	  });
</script>
<style>
.ui-fullsize .ui-btn-inner{
	font-size: 20px;
}
.ui-btn-inner{
	font-size: 20px;
}
input.ui-input-text{
	font-size: 20px;
}
label.ui-input-text{
	font-size: 20px;
}
.ui-header .ui-title, .ui-footer .ui-title{
	font-size: 20px;
}
.ui-input-text{
	font-size: 20px;
}
</style>

</head>

<body>
	
<div data-role="page" id="Login_Page">

	<div data-role="header">
		<h1>Авторизация</h1>
	</div><!-- /header -->
	
	<c:if test="${invalidUser != null}">
		<div class="errorblock">
			<c:out value="${invalidUser}"/>
		</div>
	</c:if>
	
	
	<form:form methodParam="POST" modelAttribute="atribute" action="login" method='POST'>
		<center>
        	 <label for="username">Имя:</label>
        	 <c:choose>
			    <c:when test="${user_login!=null}">
			    	<input type="text" name="username" id="username" value='<c:out value="${user_login}"/>'/>
			    </c:when>
			    <c:otherwise>
			    	<input type="text" name="username" id="username" value="" />
			    </c:otherwise>
		    </c:choose>
			 <label for="password">Пароль:</label>
         	 <input type="password" name="password" id="password" value="" />
			 <button type="submit" data-theme="b" name="submit">OK</button>
		</center>
	</form:form>
</div>
	
	
</body>
</html>