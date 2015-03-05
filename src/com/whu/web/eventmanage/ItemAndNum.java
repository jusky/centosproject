package com.whu.web.eventmanage;

public class ItemAndNum {
	//该类用于统计网上调查票数时保存各个选项的票数
	//选项
	private String item;
	//票数
	private String num;
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
}
