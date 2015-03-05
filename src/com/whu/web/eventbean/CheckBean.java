package com.whu.web.eventbean;

public class CheckBean {

	//事件编号
	private String reportID;
	//是否受理的建议
	private String isAccept;
	//初步处理意见
	private String preAdvice;
	//核实人
	private String checkName;
	//核实时间
	private String checkTime;
	public String getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getIsAccept() {
		return isAccept;
	}
	public void setIsAccept(String isAccept) {
		this.isAccept = isAccept;
	}
	public String getPreAdvice() {
		return preAdvice;
	}
	public void setPreAdvice(String preAdvice) {
		this.preAdvice = preAdvice;
	}
	public String getCheckName() {
		return checkName;
	}
	public void setCheckName(String checkName) {
		this.checkName = checkName;
	}
}
