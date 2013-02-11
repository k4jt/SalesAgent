package ua.krem.agent.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import ua.krem.agent.model.Shop;
import ua.krem.agent.model.ShopFilter;

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

	public Shop getShopById(Integer id){
		String sql = "SELECT shop_id id, name, address, code FROM shop WHERE shop_id = ?";
		Shop shop = new Shop();
		try{
			Map<String, Object> map = jdbcTemplate.queryForMap(sql, id);
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
	
	public List<Shop> filterShop(ShopFilter filter){
		List<Shop> shopList = new ArrayList<Shop>();
		if(filter == null){
			String sql = "SELECT shop_id id, name, address, code FROM shop ORDER BY id"; //limit
			try{
				List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql);
				for(Map<String, Object> map : mapList){
					shopList.add(extractShop(map));
				}
			}catch(EmptyResultDataAccessException e){
				e.printStackTrace();
			}
		} else {
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT shop_id id, name, address, code FROM shop ");
			if(filter.getCode() != null && !filter.getCode().isEmpty()){
				sql.append(" WHERE code LIKE '%").append(filter.getCode()).append("%' ");
			}
			
			if(filter.getName() != null && !filter.getName().isEmpty()){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND ");
				} else {
					sql.append(" WHERE ");
				}
				sql.append(" name LIKE '%").append(filter.getName()).append("%' ");
			}

			if(filter.getAddress() != null && !filter.getAddress().isEmpty()){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND ");
				} else {
					sql.append(" WHERE ");
				}
				sql.append(" address LIKE '%").append(filter.getAddress()).append("%' ");
			}
			
			if(sql.indexOf("WHERE") != -1 && sql.indexOf("LIKE") == -1){
				sql = new StringBuilder(sql.substring(0, sql.indexOf("WHERE")));
			}
			
			sql.append("ORDER BY id");//limit
			System.out.println(sql.toString());
			try{
				List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql.toString());
				for(Map<String, Object> map : mapList){
					shopList.add(extractShop(map));
				}
			}catch(EmptyResultDataAccessException e){
				e.printStackTrace();
			}
			
		}
		
		return shopList;
		
	}

	private Shop extractShop(Map<String, Object> map) {
		Shop shop = new Shop();
		if(map != null && !map.isEmpty()){
			shop.setId((Integer)map.get("id"));
			shop.setName((String)map.get("name"));
			shop.setAddress((String)map.get("address"));
			shop.setCode((String)map.get("code"));
		}
		return shop;
	}
}
