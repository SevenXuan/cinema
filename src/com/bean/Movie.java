package com.bean;

import java.io.Serializable;
import java.util.Date;

/**电影实体类
 * @author doris1175
 *
 */
public class Movie implements Serializable{

	private Integer id;
	private String name;
	private String intro;
	private Double score;
	private String lTid;
	private String mTid;
	private String producer;
	private String issure;
	private String director;
	private String actor;
	private Integer duration;
	//上映时间
	private Date time;	
	//版权到期时间
	private Date expiringDate;	
	private Integer count=1;
	//总票房
	private Integer grossed;
	
	//状态（修改状态为0即是删除)
	private Byte condition=1; 
	
	
	public Movie() {
	}

	public Movie(Integer id, String name, String intro, Double score, String lTid, String mTid, String producer,
			String issure, String director, String actor, Integer duration, Date time, Date expiringDate, Integer count,
			Integer grossed,Byte condition) {
		this.id = id;
		this.name = name;
		this.intro = intro;
		this.score = score;
		this.lTid = lTid;
		this.mTid = mTid;
		this.producer = producer;
		this.issure = issure;
		this.director = director;
		this.actor = actor;
		this.duration = duration;
		this.time = time;
		this.expiringDate = expiringDate;
		this.count = count;
		this.grossed = grossed;
		this.condition = condition;
	}

	
	@Override
	public String toString() {
		return "Movie [id=" + id + ", name=" + name + ", intro=" + intro + ", score=" + score + ", lTid=" + lTid
				+ ", mTid=" + mTid + ", producer=" + producer + ", issure=" + issure + ", director=" + director
				+ ", actor=" + actor + ", duration=" + duration + ", time=" + time + ", expiringDate=" + expiringDate
				+ ", count=" + count + ", grossed=" + grossed + ", condition=" + condition + "]";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public String getlTid() {
		return lTid;
	}

	public void setlTid(String lTid) {
		this.lTid = lTid;
	}

	public String getmTid() {
		return mTid;
	}

	public void setmTid(String mTid) {
		this.mTid = mTid;
	}

	public String getProducer() {
		return producer;
	}

	public void setProducer(String producer) {
		this.producer = producer;
	}

	public String getIssure() {
		return issure;
	}

	public void setIssure(String issure) {
		this.issure = issure;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Date getExpiringDate() {
		return expiringDate;
	}

	public void setExpiringDate(Date expiringDate) {
		this.expiringDate = expiringDate;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getGrossed() {
		return grossed;
	}

	public void setGrossed(Integer grossed) {
		this.grossed = grossed;
	}
	public Byte getCondition() {
		return condition;
	}

	public void setCondition(Byte condition) {
		this.condition = condition;
	}
}
