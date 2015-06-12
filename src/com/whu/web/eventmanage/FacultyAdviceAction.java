/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.eventmanage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import net.sf.json.JSONObject;

import com.whu.tools.DBTools;
import com.whu.tools.SystemConstant;
import com.whu.web.common.SystemShare;
import com.whu.tools.POIHWPFHelper;

/** 
 * MyEclipse Struts
 * Creation date: 01-16-2015
 * 
 * XDoclet definition:
 * 
 */
public class FacultyAdviceAction extends DispatchAction {
	/*
	 * Generated Methods
	 */

	
	/*
	 *  save
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		FacultyAdviceForm facultyAdviceForm = (FacultyAdviceForm) form;
		String facultyId = request.getParameter("faculty.zzID");
		String facultyName = request.getParameter("faculty.zzName");
		String advice = facultyAdviceForm.getAdvice();
		String reportId = facultyAdviceForm.getReportId();
		String id = facultyAdviceForm.getId();
		String time = facultyAdviceForm.getTime();
		String isEdit = facultyAdviceForm.getIsEdit();
		
		String sql = "";
		String[] params = new String[0];
		if ( isEdit != null && isEdit.equals("0")) { // new advice
			sql = "insert into TB_FACULTYADVICE(REPORTID,FACULTYID,ISFK,FKTIME,ADVICE) values(?, ?, ?, ?, ?)";
			params = new String[]{reportId, facultyId, "1", time, advice};
		} else if (isEdit != null && isEdit.equals("1")){
			sql = "update TB_FACULTYADVICE set FKTIME=?, ADVICE=? where ID=?";
			params = new String[]{time, advice, id};
		}
		
		DBTools dbTools = new DBTools();
		boolean result = dbTools.insertItem(sql, params);


		String createName = (String)request.getSession().getAttribute("UserName");
		if(result)
		{
			String describe = SystemShare.GetNowTime("yyyy-MM-dd") + "," + createName + "   编辑学部意见";
			//插入处理过程到数据库中
			result = dbTools.InsertHandleProcess(reportId, createName, SystemConstant.HP_FACULTYADVICE, SystemConstant.SS_SURVEYING, SystemConstant.LCT_FACULTY, describe);
			
			if(isEdit != null && isEdit.equals("0")) {
				// insert into surveyReport
				String dcbgPath = request.getSession().getServletContext().getRealPath("/") + "/attachment/" + dbTools.querySingleData("TB_SURVEYREPORT", "FILENAME", "REPORTID", reportId);

				advice = facultyName + "：\r\n\t" +  advice + "\r\n";
				new POIHWPFHelper().fillBookmark("facultyAdvice", advice, dcbgPath);
				
			}
			
			//写入日志文件
			dbTools.insertLogInfo(createName, SystemConstant.LOG_FACULTYADVICE, "编辑学部意见，事件编号为：" + reportId, request.getRemoteAddr());
		
			//更新事件的最近一次操作时间
			result = dbTools.UpdateLastTime(reportId);
		}
		
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(result)
		{
			//防止高级检索功能模块执行
			request.getSession().setAttribute("GjSearch", "false");
			json.put("statusCode", 200);
			json.put("message", "保存成功！");
		//	json.put("callbackType", "closeCurrent");
			json.put("navTabId", "addFacultyAdvice");
		}
		else
		{
			json.put("statusCode", 300);
			json.put("message", "保存失败！");
		}

		out.write(json.toString());
		out.flush();
		out.close();
		return null;
	}
	
	public ActionForward handleUpFaculty(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String reportId = request.getParameter("reportId");
		
		DBTools dbTools = new DBTools();
		String facultys = dbTools.querySingleData("TB_REPORTINFO", "FACULTY", "REPORTID", reportId);
		String[] facultyArray = facultys.split(",");
		boolean result = false;
		
		String surveyReport = dbTools.querySingleData("TB_SURVEYREPORT", "FILENAME", "REPORTID", reportId);
		String isHandled = dbTools.querySingleData("TB_FACULTYADVICE", "ID", "REPORTID", reportId);
		
		//工作提醒类型
		String msgType = SystemConstant.MSG_XBYJ;
		String sendTime = SystemShare.GetNowTime("yyyy-MM-dd HH:mm:ss");
		String checkTime = SystemShare.GetNowTime("yyyy-MM-dd");
		String isHandle = "0";
		String isNotify = "1";
		
		if(!surveyReport.equals("") && isHandled.equals("")) {
			result = dbTools.insertFacultyAdvice(reportId, facultyArray);
		}
		String createName = (String)request.getSession().getAttribute("UserName");
		String facultyUsers = dbTools.queryUserByZZName(facultys);
		if(result)
		{
			try {
				// 工作提醒
				result = dbTools.saveMsgNotify(createName, facultyUsers.split(","), reportId, sendTime, msgType, isHandle, isNotify);
				//写入日志文件
				dbTools.insertLogInfo(createName, SystemConstant.LOG_HANDLEUPFACULTY, "提交学部,事件编号为：" + reportId, request.getRemoteAddr());
			
				//更新事件的最近一次操作时间
				result = dbTools.UpdateLastTime(reportId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		

		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if (result) {
			json.put("statusCode", 200);
			json.put("message", "提交 " + facultys + " 成功！");
			json.put("navTabId", "addFacultyAdvice");
		} else {
			json.put("statusCode", 300);
			json.put("message", "提交失败！");
			if(!isHandled.equals(""))
				json.put("message", "提交失败！ 已提交,请勿重新提交");
			if(surveyReport.equals("")) 
				json.put("message", "提交失败！请先保存调查报告");
		}
		
		out.write(json.toString());
		out.flush();
		out.close();
		return null;
	}
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response ) throws IOException  {
		response.setContentType("html/text;charset=utf-8");
		
		String id = request.getParameter("id");
		String sql = "";
		if( id != null && !id.equals("")) {
			sql = "delete from TB_FACULTYADVICE where ID=?";
		}
		boolean result = new DBTools().insertItem(sql, new String[]{id});	

		PrintWriter out = response.getWriter(); 
		JSONObject json = new JSONObject();
		if (result) {
			json.put("statusCode", 200);
			json.put("message", "删除成功！");
			//json.put("callbackType", "closeCurrent");
			json.put("navTabId", "addFacultyAdvice");
		} else {
			json.put("statusCode", 300);
			json.put("message", "删除失败！");
		}
		
		out.write(json.toString());
		out.flush();
		out.close();
		return null;
	}
};