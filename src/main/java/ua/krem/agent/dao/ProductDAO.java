package ua.krem.agent.dao;

import java.util.Map;
import java.util.List;
import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import ua.krem.agent.model.Product;

@Repository
public class ProductDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Inject
	public ProductDAO(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<Product> getProducts(){
		String sql = "SELECT x.name AS PName, x.code PCode, y.name GName, z.name SGName, q.name BName FROM product_group y,";
			   sql += "counteragent q, product x LEFT OUTER JOIN  product_sub_group z ON x.sub_group_id=z.sub_group_id WHERE x.group_id= y.group_id And x.brand_id=q.counteragent_id";
		List<Product> ProductList = new ArrayList<Product>();
		try{
			List <Map<String, Object>> list = jdbcTemplate.queryForList(sql);
			if(list != null && !list.isEmpty()){
				for(int i=0;i<list.size(); i++)
				{
					Map<String, Object> elem = list.get(i);
					Product Item = new Product();
					Item.setName((String) elem.get("PName"));
					Item.setCode((String) elem.get("PCode"));
					Item.setGroup((String) elem.get("GName"));
					Item.setSubgroup((String) elem.get("SGName"));
					Item.setBrand((String) elem.get("BName"));
					ProductList.add(Item);
				}	
			}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
		}
		if(ProductList.isEmpty()) 
			{
				return null;
			}
		else 
			{
				return ProductList;
			}
	}
}
