package com.bean;

import java.io.Serializable;

/**语种实体类
 * @author jaha
 *
 */
public class LanguageType implements Serializable{
	
	private Integer id;
	
	private String type;
	
	
	public LanguageType() {
		super();
	}

	public LanguageType(Integer id, String type) {
		super();
		this.id = id;
		this.type = type;
	}

	@Override
	public String toString() {
		return "LanguageType [id=" + id + ", type=" + type + "]";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
	
	
}
