package ua.krem.agent.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Shop implements Serializable{
	private Integer id;
	private String name;
	private String address;
	private String code;
	
	public Shop(){}
	public Shop(String name, String address, String code){
		this.name = name;
		this.address = address;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String toString(){
		return  code + " " + name + " " + address;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
}
