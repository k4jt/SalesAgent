package ua.krem.agent.mvc;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import ua.krem.agent.model.User;
import ua.krem.agent.service.MyService;

@Controller
//@RequestMapping("/login")
public class LoginController {
	
	/*private final MyService myService;
	
	@Inject
	public LoginController(MyService myService){
		this.myService = myService;
	}*/
	
	/*@RequestMapping(method = RequestMethod.GET)
	public ModelAndView showLoginPage(){
		System.out.println("showLoginPage");
		ModelAndView model = new ModelAndView("login");
		model.addObject("user", new User());
		return model;
	}*/
	
	/*@RequestMapping(value="/signup", method = RequestMethod.POST)
	public String loginning(@Valid User user, BindingResult bindingResult, ModelAndView model){
		System.out.println("loginning");
		System.out.println("bindingResult.hasErrors() = " + bindingResult.hasErrors());
		if(bindingResult.hasErrors()){
			return "Login";
		}
		
		User u = myService.getUser(user.getLogin());
		if(u.getPass().equals(user.getPass())){
			user.setId(u.getId());
			model.addObject("user", user);
			
			
			return "cabinet";
		}else{
			model.addObject("warnMsg", "Invalid user name or password");
			return "Login";
		}
	}*/
	
	@RequestMapping(value="/cabinet", method = RequestMethod.GET)
	public String printWelcome(ModelMap model) {
		
		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getLogin();
	
		model.addAttribute("username", name);
		model.addAttribute("message", "Spring Security login + database example");
		return "hello";
 
	}
 
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(ModelMap model) {
 
		return "login";
 
	}
	
	@RequestMapping(value="/loginfailed", method = RequestMethod.GET)
	public String loginerror(ModelMap model) {
 
		model.addAttribute("error", "true");
		return "login";
 
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
 
		return "login";
 
	}
	
	
}