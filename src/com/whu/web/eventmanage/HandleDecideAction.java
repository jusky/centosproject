/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.eventmanage;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.whu.tools.DBTools;
import com.whu.tools.SystemConstant;
import com.whu.web.common.SystemShare;
import com.whu.web.eventbean.HandleDecide;

/** 
 * MyEclipse Struts
 * Creation date: 01-22-2013
 * 
 * XDoclet definition:
 * @struts.action path="/handleDecideAction" name="handleDecideForm" parameter="method" scope="request" validate="true"
 */
public class HandleDecideAction extends DispatchAction {
	/*
	 * Generated Methods
	 */

	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		HandleDecideForm handleDecideForm = (HandleDecideForm)form;
		/*
		String handleName = request.getParameter("n");
		String handleTime = request.getParameter("t");
		String decideContent = request.getParameter("d");
		String conference = request.getParameter("c");
		String reportID = request.getParameter("reportID");
		String id = request.getParameter("id");
		*/
		String handleName = handleDecideForm.getHandleName();
		String handleTime = handleDecideForm.getHandleTime();
		String conference = request.getParameter("org5.conference");
		String decideContent = request.getParameter("orgd.decideContent");
		String reportID = handleDecideForm.getReportID();
		String deptName = handleDecideForm.getDeptName();
		String shortInfo = handleDecideForm.getShortInfo();
		String id = handleDecideForm.getId();
		String sql = "";
		String[] params = new String[0];
		String serialNum = "";
		
		DBTools dbTools = new DBTools();
		String attachName = (String)request.getSession().getAttribute("EventAttachName");
		if(attachName != null && !attachName.equals(""))
		{
			attachName = reportID + "/" + attachName;
			request.getSession().setAttribute("EventAttachName", "");
		}
		else
		{
			attachName = "";
		}
		
		boolean editFlag = false;
		//如果不为空，则说明是编辑
		if(id != null && !id.equals(""))
		{
			editFlag = true;
			if(attachName.equals(""))
			{
				sql = "update TB_HANDLEDECIDE set HANDLENAME=?, DEPTNAME=?, SHORTINFO=?, CONFERENCE=?,HANDLETIME=?,DECIDECONTENT=? where ID=?";
				params = new String[]{handleName, deptName, shortInfo, conference, handleTime, decideContent, id};
			}
			else
			{
				sql = "update TB_HANDLEDECIDE set HANDLENAME=?, DEPTNAME=?, SHORTINFO=?, CONFERENCE=?,HANDLETIME=?,DECIDECONTENT=?,ATTACHNAME=? where ID=?";
				params = new String[]{handleName, deptName, shortInfo, conference, handleTime, decideContent, attachName, id};
			}
			
		}
		else//如果为空，则说明是新增
		{
			editFlag = false;
			sql = "select SERIALNUM from TB_HANDLEDECIDE order by ID desc limit 1";
			//生成处理决定编号
			serialNum = SystemShare.GetSerialNum(sql, new String[0]);
			
			sql = "insert into TB_HANDLEDECIDE(REPORTID,SERIALNUM,HANDLENAME,DEPTNAME,SHORTINFO,CONFERENCE,HANDLETIME,DECIDECONTENT,FILEPATH,ATTACHNAME) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			params = new String[]{reportID, serialNum, handleName, deptName, shortInfo, conference, handleTime,decideContent,"",attachName};
		}
		
		String filePath = request.getSession().getServletContext().getRealPath("/")+"/attachment/";
		//String path1 = filePath + "temp";
		String loginName = (String)request.getSession().getAttribute("LoginName");
		String path1 = request.getSession().getServletContext().getRealPath("/") + "/temp/" + loginName + "/";
		String path2 = filePath + reportID;
		//获得服务器的IP地址路径，存放在数据库中，便于下载
		String relDirectory = "attachment" + "/";
		//将临时文件夹中的附件转存到以警情编号为目录的文件夹下
		String createName = (String)request.getSession().getAttribute("UserName");
		boolean result = SystemShare.IOCopy(path1, path2, relDirectory, createName);

		result = dbTools.insertItem(sql, params);
		
		if(result && !editFlag)
		{
			sql = "update TB_REPORTINFO set STATUS=?,LASTTIME=? where REPORTID=?";
			params = new String[]{SystemConstant.SS_HANDLEDECIDE, handleTime, reportID};
			result = dbTools.insertItem(sql, params);
			//插入处理过程到数据库中
			String describe = handleTime + "," + createName + "提交处理决定,处理决定为：" + decideContent;
			dbTools.InsertHandleProcess(reportID, createName, SystemConstant.HP_HANDLEDECIDE, SystemConstant.SS_HANDLEDECIDE, SystemConstant.LCT_CLJD, describe);
			dbTools.InsertFKInfo(reportID, SystemConstant.FK_HANDLEDECIDE, handleTime);

			//写入日志文件
			dbTools.insertLogInfo(createName, SystemConstant.LOG_HANDLEDECIDE, "编辑处理决定信息，事件编号为：" + reportID, request.getRemoteAddr());
		}
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(result)
		{
			//防止高级检索功能模块执行
			request.getSession().setAttribute("GjSearch", "false");
			json.put("statusCode", 200);
			json.put("message", "保存成功");
			//json.put("callbackType", "closeCurrent");
			json.put("navTabId", "addHandleDecide");
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
			//防止高级检索功能模块执行
			request.getSession().setAttribute("GjSearch", "false");
			json.put("statusCode", 200);
			json.put("message", "删除处理决定成功");
			json.put("navTabId", "addHandleDecide");
			//json.put("rel", "addHandleDecide");
			//json.put("callbackType", "closeCurrent");
		}
		else
		{
			json.put("statusCode", 300);
			json.put("message", "删除处理决定失败！");
		}
		out.write(json.toString());
		out.flush();
		out.close();
		
		return null;
	}
	/**
	 * 编辑处理决定文档
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public ActionForward newHDD(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		if(id.equals(""))
		{
			return null;
		}
		DBTools dbTools = new DBTools();
		String sql = "select * from TB_HANDLEDECIDE where ID=?";
		HandleDecide hd = dbTools.queryHandleDecideBean(sql, new String[]{id});
		String conference = hd.getConference();
		if(conference != null && !conference.equals(""))
		{
			String conferenceTime = dbTools.querySingleData("TB_CONFERENCE", "TIME", "MEETNAME", conference);
			request.setAttribute("conferenceTime", conferenceTime);
		}
		String tempFile = hd.getFilePath();
		
		String templatePath = "";
		String filePath = request.getSession().getServletContext().getRealPath("/")+"/attachment/";
		if(tempFile == null || tempFile.equals(""))//如果是新增，则调出模板发送到客户端
		{			
			templatePath = SystemConstant.GetServerPath() + "/web/template/cljd.doc";
			request.setAttribute("IsEdit", "0");
		}
		else//如果是编辑，则查询数据库判断上次编辑过的文件是否存在，若存在，则发送到客户端继续编辑
		{
			String tempFilePath = filePath + tempFile;
			if((new File(tempFilePath)).exists())//如果存在，则得到路径
			{
				templatePath = SystemConstant.GetServerPath() + "/attachment/" +  tempFile;
				request.setAttribute("IsEdit", "1");
			}
			else//不存在，则继续使用模板，例如：人工删除或系统出错
			{
				request.setAttribute("IsEdit", "0");
				templatePath = SystemConstant.GetServerPath() + "/web/template/cljd.doc";
			}
		}
		String userName = (String)request.getSession().getAttribute("UserName");
		//写入日志文件
		dbTools.insertLogInfo(userName, SystemConstant.LOG_HANDLEDECIDE, "编辑处理决定，事件编号为：" + hd.getReportID() + ", 处理决定编号为：" + hd.getSerialNum(), request.getRemoteAddr());

		request.setAttribute("ServerPath", SystemConstant.GetServerPath());
		request.setAttribute("templatePath", templatePath);
		request.setAttribute("HandleDecide", hd);
		return mapping.findForward("handleDecide");
	}
}