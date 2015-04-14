package com.whu.web.eventbean;

import java.util.List;

public class JDYJSBean {
	private String id;
	private String reportID;
	//案由
	private String eventReason;
	//鉴定内容与目的
	private String identifyContent;
	//委托单位
	private String wtDept;
	//鉴定结论
	private String jdConclusion;
	//鉴定意见
	private String jdAdvice;
	//提交的鉴定结论
	private String conclusion;
	//鉴定结论列表
	private List jdConclusionList = null;
	//附件
	private String filePath;
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
	public String getJdAdvice() {
		return jdAdvice;
	}
	public void setJdAdvice(String jdAdvice) {
		this.jdAdvice = jdAdvice;
	}
	public String getConclusion() {
		return conclusion;
	}
	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}
	public List getJdConclusionList() {
		return jdConclusionList;
	}
	public void setJdConclusionList(List jdConclusionList) {
		this.jdConclusionList = jdConclusionList;
	}
	public String getEventReason() {
		return eventReason;
	}
	public void setEventReason(String eventReason) {
		this.eventReason = eventReason;
	}
	public String getIdentifyContent() {
		return identifyContent;
	}
	public void setIdentifyContent(String identifyContent) {
		this.identifyContent = identifyContent;
	}
	public String getWtDept() {
		return wtDept;
	}
	public void setWtDept(String wtDept) {
		this.wtDept = wtDept;
	}
	public String getJdConclusion() {
		return jdConclusion;
	}
	public void setJdConclusion(String jdConclusion) {
		this.jdConclusion = jdConclusion;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}
