package com.whu.web.eventbean;
/**
 * 专家鉴定函信息
 * @author Administrator
 *
 */
public class ExpertJDH {
	//编号
	private String id;
	//标题
	private String title;
	//简述
	private String shortInfo;
	//反馈日期
	private String fkTime;
	//鉴定目标
	private String target;
	//鉴定内容
	private String jdContent;
	//事件编号
	private String reportID;
	
	private String year;
	private String month;
	private String day;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getShortInfo() {
		return shortInfo;
	}
	public void setShortInfo(String shortInfo) {
		this.shortInfo = shortInfo;
	}
	public String getFkTime() {
		return fkTime;
	}
	public void setFkTime(String fkTime) {
		this.fkTime = fkTime;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getJdContent() {
		return jdContent;
	}
	public void setJdContent(String jdContent) {
		this.jdContent = jdContent;
	}

}
