/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.event;

import java.io.File;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.whu.tools.CheckPage;
import com.whu.tools.DBTools;
import com.whu.tools.DebugLog;
import com.whu.tools.ExcelTools;
import com.whu.tools.SystemConstant;
import com.whu.web.common.DocConverter;
import com.whu.web.common.SystemShare;
import com.whu.web.eventbean.AttachmentBean;
import com.whu.web.eventbean.HandleDecide;


/** 
 * MyEclipse Struts
 * Creation date: 03-12-2014
 * 
 * XDoclet definition:
 * @struts.action path="/cljdManageAction" name="cljdManageForm" parameter="method" scope="request" validate="true"
 */
public class CljdManageAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		CljdManageForm cljdManageForm = (CljdManageForm) form;
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;// 
		int rowsPerPage = 20;// 
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null && request.getParameter("queryPageNo") != "") {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		String sql = "select * from TB_HANDLEDECIDE order by ID desc";
		request.getSession().setAttribute("queryCljdSql", sql);
		pageBean.setQuerySql(sql);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryCljdList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			cljdManageForm.setRecordNotFind("false");
			cljdManageForm.setRecordList(result);
			
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			cljdManageForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		//根据阶段的不同跳转到不同的页面
		return mapping.findForward("init");
	}
	/**
	 * 查询和分页
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		CljdManageForm cljdManageForm = (CljdManageForm) form;
		String operation = request.getParameter("operation");

		CheckPage pageBean = new CheckPage();
		String sql = "";
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);

		if (operation.equalsIgnoreCase("search") || operation.equalsIgnoreCase("select")) {
			String serialNum = cljdManageForm.getSerialNum();
			String handleName = cljdManageForm.getHandleName();
			String beginTime = cljdManageForm.getHandleBeginTime();
			String endTime = cljdManageForm.getHandleEndTime();
			String conference = cljdManageForm.getConference();
			String temp = "";
			if(!serialNum.equals(""))
			{
				temp += " and SERIALNUM='" + serialNum + "' ";
			}
			if(!handleName.equals(""))
			{
				temp += " and HANDLENAME like '%" + handleName + "%'";
			}
			if(!conference.equals(""))
			{
				temp += " and CONFERENCE like '%" + conference + "%' ";
			}
			if(!beginTime.equals(""))
			{
				temp += " and HANDLETIME >= '" + beginTime + "'";
			}
			if(!endTime.equals(""))
			{
				temp += " and HANDLETIME <= '" + endTime + "'";
			}
			sql = "select * from TB_HANDLEDECIDE where 1=1 " + temp + " order by ID desc";
			request.getSession().setAttribute("queryCljdSql", sql);
		}
		
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryCljdSql");
			if (request.getParameter("currentPage") != null && request.getParameter("currentPage") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("currentPage"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryCljdList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			cljdManageForm.setRecordNotFind("false");
			cljdManageForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			cljdManageForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String ids = request.getParameter("ids");
		DBTools dbTool = new DBTools();
		
		boolean result = true;
		if(ids == null || ids == "")
		{
			String id = request.getParameter("id");
			String dirPath = request.getSession().getServletContext().getRealPath("/");
			String sql = "select * from TB_HANDLEDECIDE where ID=" + id;
			HandleDecide hd = dbTool.queryHandleDecideBean(sql);
			if(hd != null)
			{
				String filePath = hd.getFilePath();
				if(filePath != null && !filePath.equals(""))
				{
					//删除处理决定文档
					filePath = dirPath + "/attachment/" + filePath;
					result = SystemShare.deleteFileFromDisk(filePath);
					//如果存在swf文件，则也一起删除
					filePath = filePath.substring(0, filePath.lastIndexOf("."));
					filePath = filePath + ".swf";
					result = SystemShare.deleteFileFromDisk(filePath);
				}
			}
			result = dbTool.deleteItemReal(id, "TB_HANDLEDECIDE", "ID");
		}
		else
		{
			String[] arrID = ids.split(",");
			result = dbTool.deleteItemsReal(arrID, "TB_HANDLEDECIDE", "ID");
		}
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(result)
		{
			json.put("statusCode", 200);
			json.put("message", "删除成功！");
		}
		else
		{
			json.put("statusCode", 300);
			json.put("message", "删除失败！");
		}
		out.write(json.toString());
		out.flush();
		out.close();
		
		return null;
	}
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String sql = "";
		
		DBTools dbTools = new DBTools();
		sql = "select * from TB_HANDLEDECIDE where ID=" + id;
		HandleDecide hd = dbTools.queryHandleDecideBean(sql);
		String conference = hd.getConference();
		if(conference != null && !conference.equals(""))
		{
			String conferenceTime = dbTools.querySingleDate("TB_CONFERENCE", "TIME", "MEETNAME", conference);
			request.setAttribute("conferenceTime", conferenceTime);
		}
		
		String templatePath = "";
		String filePath = request.getSession().getServletContext().getRealPath("/")+"/attachment/";
		String docPath = dbTools.querySingleDate("TB_HANDLEDECIDE", "FILEPATH", "ID", id);
		if(docPath != null && !docPath.equals(""))
		{
			String tempFilePath = filePath + docPath;
			if((new File(tempFilePath)).exists())//如果存在，则得到路径
			{
				templatePath = SystemConstant.GetServerPath() + "/attachment/" +  docPath;
				request.setAttribute("IsEdit", "1");
			}
			else//不存在，则继续使用模板，例如：人工删除或系统出错
			{
				request.setAttribute("IsEdit", "0");
				templatePath = SystemConstant.GetServerPath() + "/web/template/cljd.doc";
			}
		}
		else
		{
			request.setAttribute("IsEdit", "0");
			templatePath = SystemConstant.GetServerPath() + "/web/template/cljd.doc";
		}
		request.setAttribute("ServerPath", SystemConstant.GetServerPath());
		request.setAttribute("templatePath", templatePath);
		request.setAttribute("HandleDecide", hd);
		return mapping.findForward("edit");
	}
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String sql = "";
		
		DBTools dbTools = new DBTools();
		sql = "select * from TB_HANDLEDECIDE where ID=" + id;
		HandleDecide hd = dbTools.queryHandleDecideBean(sql);
		String reportID = hd.getReportID();
		String dirPath = request.getSession().getServletContext().getRealPath("/")+"/attachment/" + reportID;
		File files = new File(dirPath);
		if(!files.isDirectory()){
			return null;
		}
		File[] fileList = files.listFiles();  //目录中的所有文件
		String extName = "";
		String fileName = "";
		String swfName = "";
		int i = 0;
		try
		{
	        for(File file : fileList){
	                  if(!file.isFile())   //判断是不是文件
	                  continue;
	                  fileName = file.getName();
	                  String fileName1 = fileName.substring(0, fileName.lastIndexOf(".")); 
	                  extName = fileName.substring(fileName.lastIndexOf(".")+1);  
	                  if(!extName.equals("swf"))//swf文件为预览时的文件
	                  {
	                	  if(SystemShare.ISDoc(extName))
			               {
	                		  swfName = dirPath + "/" + fileName1 + ".swf";
	                		  File swfFile = new File(swfName);
	                		  if(!swfFile.exists())//如果不存在，则生成swf文件
	                		  {
					              String converfilename = dirPath +"/"+fileName; 
					              DocConverter d = new DocConverter(converfilename);
					              d.conver();  
	                		  }
			               }
	                  }
	        }
	        request.getSession().setAttribute("reportID", reportID);
	        String filePath = hd.getFilePath();
	        //得到 处理决定路径  20120000000000/关于XXX的处理决定.doc
	        //去掉事件编号
	        filePath = filePath.substring(filePath.lastIndexOf("/")+1);
	        //去掉后缀名
	        filePath = filePath.substring(0, filePath.lastIndexOf("."));
	        request.setAttribute("fileName", filePath);
		}
		catch (Exception e) {
			e.printStackTrace();
			DebugLog.WriteDebug(e);
		}
		return mapping.findForward("detail");
	}
	/**
	 * 导出处理决定列表
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward export(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DBTools db = new DBTools();
		
		String sql = (String)request.getSession().getAttribute("queryCljdSql");
		try
		{
			String fname = "cljdList";
			OutputStream os = response.getOutputStream();
			response.reset();
			response.setHeader("Content-disposition", "attachment;filename=" + fname + ".xls");
			response.setContentType("application/msexcel");
			ResultSet rs = db.queryRsList(sql);
			rs.last();
			int length = rs.getRow();
			rs.beforeFirst();
			ArrayList result = db.queryCljdList(rs, length);
			ExcelTools et = new ExcelTools();
			//et.createSheet(rs, os);
			String sheetName = "处理决定信息表";
			ArrayList titleList = new ArrayList();
			titleList.add("序号");
			titleList.add("编号");
			titleList.add("处理人");
			titleList.add("所属单位");
			titleList.add("会议");
			titleList.add("处理时间");
			titleList.add("处理决定");
			et.createEventSheet(result, os, sheetName,5, titleList);
			rs.close();
		}
		catch(Exception e)
		{
			System.out.println(e);
			DebugLog.WriteDebug(e);
		}
		return null;
	}
}