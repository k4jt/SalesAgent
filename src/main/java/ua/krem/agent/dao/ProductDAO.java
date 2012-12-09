package ua.krem.agent.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import ua.krem.agent.model.Brand;
import ua.krem.agent.model.Document;
import ua.krem.agent.model.Item;
import ua.krem.agent.model.Product;
import ua.krem.agent.model.ProductFilter;

@Repository
public class ProductDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Inject
	public ProductDAO(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<Product> getProducts(ProductFilter filter, List<Item> itemListOriginal){
		boolean cutTail = filter == null && itemListOriginal != null;
		List<Item> itemList = null;
		if(itemListOriginal != null){
			System.out.println("all ids");
			itemList = new ArrayList<Item>();
			for(Item i : itemListOriginal){
				System.out.println(i.id + ":" + i.amount);
				itemList.add(i);
			}
		}
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT x.prod_id id, x.name AS PName, x.code PCode, y.name GName, z.name SGName, q.name BName ");
		sql.append("FROM product_group y, counteragent q, product x ");
		sql.append("LEFT OUTER JOIN  product_sub_group z ON x.sub_group_id=z.sub_group_id ");
		sql.append("WHERE x.group_id= y.group_id And x.brand_id=q.counteragent_id ");
		if(filter != null){
			if(filter.getProdName() != null && !filter.getProdName().trim().isEmpty()){
				sql.append(" AND x.name LIKE '%").append(filter.getProdName()).append("%' ");
				System.out.println("prodName: " + filter.getProdName());
			}
			if(filter.getBrand() != null && !filter.getBrand().trim().isEmpty()){
				sql.append(" AND q.counteragent_id = ").append(filter.getBrand());
			}
		}
		System.out.println(sql.toString());
		List<Product> productList = new ArrayList<Product>();
		List<Product> result = new ArrayList<Product>();
	
	if(!cutTail){
			
		
		try{
			List <Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString());
			if(list != null && !list.isEmpty()){
	qwerty: 	for(int i=0; i<list.size(); i++)
				{
					Map<String, Object> elem = list.get(i);
					Product item = new Product();
					item.setId((Integer) elem.get("id"));
					item.setName((String) elem.get("PName"));
					item.setCode((String) elem.get("PCode"));
					item.setGroup((String) elem.get("GName"));
					item.setSubgroup((String) elem.get("SGName"));
					item.setBrand((String) elem.get("BName"));
					if(itemList != null && !itemList.isEmpty()){
						for(int j = 0; j < itemList.size(); ++j){
							if(itemList.get(j).id == item.getId()){
								continue qwerty;
							}
						}
					}
					
					productList.add(item);
				}	
			}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
		}
	}	
		if(itemList != null && !itemList.isEmpty()){
			StringBuilder buildId = new StringBuilder();
			for(Item i : itemList){
				buildId.append(i.id).append(", ");
			}
			String ids = buildId.substring(0, buildId.length() - 2);
			System.out.println("ids: " + ids);
			String select = "SELECT x.prod_id id, x.name AS PName FROM product x WHERE x.prod_id IN (" + ids + ")";
			System.out.println(select);
			try{
				List <Map<String, Object>> list = jdbcTemplate.queryForList(select);
				if(list != null && !list.isEmpty()){
					System.out.println("list.size = " + list.size());
					for(int i=0; i<list.size(); i++)
					{
						Map<String, Object> elem = list.get(i);
						Product item = new Product();
						item.setId((Integer) elem.get("id"));
						item.setName((String) elem.get("PName"));
						System.out.println(item.getId() + ":" + item.getName());
						if(itemList != null && !itemList.isEmpty()){
							for(int j = 0; j < itemList.size(); ++j){
								if(itemList.get(j).id == item.getId()){
									item.setAmount(itemList.get(j).amount);
									System.out.println("$remove " + itemList.get(j).id);
									itemList.remove(j);
									break;
								}
							}
						}
						
						result.add(item);
						System.out.println("productList.add({" + item.getId() + ":" + item.getAmount() + "})");
					}	
				}
			}catch(EmptyResultDataAccessException e){
				e.printStackTrace();
			}
		}
		result.addAll(productList);
		return result;
	}

	public List<Brand> getBrands(){
		String sql = "SELECT counteragent_id id, name FROM counteragent WHERE brand_flag = 1";
		List<Brand> brandList = new ArrayList<Brand>();
		try{
			List <Map<String, Object>> list = jdbcTemplate.queryForList(sql);
			if(list != null && !list.isEmpty()){
				for(int i=0; i<list.size(); i++)
				{
					Map<String, Object> elem = list.get(i);
					Brand item = new Brand();
					item.setId((Integer) elem.get("id"));
					item.setName((String) elem.get("name"));
					brandList.add(item);
				}	
			}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
		}
		return brandList;
	}
	
	public String editDocument(Document doc){
		String result = null;
		
		String sql = "SELECT doc_element_id, prod_id, amount FROM doc_element WHERE doc_id = ?";
		List<Integer> toDelete = new ArrayList<Integer>();
		List<Integer> exist = new ArrayList<Integer>();
		List<Item> toInsert = new ArrayList<Item>();
		try{
			List <Map<String, Object>> currentlist = jdbcTemplate.queryForList(sql, doc.getId());
			if(currentlist != null && !currentlist.isEmpty()){
				for(Map<String, Object> map : currentlist)	{
					Integer prodId = (Integer)map.get("prod_id");
					Integer amount = (Integer)map.get("amount");
					Integer elemId = (Integer)map.get("doc_element_id");
					Item item = new Item();
					item.amount = amount;
					System.out.println("prodId = " + prodId);
					item.id = prodId;
					System.out.println("item.id = " + item.id);
					boolean find = false;
					for(int i = 0; i < doc.getProdId().length; ++i){
						Integer curProdId = null;
						try{
							curProdId = Integer.parseInt(doc.getProdId()[i]);
						}catch(NumberFormatException e){
							e.printStackTrace();
						}
						if(curProdId == prodId){
							find = true;
							Integer curAmount = null;
							try{
								if(doc != null && doc.getAmount() != null && doc.getAmount()[i] != null){
									curAmount = Integer.parseInt(doc.getAmount()[i]);
								}
							}catch(NumberFormatException e){
								e.printStackTrace();
							}catch(Exception eq){
								eq.printStackTrace();
							}
							
							if(curAmount != amount){
								toDelete.add(elemId);
								if(curAmount != null && curAmount !=0 ){
									item.amount = curAmount;
									toInsert.add(item);
								}
							}else{
								exist.add(prodId);
							}
							break;
						}
					}
					if(!find){
						toDelete.add(elemId);
					}
					
				}
			}
			
			
			
			
			for(int i = 0; i < doc.getAmount().length; ++i){
				boolean find = false;
				try{
					Integer curProdId = Integer.parseInt(doc.getProdId()[i]);
					for(Integer alreadyExistProdId : exist){
						if(alreadyExistProdId == curProdId){
							find = true;
							break;
						}
					}
					
					if(!find){
						if(doc.getAmount()[i] != null && !doc.getAmount()[i].equals("0") && !doc.getAmount()[i].isEmpty()){
							try{
								Item item = new Item();
								item.amount = Integer.parseInt( doc.getAmount()[i]);
								item.id = curProdId;
								toInsert.add(item);
							}catch(NumberFormatException e){
								e.printStackTrace();
							}
						}
					}
				}catch(NumberFormatException e){
					e.printStackTrace();
				}
				
				
			}
			
			
			sql = "DELETE FROM doc_element WHERE doc_element_id = ?";
			for(Integer elem_id : toDelete){
				jdbcTemplate.update(sql, elem_id);
			}
			
			sql = "INSERT INTO doc_element (amount, doc_id, prod_id) VALUES (?, ?, ?)";
			for(Item item : toInsert){
				jdbcTemplate.update(sql, item.amount, doc.getId(), item.id);
			}
			
			result = "Сохранение прошло успешно";
			
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
			result = "Ощибка";
		}
		
		return result;
	}
	
	public String addDocument(Document doc){
		String result = "";
		String sql = "INSERT INTO doc (date, warehouse_id, shop_id, user_id, type) VALUES (NOW(), ?, ?, ?, ?)";
		try{
			if(jdbcTemplate.update(sql, 1, doc.getShopId(), doc.getUserId(), doc.getDocType()) != 0){
				
				sql = "SELECT max(doc_id) id FROM doc";
				doc.setId((Integer) jdbcTemplate.queryForInt(sql));
				
				sql = "INSERT INTO doc_element (amount, doc_id, prod_id) VALUES (?, ?, ?)";
				for(int i = 0; i < doc.getAmount().length; ++i){
					if(doc.getAmount()[i] != null && !doc.getAmount()[i].isEmpty()){
						try{
							if(Integer.parseInt(doc.getAmount()[i]) != 0){
								jdbcTemplate.update(sql, doc.getAmount()[i], doc.getId(), doc.getProdId()[i]);
							}
						}catch(NumberFormatException e){
							e.printStackTrace();
							result = "Ошибка при сохранении";
						}
					}
				}
				
				sql = "SELECT add1 FROM doc WHERE doc_id = ?";
				String add1 = jdbcTemplate.queryForObject(sql, String.class, doc.getId());
				result = "Документ #" + add1 + "# c id=" + doc.getId() + " успешно сохранен!";
			}
			
		}catch(DataAccessException e){
			e.printStackTrace();
			result = "Ошибка при сохранении";
		}
		return result;
	}
}
