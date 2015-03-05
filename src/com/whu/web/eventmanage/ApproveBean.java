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
	//审核时间
	private String approveTime;
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
	
}
