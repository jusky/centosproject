package com.whu.web.event;

import java.util.List;

public class EventBean {

	//流水号
	private String id;
	//举报信息编号
	private String reportID;
	//举报人姓名
	private String reportName;
	//编号
	private String serialNum;
	//办公电话
	private String gdPhone;
	//邮箱地址
	private String mailAddress;
	//举报时间
	private String reportTime;
	//举报人联系方式
	private String telPhone;
	//当前状态̬
	private String status;
	//被举报人姓名
	private String beReportName;
	//举报人单位
	private String dept;
	//举报方式
	private String reportType;
	//举报事由
	private String reportReason;
	//举报内容
	private String reportContent;
	//创建时间
	private String createTime;
	//录入者
	private String createName;
	//是否删除，1删除，0未删除
	private String isDelete;
	//备注
	private String bz;
	//附件路径
	private String accessory;
	//被举报人列表
	private List beReportList = null;
	//是否匿名
	private String isNI;
	//查询码
	private String searchID;
	//所属学部
	private String faculty;
	
	//查办人员
	private String officer;
	
	public String getAccessory() {
		return accessory;
	}
	public void setAccessory(String accessory) {
		this.accessory = accessory;
	}
	public String getFaculty() {
		return faculty;
	}
	public void setFaculty(String faculty) {
		this.faculty = faculty;
	}
	public String getSearchID() {
		return searchID;
	}
	public void setSearchID(String searchID) {
		this.searchID = searchID;
	}
	public String getIsNI() {
		return isNI;
	}
	public void setIsNI(String isNI) {
		this.isNI = isNI;
	}
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
	
	public List getBeReportList() {
		return beReportList;
	}
	public void setBeReportList(List beReportList) {
		this.beReportList = beReportList;
	}
	public String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReportID() {
		return reportID;
	}
	public void setReportID(String reportID) {
		this.reportID = reportID;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getGdPhone() {
		return gdPhone;
	}
	public void setGdPhone(String gdPhone) {
		this.gdPhone = gdPhone;
	}
	public String getMailAddress() {
		return mailAddress;
	}
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}
	public String getReportTime() {
		return reportTime;
	}
	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}
	public String getTelPhone() {
		return telPhone;
	}
	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getBeReportName() {
		return beReportName;
	}
	public void setBeReportName(String beReportName) {
		this.beReportName = beReportName;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getReportType() {
		return reportType;
	}
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}
	public String getReportReason() {
		return reportReason;
	}
	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getCreateName() {
		return createName;
	}
	public void setCreateName(String createName) {
		this.createName = createName;
	}
	public String getOfficer() {
		return officer;
	}
	public void setOfficer( String officer) {
		this.officer = officer;
	}
}
