package com.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.Movie;
import com.bean.Room;
import com.bean.Schedule;
import com.service.ScheduleService;
import com.util.PageAssistant;

@Controller
@RequestMapping("schedule")
public class ScheduleAction {

	@Resource
	private ScheduleService scheduleService;
	
	/**查询单个影厅的所有排片信息
	 * @param rid
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("queryRoomSchedule")
	public String queryRoomSchedule(String rid,	PageAssistant<Schedule> pa, HttpSession session) {
		
		Map<String,Object> map = new HashMap<>();
		
		//保存对应影厅编号
		if (rid != null && rid != "") {
			map.put("rid", rid);
			session.setAttribute("rid", rid);
		}
		//只查上映的影片
		map.put("condition", 1);
		
		//设置总记录数
		pa.setCount(scheduleService.count(map));
		
		map.put("size",pa.getPageSize());
		map.put("start", pa.getStart());  
		
		//查询所有排片并保持到pa的属性中
		List<Schedule> list = scheduleService.select(map);
		pa.setItems(list);
		
		//查询所有影厅
		session.setAttribute("room", scheduleService.selectRoom());
		//查询所有上映影片
		session.setAttribute("movie", scheduleService.selectMovie());
		
		//保持页面助手对象到作用域
		session.setAttribute("pa", pa);
		
		return "redirect:/addFilmOnShow.jsp";
		
	}
	
	/**查询所有排片
	 * @return
	 */
	@RequestMapping("query")
	public String query(String name, String rid, String from, String condition, 
			PageAssistant<Schedule> pa, HttpSession session) {
		
		//判断from，等于1说明来自选票连接，只能显示上映影片
		if (from != null && from.equals("1")) {
			condition = "1";
		}
		
		Map<String,Object> map = new HashMap<>();
		
		//添加查询条件,关键字和影厅,并保持到作用域
		if (name != null && name != "") {
			map.put("keyword", name);
			session.setAttribute("keyword", name);
		}
		if (rid != null && rid != "") {
			map.put("rid", rid);
			session.setAttribute("rid", rid);
		}
		if(condition != null && condition != "") {
			map.put("condition", condition);
			session.setAttribute("condition", condition);
		}
		
		//设置总记录数
		pa.setCount(scheduleService.count(map));
		
		map.put("size",pa.getPageSize());
		map.put("start", pa.getStart());  
		
		//查询所有排片并保持到pa的属性中
		List<Schedule> list = scheduleService.select(map);
		pa.setItems(list);
		
		//查询所有影厅
		session.setAttribute("room", scheduleService.selectRoom());
		
		//保持页面助手对象到作用域
		session.setAttribute("pa", pa);
		
		//判断跳转页面
		if (from != null && from.equals("1")) {
			return "redirect:/chooseMovie.jsp";
		}
		return "redirect:/filmsOnShow.jsp";
	}
	
	/**下映影片
	 * @param s
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("cancelMovie")
	@ResponseBody
	public String cancelMovie(Schedule s, PageAssistant<Schedule> pa ,HttpSession session) {
		
		//condition属性改为0，表示下映状态
		s.setCondition(0);
		System.out.println(s);
		
		scheduleService.update(s);
		return "1";
		
	}
	
	/**添加上映影片前查询的数据
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("queryMovie")
	public String queryMovie(PageAssistant<Schedule> pa ,HttpSession session) {
		
		//查询所有影片
		if (session.getAttribute("movie") == null) {
			session.setAttribute("movie", scheduleService.selectMovie());
		}
		
		return "redirect:/addFilmOnShow.jsp";
	}
		
	/**添加排片
	 * @param s
	 * @param start
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("addSchedule")
	@ResponseBody
	public String addSchedule(Schedule s, String start, PageAssistant<Schedule> pa, HttpSession session) {
		
		List<Movie> list = (List<Movie>) session.getAttribute("movie");
		Movie m = null;
		
		//找到对应影片对象
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getId().equals(s.getMid())) {
				m = list.get(i);
				break;
			}
		}
		
		//获取电影的播放时间毫秒数
		String time[] = start.split("T");
		String timeString = time[0] + " " + time[1] + ":00";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		//设置放映时间
		try {
			s.setStartTime(sdf.parse(timeString));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		//获取影片的时长毫秒数
		int duration = m.getDuration()*60*1000;
		//相加获取影片结束时间
		Date endTime = new Date(s.getStartTime().getTime() + duration);
		
		//设置结束时间
		s.setEndTime(endTime);
		
		try {
			//添加上映影片
			scheduleService.add(s);
		} catch (Exception e) {
			return "-1";
		}
		return "1";
		
	}
		
	/**查询所有影厅信息
	 * @return
	 */
	@RequestMapping("queryRoom")
	public String queryRoom(HttpSession session) {
		
		//查询所有影厅
		session.setAttribute("room", scheduleService.selectRoom());
		
		return "redirect:/RoomList.jsp";
	}
	
	/**查询损坏座位
	 * @param id
	 * @param session
	 * @return
	 */
	@RequestMapping("queryRoomSeat")
	public String queryRoomSeat(int id, HttpSession session) {
		
		//获取该影厅的对象
		Room r = new Room();
		List<Room> rooms = scheduleService.selectRoom();
		for (Room room : rooms) {
			if (room.getId() == id) {
				r = room;
			}
		}
		
		System.out.println(r);
		//保存损坏座位编号到作用域，删除已售座位编号
		session.setAttribute("room", r);
		//移除已售座位编号
		session.removeAttribute("sellSeat");
		//保存座位左边距
		session.setAttribute("leftMargin", 600);
		
		//4.跳转到对应的损坏座位影厅页面
		return "redirect:/roomjsp/damageRoom.jsp";
	}
	
	/**更新损坏座位编号
	 * @return
	 */
	@RequestMapping("updateDamageSeat")
	@ResponseBody
	public String updateDamageSeat(String seatId, HttpSession session) {
		
		//获取当前影厅的对象
		Room r = (Room) session.getAttribute("room");
		
		//更新损坏座位编号
		r.setSeatId(seatId);
		
		try {
			//更新到数据库
			scheduleService.updateRoom(r);
		} catch (Exception e) {
			//更新失败
			return "0";
		}
		//更新成功
		return "1";
		
	}
	
}










