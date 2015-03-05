package com.whu.web.zuzhi;

public class ZZBean {
	//编号
	private String id;
	//组织编号
	private String zzID;
	//组织美女搞成
	private String zzName;
	//组织说明
	private String zzDescribe;
	//是否有下属组织
	private String isJC;
	//上级组织编号
	private String pzzID;
	//上级组织名称
	private String pzzName;
	public String getPzzName() {
		return pzzName;
	}
	public void setPzzName(String pzzName) {
		this.pzzName = pzzName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getZzID() {
		return zzID;
	}
	public void setZzID(String zzID) {
		this.zzID = zzID;
	}
	public String getZzName() {
		return zzName;
	}
	public void setZzName(String zzName) {
		this.zzName = zzName;
	}
	public String getZzDescribe() {
		return zzDescribe;
	}
	public void setZzDescribe(String zzDescribe) {
		this.zzDescribe = zzDescribe;
	}
	public String getIsJC() {
		return isJC;
	}
	public void setIsJC(String isJC) {
		this.isJC = isJC;
	}
	public String getPzzID() {
		return pzzID;
	}
	public void setPzzID(String pzzID) {
		this.pzzID = pzzID;
	}
}
