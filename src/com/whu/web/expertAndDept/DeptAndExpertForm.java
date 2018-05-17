package com.whu.web.expertAndDept;

import java.util.List;

import org.apache.struts.action.ActionForm;

public class DeptAndExpertForm extends ActionForm{
	private String recordNotFind = "false";
	private List recordList = null;
	private String loginName;
	private int delayLoginTime;
	
	public String getRecordNotFind() {
		return recordNotFind;
	}
	public void setRecordNotFind(String recordNotFind) {
		this.recordNotFind = recordNotFind;
	}

	public List getRecordList() {
		return recordList;
	}
	public void setRecordList(List recordList) {
		this.recordList = recordList;
	}
	
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public int getDelayLoginTime() {
		return delayLoginTime;
	}
	public void setDelayLoginTime(int delayLoginTime) {
		this.delayLoginTime = delayLoginTime;
	}
}
