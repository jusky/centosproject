package com.whu.web.expertAndDept;

public class DeptAdviceBean {

	//单位意见
	private String deptAdvice;
	//当事人姓名
	private String litigantName;
	//当事人态度
	private String attitude;
	//面谈时间
	private String litigantTime;
	//专家意见
	private String expertAdvice;
	public String getDeptAdvice() {
		return deptAdvice;
	}
	public void setDeptAdvice(String deptAdvice) {
		this.deptAdvice = deptAdvice;
	}
	public String getLitigantName() {
		return litigantName;
	}
	public void setLitigantName(String litigantName) {
		this.litigantName = litigantName;
	}
	public String getAttitude() {
		return attitude;
	}
	public void setAttitude(String attitude) {
		this.attitude = attitude;
	}
	public String getLitigantTime() {
		return litigantTime;
	}
	public void setLitigantTime(String litigantTime) {
		this.litigantTime = litigantTime;
	}
	public String getExpertAdvice() {
		return expertAdvice;
	}
	public void setExpertAdvice(String expertAdvice) {
		this.expertAdvice = expertAdvice;
	}
}
