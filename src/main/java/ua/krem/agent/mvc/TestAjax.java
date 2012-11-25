package ua.krem.agent.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
public class TestAjax{

	/*@RequestMapping(value = "/time", method = RequestMethod.GET)
	  public @ResponseBody String getTime(@RequestParam String name) {
	    String result = "Time for " + name + " is " + new Date().toString();
	    return result;
	  }*/

	
	@RequestMapping(value="/tree", method=RequestMethod.GET)
	public @ResponseBody String doGet(@RequestParam String id){
		StringBuilder out = new StringBuilder();
	    	int randNodCount = 5;
	    	int curId;
	    	try{
	    		curId = Integer.parseInt(id); 
	    	}catch(NumberFormatException e){
	    		e.printStackTrace();
	    		curId = 0;
	    	}
	    	
	    	for (int i = 0; i < randNodCount; i++) {
	    			out.append("<li class='jstree-closed' id='");
	    			out.append(curId + i).append("'><a href='#'>Node ");
	    			out.append(curId + i);
	    			out.append("</a></li>");
			}
	    	System.out.println(out.toString());
	    	return out.toString();
	   }

}
