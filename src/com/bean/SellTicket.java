package com.bean;

import java.io.Serializable;
import java.util.Date;

public class SellTicket implements Serializable{

	private Integer id;
	private Date time;
	private Integer sid;
	private Integer adultNum;
	private double totalPrice;
	private String seatId;
	
	private Schedule schedule;
	
	public SellTicket() {
	}

	public SellTicket(Integer id, Date time, Integer sid, Integer adultNum, double totalPrice, String seatId,
			Schedule schedule) {
		this.id = id;
		this.time = time;
		this.sid = sid;
		this.adultNum = adultNum;
		this.totalPrice = totalPrice;
		this.seatId = seatId;
		this.schedule = schedule;
	}

	@Override
	public String toString() {
		return "SellTicket [id=" + id + ", time=" + time + ", sid=" + sid + ", adultNum=" + adultNum + ", totalPrice="
				+ totalPrice + ", seatId=" + seatId + ", schedule=" + schedule + "]";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Integer getAdultNum() {
		return adultNum;
	}

	public void setAdultNum(Integer adultNum) {
		this.adultNum = adultNum;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice() {
		this.totalPrice = adultNum*schedule.getPrice();
	}

	public String getSeatId() {
		return seatId;
	}

	public void setSeatId(String seatId) {
		this.seatId = seatId;
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

}
