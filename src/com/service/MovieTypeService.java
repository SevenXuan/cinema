package com.service;

import java.util.List;
import java.util.Map;

import com.bean.Movie;
import com.bean.MovieType;

public interface MovieTypeService {

	/** ��ѯӰƬ��Ϣ */
	List<MovieType> select(Map<String, Object> map);

	/** ��ѯ����ӰƬ��Ϣ */
	MovieType unique(MovieType mt);
	
	/** ��ѯ����ӰƬ��Ϣ���� */
	int count(Map<String, Object> map);
	

}
