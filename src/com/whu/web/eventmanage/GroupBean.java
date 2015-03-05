package com.whu.web.eventmanage;

/**
 * 调查组成员Bean
 * @author wch
 *
 */
public class GroupBean {
	//编号
	private String id;
	//姓名
	private String name;
	//单位
	private String unit;
	//联系方式
	private String telPhone;
	//家庭住址
	private String address;
	//主要工作
	private String workContent;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getTelPhone() {
		return telPhone;
	}
	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getWorkContent() {
		return workContent;
	}
	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}
}
