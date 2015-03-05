package com.whu.web.eventbean;
/**
 * 依托单位意见
 * @author Administrator
 *
 */
public class DeptAdvice {

	//编号
	private String id;
	//依托单位名称
	private String dept;
	//提交时间
	private String time;
	//处理意见
	private String advice;
	private String attachName;
	private String isFK;
	private String expertAdvice;
	private String serialNum;
	//是否新增调查函
	private String isLetter;
	public String getIsLetter() {
		return isLetter;
	}
	public void setIsLetter(String isLetter) {
		this.isLetter = isLetter;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getExpertAdvice() {
		return expertAdvice;
	}
	public void setExpertAdvice(String expertAdvice) {
		this.expertAdvice = expertAdvice;
	}
	public String getIsFK() {
		return isFK;
	}
	public void setIsFK(String isFK) {
		this.isFK = isFK;
	}
	public String getAttachName() {
		return attachName;
	}
	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getAdvice() {
		return advice;
	}
	public void setAdvice(String advice) {
		this.advice = advice;
	}
	
}
