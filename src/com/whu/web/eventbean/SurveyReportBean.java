package com.whu.web.eventbean;

public class SurveyReportBean {

	private String id;
	private String reportID;
	private String serialNum;
	private String reportName;
	private String beReportName;
	private String filePath;
	private String createTime;
	
	
	private String localPath;
	private String templatePath;
	private String reportContent;
	private String checkInfo;
	//已经上传的调查报告路径
	private String oldReportPath;
	//下载的调查报告的临时文件夹
	private String oldReportLocal;
	private String deptAdvice;
	private String expertAdvice;
	private String litigantState;
	private String facultyAdvice;
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
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getBeReportName() {
		return beReportName;
	}
	public void setBeReportName(String beReportName) {
		this.beReportName = beReportName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getExpertAdvice() {
		return expertAdvice;
	}
	public void setExpertAdvice(String expertAdvice) {
		this.expertAdvice = expertAdvice;
	}
	public String getLitigantState() {
		return litigantState;
	}
	public void setLitigantState(String litigantState) {
		this.litigantState = litigantState;
	}
	public String getFacultyAdvice() {
		return facultyAdvice;
	}
	public void setFacultyAdvice(String facultyAdvice) {
		this.facultyAdvice = facultyAdvice;
	}
	public String getDeptAdvice() {
		return deptAdvice;
	}
	public void setDeptAdvice(String deptAdvice) {
		this.deptAdvice = deptAdvice;
	}
	public String getOldReportLocal() {
		return oldReportLocal;
	}
	public void setOldReportLocal(String oldReportLocal) {
		this.oldReportLocal = oldReportLocal;
	}
	public String getOldReportPath() {
		return oldReportPath;
	}
	public void setOldReportPath(String oldReportPath) {
		this.oldReportPath = oldReportPath;
	}
	public String getLocalPath() {
		return localPath;
	}
	public void setLocalPath(String localPath) {
		this.localPath = localPath;
	}
	public String getTemplatePath() {
		return templatePath;
	}
	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getCheckInfo() {
		return checkInfo;
	}
	public void setCheckInfo(String checkInfo) {
		this.checkInfo = checkInfo;
	}
}
