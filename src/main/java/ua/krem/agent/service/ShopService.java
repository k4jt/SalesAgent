package ua.krem.agent.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.ShopDAO;
import ua.krem.agent.model.Shop;
import ua.krem.agent.model.ShopFilter;
@Service
public class ShopService {

	private ShopDAO shopDAO;
	
	@Inject
	public ShopService(ShopDAO shopDAO){
		this.shopDAO = shopDAO;
	}
	
	public Shop getShopByCode(String code){
		return shopDAO.getShopByCode(code);
	}
	
	public List<Shop> filterShop(ShopFilter filter){
		return shopDAO.filterShop(filter); 
	}
}
