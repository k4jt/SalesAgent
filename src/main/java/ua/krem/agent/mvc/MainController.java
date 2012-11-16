package ua.krem.agent.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {

	@RequestMapping(value="/tasks_with_tp", method = RequestMethod.GET)
	public String taskWithTp(){
		return "tasks_with_tp";
	}
}
