package com.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Movie;
import com.bean.Room;
import com.bean.Schedule;
import com.dao.ScheduleMapper;
import com.service.ScheduleService;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleMapper mapper;
	
	@Override
	public void add(Schedule s) {
		mapper.add(s);
	}

	@Override
	public void update(Schedule s) {
		mapper.update(s);
	}

	@Override
	public void delete(Schedule s) {
		mapper.delete(s);
	}

	@Override
	public List<Schedule> select(Map<String, Object> map) {
		return mapper.select(map);
	}

	@Override
	public int count(Map<String,Object> map) {
		return mapper.count(map);
	}

	@Override
	public List<Room> selectRoom() {
		return mapper.selectRoom();
	}

	@Override
	public List<Movie> selectMovie() {
		return mapper.selectMovie();
	}

	@Override
	public void updateRoom(Room room) {
		mapper.updateRoom(room);
	}

}
