package com.util;

import java.util.List;

/**
 * 页面助手
 * @author Administrator
 *
 * @param <T>
 */
public class PageAssistant<T> {

	/** 总记录数 */
	private int count;
	/** 总页数 */
	private int totalPage;
	/** 页面大小 */
	private int pageSize = 5;
	/** 当前页码 */
	private int currPage = 1;
	/** 当前页的起始记录编号 */
	private int start;
	/** 当前页的数据集合 */
	private List<T> items;
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
		setTotalPage();
	}

	public int getTotalPage() {
		return totalPage;
	}

	private void setTotalPage() {
		this.totalPage = count / pageSize;
		
		if(count % pageSize != 0) {
			totalPage++;
		}
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
		setTotalPage();
		setStart();
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
		setStart();
	}

	public int getStart() {
		return start;
	}

	private void setStart() {
		this.start = (currPage-1) * pageSize;
	}

	public List<T> getItems() {
		return items;
	}

	public void setItems(List<T> items) {
		this.items = items;
	}

	@Override
	public String toString() {
		return "PageAssistant [count=" + count + ", totalPage=" + totalPage + ", pageSize=" + pageSize + ", currPage="
				+ currPage + ", start=" + start + "]";
	}
}
















