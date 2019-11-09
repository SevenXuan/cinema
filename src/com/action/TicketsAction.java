package com.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.Room;
import com.bean.Schedule;
import com.bean.SellTicket;
import com.service.ScheduleService;
import com.service.SellTicketService;
import com.util.PageAssistant;

@Controller
@RequestMapping("ticket")
public class TicketsAction {

	@Resource
	//��Ƭ��
	private ScheduleService scheduleService;
	@Resource
	//��Ʊ��¼��
	private SellTicketService sellTicketService;
	
	/**��ѯӰƬ��λ��Ʊ�������ѯ��Ƭ��
	 * @param sid
	 * @param session
	 * @return
	 */
	@RequestMapping("querySeat")
	public String querySeat(int sid, HttpSession session) {
		
		Map<String,Object> map = new HashMap<>();
		map.put("id", sid);
		
		//��ȡ��Ƭ��Ϣ
		List<Schedule> list = scheduleService.select(map);
		//1.��ȡ��Ƭ����
		Schedule s = list.get(0);
		//������Ƭ������Ϣ��������
		session.setAttribute("schedule", s);
		
		//2.��ȡӰ����Ϣ���󣬻�ȡ��Ӧ������λ��
		Room r = null;
		int rid = s.getRoom().getId();
		
		List<Room> rooms = scheduleService.selectRoom();
		
		//���ӰƬ��ӦӰ������
		for (Room room : rooms) {
			if (room.getId() == rid) {
				r = room;
				break;
			}
		}
		//��ʾӰ��������Ϣ
		System.out.println(r);
		
		//����Ӱ������������
		session.setAttribute("room", r);
		
		//����Ӱ����λ���ƫ����
		if (rid == 1 || rid == 2) {
			session.setAttribute("leftMargin", 550);
		}else {
			session.setAttribute("leftMargin", 600);
		}
		
		//4.��ת����Ӧ��Ӱ��ҳ��
		return "redirect:/roomjsp/Room.jsp";
	}
	
	/**����������λ��ţ��޸���Ƭ�����Ϊ��Ϣ
	 * ͬʱ�������ۼ�¼
	 * @param seatId
	 * @param session
	 * @return
	 */
	@RequestMapping("buyTicket")
	@ResponseBody
	public String buyTicket(String[] seatId, HttpSession session) {
		
		/**1.����������λ��ŵ���Ƭ��*/
		//��ȡ�������е���Ƭ����
		Schedule s = (Schedule) session.getAttribute("schedule");
		
		//ƴ����Ʊ��λ��Ϣ�����浽����������
		String sellSeats = new String();
		for (int i = 0; i < seatId.length; i++) {
			sellSeats = sellSeats + "," + seatId[i];
		}
		
		s.setSellSeat(sellSeats);
		
		
		/**2.�����Ʊ��¼*/
		//��ȡ��Ʊʱ��
		SellTicket st = new SellTicket();
		st.setTime(new Date());
		
		//������Ƭ�ı��
		st.setSid(s.getId());
		
		//��ȡ��λ����
		st.setAdultNum(seatId.length);
		
		//������Ƭ������ܼ�
		st.setSchedule(s);
		st.setTotalPrice();
		
		//����������λ���
		String sellSeat = seatId[0];
		for (int i = 1; i < seatId.length; i++) {
			sellSeat = sellSeat + "," + seatId[i];
		}
		st.setSeatId(sellSeat);
		
		//���µ����ݿ���
		
		//������Ƭ������λ���
		scheduleService.update(s);
		//�������ۼ�¼
		sellTicketService.add(st);
		
		//���³ɹ�
		return "1";
	}
	
	/**��ѯ���Զ�Ʊ��ӰƬ��Ϣ�����ڹ�Ʊ
	 * @param name
	 * @param rid
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("query")
	public String query(String name, String rid, PageAssistant<Schedule> pa, HttpSession session) {
		
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
		//ֻ��ѯ������ӳ��ӰƬ
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
		
		//����ҳ�����ֶ���������
		session.setAttribute("pa", pa);
		
		return "redirect:/chooseMovie.jsp";
	}
	
	
	/**��ѯ������Ʊ��¼
	 * @return
	 */
	@RequestMapping("querySellInfo")
	public String querySellInfo(String name, String rid, 
			PageAssistant<SellTicket> pa, HttpSession session) {
		
		Map<String, Object> map = new HashMap<>();
		
		//��Ӳ�ѯ����,�ؼ��ֺ�Ӱ��,�����浽������
		if (name != null && name != "") {
			map.put("keyword", name);
			session.setAttribute("keyword", name);
		}
		if (rid != null && rid != "") {
			map.put("rid", rid);
			session.setAttribute("rid", rid);
		}
		
		//�����ܼ�¼��
		pa.setCount(sellTicketService.count(map).size());
		
		map.put("start", pa.getStart());
		map.put("size", pa.getPageSize());
		
		List<SellTicket> list = sellTicketService.select(map);
		//���漯��
		pa.setItems(list);
		//����ҳ�����ֵ�������
		session.setAttribute("pa", pa);
		//��ѯ����Ӱ��
		session.setAttribute("room", scheduleService.selectRoom());
		
		return "redirect:/sellInfo.jsp";
	}
	
	/**��Ʊ
	 * @return
	 */
	@RequestMapping("refundTicket")
	@ResponseBody
	public String refundTicket(int siId, HttpSession session) {
		
		/**1.����Ƭ���������λ�У�ɾ������Ʊ��¼����λ*/
		SellTicket sellTicket = new SellTicket();
		//��ȡ������Ʊ��¼
		Map<String, Object> map = new HashMap<>();
		List<SellTicket> list = sellTicketService.select(map);
		
		//������ȡ��Ӧ����Ʊ��¼����
		for (SellTicket s1 : list) {
			if (s1.getId() == siId) {
				sellTicket = s1;
			}
		}
		//��ȡ����Ʊ��¼����λ���
		String refundSeat = sellTicket.getSeatId();
		System.out.println("��Ʊ��λΪ��" + refundSeat);
		
		//��ȡ��Ƭ�����λ
		Schedule s = sellTicket.getSchedule();
		String sellSeat = s.getSellSeat();
		System.out.println("������λ:" + sellSeat);
		
		/**2.��sellSeat��ȥ��refundSeat*/
		String[] seats = sellSeat.split(refundSeat);
		System.out.println("����Ʊ��λ�зֺ�����ĳ���Ϊ��"+ seats.length + ","+ Arrays.toString(seats));
		
		//�ַ��������е�Ԫ�����á�,���з�һ�Σ����浽allSeat������
		List<String> allSeat = new ArrayList<>();
		
		for (String seat : seats) {
			String[] singleSeat = seat.split(",");
			//�������е�Ԫ����ӵ�������
			for (String string : singleSeat) {
				allSeat.add(string);
			}
		}
		System.out.println("�ö����зֺ󱣴��ڼ����е���λ��" + allSeat.toString());
		
		//��󽫼����е�Ԫ���ö���ƴ�Ӽ���
		StringBuilder newSellSeat = new StringBuilder();  
		boolean flag = false;  
        for (String string : allSeat) {  
            if (flag) {  
            	newSellSeat.append(",");  
            } else {  
                flag = true;  
            }  
            newSellSeat.append(string);  
        }
        String finalSeat = newSellSeat.toString();
		System.out.println("���ƴ����ɵ���λ�ַ�����" + newSellSeat);
		
		//���ֵ�������
		s.setSellSeat(finalSeat);
		
		/**3.���µ����ݿ�*/
		try {
			//������Ƭ�����λ���
			scheduleService.update(s);
			//ɾ����Ʊ��¼
			sellTicketService.delete(siId);
		} catch (Exception e) {
			//��Ʊʧ��
			return "0";
		}
		//��Ʊ�ɹ�
		return "1";
		
	}
	
	
}



















