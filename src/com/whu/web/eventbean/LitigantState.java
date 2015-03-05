package com.whu.web.eventbean;

/**
 * 当事人陈述
 * @author Administrator
 *
 */
public class LitigantState {
	//编号
	private String id;
	//当事人姓名
	private String litigantName;
	//陈述时间
	private String litigantTime;
	//陈述内容
	private String litigantContent;
	private String talkRecorder;
	private String filePath;
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getTalkRecorder() {
		return talkRecorder;
	}
	public void setTalkRecorder(String talkRecorder) {
		this.talkRecorder = talkRecorder;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLitigantName() {
		return litigantName;
	}
	public void setLitigantName(String litigantName) {
		this.litigantName = litigantName;
	}
	public String getLitigantTime() {
		return litigantTime;
	}
	public void setLitigantTime(String litigantTime) {
		this.litigantTime = litigantTime;
	}
	public String getLitigantContent() {
		return litigantContent;
	}
	public void setLitigantContent(String litigantContent) {
		this.litigantContent = litigantContent;
	}

}
