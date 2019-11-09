package com.service;

import java.util.List;
import java.util.Map;

import com.bean.LanguageType;
import com.bean.Movie;

public interface LanguageTypeService {
	
	/** 查询语种 */
	List<LanguageType> select(Map<String, Object> map);

	/** 查询单个语种 */
	LanguageType unique(LanguageType lt);
	
	/** 查询所有语种 */
	int count(Map<String, Object> map);

	
}
