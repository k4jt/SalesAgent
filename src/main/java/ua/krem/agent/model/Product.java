package ua.krem.agent.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Product implements Serializable{
	private Integer id;
	private String name;
	private String group;
	private String subgroup;
	private String brand;
	private String code;
	
	public Product(){}
	public Product(String name, String code, String group, String subgroup){
		this.name = name;
		this.code = code;
		this.group = group;
		this.subgroup = subgroup;
	}
	
	public String getSubgroup() {
		return subgroup;
	}
	public void setSubgroup(String subgroup) {
		this.subgroup = subgroup;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String toString(){
		return "Code: " + code + ", Name: " + name + ", Group: " + group;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
}
