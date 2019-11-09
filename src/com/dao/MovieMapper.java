package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.Movie;

public interface MovieMapper {

	/** ����ӰƬ */
	void add(Movie m);

	/** �޸�ӰƬ��Ϣ */
	void update(Movie m);

	/** ��ѯӰƬ */
	List<Movie> select(Map<String, Object> map);

	/** ��ѯ����ӰƬ���� */
	Movie unique(Movie m);
	
	/** ��ѯ����ӰƬ */
	int count(Map<String, Object> map);
	
	
}
