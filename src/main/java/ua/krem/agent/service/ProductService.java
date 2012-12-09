package ua.krem.agent.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.ProductDAO;
import ua.krem.agent.model.Brand;
import ua.krem.agent.model.Document;
import ua.krem.agent.model.ProductFilter;
import ua.krem.agent.model.Item;
import ua.krem.agent.model.Product;

@Service
public class ProductService {

	private ProductDAO productDAO;
	
	@Inject
	public ProductService(ProductDAO productDAO){
		this.productDAO = productDAO;
	}
	
	public List<Product> getProducts(ProductFilter filter, List<Item> itemList){
		return productDAO.getProducts(filter, itemList);
	}
	
	public List<Brand> getBrands(){
		return productDAO.getBrands();
	}
	
	public String addDocument(Document doc){
		return productDAO.addDocument(doc);
	}
	
	public String editDocument(Document doc){
		return productDAO.editDocument(doc);
	}
}
