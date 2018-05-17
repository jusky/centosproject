package com.whu.web.eventmanage;

public class ApproveBean {
	
	//举报编号
	private String reportID;
	//是否立案
	private String isLA;
	//领导立案建议
	private String laAdvice;
	//审核领导
	private String approveName;
	//批示时间
	private String approveTime;
	//领导批示意见
	private String headAdvice;
	//批示领导
	private String headName;
	
	private String isXY;
	public String getApproveTime() {
		return approveTime;
	}
	public void setApproveTime(String approveTime) {
		this.approveTime = approveTime;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getIsLA() {
		return isLA;
	}
	public void setIsLA(String isLA) {
		this.isLA = isLA;
	}
	
	public String getIsXY() {
		return isXY;
	}
	public void setIsXY(String isXY) {
		this.isXY = isXY;
	}
	
	public String getLaAdvice() {
		return laAdvice;
	}
	public void setLaAdvice(String laAdvice) {
		this.laAdvice = laAdvice;
	}
	public String getApproveName() {
		return approveName;
	}
	public void setApproveName(String approveName) {
		this.approveName = approveName;
	}
	public String getHeadAdvice() {
		return headAdvice;
	}
	public void setHeadAdvice(String headAdvice) {
		this.headAdvice = headAdvice;
	}
	public String getHeadName() {
		return headName;
	}
	public void setHeadName(String headName) {
		this.headName = headName;
	}
	
	
}
