package ua.krem.agent.mvc;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import ua.krem.agent.model.LoginData;
import ua.krem.agent.model.User;
import ua.krem.agent.service.UserService;

@Controller
public class LoginController {
	
	private final UserService service;
	
	@Inject
	public LoginController(UserService myService){
		service = myService;
	}
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public ModelAndView showLoginPage(){
		System.out.println("showLoginPage");
		ModelAndView model = new ModelAndView("login");
		model.addObject("user", new User());
		return model;
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public ModelAndView loginning(@ModelAttribute("atribute") LoginData loginData){
		ModelAndView model = null;
		User user = service.getUser(loginData.getUsername());
		if(user.getPass().equals(loginData.getPassword())){
			model = new ModelAndView("cabinet");
		}else{
			model = new ModelAndView("login");
			model.addObject("invalidUser", "Invalid user name");
		}
		
		return model;
	}
	
	
	
	
}