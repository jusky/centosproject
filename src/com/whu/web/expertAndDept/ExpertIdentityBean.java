package com.whu.web.expertAndDept;

import java.util.List;

public class ExpertIdentityBean {
	//用于前台显示，序号1，2,3
	private String serialNum;
	//编号：数据库记录的编号
	private String id;
	//事件标题
	private String eventTitle;
	//专家鉴定函
	private String letterPath;
	//鉴定意见书
	private String adviceLetterPath;
	//反馈截止日期
	private String time;
	//举报编号
	private String reportID;
	//专家鉴定相关编号
	private String adviceID;
	//是否已经提交
	private String isSubmit;
	//附件列表
	private List attachList = null;
	//事件状态，如果状态为调查中，则可以在线提交，否则不能提交
	private String status;
	//鉴定内容及目的
	private String jdContent = "";
	//委托机构
	private String wtDept = "";
	//案由
	private String eventReason = "";
	
	public String getEventReason() {
		return eventReason;
	}
	public void setEventReason(String eventReason) {
		this.eventReason = eventReason;
	}
	public String getJdContent() {
		return jdContent;
	}
	public void setJdContent(String jdContent) {
		this.jdContent = jdContent;
	}
	public String getWtDept() {
		return wtDept;
	}
	public void setWtDept(String wtDept) {
		this.wtDept = wtDept;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIsSubmit() {
		return isSubmit;
	}
	public void setIsSubmit(String isSubmit) {
		this.isSubmit = isSubmit;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getAdviceID() {
		return adviceID;
	}
	public void setAdviceID(String adviceID) {
		this.adviceID = adviceID;
	}
	public List getAttachList() {
		return attachList;
	}
	public void setAttachList(List attachList) {
		this.attachList = attachList;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEventTitle() {
		return eventTitle;
	}
	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}
	public String getLetterPath() {
		return letterPath;
	}
	public void setLetterPath(String letterPath) {
		this.letterPath = letterPath;
	}
	public String getAdviceLetterPath() {
		return adviceLetterPath;
	}
	public void setAdviceLetterPath(String adviceLetterPath) {
		this.adviceLetterPath = adviceLetterPath;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
}
