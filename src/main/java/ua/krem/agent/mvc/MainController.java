package ua.krem.agent.mvc;


import java.io.UnsupportedEncodingException;
import java.util.List;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ua.krem.agent.model.Brand;
import ua.krem.agent.model.Code;
import ua.krem.agent.model.Filter;
import ua.krem.agent.model.Product;
import ua.krem.agent.model.Shop;
import ua.krem.agent.service.ProductService;
import ua.krem.agent.service.ShopService;

@Controller
public class MainController {

	private ShopService shopService;
	private ProductService productService;
	
	@Inject
	public MainController(ShopService shopService, ProductService productService){
		this.shopService = shopService;
		this.productService = productService;
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
	
	@RequestMapping(value="/calc", method = RequestMethod.GET)
	 @ResponseBody public String GetShopName(@RequestParam String code) throws UnsupportedEncodingException{
		System.out.println("CODE IS: "+code);
		Shop shop = shopService.getShopByCode(code);
		System.out.println(shop.toString());
		String rez;
		if(shop.getName() != null && !shop.getName().isEmpty()){
			rez = new String(shop.toString().getBytes("ISO-8859-1"),"UTF-8");
		}else{
			rez = new String("Торговая точка не найдена!".getBytes("ISO-8859-1"),"UTF-8");
			}
		return rez;
	}
	
	@RequestMapping(value="/choose_doc_type", method = RequestMethod.GET)
	public String chooseDocType(){
		return "choose_doc_type";
	}

	@RequestMapping(value="/realization", method = RequestMethod.POST)
	public ModelAndView filteredRezult(@ModelAttribute("filterAtribute") Filter filter){
		ModelAndView model = new ModelAndView("realization");
		
		if(filter != null){
			if(filter.getProdName() != null){
				System.out.println("filter prod name: " + filter.getProdName());
			}
			if(filter.getBrand() != null){
				System.out.println("filter brand: " + filter.getBrand());
			}
		}
		
		List<Brand> brandList = productService.getBrands();
		model.addObject("brandList", brandList);
		
		List<Product> list = productService.getProducts(filter);
		model.addObject("productList", list);
		
		return model;
	}
	
	
	
	@RequestMapping(value="/realization", method = RequestMethod.GET)
	public ModelAndView realization(HttpSession session){
		session.setAttribute("docType", "Реализация");
		Shop shop = (Shop)session.getAttribute("shop");
		System.out.println("getted shop: " + shop);
		
		List<Product> list = productService.getProducts(null);
		ModelAndView model = new ModelAndView("realization");
		model.addObject("productList", list);
		
		List<Brand> brandList = productService.getBrands();
		model.addObject("brandList", brandList);
		
		return model;
	}

	@RequestMapping(value="/return_back", method = RequestMethod.GET)
	public ModelAndView returnBack(HttpSession session){
		session.setAttribute("docType", "Возврат");
		Shop shop = (Shop)session.getAttribute("shop");
		System.out.println("getted shop: " + shop);
		
		List<Product> list = productService.getProducts(null);
		ModelAndView model = new ModelAndView("realization");
		model.addObject("productList", list);
		
		List<Brand> brandList = productService.getBrands();
		model.addObject("brandList", brandList);
		
		return model;
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
