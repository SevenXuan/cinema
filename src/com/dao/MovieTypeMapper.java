package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.MovieType;

public interface MovieTypeMapper {

	/** ��ѯӰƬ��Ϣ */
	List<MovieType> select(Map<String, Object> map);

	/** ��ѯ����ӰƬ��Ϣ */
	MovieType unique(MovieType mt);
	
	/** ��ѯ����ӰƬ��Ϣ���� */
	int count(Map<String, Object> map);
	
	
}
