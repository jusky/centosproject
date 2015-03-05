package com.whu.web.email;

public class RecvMailInfo {

	//编号
	private String id;
	//发送人姓名
	private String sendName;
	//接收者
	private String recvName;
	//抄送人
	private String csName;
	//附件
	private String accessory;
	//主题
	private String title;
	//正文
	private String content;
	//暗送人
	private String asName;
	//接收时间
	private String recvTime;
	//发送时间
	private String sendTime;
	//是否已读
	private String isRead;
	//是否需要回执
	private String needReply;
	//邮件的唯一标示
	private String emailID;
	public String getEmailID() {
		return emailID;
	}
	public void setEmailID(String emailID) {
		this.emailID = emailID;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getAsName() {
		return asName;
	}
	public void setAsName(String asName) {
		this.asName = asName;
	}
	public String getRecvTime() {
		return recvTime;
	}
	public void setRecvTime(String recvTime) {
		this.recvTime = recvTime;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getIsRead() {
		return isRead;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	public String getNeedReply() {
		return needReply;
	}
	public void setNeedReply(String needReply) {
		this.needReply = needReply;
	}
}
