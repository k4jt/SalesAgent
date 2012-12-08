package ua.krem.agent.model;

import java.io.Serializable;

public class Document implements Serializable{

	private Integer id;
	
	private Integer userId;

	private Integer shopId;
	
	private Integer docType;
	
	public String[] prodId;
	
	public String[] amount;

	public String[] getAmount() {
		return amount;
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
	
}
