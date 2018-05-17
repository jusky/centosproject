package com.whu.web.eventbean;
/**
 * 分析结论
 * @author Administrator
 *
 */
public class TreatmentSuggestion {

	//编号
	private String id;
	//事件编号
	private String reportid;
	//办公人员
	private String workername;
	//时间
	private String time;
	//内容
	private String content;
	//附件
	private String attachname;
	
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	
	public String getReportid() {
		return reportid;
	}
	public void setReportid(String reportid) {
		this.reportid = reportid;
	}
	
	public String getWorkername() {
		return workername;
	}
	public void setWorkername(String workername) {
		this.workername = workername;
	}
	
	public String getTime()
	{
		return time;
	}
	public void setTime(String time)
	{
		this.time = time;
	}
	
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getAttachname() {
		return attachname;
	}
	public void setAttachname(String attachname) {
		this.attachname = attachname;
	}
	

}
