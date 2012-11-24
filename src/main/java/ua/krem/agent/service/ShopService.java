package ua.krem.agent.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.ShopDAO;
import ua.krem.agent.model.Shop;
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
}
