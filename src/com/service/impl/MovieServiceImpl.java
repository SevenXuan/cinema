package com.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Movie;
import com.dao.MovieMapper;
import com.service.MovieService;

@Service
public class MovieServiceImpl implements MovieService {

	@Autowired
	private MovieMapper mapper;
	
	@Override
	public void add(Movie m) {
		mapper.add(m);
	}

	@Override
	public void update(Movie m) {
		mapper.update(m);
	}

	@Override
	public List<Movie> select(Map<String, Object> map) {
		return mapper.select(map);
	}

	@Override
	public int count(Map<String,Object> map) {
		return mapper.count(map);
	}

	@Override
	public Movie unique(Movie m) {
		return mapper.unique(m);
	}

}
