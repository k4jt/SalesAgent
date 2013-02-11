package ua.krem.agent.dao;

import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import ua.krem.agent.model.DocHead;
import ua.krem.agent.model.DocHeadFilter;
import ua.krem.agent.model.DocList;
import ua.krem.agent.model.Document;
import ua.krem.agent.model.Item;
import org.apache.commons.net.ftp.FTPClient;
import java.io.FileInputStream;

@Repository
public class DocumentDAO {

	private JdbcTemplate jdbcTemplate;
	private ProductDAO productDAO;
	
	@Inject
	public DocumentDAO(JdbcTemplate jdbcTemplate, ProductDAO productDAO){
		this.jdbcTemplate = jdbcTemplate;
		this.productDAO = productDAO;
	}
	
	public List<DocHead> selectDoc(DocHeadFilter filter, int Code, String docGlobalDate){
		List<DocHead> docList = new ArrayList<DocHead>();
		if(filter == null){
			String sql = "SELECT doc_id id, date, add1, add2, type, status FROM doc ORDER BY id"; //limit
			if(Code==1)
			{
			  sql = "SELECT doc_id id, date, add1, add2, type, status FROM doc WHERE doc.status <> \"Передан\" ORDER BY id"; //limit
			}
			try{
				List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql);
				for(Map<String, Object> map : mapList){
					docList.add(extractDocHead(map));
				}
			}catch(EmptyResultDataAccessException e){
				e.printStackTrace();
			}
		} else {
			System.out.println("filter.userId = " + filter.getUserId());
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT doc_id id, date, add1, add2, type, status FROM doc ");
			if(filter.getUserId() != null){
				sql.append(" WHERE user_id = ").append(filter.getUserId());
			}
			
			if(filter.getAdd1() != null && !filter.getAdd1().isEmpty()){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND ");
				} else {
					sql.append(" WHERE ");
				}
				sql.append(" add1 LIKE '%").append(filter.getAdd1()).append("%' ");
			}

			if(filter.getAdd2() != null && !filter.getAdd2().isEmpty()){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND ");
				} else {
					sql.append(" WHERE ");
				}
				sql.append(" add2 LIKE '%").append(filter.getAdd2()).append("%' ");
			}

			if(filter.getDocType() != null){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND ");
				} else {
					sql.append(" WHERE ");
				}
				sql.append(" type = ").append(filter.getDocType());
			}

			if(filter.getFrom() != null && filter.getTo() != null && !filter.getFrom().isEmpty() && !filter.getTo().isEmpty()){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND ");
				} else {
					sql.append(" WHERE ");
				}
				sql.append(" date BETWEEN '").append(filter.getFrom()).append("' AND '").append(filter.getTo()).append("' ");
			}
			else 
			{
				if (filter.getFrom()!=null && !filter.getFrom().isEmpty())
				{
					if(sql.indexOf("WHERE") != -1){
						sql.append(" AND ");
					} else {
						sql.append(" WHERE ");
					}
					sql.append(" date > '").append(filter.getFrom()).append("' ");
				}
				else
				{
					if (filter.getTo()!=null && !filter.getTo().isEmpty())
					{
						if(sql.indexOf("WHERE") != -1){
							sql.append(" AND ");
						} else {
							sql.append(" WHERE ");
						}
						sql.append(" date < '").append(filter.getTo()).append("' ");
					}
				}
				

			}
			
			//if user comes without session
			if(sql.indexOf("WHERE") != -1 && sql.indexOf("=") == -1){
				sql = new StringBuilder(sql.substring(0, sql.indexOf("WHERE")));
			}
			
			if(sql.indexOf("date >") == -1 && sql.indexOf("date <") == -1 && sql.indexOf("BETWEEN") == -1){
				if(sql.indexOf("WHERE") != -1){
					sql.append(" AND YEAR(date) = YEAR('"+docGlobalDate+"') AND MONTH(date) = MONTH('"+docGlobalDate+"') AND DAY(date) = DAY('"+docGlobalDate+"')");
				} else {
					sql.append(" WHERE YEAR(date) = YEAR('"+docGlobalDate+"') AND MONTH(date) = MONTH('"+docGlobalDate+"') AND DAY(date) = DAY('"+ docGlobalDate+ "')");
				}
			}
			if(sql.indexOf("WHERE") != -1)
			{
				if(Code == 1)
				sql.append("AND doc.status <> \"Передан\"");
			}
			else 
			{
				if(Code == 1)
				sql.append("WHERE doc.status <> \"Передан\"");
			}
			sql.append(" ORDER BY id"); //limit
			System.out.println(sql.toString());
			try{
				List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql.toString());
				for(Map<String, Object> map : mapList){
					docList.add(extractDocHead(map));
				}
			}catch(EmptyResultDataAccessException e){
				e.printStackTrace();
			}
			
			
		}
		
		return docList;
	}
	
	private DocHead extractDocHead(Map<String, Object> map) {
		DocHead docHead = new DocHead();
		if(map != null && !map.isEmpty()){
			docHead.setId((Integer)map.get("id"));
			docHead.setDate((Date)map.get("date"));
			docHead.setAdd1((String)map.get("add1"));
			docHead.setAdd2((String)map.get("add2"));
			docHead.setStatus((String)map.get("status"));
			if((Integer)map.get("type") == 1){
				docHead.setType("Возврат");
			} else {
				docHead.setType("Реализация");
			}
		}
		return docHead;
	}
	
	public Document getDocumentById(Integer docId){
		String sql = "SELECT shop_id, type FROM doc WHERE doc_id = ?";
		Document doc = new Document();
		doc.setId(docId);
		try{
			Map<String, Object> map = jdbcTemplate.queryForMap(sql, docId);
			if(map != null && !map.isEmpty()){
				doc.setShopId((Integer)map.get("shop_id"));
				doc.setDocType((Integer)map.get("type"));
				
				sql = "SELECT prod_id, amount FROM doc_element WHERE doc_id = ?";
				List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql.toString(), docId);
				List<Item> itemList = new ArrayList<Item>();
				for(Map<String, Object> m : mapList){
					if(m.get("amount") != null && !((Integer)m.get("amount")).toString().isEmpty()){
						Item item = new Item();
						item.id = (Integer)m.get("prod_id");
						item.amount = (Integer)m.get("amount");
						itemList.add(item);
					}
				}
				doc.setItemList(itemList);
				doc.setProductList( productDAO.getProducts(null, itemList) );
				
			}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
		}
		
		return doc;
	}

	public String exportDocuments(DocList docs, String uid, String path) {
		String result = "Документы успешно экспортированы";
		String sql = "select CONCAT_WS(\"; \", X.doc_id, X.date, X.type, X.type1, X.shop_id, Y.code, Y.name, P.integration_id, P.code, P.name, Z.amount) AS Col from doc X, shop Y, doc_element Z, product P WHERE  X.shop_id = Y.shop_id AND Z.doc_id = X.doc_id AND Z.prod_id = P.prod_id AND X.doc_id = ?"; 
		String upd = "UPDATE doc SET status=\"Передан\" WHERE doc_id=?";
		int[] id = docs.getDocId();
		int[] flag = docs.getChecked();	
		if(flag.length==0) return "Ошибка экспорта: ничего не было выбрано!"; 
		try{
			SimpleDateFormat SDF = new SimpleDateFormat("ddMMyy-hhmmss");
			String filename = SDF.format( new Date() )+ "-" + uid +"_expdoc.csv";
			path=path + filename;
			FileWriter rfile = new FileWriter(path);
			rfile.write("Doc_ID; Date; Doc_Type; Doc_Type1; Shop_ID; Shop_Code; Shop_Name; Prod_INC; Prod_Code; Prod_Name; Prod_Amount \n");
			for(int i=0; i<flag.length;i++)
			{
				List<Map<String, Object>> mapList = jdbcTemplate.queryForList(sql.toString(), id[i]);
				jdbcTemplate.update(upd.toString(),id[i]);
				for(Map<String, Object> el : mapList)
				{
					rfile.write(el.get("Col").toString());
					rfile.write("\n");
				}
			}
			System.out.println(path);
			rfile.close(); //Список документов
			
            FTPClient client = new FTPClient();
		    FileInputStream fis = null;

		    client.connect("kremen.ftp.ukraine.com.ua");
		    client.login("kremen_ftp", "Fred1969");

		    fis = new FileInputStream(path);
		    client.storeFile(filename, fis);
		    client.logout();
		    fis.close();
		}
		catch(EmptyResultDataAccessException e){
			e.printStackTrace();
			return "Ошибка экспорта";
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return "Ошибка экcпорта";
		}
		return result;
	}
	
}
