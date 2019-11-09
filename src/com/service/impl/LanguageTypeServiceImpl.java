package com.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.LanguageType;
import com.dao.LanguageTypeMapper;
import com.service.LanguageTypeService;

@Service
public class LanguageTypeServiceImpl implements LanguageTypeService {

	@Autowired
	private LanguageTypeMapper mapper;

	@Override
	public List<LanguageType> select(Map<String, Object> map) {
		return mapper.select(map);
	}

	@Override
	public LanguageType unique(LanguageType lt) {
		return mapper.unique(lt);
	}

	@Override
	public int count(Map<String, Object> map) {
		return mapper.count(map);
	}

	
	
}
