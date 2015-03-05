package com.whu.web.eventbean;
/**
 * 审核信息
 * @author Administrator
 *
 */
public class ApproveInfo {

	//拟办意见
	private String nibanAdvice;
	//拟办人
	private String nibanName;
	//拟办时间
	private String nibanTime;
	//领导批示意见
	private String headAdvice;
	//批示领导
	private String headName;
	//批示时间
	private String headTime;
	public String getNibanAdvice() {
		return nibanAdvice;
	}
	public void setNibanAdvice(String nibanAdvice) {
		this.nibanAdvice = nibanAdvice;
	}
	public String getNibanName() {
		return nibanName;
	}
	public void setNibanName(String nibanName) {
		this.nibanName = nibanName;
	}
	public String getNibanTime() {
		return nibanTime;
	}
	public void setNibanTime(String nibanTime) {
		this.nibanTime = nibanTime;
	}
	public String getHeadAdvice() {
		return headAdvice;
	}
	public void setHeadAdvice(String headAdvice) {
		this.headAdvice = headAdvice;
	}
	public String getHeadName() {
		return headName;
	}
	public void setHeadName(String headName) {
		this.headName = headName;
	}
	public String getHeadTime() {
		return headTime;
	}
	public void setHeadTime(String headTime) {
		this.headTime = headTime;
	}
	
}
