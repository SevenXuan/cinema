package com.dao;

import java.util.List;
import java.util.Map;

import com.bean.SellTicket;

/**��Ʊ���ݲ�ӿ�
 * @author doris1175
 *
 */
public interface SellTicketMapper {

	/** ������Ʊ��¼*/
	void add(SellTicket sti);
	/** �޸���Ʊ��¼*/
	void update(SellTicket sti);
	/** ɾ����Ʊ��¼*/
	void delete(int id);
	/**��ѯ��Ʊ��¼*/
	List<SellTicket> select(Map<String,Object> map);
	/**��ѯ����Ʊ��¼��*/
	List<SellTicket> count(Map<String,Object> map);
}
