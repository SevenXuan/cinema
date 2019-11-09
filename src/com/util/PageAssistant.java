package com.util;

import java.util.List;

/**
 * ҳ������
 * @author Administrator
 *
 * @param <T>
 */
public class PageAssistant<T> {

	/** �ܼ�¼�� */
	private int count;
	/** ��ҳ�� */
	private int totalPage;
	/** ҳ���С */
	private int pageSize = 5;
	/** ��ǰҳ�� */
	private int currPage = 1;
	/** ��ǰҳ����ʼ��¼��� */
	private int start;
	/** ��ǰҳ�����ݼ��� */
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
















