package com.whu.web.eventbean;
/**
 * 复议申请
 * @author Administrator
 *
 */
public class FYApply {

	//编号
	private String id;
	//事件编号
	private String reportID;
	//复议申请人姓名
	private String fyApplyName;
	//复议提出时间
	private String fyTime;
	//简短描述
	private String shortInfo;
	//附件路径，attachment/20130202332233/fileName.ext
	private String attachPath;
	//是否受理异议申请
	private String isAccept;
	public String getIsAccept() {
		return isAccept;
	}
	public void setIsAccept(String isAccept) {
		this.isAccept = isAccept;
	}
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
	public String getFyApplyName() {
		return fyApplyName;
	}
	public void setFyApplyName(String fyApplyName) {
		this.fyApplyName = fyApplyName;
	}
	public String getFyTime() {
		return fyTime;
	}
	public void setFyTime(String fyTime) {
		this.fyTime = fyTime;
	}
	public String getShortInfo() {
		return shortInfo;
	}
	public void setShortInfo(String shortInfo) {
		this.shortInfo = shortInfo;
	}
	public String getAttachPath() {
		return attachPath;
	}
	public void setAttachPath(String attachPath) {
		this.attachPath = attachPath;
	}
	
}
