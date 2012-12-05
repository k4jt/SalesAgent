package ua.krem.agent.dao;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import ua.krem.agent.model.Shop;

@Repository
public class ShopDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Inject
	public ShopDAO(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate = jdbcTemplate;
	}

	public Shop getShopByCode(String code){
		String sql = "SELECT shop_id id, name, address, code FROM shop WHERE code = ?";
		Shop shop = new Shop();
		try{
			Map<String, Object> map = jdbcTemplate.queryForMap(sql, code);
			if(map != null && !map.isEmpty()){
				shop.setId((Integer)map.get("id"));
				shop.setName((String)map.get("name"));
				shop.setAddress((String)map.get("address"));
				shop.setCode((String)map.get("code"));
			}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
		}
		return shop;
	}
}
