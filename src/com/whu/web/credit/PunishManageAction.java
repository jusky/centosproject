/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.credit;

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
import com.whu.web.common.SystemShare;
import com.whu.web.credit.PunishBean;
import com.whu.web.credit.PunishManageForm;

/** 
 * MyEclipse Struts
 * Creation date: 12-05-2014
 * 
 * XDoclet definition:
 * @struts.action path="/punishManageAction" name="punishManageForm" parameter="method" scope="request" validate="true"
 * @struts.action-forward name="init" path="/web/credit/punishManage.jsp"
 */
public class PunishManageAction extends DispatchAction {
	
	
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		PunishManageForm punishManageForm = (PunishManageForm)form;
		
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null) {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		String sql = "select A.ID, CODENAME, A.CODE, CAPTION, REMARK, YEAR, RATE from (select * from SYS_DATA_DIC where CODENAME='ZDBZ_CLJD') as A join SYS_CLJD_RATE as B where A.CODE=B.CODE";
		String[] params = new String[0];
		request.getSession().setAttribute("queryPunishSql", sql);
		request.getSession().setAttribute("queryPunishParams", params);
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryPunishList(rs, rowsPerPage);
				
		if(result.size() > 0)
		{
			punishManageForm.setRecordNotFind("false");
			punishManageForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			punishManageForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	
	
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		PunishManageForm punishManageForm = (PunishManageForm)form;
		String operation = request.getParameter("operation");
		CheckPage pageBean = new CheckPage();
		String sql = "";
		String[] params = new String[0];
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (operation.equalsIgnoreCase("search")) {
			String name = punishManageForm.getCaption();
			String temp = "";
			if(name != null && !name.equals(""))
			{
				temp += " and CAPTION like ?";
				params = new String[]{"%" + name + "%"};
			}
			sql = "select A.ID, CODENAME, A.CODE, CAPTION, REMARK, YEAR, RATE from (select * from SYS_DATA_DIC where CODENAME='ZDBZ_CLJD') as A join SYS_CLJD_RATE as B where A.CODE=B.CODE " + temp;
			request.getSession().setAttribute("queryPunishSql", sql);
			request.getSession().setAttribute("queryPunishParams", params);
		}
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryPunishSql");
			params = (String[])request.getSession().getAttribute("queyrPunishParams");
			if (request.getParameter("currentPage") != null && request.getParameter("currentPage") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("currentPage"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryPunishList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			punishManageForm.setRecordNotFind("false");
			punishManageForm.setRecordList(result);
			
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			punishManageForm.setRecordNotFind("true");
			
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	
	
	
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");

		boolean result = false;
		String ids = request.getParameter("ids");
		DBTools dbTool = new DBTools();
		if(ids == null || ids == "")
		{
			String uid = request.getParameter("uid");
			result = dbTool.deleteItemReal(uid, "SYS_DATA_DIC", "ID");
		}
		else
		{
			String[] arrID = ids.split(",");
			result = dbTool.deleteItemsReal(arrID, "SYS_DATA_DIC", "ID");
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
}