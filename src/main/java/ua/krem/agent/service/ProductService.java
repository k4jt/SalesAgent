package ua.krem.agent.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.ProductDAO;
import ua.krem.agent.model.Brand;
import ua.krem.agent.model.Document;
import ua.krem.agent.model.Filter;
import ua.krem.agent.model.Product;

@Service
public class ProductService {

	private ProductDAO productDAO;
	
	@Inject
	public ProductService(ProductDAO productDAO){
		this.productDAO = productDAO;
	}
	
	public List<Product> getProducts(Filter filter){
		return productDAO.getProducts(filter);
	}
	
	public List<Brand> getBrands(){
		return productDAO.getBrands();
	}
	
	public void addDocument(Document doc){
		productDAO.addDocument(doc);
	}
	
}
