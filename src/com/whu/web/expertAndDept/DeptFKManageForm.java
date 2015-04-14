package com.whu.web.expertAndDept;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;
import org.apache.struts.validator.ValidatorForm;

/** 
 * MyEclipse Struts
 * Creation date: 05-21-2014
 * 
 * XDoclet definition:
 * @struts.form name="deptFKForm"
 */
public class DeptFKManageForm extends ValidatorForm {
	/*
	 * Generated Methods
	 */
	private String reportID;
	private String adviceID;
	
	public String getReportID() {
		return reportID;
	}

	public void setReportID(String reportID) {
		this.reportID = reportID;
	}

	public String getAdviceID() {
		return adviceID;
	}

	public void setAdviceID(String adviceID) {
		this.adviceID = adviceID;
	}

	private String recordNotFind = "false";
	private List recordList = null;
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

	/** 
	 * Method validate
	 * @param mapping
	 * @param request
	 * @return ActionErrors
	 */
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	/** 
	 * Method reset
	 * @param mapping
	 * @param request
	 */
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		// TODO Auto-generated method stub
	}
}