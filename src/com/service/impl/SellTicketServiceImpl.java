package com.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.SellTicket;
import com.dao.SellTicketMapper;
import com.service.SellTicketService;

@Service
public class SellTicketServiceImpl implements SellTicketService {
	
	@Autowired
	private SellTicketMapper mapper;
	
	@Override
	public void add(SellTicket sti) {
		mapper.add(sti);
	}

	@Override
	public void update(SellTicket sti) {
		mapper.update(sti);
	}

	@Override
	public void delete(int id) {
		mapper.delete(id);
	}

	@Override
	public List<SellTicket> select(Map<String, Object> map) {
		return mapper.select(map);
	}

	@Override
	public List<SellTicket> count(Map<String, Object> map) {
		return mapper.count(map);
	}


}
