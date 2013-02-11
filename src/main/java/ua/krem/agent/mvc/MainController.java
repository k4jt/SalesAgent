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
import ua.krem.agent.model.DocList;
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
	
	/* BEGIN
	 * DUMMY
	 * METHODS
	 */
	
	@RequestMapping(value="/choose_by_code", method = RequestMethod.GET)
	public String chooseByCode(){
		return "choose_by_code";
	}
	
	@RequestMapping(value="/sync_type", method = RequestMethod.GET)
	public String synctype(){
		return "sync_type";
	}
	
	@RequestMapping(value="/tasks_with_tp", method = RequestMethod.GET)
	public String taskWithTp(HttpSession session){
		session.removeAttribute("docId");
		System.out.println("DOCID REMOVED!");
		return "tasks_with_tp";
	}

	/* END
	 * DUMMY
	 * METHODS
	 */
	
	/* BEGIN
	 * AJAX
	 * HANDLERS
	 */
	@RequestMapping(value="/set_global_date", method = RequestMethod.GET)
	@ResponseBody public String setGlobalDocDate(HttpSession session, @RequestParam String date){
		System.out.println("SET GLOBAL DOC DATE: "+ date);
		if(date != null && !date.isEmpty()){
			session.setAttribute("docGlobalDate", date);
		}
		return "Done";
	}
	
	@RequestMapping(value="/set_doc_date", method = RequestMethod.GET)
	@ResponseBody public String setSelectedDocDate(HttpSession session, @RequestParam String date){
		System.out.println("SET DOC DATE: "+ date);
		if(date != null && !date.isEmpty()){
			session.setAttribute("selDocDate", date);
		}
		return "Done";
	}
	
	@RequestMapping(value="/get_global_date", method = RequestMethod.GET)
	@ResponseBody public String getdocGlobalDate(HttpSession session){
		return (String) session.getAttribute("docGlobalDate");
	}
	
	@RequestMapping(value="/get_doc_date", method = RequestMethod.GET)
	@ResponseBody public String getSelectedDocDate(HttpSession session){
		return (String) session.getAttribute("selDocDate");
	}
	
	@RequestMapping(value="/set_change", method = RequestMethod.GET)
	@ResponseBody public String setDocChange(HttpSession session){
		session.setAttribute("docChange", (Integer)1);
		return (String) session.getAttribute("docChange");
	}
	
	@RequestMapping(value="/calc", method = RequestMethod.GET)
	 @ResponseBody public String getShopName(@RequestParam String code) throws UnsupportedEncodingException{
		System.out.println("CODE IS: "+code);
		Shop shop = shopService.getShopByCode(code);
		System.out.println(shop.toString());
		String rez;
		if(shop.getName() != null && !shop.getName().isEmpty()){
				rez = toAjaxString(shop.toString());
		}else{
				rez = toAjaxString("Торговая точка не найдена!");
			}
		return rez;
	}
	//ADDITIONAL FUNCTIONS for RequestMapping '/calc'!! 
	//Transforms String to ASCII-String (AAA->65 65 65) 
	public String toAjaxString(String forCode)
	{
		StringBuilder ajaxStr = new StringBuilder();
		int [] bArr = new int[forCode.length()];
		for(int i=0; i<bArr.length; i++)
		{
			bArr[i]=(int)forCode.charAt(i);
		}
		for(int i=0; i<bArr.length; i++)
		{
			ajaxStr.append(String.valueOf(bArr[i])+" ");
		}
		return ajaxStr.toString();
	}
	
	@RequestMapping(value="/addItem", method = RequestMethod.GET)
    @ResponseBody public String addItems(@RequestParam String idStr, @RequestParam String colStr, HttpSession session){
		
		List<Item> itemList = getItemListFromSession(session);
		System.out.println("WOTRKEDED!");
		System.out.println("WOTRKEDED!");
		System.out.println("WOTRKEDED!");
		System.out.println("PARAMETERS: "+idStr+" - " + colStr);
		int id = Integer.parseInt(idStr);
		int amount = Integer.parseInt(colStr);
		Item item = new Item(id, amount);
		if(!updateItemIfContainsInList(itemList, item)){
			itemList.add(item);
		}
		session.setAttribute("itemList", itemList);
		System.out.println("\nITEMLIST ADD ITEM!!!\n");
		if(itemList != null){
			for(Item i : itemList){
				System.out.println(i.id + " - " + i.amount);
			}
		}
		//session.setAttribute("itemAmount", colStr);
		return "Oops!";
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
	
	@RequestMapping(value="/edit_doc", method = RequestMethod.GET)
    public ModelAndView edit(HttpSession session, @RequestParam String docId){
		System.out.println("EDIT\n\nDOC ID: "+ docId);
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
	
	/* END
	 * AJAX
	 * HANDLERS
	 */

	/* BEGIN
	 * FORM POST
	 * METHODS
	 */

	@RequestMapping(value="/procDoc", method = RequestMethod.POST)
	public ModelAndView procDoc(@ModelAttribute("atribute") Document doc, HttpSession session){
		ModelAndView model = null;
		session.removeAttribute("itemList");
		System.out.println("PROCDOC!");
		doc.setDocType((Integer)session.getAttribute("docTypeId"));
		if(doc.getDocType1() == null)
		{
			doc.setDocType1(0);
		}
		session.removeAttribute("docType");
		session.removeAttribute("docTypeId");
		Integer docId = (Integer)session.getAttribute("docId");
		session.removeAttribute("docId");
		Shop shop = (Shop)session.getAttribute("shop");
		User user = (User)session.getAttribute("user");
		if(user != null && shop != null){
			doc.setUserId(user.getId());
			doc.setShopId(shop.getId());
		}
		String docDate="";
		if(docId != null){
			docDate = (String)session.getAttribute("selDocDate");
			doc.setId(docId);
			model = new ModelAndView("cabinet");
			model.addObject("save_result", productService.editDocument(doc, docDate));
		} else {
			docDate = (String)session.getAttribute("docGlobalDate");
			Integer flagChange = (Integer)session.getAttribute("docChange");
			if(flagChange==null)
			{
				flagChange=0;
			}
			session.removeAttribute("docChange");
			model = new ModelAndView("choose_doc_type");
			model.addObject("save_result", productService.addDocument(doc, docDate, flagChange));
			
		}
		
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
	
	private List<Item> getItemListFromSession(HttpSession session) {
		List<Item> itemList = (List<Item>) session.getAttribute("itemList");
		if(itemList == null){
			itemList = new ArrayList<Item>();
		}
		return itemList;
	}
	
	private Item extractItemFromIdAmountString(String idAmount){
		String[] array = idAmount.split(" ");
		int id = 0;
		int amount = 0;
		try{
			id = Integer.parseInt(array[0]);
			amount = Integer.parseInt(array[1]);
		}catch(Exception e){
			e.printStackTrace();
		}
		return new Item(id, amount);
	}
	
	/**
	 * @return true if update, false if not update
	 */
	private boolean updateItemIfContainsInList(List<Item> itemList, Item item){
		boolean contains = false;
		for(Item i : itemList){
			if(i.id == item.id){
				if(item.amount == 0){
					itemList.remove(i);
				} else {
					i.amount = item.amount;
				}
				contains = true;
				break;
			}
		}
		return contains;
	}
	
	
	/*public void addItems(@RequestParam String idStr, @RequestParam String colStr, HttpSession session){
		
		List<Item> itemList = getItemListFromSession(session);
		int id = Integer.parseInt(idStr);
		int amount = Integer.parseInt(colStr);
		Item item = new Item(id, amount);
		if(!updateItemIfContainsInList(itemList, item)){
			itemList.add(item);
		}
		session.setAttribute("itemList", itemList);
	}*/
	
	/*(@RequestParam String code) throws UnsupportedEncodingException{
		System.out.println("CODE IS: "+code);
		Shop shop = shopService.getShopByCode(code);
		System.out.println(shop.toString());
		String rez;
		if(shop.getName() != null && !shop.getName().isEmpty()){
			//rez = new String(shop.toString().getBytes("ISO-8859-1"),"UTF-8");
			//rez += new String(shop.toString().getBytes("Windows-1251"),"UTF-8");
				rez = toAjaxString(shop.toString());
		}else{
				rez = toAjaxString("Торговая точка не найдена!");
			}
		return rez;
	}*/
	
	
	@RequestMapping(value="/choose_doc_type", method = RequestMethod.GET)
	public String chooseDocType(HttpSession session){
		session.removeAttribute("docType");
		return "choose_doc_type";
	}
	@RequestMapping(value="/filterTP", method = RequestMethod.POST)
	public ModelAndView filteredShop(@ModelAttribute("filterAtribute") ShopFilter filter, HttpSession session){
		ModelAndView model = new ModelAndView("choose_from_list");
		model.addObject("shopList", shopService.filterShop(filter));		
		return model;
	}
	
	@RequestMapping(value="/designdoc", method = RequestMethod.POST)
	public ModelAndView filteredRezult(@ModelAttribute("filterAtribute") ProductFilter filter, HttpSession session){

		ModelAndView model = new ModelAndView("designdoc");
		model.addObject("brandList", productService.getBrands());
		System.out.println("\nITEMLIST!!!\n");
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
	
	
	
	@RequestMapping(value="/designdoc", method = RequestMethod.GET)
	public ModelAndView designdoc(HttpSession session){
		Integer docId = (Integer)session.getAttribute("docId");
		System.out.println("NEW\n\nDOC ID: "+ docId);
		if(docId == null)
		{
			session.removeAttribute("docType");
			session.removeAttribute("docTypeId");
			session.setAttribute("docType", "Реализация");
			session.setAttribute("docTypeId", 0);
			return makeDoc(session);
		}
		else{
			try{
				return editDoc(session, docId);
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
		
		
		ModelAndView model = new ModelAndView("designdoc");
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
		System.out.println("GET");
		System.out.println("GET");
		System.out.println("GET");
		System.out.println(session.getServletContext().getRealPath("/"));
		List<Product> list = productService.getProducts(null, null);
		ModelAndView model = new ModelAndView("designdoc");
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

	@RequestMapping(value="/choose_from_list", method = RequestMethod.GET)
	public ModelAndView chooseFromListTT(){
		ModelAndView model = new ModelAndView("choose_from_list");
		
		model.addObject("shopList", shopService.filterShop(null));
		
		return model;
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
		String docGlobalDate = (String)session.getAttribute("docGlobalDate");
		model.addObject("docList", documentService.selectDoc(filter, docGlobalDate));
		
		return model;
	}
	
	@RequestMapping(value="/export", method=RequestMethod.GET)
	public ModelAndView showExportDocument(HttpSession session){
		ModelAndView model = new ModelAndView("export");
		User user = (User)session.getAttribute("user");
		DocHeadFilter filter = new DocHeadFilter();
		if(user != null){
			filter.setUserId(user.getId());
		}
		String docGlobalDate = (String)session.getAttribute("docGlobalDate");
		model.addObject("expList", documentService.selectExpDoc(filter, docGlobalDate));
		
		return model;
	}
	
	@RequestMapping(value="/procExport", method = RequestMethod.POST)
	public ModelAndView procExport(@ModelAttribute("atribute") DocList docs, HttpSession session){
		ModelAndView model = null;
		User user = (User)session.getAttribute("user");
		model = new ModelAndView("cabinet");
		if(docs != null)
		{
		  model.addObject("exp_result", documentService.exportDocuments(docs, user.getId().toString(), session.getServletContext().getRealPath("/")));
		}
		else
		{
			model.addObject("exp_result", "Для экспорта не было выбрано ни одного документа!");
		}
		return model;
	}
	
	@RequestMapping(value="/filterDoc", method = RequestMethod.POST)
	public ModelAndView filterDoc(@ModelAttribute("filterAtribute") DocHeadFilter filter, HttpSession session){
		String date = filter.getFrom();
		String mm, dd, yy;
		if(date.length()>6)
		{
			mm = date.substring(3, 5);
			dd = date.substring(0, 2);
			yy = date.substring(6);
			filter.setFrom(yy+"-"+mm+"-"+dd);
		}
		date = filter.getTo();
		if(date.length()>6)
		{
			mm = date.substring(3, 5);
			dd = date.substring(0, 2);
			yy = date.substring(6);
			filter.setTo(yy+"-"+mm+"-"+dd);
		}
		ModelAndView model = new ModelAndView("documents");
		User user = (User)session.getAttribute("user");
		System.out.println("user = " + user);
		System.out.println("filter = " + filter.getFrom());
		if(user != null){
			filter.setUserId(user.getId());
		}
		String docGlobalDate = (String)session.getAttribute("docGlobalDate");
		model.addObject("docList", documentService.selectDoc(filter,docGlobalDate));
		
		return model;
	}
	
	@RequestMapping(value="/filterExportDoc", method = RequestMethod.POST)
	public ModelAndView filterExpDoc(@ModelAttribute("filterAtribute") DocHeadFilter filter, HttpSession session){
		String date = filter.getFrom();
		String mm, dd, yy;
		if(date.length()>6)
		{
			mm = date.substring(3, 5);
			dd = date.substring(0, 2);
			yy = date.substring(6);
			filter.setFrom(yy+"-"+mm+"-"+dd);
		}
		date = filter.getTo();
		if(date.length()>6)
		{
			mm = date.substring(3, 5);
			dd = date.substring(0, 2);
			yy = date.substring(6);
			filter.setTo(yy+"-"+mm+"-"+dd);
		}
		ModelAndView model = new ModelAndView("export");
		User user = (User)session.getAttribute("user");
		System.out.println("user = " + user);
		if(user != null){
			filter.setUserId(user.getId());
		}
		String docGlobalDate = (String)session.getAttribute("docGlobalDate");
		model.addObject("expList", documentService.selectExpDoc(filter,docGlobalDate));
		
		return model;
	}
	
}
