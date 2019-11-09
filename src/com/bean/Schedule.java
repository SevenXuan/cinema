package com.bean;

import java.io.Serializable;
import java.util.Date;

/**≈≈∆¨±Ì
 * @author doris1175
 *
 */
public class Schedule implements Serializable{

	private Integer id;
	private Integer mid;
	private Integer rid;
	private double price;
	private Date startTime;
	private Date endTime;
	private String sellSeat;
	private Integer condition;
	
	private Movie movie;
	private Room room;
	
	public Schedule() {
	}

	public Schedule(Integer id, Integer mid, Integer rid, double price, Date startTime, Date endTime, String sellSeat,
			Integer condition, Movie movie, Room room) {
		this.id = id;
		this.mid = mid;
		this.rid = rid;
		this.price = price;
		this.startTime = startTime;
		this.endTime = endTime;
		this.sellSeat = sellSeat;
		this.condition = condition;
		this.movie = movie;
		this.room = room;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public Integer getRid() {
		return rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getSellSeat() {
		return sellSeat;
	}

	public void setSellSeat(String sellSeat) {
		this.sellSeat = sellSeat;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public Integer getCondition() {
		return condition;
	}

	public void setCondition(Integer condition) {
		this.condition = condition;
	}

	@Override
	public String toString() {
		return "Schedule [id=" + id + ", mid=" + mid + ", rid=" + rid + ", price=" + price + ", startTime=" + startTime
				+ ", endTime=" + endTime + ", sellSeat=" + sellSeat + ", condition=" + condition + ", movie=" + movie
				+ ", room=" + room + "]";
	}

}
