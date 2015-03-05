package com.whu.web.expertAndDept;

public class ExpertFile {

	private String id;
	//专家鉴定函文档路径
	private String jdhPath = "";
	//鉴定意见书文档路径
	private String yjsPath = "";
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getJdhPath() {
		return jdhPath;
	}
	public void setJdhPath(String jdhPath) {
		this.jdhPath = jdhPath;
	}
	public String getYjsPath() {
		return yjsPath;
	}
	public void setYjsPath(String yjsPath) {
		this.yjsPath = yjsPath;
	}
}
