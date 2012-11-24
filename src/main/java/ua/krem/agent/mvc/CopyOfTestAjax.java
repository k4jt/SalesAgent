package ua.krem.agent.mvc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@Controller
@RequestMapping(value="/testAjax", method = RequestMethod.GET)
public class CopyOfTestAjax extends HttpServlet{

	 @Override
	   public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	      response.setContentType("text/html; charset=UTF-8");
	      PrintWriter out = response.getWriter();
	 
	      try {

	    	int randNodCount = (int)Math.random() * 10;
	    	for (int i = 0; i < randNodCount; i++) {
	    		if(Math.random() > 0.5){
	    			out.println("<li class=\"jstree-closed\"><a href=\"#\">Node ");// 1</a></li>");
	    			out.println("" + ((int)Math.random()*100));
	    			out.println("</a></li>");
	    		}
			}
	 
	        
	      } finally {
	         out.close();  // Always close the output writer
	      }
	   }
	 
	   @Override
	   public void doPost(HttpServletRequest request, HttpServletResponse response)
	               throws IOException, ServletException {
	      doGet(request, response);
	   }
}
