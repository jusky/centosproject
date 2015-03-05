package com.whu.web.expertAndDept;
/**
 * 该类用于保存附件名称与路径的对应关系
 * @author Administrator
 *
 */
public class UrlAndName {

	private String id;
	private String url;
	private String name;
	private String isCheck;
	public String getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
