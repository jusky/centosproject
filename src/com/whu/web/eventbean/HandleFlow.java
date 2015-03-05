package com.whu.web.eventbean;

/**
 * 处理流程
 * @author Administrator
 *
 */
public class HandleFlow {

	//编号（数据库编号）
	private String id;
	//序号
	private String serialNum;
	//操作人姓名
	private String name;
	//操作时间
	private String time;
	//操作类型
	private String type;
	//事件状态
	private String status;
	//流程类型
	private String flowType;
	//描述
	private String describe;
	//是否执行到该步骤
	private String sel = "false";
	public String getFlowType() {
		return flowType;
	}
	public void setFlowType(String flowType) {
		this.flowType = flowType;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getSel() {
		return sel;
	}
	public void setSel(String sel) {
		this.sel = sel;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
