package com.whu.web.email;

import java.util.List;

public class EmailInfo {

	//发送人姓名
	private String sendName;
	//接收人姓名
	private String recvName;
	//抄送姓名
	private String csName;
	//附件
	private String accessory;
	//标题
	private String title;
	//内容
	private String content;
	
	//向鉴定专家发送邮件时，保存的用户名和密码
	private String loginName;
	private String password;
	private List attachList = null;
	public List getAttachList() {
		return attachList;
	}
	public void setAttachList(List attachList) {
		this.attachList = attachList;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public String getRecvName() {
		return recvName;
	}
	public void setRecvName(String recvName) {
		this.recvName = recvName;
	}
	public String getCsName() {
		return csName;
	}
	public void setCsName(String csName) {
		this.csName = csName;
	}
	public String getAccessory() {
		return accessory;
	}
	public void setAccessory(String accessory) {
		this.accessory = accessory;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
