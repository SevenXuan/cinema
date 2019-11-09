package com.bean;

import java.io.Serializable;

/**影厅实体类
 * @author doris1175
 *
 */
public class Room implements Serializable{
	
	private Integer id;
	private String type;
	//座位数量
	private Integer seat;
	//维护座位编号
	private String seatId;
	private int rows;
	private int cols;
	
	public Room() {
	}

	public Room(Integer id, String type, Integer seat, String seatId, int rows, int cols) {
		super();
		this.id = id;
		this.type = type;
		this.seat = seat;
		this.seatId = seatId;
		this.rows = rows;
		this.cols = cols;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getSeat() {
		return seat;
	}

	public void setSeat(Integer seat) {
		this.seat = seat;
	}

	public String getSeatId() {
		return seatId;
	}

	public void setSeatId(String seatId) {
		this.seatId = seatId;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getCols() {
		return cols;
	}

	public void setCols(int cols) {
		this.cols = cols;
	}

	@Override
	public String toString() {
		return "Room [id=" + id + ", type=" + type + ", seat=" + seat + ", seatId=" + seatId + ", rows=" + rows
				+ ", cols=" + cols + "]";
	}
	
}
