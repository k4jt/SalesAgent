package ua.krem.agent.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class User implements Serializable{
	private Integer id;
	
	private String login;
	
	private String pass;

	public User(){
		login = "";
		pass = "";
	}
	
	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
}
