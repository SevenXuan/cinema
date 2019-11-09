package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.MovieType;

public interface MovieTypeMapper {

	/** 查询影片信息 */
	List<MovieType> select(Map<String, Object> map);

	/** 查询单个影片信息 */
	MovieType unique(MovieType mt);
	
	/** 查询所有影片信息个数 */
	int count(Map<String, Object> map);
	
	
}
