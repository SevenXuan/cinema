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
	
	/**��ѯ����Ӱ����������Ƭ��Ϣ
	 * @param rid
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("queryRoomSchedule")
	public String queryRoomSchedule(String rid,	PageAssistant<Schedule> pa, HttpSession session) {
		
		Map<String,Object> map = new HashMap<>();
		
		//�����ӦӰ�����
		if (rid != null && rid != "") {
			map.put("rid", rid);
			session.setAttribute("rid", rid);
		}
		//ֻ����ӳ��ӰƬ
		map.put("condition", 1);
		
		//�����ܼ�¼��
		pa.setCount(scheduleService.count(map));
		
		map.put("size",pa.getPageSize());
		map.put("start", pa.getStart());  
		
		//��ѯ������Ƭ�����ֵ�pa��������
		List<Schedule> list = scheduleService.select(map);
		pa.setItems(list);
		
		//��ѯ����Ӱ��
		session.setAttribute("room", scheduleService.selectRoom());
		//��ѯ������ӳӰƬ
		session.setAttribute("movie", scheduleService.selectMovie());
		
		//����ҳ�����ֶ���������
		session.setAttribute("pa", pa);
		
		return "redirect:/addFilmOnShow.jsp";
		
	}
	
	/**��ѯ������Ƭ
	 * @return
	 */
	@RequestMapping("query")
	public String query(String name, String rid, String from, String condition, 
			PageAssistant<Schedule> pa, HttpSession session) {
		
		//�ж�from������1˵������ѡƱ���ӣ�ֻ����ʾ��ӳӰƬ
		if (from != null && from.equals("1")) {
			condition = "1";
		}
		
		Map<String,Object> map = new HashMap<>();
		
		//��Ӳ�ѯ����,�ؼ��ֺ�Ӱ��,�����ֵ�������
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
		
		//�����ܼ�¼��
		pa.setCount(scheduleService.count(map));
		
		map.put("size",pa.getPageSize());
		map.put("start", pa.getStart());  
		
		//��ѯ������Ƭ�����ֵ�pa��������
		List<Schedule> list = scheduleService.select(map);
		pa.setItems(list);
		
		//��ѯ����Ӱ��
		session.setAttribute("room", scheduleService.selectRoom());
		
		//����ҳ�����ֶ���������
		session.setAttribute("pa", pa);
		
		//�ж���תҳ��
		if (from != null && from.equals("1")) {
			return "redirect:/chooseMovie.jsp";
		}
		return "redirect:/filmsOnShow.jsp";
	}
	
	/**��ӳӰƬ
	 * @param s
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("cancelMovie")
	@ResponseBody
	public String cancelMovie(Schedule s, PageAssistant<Schedule> pa ,HttpSession session) {
		
		//condition���Ը�Ϊ0����ʾ��ӳ״̬
		s.setCondition(0);
		System.out.println(s);
		
		scheduleService.update(s);
		return "1";
		
	}
	
	/**�����ӳӰƬǰ��ѯ������
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("queryMovie")
	public String queryMovie(PageAssistant<Schedule> pa ,HttpSession session) {
		
		//��ѯ����ӰƬ
		if (session.getAttribute("movie") == null) {
			session.setAttribute("movie", scheduleService.selectMovie());
		}
		
		return "redirect:/addFilmOnShow.jsp";
	}
		
	/**�����Ƭ
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
		
		//�ҵ���ӦӰƬ����
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getId().equals(s.getMid())) {
				m = list.get(i);
				break;
			}
		}
		
		//��ȡ��Ӱ�Ĳ���ʱ�������
		String time[] = start.split("T");
		String timeString = time[0] + " " + time[1] + ":00";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		//���÷�ӳʱ��
		try {
			s.setStartTime(sdf.parse(timeString));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		//��ȡӰƬ��ʱ��������
		int duration = m.getDuration()*60*1000;
		//��ӻ�ȡӰƬ����ʱ��
		Date endTime = new Date(s.getStartTime().getTime() + duration);
		
		//���ý���ʱ��
		s.setEndTime(endTime);
		
		try {
			//�����ӳӰƬ
			scheduleService.add(s);
		} catch (Exception e) {
			return "-1";
		}
		return "1";
		
	}
		
	/**��ѯ����Ӱ����Ϣ
	 * @return
	 */
	@RequestMapping("queryRoom")
	public String queryRoom(HttpSession session) {
		
		//��ѯ����Ӱ��
		session.setAttribute("room", scheduleService.selectRoom());
		
		return "redirect:/RoomList.jsp";
	}
	
	/**��ѯ����λ
	 * @param id
	 * @param session
	 * @return
	 */
	@RequestMapping("queryRoomSeat")
	public String queryRoomSeat(int id, HttpSession session) {
		
		//��ȡ��Ӱ���Ķ���
		Room r = new Room();
		List<Room> rooms = scheduleService.selectRoom();
		for (Room room : rooms) {
			if (room.getId() == id) {
				r = room;
			}
		}
		
		System.out.println(r);
		//��������λ��ŵ�������ɾ��������λ���
		session.setAttribute("room", r);
		//�Ƴ�������λ���
		session.removeAttribute("sellSeat");
		//������λ��߾�
		session.setAttribute("leftMargin", 600);
		
		//4.��ת����Ӧ������λӰ��ҳ��
		return "redirect:/roomjsp/damageRoom.jsp";
	}
	
	/**��������λ���
	 * @return
	 */
	@RequestMapping("updateDamageSeat")
	@ResponseBody
	public String updateDamageSeat(String seatId, HttpSession session) {
		
		//��ȡ��ǰӰ���Ķ���
		Room r = (Room) session.getAttribute("room");
		
		//��������λ���
		r.setSeatId(seatId);
		
		try {
			//���µ����ݿ�
			scheduleService.updateRoom(r);
		} catch (Exception e) {
			//����ʧ��
			return "0";
		}
		//���³ɹ�
		return "1";
		
	}
	
}










