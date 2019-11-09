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
	//排片表
	private ScheduleService scheduleService;
	@Resource
	//售票记录表
	private SellTicketService sellTicketService;
	
	/**查询影片座位售票情况，查询排片表
	 * @param sid
	 * @param session
	 * @return
	 */
	@RequestMapping("querySeat")
	public String querySeat(int sid, HttpSession session) {
		
		Map<String,Object> map = new HashMap<>();
		map.put("id", sid);
		
		//获取排片信息
		List<Schedule> list = scheduleService.select(map);
		//1.获取排片对象
		Schedule s = list.get(0);
		//保存排片对象信息到作用域
		session.setAttribute("schedule", s);
		
		//2.获取影厅信息对象，获取对应的损坏座位号
		Room r = null;
		int rid = s.getRoom().getId();
		
		List<Room> rooms = scheduleService.selectRoom();
		
		//获得影片对应影厅对象
		for (Room room : rooms) {
			if (room.getId() == rid) {
				r = room;
				break;
			}
		}
		//显示影厅对象信息
		System.out.println(r);
		
		//保存影厅对象到作用域
		session.setAttribute("room", r);
		
		//保存影厅座位左侧偏移量
		if (rid == 1 || rid == 2) {
			session.setAttribute("leftMargin", 550);
		}else {
			session.setAttribute("leftMargin", 600);
		}
		
		//4.跳转到对应的影厅页面
		return "redirect:/roomjsp/Room.jsp";
	}
	
	/**新增已售座位编号，修改排片表的作为信息
	 * 同时新增销售记录
	 * @param seatId
	 * @param session
	 * @return
	 */
	@RequestMapping("buyTicket")
	@ResponseBody
	public String buyTicket(String[] seatId, HttpSession session) {
		
		/**1.更新已售座位编号到排片表*/
		//获取作用域中的排片对象
		Schedule s = (Schedule) session.getAttribute("schedule");
		
		//拼接售票座位信息，保存到对象属性中
		String sellSeats = new String();
		for (int i = 0; i < seatId.length; i++) {
			sellSeats = sellSeats + "," + seatId[i];
		}
		
		s.setSellSeat(sellSeats);
		
		
		/**2.添加售票记录*/
		//获取售票时间
		SellTicket st = new SellTicket();
		st.setTime(new Date());
		
		//设置排片的编号
		st.setSid(s.getId());
		
		//获取座位数量
		st.setAdultNum(seatId.length);
		
		//设置排片对象和总价
		st.setSchedule(s);
		st.setTotalPrice();
		
		//设置售卖座位编号
		String sellSeat = seatId[0];
		for (int i = 1; i < seatId.length; i++) {
			sellSeat = sellSeat + "," + seatId[i];
		}
		st.setSeatId(sellSeat);
		
		//更新到数据库中
		
		//更新排片已售座位编号
		scheduleService.update(s);
		//新增销售记录
		sellTicketService.add(st);
		
		//更新成功
		return "1";
	}
	
	/**查询可以订票的影片信息，用于购票
	 * @param name
	 * @param rid
	 * @param pa
	 * @param session
	 * @return
	 */
	@RequestMapping("query")
	public String query(String name, String rid, PageAssistant<Schedule> pa, HttpSession session) {
		
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
		//只查询正在上映的影片
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
		
		//保持页面助手对象到作用域
		session.setAttribute("pa", pa);
		
		return "redirect:/chooseMovie.jsp";
	}
	
	
	/**查询所有售票记录
	 * @return
	 */
	@RequestMapping("querySellInfo")
	public String querySellInfo(String name, String rid, 
			PageAssistant<SellTicket> pa, HttpSession session) {
		
		Map<String, Object> map = new HashMap<>();
		
		//添加查询条件,关键字和影厅,并保存到作用域
		if (name != null && name != "") {
			map.put("keyword", name);
			session.setAttribute("keyword", name);
		}
		if (rid != null && rid != "") {
			map.put("rid", rid);
			session.setAttribute("rid", rid);
		}
		
		//设置总记录数
		pa.setCount(sellTicketService.count(map).size());
		
		map.put("start", pa.getStart());
		map.put("size", pa.getPageSize());
		
		List<SellTicket> list = sellTicketService.select(map);
		//保存集合
		pa.setItems(list);
		//保存页面助手到作用域
		session.setAttribute("pa", pa);
		//查询所有影厅
		session.setAttribute("room", scheduleService.selectRoom());
		
		return "redirect:/sellInfo.jsp";
	}
	
	/**退票
	 * @return
	 */
	@RequestMapping("refundTicket")
	@ResponseBody
	public String refundTicket(int siId, HttpSession session) {
		
		/**1.从排片表的已售座位中，删除该售票记录的座位*/
		SellTicket sellTicket = new SellTicket();
		//获取所有售票记录
		Map<String, Object> map = new HashMap<>();
		List<SellTicket> list = sellTicketService.select(map);
		
		//遍历获取对应的售票记录对象
		for (SellTicket s1 : list) {
			if (s1.getId() == siId) {
				sellTicket = s1;
			}
		}
		//获取该售票记录的座位编号
		String refundSeat = sellTicket.getSeatId();
		System.out.println("退票座位为：" + refundSeat);
		
		//获取排片表的座位
		Schedule s = sellTicket.getSchedule();
		String sellSeat = s.getSellSeat();
		System.out.println("已售座位:" + sellSeat);
		
		/**2.从sellSeat中去掉refundSeat*/
		String[] seats = sellSeat.split(refundSeat);
		System.out.println("用退票座位切分后数组的长度为："+ seats.length + ","+ Arrays.toString(seats));
		
		//字符串数组中的元素再用“,”切分一次，保存到allSeat集合中
		List<String> allSeat = new ArrayList<>();
		
		for (String seat : seats) {
			String[] singleSeat = seat.split(",");
			//将数组中的元素添加到集合中
			for (String string : singleSeat) {
				allSeat.add(string);
			}
		}
		System.out.println("用逗号切分后保存在集合中的座位：" + allSeat.toString());
		
		//最后将集合中的元素用逗号拼接即可
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
		System.out.println("最后拼接完成的座位字符串：" + newSellSeat);
		
		//保持到对象中
		s.setSellSeat(finalSeat);
		
		/**3.更新到数据库*/
		try {
			//更新排片表的座位编号
			scheduleService.update(s);
			//删除售票记录
			sellTicketService.delete(siId);
		} catch (Exception e) {
			//退票失败
			return "0";
		}
		//退票成功
		return "1";
		
	}
	
	
}



















