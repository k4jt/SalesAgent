package ua.krem.agent.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Code implements Serializable{
	
	private String code;

	public String getCode() {
		if(code.indexOf(" ")!=-1){
			code = code.substring(0, code.indexOf(" ")).trim();
		}
		System.out.println("code: " + code);
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
