package ua.krem.agent.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
@RequestMapping(value="/testAjax")
public class TestAjax{

	@RequestMapping(method=RequestMethod.GET)
	public @ResponseBody String doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		StringBuilder out = new StringBuilder();

	    	int randNodCount = 5;
	    	for (int i = 0; i < randNodCount; i++) {
	    			out.append("<li class=\"jstree-closed\"><a href=\"#\">Node ");// 1</a></li>");
	    			out.append("" + i);
	    			out.append("</a></li>");
			}
	    	System.out.println(out.toString());
	    	return out.toString();
	   }

		@RequestMapping(method = RequestMethod.POST)
	   public @ResponseBody String doPost(HttpServletRequest request, HttpServletResponse response)
	               throws IOException, ServletException {
	      return doGet(request, response);
	   }
}
