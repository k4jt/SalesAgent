package ua.krem.agent.model;

import java.io.Serializable;
@SuppressWarnings("serial")
public class Filter implements Serializable{
	
	private String prodName;

	private String brand;

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}


}
