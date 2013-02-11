package ua.krem.agent.model;

import java.io.Serializable;
import java.util.List;
@SuppressWarnings("serial")
public class Document implements Serializable{

	private Integer id;
	
	private Integer userId;

	private Integer shopId;
	
	private Integer docType;
	
	private Integer docType1;

	public String[] prodId;
	
	public String[] amount;
	
	private List<Product> productList;

	private List<Item> itemList;

	public String[] getAmount() {
		return amount;
	}

	public Integer getDocType1() {
		return docType1;
	}

	public void setDocType1(Integer docType1) {
		this.docType1 = docType1;
	}
	
	public void setAmount(String[] amount) {
		this.amount = amount;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public String[] getProdId() {
		return prodId;
	}

	public void setProdId(String[] prodId) {
		this.prodId = prodId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDocType() {
		return docType;
	}

	public void setDocType(Integer docType) {
		this.docType = docType;
	}

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}

	public List<Item> getItemList() {
		return itemList;
	}

	public void setItemList(List<Item> itemList) {
		this.itemList = itemList;
	}
	
}
