package com.service;

import java.util.List;
import java.util.Map;

import com.bean.SellTicket;

public interface SellTicketService {

	/** 新增售票记录*/
	void add(SellTicket sti);
	/** 修改售票记录*/
	void update(SellTicket sti);
	/** 删除售票记录*/
	void delete(int id);
	/**查询售票记录*/
	List<SellTicket> select(Map<String,Object> map);
	/**查询总售票记录数*/
	List<SellTicket> count(Map<String,Object> map);
	
}
