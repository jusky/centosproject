package com.whu.web.eventbean;

//专家信息
public class ExpertInfo {
	//序号
	private String serialNum;
	//编号
	private String id;
	//姓名
	private String name;
	//性别
	private String sex;
	//年龄
	private String age;
	//职称
	private String title;
	//是否博导
	private String isPHD;
	//单位
	private String dept;
	//专业
	private String specialty;
	//研究方向
	private String research;
	//联系电话
	private String phone;
	//邮箱地址
	private String email;
	//通信地址
	private String address;
	//所属学部
	private String faculty;
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getFaculty() {
		return faculty;
	}
	public void setFaculty(String faculty) {
		this.faculty = faculty;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIsPHD() {
		return isPHD;
	}
	public void setIsPHD(String isPHD) {
		this.isPHD = isPHD;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getSpecialty() {
		return specialty;
	}
	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}
	public String getResearch() {
		return research;
	}
	public void setResearch(String research) {
		this.research = research;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
