package com.whu.web.eventbean;
/**
 * 处理决定
 * @author Administrator
 *
 */
public class HandleDecide {

	private String id;
	private String handleName;
	private String conference;
	private String handleTime;
	private String decideContent;
	private String reportID;
	private String serialNum;
	private String filePath;
	private String attachName;
	private String deptName;
	private String shortInfo;
	private String xuhao;
	//撤销项目（基金号）
	private String fundNum;
	private String fundNumRecover;
	//取消申请资格年限
	private String applicantQualificationsYear;
	private String repealYearStart;
	private String repealYearEnd;
	//通报批评or内部通报批评or书面警告or谈话提醒
	private String radioChoose;
	
	public String getRadioChoose() {
		return radioChoose;
	}
	public void setRadioChoose(String radioChoose) {
		this.radioChoose = radioChoose;
	}
	
	public String getApplicantQualificationsYear() {
		return applicantQualificationsYear;
	}
	public void setApplicantQualificationsYear(String applicantQualificationsYear) {
		this.applicantQualificationsYear = applicantQualificationsYear;
	}
	
	public String getrepealYearStart() {
		return repealYearStart;
	}
	public void setrepealYearStart(String repealYearStart) {
		this.repealYearStart = repealYearStart;
	}
	
	public String getrepealYearEnd() {
		return repealYearEnd;
	}
	public void setrepealYearEnd(String repealYearEnd) {
		this.repealYearEnd = repealYearEnd;
	}
	
	public String getfundNumRecover() {
		return fundNumRecover;
	}
	public void setfundNumRecover(String fundNumRecover) {
		this.fundNumRecover = fundNumRecover;
	}
	
	public String getFundNum() {
		return fundNum;
	}
	public void setFundNum(String fundNum) {
		this.fundNum = fundNum;
	}
	
	public String getXuhao() {
		return xuhao;
	}
	public void setXuhao(String xuhao) {
		this.xuhao = xuhao;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getShortInfo() {
		return shortInfo;
	}
	public void setShortInfo(String shortInfo) {
		this.shortInfo = shortInfo;
	}
	public String getAttachName() {
		return attachName;
	}
	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHandleName() {
		return handleName;
	}
	public void setHandleName(String handleName) {
		this.handleName = handleName;
	}
	public String getConference() {
		return conference;
	}
	public void setConference(String conference) {
		this.conference = conference;
	}
	public String getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(String handleTime) {
		this.handleTime = handleTime;
	}
	public String getDecideContent() {
		return decideContent;
	}
	public void setDecideContent(String decideContent) {
		this.decideContent = decideContent;
	}
}
