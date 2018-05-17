package com.whu.web.expertAndDept;

import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.whu.tools.CheckPage;
import com.whu.tools.DBTools;
import com.whu.web.common.SystemShare;

public class DeptAndExpertAction  extends DispatchAction{

	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DeptAndExpertForm deptAndExpertForm = (DeptAndExpertForm) form;
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null) {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		String sql = "select * from SYS_ED_USER";
		String[] params = new String[0];
		request.getSession().setAttribute("querydeptAndExpertSql", sql);
		request.getSession().setAttribute("querydeptAndExpertParams", params);
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryDeptAndExpertList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			deptAndExpertForm.setRecordNotFind("false");
			deptAndExpertForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			deptAndExpertForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		DeptAndExpertForm deptAndExpertForm = (DeptAndExpertForm)form;
		String operation = request.getParameter("operation");
		CheckPage pageBean = new CheckPage();
		String sql = "";
		String[] params = null;
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (operation.equalsIgnoreCase("search")) {
			String loginName = deptAndExpertForm.getLoginName();
			params = new String[0];
			String temp = "";
			if(loginName != null && !loginName.equals(""))
			{
				temp += " where LOGINNAME like ?";
				loginName = "%" + loginName + "%";
				params = new String[]{ loginName};
			}
			sql = "select * from SYS_ED_USER" + temp;
			request.getSession().setAttribute("querydeptAndExpertSql", sql);
			request.getSession().setAttribute("querydeptAndExpertParams", params);
		}
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("querydeptAndExpertSql");
			params = (String[])request.getSession().getAttribute("querydeptAndExpertParams");
			if (request.getParameter("pageNum") != null && request.getParameter("pageNum") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("pageNum"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryDeptAndExpertList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			deptAndExpertForm.setRecordNotFind("false");
			deptAndExpertForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			deptAndExpertForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	public ActionForward delayTime(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		DeptAndExpertForm deptAndExpertForm = (DeptAndExpertForm)form;
		String id = request.getParameter("id");
		request.getSession().setAttribute("ID", id);
		return mapping.findForward("delayTime");
	}
	public ActionForward saveDelayTime(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		DeptAndExpertForm deptAndExpertForm =  (DeptAndExpertForm) form;
		int delayLoginTime = deptAndExpertForm.getDelayLoginTime();
		String id =(String) request.getSession().getAttribute("ID");
		DBTools db = new DBTools();
		String oldEndTime =db.querySingleData("SYS_ED_USER", "ENDTIME", "ID", id);
		SimpleDateFormat forma = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String year=oldEndTime.substring(0, 4);
		String month=oldEndTime.substring(5, 7);
		String day=oldEndTime.substring(8, 10);
		GregorianCalendar worldTime =new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month)-1,Integer.parseInt(day));
		worldTime.add(GregorianCalendar.DATE,delayLoginTime);
		Date d=worldTime.getTime();
		String valTime_string=forma.format(d);
		Date date = forma.parse(valTime_string);
		String newEndTime = forma.format(date);
		String sql = "update SYS_ED_USER set ENDTIME=? where ID=?";
		String[] params = new String[]{newEndTime, id};
		boolean result = db.insertItem(sql, params);
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(result)
		{
			json.put("statusCode", 200);
			json.put("message", "保存成功！");
			json.put("callbackType", "closeCurrent");
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
}
