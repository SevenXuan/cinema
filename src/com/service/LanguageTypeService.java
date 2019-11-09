package com.service;

import java.util.List;
import java.util.Map;

import com.bean.LanguageType;
import com.bean.Movie;

public interface LanguageTypeService {
	
	/** ��ѯ���� */
	List<LanguageType> select(Map<String, Object> map);

	/** ��ѯ�������� */
	LanguageType unique(LanguageType lt);
	
	/** ��ѯ�������� */
	int count(Map<String, Object> map);

	
}
