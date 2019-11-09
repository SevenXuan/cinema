package com.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Movie;
import com.bean.MovieType;
import com.dao.MovieTypeMapper;
import com.service.MovieTypeService;

@Service
public class MovieTypeServiceImpl implements MovieTypeService {

	@Autowired
	private MovieTypeMapper mapper;

	@Override
	public List<MovieType> select(Map<String, Object> map) {
		return mapper.select(map);
	}

	@Override
	public MovieType unique(MovieType mt) {
		return mapper.unique(mt);
	}

	@Override
	public int count(Map<String, Object> map) {
		return mapper.count(map);
	}
	
	
}
