/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.credit;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 12-01-2014
 * 
 * XDoclet definition:
 * @struts.form name="configIndividualForm"
 */
public class ConfigIndividualForm extends ActionForm {
	/*
	 * Generated fields
	 */

	/** id property */
	private String id;

	/** phone property */
	private String phone;

	/** title property */
	private String title;

	/** sex property */
	private String sex;

	/** isexpert property */
	private String isExpert;

	/** address property */
	private String address;

	/** email property */
	private String email;

	/** institute property */
	private String institute;

	/** name property */
	private String name;

	/** pid property */
	private String pid;

	/** specialty property */
	private String specialty;

	
	
	
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
	/*
	 * Generated Methods
	 */

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

	/** 
	 * Returns the id.
	 * @return String
	 */
	public String getId() {
		return id;
	}

	/** 
	 * Set the id.
	 * @param id The id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/** 
	 * Returns the phone.
	 * @return String
	 */
	public String getPhone() {
		return phone;
	}

	/** 
	 * Set the phone.
	 * @param phone The phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/** 
	 * Returns the title.
	 * @return String
	 */
	public String getTitle() {
		return title;
	}

	/** 
	 * Set the title.
	 * @param title The title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/** 
	 * Returns the sex.
	 * @return String
	 */
	public String getSex() {
		return sex;
	}

	/** 
	 * Set the sex.
	 * @param sex The sex to set
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/** 
	 * Returns the isexpert.
	 * @return String
	 */
	public String getIsExpert() {
		return isExpert;
	}

	/** 
	 * Set the isexpert.
	 * @param isexpert The isexpert to set
	 */
	public void setIsExpert(String isExpert) {
		this.isExpert = isExpert;
	}

	/** 
	 * Returns the address.
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/** 
	 * Set the address.
	 * @param address The address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/** 
	 * Returns the email.
	 * @return String
	 */
	public String getEmail() {
		return email;
	}

	/** 
	 * Set the email.
	 * @param email The email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/** 
	 * Returns the institute.
	 * @return String
	 */
	public String getInstitute() {
		return institute;
	}

	/** 
	 * Set the institute.
	 * @param institute The institute to set
	 */
	public void setInstitute(String institute) {
		this.institute = institute;
	}

	/** 
	 * Returns the name.
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/** 
	 * Set the name.
	 * @param name The name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/** 
	 * Returns the pid.
	 * @return String
	 */
	public String getPid() {
		return pid;
	}

	/** 
	 * Set the pid.
	 * @param pid The pid to set
	 */
	public void setPid(String pid) {
		this.pid = pid;
	}

	/** 
	 * Returns the specialty.
	 * @return String
	 */
	public String getSpecialty() {
		return specialty;
	}

	/** 
	 * Set the specialty.
	 * @param specialty The specialty to set
	 */
	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}
}