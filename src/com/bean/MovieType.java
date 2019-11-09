package com.bean;

import java.io.Serializable;

/**影片信息实体类
 * @author jaha
 *
 */
public class MovieType implements Serializable{
		
	private Integer id;
		
	private String name;
		
	
	public MovieType() {
		
	}

	public MovieType(Integer id, String type) {
		this.id = id;
		this.name = type;
	}

	@Override
	public String toString() {
		return "MovieType [id=" + id + ", name=" + name + "]";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}






















