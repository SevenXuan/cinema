package com.service;

import java.util.List;
import java.util.Map;

import com.bean.Movie;
import com.bean.Room;
import com.bean.Schedule;

public interface ScheduleService {

	/** ������Ƭ��¼*/
	void add(Schedule s);
	/** �޸���Ƭ��¼*/
	void update(Schedule s);
	/** ɾ����Ƭ��¼*/
	void delete(Schedule s);
	/**��ѯ��Ƭ��¼*/
	List<Schedule> select(Map<String,Object> map);
	/**��ѯ��Ƭ��¼��*/
	int count(Map<String,Object> map);
	
	/**��ѯ����Ӱ��*/
	List<Room> selectRoom();
	
	/**�޸�Ӱ����Ϣ*/
	void updateRoom(Room room);
	
	/**��ѯ����ӰƬ*/
	List<Movie> selectMovie();
}