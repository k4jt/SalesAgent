package ua.krem.agent.mvc;


import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
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
import ua.krem.agent.model.DocHeadFilter;
import ua.krem.agent.model.Document;
import ua.krem.agent.model.Item;
import ua.krem.agent.model.Product;
import ua.krem.agent.model.ProductFilter;
import ua.krem.agent.model.Shop;
import ua.krem.agent.model.ShopFilter;
import ua.krem.agent.model.User;
import ua.krem.agent.service.DocumentService;
import ua.krem.agent.service.ProductService;
import ua.krem.agent.service.ShopService;

@Controller
public class MainController {

	private ShopService shopService;
	private ProductService productService;
	private DocumentService documentService;
	
	@Inject
	public MainController(ShopService shopService, ProductService productService, DocumentService documentService){
		this.shopService = shopService;
		this.productService = productService;
		this.documentService = documentService;
	}
	
	@RequestMapping(value="/tasks_with_tp", method = RequestMethod.GET)
	public String taskWithTp(){
		return "tasks_with_tp";
	}

	@RequestMapping(value="/choose_by_code", method = RequestMethod.GET)
	public String chooseByCode(){
		return "choose_by_code";
	}

	@RequestMapping(value="/procDoc", method = RequestMethod.POST)
	public ModelAndView procDoc(@ModelAttribute("atribute") Document doc, HttpSession session){
		ModelAndView model = null;
		session.removeAttribute("itemList");
		System.out.println("DocType: " + session.getAttribute("docType"));
		doc.setDocType( (Integer)session.getAttribute("docTypeId")  );

		System.out.println("docType: " + doc.getDocType());
		session.removeAttribute("docType");
		session.removeAttribute("docTypeId");
		Integer docId = (Integer)session.getAttribute("docId");
		session.removeAttribute("docId");
		System.out.println("docId = " + docId);
		Shop shop = (Shop)session.getAttribute("shop");
		User user = (User)session.getAttribute("user");
		if(user != null && shop != null){
			doc.setUserId(user.getId());
			doc.setShopId(shop.getId());
		}
		if(docId != null){
			doc.setId(docId);
			model = new ModelAndView("cabinet");
			model.addObject("save_result", productService.editDocument(doc));
		} else {
			model = new ModelAndView("choose_doc_type");
			model.addObject("save_result", productService.addDocument(doc));
		}
		
		System.out.println("model = " + model.getViewName() );
		return model;
	}
	
	
	@RequestMapping(value="/choose_by_code", method = RequestMethod.POST)
	public ModelAndView chooseTpByCode(@ModelAttribute("atribute") Code code, HttpSession session){
		Shop shop = shopService.getShopByCode(code.getCode());
		System.out.println("[shop] " + shop);
		System.out.println(code.getCode());
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
	
	@RequestMapping(value="/addItem", method = RequestMethod.GET)
	public void addItems(@RequestParam String idAmount, HttpSession session){
		String[] array = idAmount.split(" ");
		System.out.println("hello");
		int id = Integer.parseInt(array[0]);
		try{
			int amount = Integer.parseInt(array[1]);
			
			List<Item> itemList = (List<Item>) session.getAttribute("itemList");
			if(itemList == null){
				System.out.println("create new itemList");
				itemList = new ArrayList<Item>();
			}
			Item item = new Item();
			item.id = id;
			item.amount = amount;
			if(amount == 0){
				for(Item i : itemList){
					if(i.id == id){
						itemList.remove(i);
						break;
					}
				}
			}else{
				itemList.add(item);
			}
			
			session.setAttribute("itemList", itemList);
			
			System.out.println("ItemList contain:");
			for(Item i : itemList){
				System.out.println(i.id + ":" + i.amount);
			}
			
			
		}catch(NumberFormatException e){
			e.printStackTrace();
		}catch(IndexOutOfBoundsException e){
			e.printStackTrace();
			List<Item> itemList = (List<Item>) session.getAttribute("itemList");
			if(itemList != null){
				for(Item i : itemList){
					if(i.id == id){
						itemList.remove(i);
						break;
					}
				}
				session.setAttribute("itemList", itemList);
			}
		}
		
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

	@RequestMapping(value="/selectShop", method = RequestMethod.GET)
	public ModelAndView selectShop(@RequestParam String code, HttpSession session) {
		System.out.println("shop code IS: " + code);
		
		ModelAndView model = new ModelAndView("choose_doc_type");
		Shop shop = shopService.getShopByCode(code);
		session.setAttribute("shop", shop);
		model.addObject("shop", shop);
		
		return model;
	}
	
	@RequestMapping(value="/choose_doc_type", method = RequestMethod.GET)
	public String chooseDocType(HttpSession session){
		session.removeAttribute("docType");
		return "choose_doc_type";
	}
	@RequestMapping(value="/filterTP", method = RequestMethod.POST)
	public ModelAndView filteredShop(@ModelAttribute("filterAtribute") ShopFilter filter, HttpSession session){
		ModelAndView model = new ModelAndView("choose_from_list");
		if(filter != null){
			System.out.println(filter.getCode());
			System.out.println(filter.getName());
			System.out.println(filter.getAddress());
		}
		model.addObject("shopList", shopService.filterShop(filter));
		
		return model;
	}
	
	@RequestMapping(value="/realization", method = RequestMethod.POST)
	public ModelAndView filteredRezult(@ModelAttribute("filterAtribute") ProductFilter filter, HttpSession session){

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
		
		List<Item> itemList = (List<Item>) session.getAttribute("itemList");
		if(itemList != null){
			for(Item i : itemList){
				System.out.println(i.id + " - " + i.amount);
			}
		}
		
		List<Product> list = productService.getProducts(filter, itemList);
		model.addObject("productList", list);
		
		return model;
	}
	
	
	
	@RequestMapping(value="/realization", method = RequestMethod.GET)
	public ModelAndView realization(HttpSession session){
		session.removeAttribute("docType");
		session.removeAttribute("docTypeId");
		session.setAttribute("docType", "Реализация");
		session.setAttribute("docTypeId", 0);
		return makeDoc(session);
	}
	
	@RequestMapping(value="/edit_doc", method = RequestMethod.GET)
	public ModelAndView edit(HttpSession session, @RequestParam String docId){
		if(docId == null || docId.isEmpty()){
			session.setAttribute("docType", "Реализация");
			session.setAttribute("docTypeId", 0);
			return makeDoc(session);
		} else {
			try{
				Integer id = Integer.parseInt(docId);
				return editDoc(session, id);
			}catch(NumberFormatException e){
				e.printStackTrace();
				return makeDoc(session);
			}
		}
	}
	
	private ModelAndView editDoc(HttpSession session, Integer docId){
		session.removeAttribute("docType");
		session.removeAttribute("docTypeId");
		session.removeAttribute("itemList");
		session.removeAttribute("shop");
		
		
		ModelAndView model = new ModelAndView("realization");
		Document doc = documentService.getDocumentById(docId);
		
		if(doc != null){
			session.setAttribute("docId", docId);
			session.setAttribute("docTypeId", doc.getDocType());
			
			if(doc.getDocType() == 0){
				session.setAttribute("docType", "Реализация");
			} else {
				session.setAttribute("docType", "Возврат");
			}
			
			session.setAttribute("shop", shopService.getShopById(doc.getShopId()) );
			session.setAttribute("itemList", doc.getItemList());
			
			model.addObject("productList", doc.getProductList());
			
			
		}
		
		List<Brand> brandList = productService.getBrands();
		model.addObject("brandList", brandList);
		return model;
	}
	
	private ModelAndView makeDoc(HttpSession session){
		session.removeAttribute("docId");
		
		System.out.println(session.getAttribute("docType"));
		System.out.println(session.getAttribute("docTypeId"));
		session.removeAttribute("itemList");
		
		Shop shop = (Shop)session.getAttribute("shop");
		System.out.println("getted shop: " + shop);
		
		List<Product> list = productService.getProducts(null, null);
		ModelAndView model = new ModelAndView("realization");
		model.addObject("productList", list);
		
		List<Brand> brandList = productService.getBrands();
		model.addObject("brandList", brandList);
		
		return model;
	}

	@RequestMapping(value="/return_back", method = RequestMethod.GET)
	public ModelAndView returnBack(HttpSession session){
		session.removeAttribute("docType");
		session.removeAttribute("docTypeId");
		session.setAttribute("docType", "Возврат");
		session.setAttribute("docTypeId", 1);
		return makeDoc(session);
	}

	@RequestMapping(value="/data", method = RequestMethod.GET)
	public String data(){
		return "data";
	}

	@RequestMapping(value="/choose_from_list", method = RequestMethod.GET)
	public ModelAndView chooseFromListTT(){
		ModelAndView model = new ModelAndView("choose_from_list");
		
		model.addObject("shopList", shopService.filterShop(null));
		
		return model;
	}

	@RequestMapping(value="/test", method = RequestMethod.GET)
	public String test(){
		return "test";
	}
	@RequestMapping(value="/documents", method=RequestMethod.GET)
	public ModelAndView showDocument(HttpSession session){
		ModelAndView model = new ModelAndView("documents");
		User user = (User)session.getAttribute("user");
		DocHeadFilter filter = new DocHeadFilter();
		System.out.println("user = " + user);
		if(user != null){
			filter.setUserId(user.getId());
		}
		model.addObject("shopList", documentService.selectDoc(filter));
		
		return model;
	}
	
	@RequestMapping(value="/filterDoc", method = RequestMethod.POST)
	public ModelAndView filtereDoc(@ModelAttribute("filterAtribute") DocHeadFilter filter, HttpSession session){
		ModelAndView model = new ModelAndView("documents");
		User user = (User)session.getAttribute("user");
		System.out.println("user = " + user);
		if(user != null){
			filter.setUserId(user.getId());
		}
		model.addObject("shopList", documentService.selectDoc(filter));
		
		return model;
	}
	
}
