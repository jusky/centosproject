package com.whu.web.eventbean;
//收件阅办单
public class SjybdBean {
	private String id;
	private String reportID;
	private String reportName;
	//编号--年号
	private String numYear;
	//编号
	private String numID;
	//年
	private String year;
	private String month;
	private String day;
	private String serialNum;
	private String recvTime;
	private String comeName;
	private String title;
	private String filePath;
	private String proposedOpinion;//拟办意见
	
	public String getProposedOpinion() {
		return proposedOpinion;
	}
	public void setProposedOpinion(String proposedOpinion) {
		this.proposedOpinion = proposedOpinion;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComeName() {
		return comeName;
	}
	public void setComeName(String comeName) {
		this.comeName = comeName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getRecvTime() {
		return recvTime;
	}
	public void setRecvTime(String recvTime) {
		this.recvTime = recvTime;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getNumYear() {
		return numYear;
	}
	public void setNumYear(String numYear) {
		this.numYear = numYear;
	}
	public String getNumID() {
		return numID;
	}
	public void setNumID(String numID) {
		this.numID = numID;
	}
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
}
