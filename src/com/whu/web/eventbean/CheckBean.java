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
	//拟办意见
	private String nibanAdvice;
	//拟办人
	private String nibanName;
	//拟办时间
	private String nibanTime;
	
	public String getNibanAdvice() {
		return nibanAdvice;
	}
	public void setNibanAdvice(String nibanAdvice) {
		this.nibanAdvice = nibanAdvice;
	}
	public String getNibanName() {
		return nibanName;
	}
	public void setNibanName(String nibanName) {
		this.nibanName = nibanName;
	}
	public String getNibanTime() {
		return nibanTime;
	}
	public void setNibanTime(String nibanTime) {
		this.nibanTime = nibanTime;
	}
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
