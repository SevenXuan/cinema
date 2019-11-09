package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.LanguageType;

public interface LanguageTypeMapper {

	/** 查询语种 */
	List<LanguageType> select(Map<String, Object> map);

	/** 查询单个语种 */
	LanguageType unique(LanguageType lt);
	
	/** 查询所有语种 */
	int count(Map<String, Object> map);
	
	
}
