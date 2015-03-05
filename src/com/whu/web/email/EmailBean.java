package com.whu.web.email;

public class EmailBean {
	//编号
	private String ID;
	//账户名称
	private String accountName;
	//邮箱类型:pop3类型、
	private String mailBoxType;
	//邮箱地址
	private String mailBoxAddress;
	//邮箱密码
	private String mailBoxPwd;
	//smtp主机
	private String smtpPC;
	//smtp端口
	private String smtpPort;
	//pop主机
	private String popPC;
	//pop端口
	private String popPort;
	//是否默认
	private String isDefault;
	public String getID() {
		return ID;
	}
	public void setID(String id) {
		ID = id;
	}
	public String getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getMailBoxType() {
		return mailBoxType;
	}
	public void setMailBoxType(String mailBoxType) {
		this.mailBoxType = mailBoxType;
	}
	public String getMailBoxAddress() {
		return mailBoxAddress;
	}
	public void setMailBoxAddress(String mailBoxAddress) {
		this.mailBoxAddress = mailBoxAddress;
	}
	public String getMailBoxPwd() {
		return mailBoxPwd;
	}
	public void setMailBoxPwd(String mailBoxPwd) {
		this.mailBoxPwd = mailBoxPwd;
	}
	public String getSmtpPC() {
		return smtpPC;
	}
	public void setSmtpPC(String smtpPC) {
		this.smtpPC = smtpPC;
	}
	public String getSmtpPort() {
		return smtpPort;
	}
	public void setSmtpPort(String smtpPort) {
		this.smtpPort = smtpPort;
	}
	public String getPopPC() {
		return popPC;
	}
	public void setPopPC(String popPC) {
		this.popPC = popPC;
	}
	public String getPopPort() {
		return popPort;
	}
	public void setPopPort(String popPort) {
		this.popPort = popPort;
	}
}
