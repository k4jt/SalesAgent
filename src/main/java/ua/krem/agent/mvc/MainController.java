package ua.krem.agent.mvc;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import ua.krem.agent.model.Code;
import ua.krem.agent.model.Shop;
import ua.krem.agent.service.ShopService;

@Controller
public class MainController {

	private ShopService shopService;
	
	@Inject
	public MainController(ShopService shopService){
		this.shopService = shopService;
	}
	
	@RequestMapping(value="/tasks_with_tp", method = RequestMethod.GET)
	public String taskWithTp(){
		return "tasks_with_tp";
	}

	@RequestMapping(value="/choose_by_code", method = RequestMethod.GET)
	public String chooseByCode(){
		return "choose_by_code";
	}

	@RequestMapping(value="/choose_by_code", method = RequestMethod.POST)
	public ModelAndView chooseTpByCode(@ModelAttribute("atribute") Code code, HttpSession session){
		Shop shop = shopService.getShopByCode(code.getCode());
		System.out.println("[shop] " + shop);
		ModelAndView model;
		if(shop.getName() != null && !shop.getName().isEmpty()){
			model = new ModelAndView("choose_doc_type");
			model.addObject("shop", shop);
			session.setAttribute("shop", shop);
		}else{
			model = new ModelAndView("choose_by_code");
			model.addObject("errorMsg", "Торговая точка не найдена!");
			session.removeAttribute("shop");
		}
		return model;
	}

	@RequestMapping(value="/choose_doc_type", method = RequestMethod.GET)
	public String chooseDocType(){
		return "choose_doc_type";
	}

	@RequestMapping(value="/realization", method = RequestMethod.GET)
	public String realization(HttpSession session){
		Shop shop = (Shop)session.getAttribute("shop");
		System.out.println("getted shop: " + shop);
		return "realization";
	}

	@RequestMapping(value="/return_back", method = RequestMethod.GET)
	public String returnBack(){
		return "return_back";
	}

	@RequestMapping(value="/data", method = RequestMethod.GET)
	public String data(){
		return "data";
	}

	@RequestMapping(value="/test", method = RequestMethod.GET)
	public String test(){
		return "test";
	}
}
