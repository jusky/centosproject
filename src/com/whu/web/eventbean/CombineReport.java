package com.whu.web.eventbean;

import java.util.List;

//合并的调查报告
public class CombineReport {

	private String id;
	private String reportIDs;
	private String filePath;
	private String fileName;
	private String createTime;
	private List reportIDList = null;
	public List getReportIDList() {
		return reportIDList;
	}
	public void setReportIDList(List reportIDList) {
		this.reportIDList = reportIDList;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReportIDs() {
		return reportIDs;
	}
	public void setReportIDs(String reportIDs) {
		this.reportIDs = reportIDs;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}
