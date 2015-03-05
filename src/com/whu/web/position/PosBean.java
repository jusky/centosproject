package com.whu.web.position;

public class PosBean {
	private String id;
	private String posName;
	private String posDescribe;
	private String serialNum;
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
	public String getPosName() {
		return posName;
	}
	public void setPosName(String posName) {
		this.posName = posName;
	}
	public String getPosDescribe() {
		return posDescribe;
	}
	public void setPosDescribe(String posDescribe) {
		this.posDescribe = posDescribe;
	}

}
