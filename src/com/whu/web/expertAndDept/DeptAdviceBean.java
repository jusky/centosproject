package com.whu.web.expertAndDept;

import java.util.List;

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
	//附件
	private String filePath;
	//被举报人列表
	private List beReportList = null;
	public List getBeReportList() {
		return beReportList;
	}
	public void setBeReportList(List beReportList) {
		this.beReportList = beReportList;
	}
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
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}
