package com.service;

import java.util.List;
import java.util.Map;

import com.bean.Movie;
import com.bean.Room;
import com.bean.Schedule;

public interface ScheduleService {

	/** 新增排片记录*/
	void add(Schedule s);
	/** 修改排片记录*/
	void update(Schedule s);
	/** 删除排片记录*/
	void delete(Schedule s);
	/**查询排片记录*/
	List<Schedule> select(Map<String,Object> map);
	/**查询排片记录数*/
	int count(Map<String,Object> map);
	
	/**查询所有影厅*/
	List<Room> selectRoom();
	
	/**修改影厅信息*/
	void updateRoom(Room room);
	
	/**查询所有影片*/
	List<Movie> selectMovie();
}
