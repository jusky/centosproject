package com.whu.web.eventbean;
/**
 * 专家鉴定意见
 * @author Administrator
 *
 */
public class ExpertAdvice {

	private String id;
	//专家姓名
	private String expertName;
	//鉴定日期
	private String time;
	//鉴定结论
	private String conclusion;
	//鉴定意见
	private String advice;
	private String attachName;
	private String isFK;
	private String isEmail;
	public String getIsEmail() {
		return isEmail;
	}
	public void setIsEmail(String isEmail) {
		this.isEmail = isEmail;
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
	public String getConclusion() {
		return conclusion;
	}
	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getExpertName() {
		return expertName;
	}
	public void setExpertName(String expertName) {
		this.expertName = expertName;
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
