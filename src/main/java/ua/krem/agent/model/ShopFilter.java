package ua.krem.agent.model;

import java.io.Serializable;
@SuppressWarnings("serial")
public class ShopFilter implements Serializable{
	private String code;
	private String name;
	private String address;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	

}
