package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.LanguageType;

public interface LanguageTypeMapper {

	/** ��ѯ���� */
	List<LanguageType> select(Map<String, Object> map);

	/** ��ѯ�������� */
	LanguageType unique(LanguageType lt);
	
	/** ��ѯ�������� */
	int count(Map<String, Object> map);
	
	
}
