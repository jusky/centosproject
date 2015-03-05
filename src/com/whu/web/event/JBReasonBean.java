package com.whu.web.event;

//举报事由
public class JBReasonBean {

	private String id;
	private String jbReason;
	private String reasonID;
	private String pID;
	public String getReasonID() {
		return reasonID;
	}
	public void setReasonID(String reasonID) {
		this.reasonID = reasonID;
	}
	public String getPID() {
		return pID;
	}
	public void setPID(String pid) {
		pID = pid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getJbReason() {
		return jbReason;
	}
	public void setJbReason(String jbReason) {
		this.jbReason = jbReason;
	}
}
