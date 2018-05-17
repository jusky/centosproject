package com.whu.web.expert;

public class UnLoginedExpertBean {
	//举报序号
	private String id;
	//专家姓名
	private String expertName;
	//专家账号
	private String loginName;
	//专家邮箱
	private String emailAddress;
	//编号
	private String serialNum;
	//举报人姓名
	private String repoerName;
	//被举报人姓名
	private String beReportName;
	//鉴定专家账号生成时间（也即发送邮件时间）
	private String sendEmailTime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getExpertName() {
		return expertName;
	}
	public void setExpertName(String expertName) {
		this.expertName = expertName;
	}
	
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	
	public String getRepoerName() {
		return repoerName;
	}
	public void setRepoerName(String repoerName) {
		this.repoerName = repoerName;
	}
	
	public String getBeReportName() {
		return beReportName;
	}
	public void setBeReportName(String beReportName) {
		this.beReportName = beReportName;
	}
	
	public String getSendEmailTime() {
		return sendEmailTime;
	}
	public void setSendEmailTime(String sendEmailTime) {
		this.sendEmailTime = sendEmailTime;
	}

}
