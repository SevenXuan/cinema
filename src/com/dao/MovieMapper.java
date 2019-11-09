package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.Movie;

public interface MovieMapper {

	/** 新增影片 */
	void add(Movie m);

	/** 修改影片信息 */
	void update(Movie m);

	/** 查询影片 */
	List<Movie> select(Map<String, Object> map);

	/** 查询单个影片详情 */
	Movie unique(Movie m);
	
	/** 查询所有影片 */
	int count(Map<String, Object> map);
	
	
}
