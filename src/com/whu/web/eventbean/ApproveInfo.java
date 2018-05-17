package com.whu.web.eventbean;

import java.util.List;

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
	//领导审核意见列表
	private List approveList = null;
	//领导批示意见
	private String headAdvice;
	//批示领导
	private String headName;
	//批示时间
	private String headTime;
	//办公人员初核意见列表
	private List checkList = null;
	private String isXY;
	
	public List getCheckList() {
		return checkList;
	}
	public void setCheckList(List checkList) {
		this.checkList = checkList;
	}
	public List getApproveList() {
		return approveList;
	}
	public void setApproveList(List approveList) {
		this.approveList = approveList;
	}
	public String getNibanAdvice() {
		return nibanAdvice;
	}
	public void setNibanAdvice(String nibanAdvice) {
		this.nibanAdvice = nibanAdvice;
	}
	public String getIsXY() {
		return isXY;
	}
	public void setIsXY(String isXY) {
		this.isXY = isXY;
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
