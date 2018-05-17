package com.whu.web.expert;

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

/**
 * @author root
 *
 */
public class UnLoginedExpertAction extends DispatchAction {
	
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		UnLoginedExpertForm unLoginedExpertForm = (UnLoginedExpertForm) form;
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		pageBean.setQueryPageNo(queryPageNo);
		// String sql = "select ID,CONNAME,CONADDR from TB_CONTACT where LOGINNAME='" + loginName + "' or LOGINNAME='committee' or LOGINNAME='expert'";
		String sql = "select a.SENDEMAILTIME as SENDEMAILTIME,c.REPORTID as ID,a.EXPERTNAME as EXPERTNAME,a.LOGINNAME as LOGINNAME,a.EMAILADDRESS as  EMAILADDRESS,c.SERIALNUM as SERIALNUM,c.REPORTNAME as REPORTNAME,c.BEREPORTNAME as BEREPORTNAME from TB_EXPERTEMAIL a,SYS_ED_USER b,TB_REPORTINFO c where a.LOGINNAME=b.LOGINNAME and a.REPORTID=c.REPORTID and b.ISUSE='0'";
		String[] params = new String[0];
		request.getSession().setAttribute("queryunLoginedExpertSql", sql);
		request.getSession().setAttribute("queryunLoginedExpertParams", params);
		
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryUnLoginedExpertList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			unLoginedExpertForm.setRecordNotFind("false");
			unLoginedExpertForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			unLoginedExpertForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("unLoginedExpert");
	}
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		String loginName = (String)request.getSession().getAttribute("LoginName");
		UnLoginedExpertForm unLoginedExpertForm = (UnLoginedExpertForm)form;
		String operation = request.getParameter("operation");
		
		CheckPage pageBean = new CheckPage();
		String sql = "";
		String[] params = null;
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (operation.equalsIgnoreCase("search")) {
			String expertName = unLoginedExpertForm.getExpertName();
			params = new String[0];
			String temp = "";
			if(expertName != null && !expertName.equals(""))
			{
				temp += " and a.EXPERTNAME like ?";
				expertName = "%" + expertName + "%";
				params = new String[]{ expertName};
			}
			sql = "select a.SENDEMAILTIME as SENDEMAILTIME,c.REPORTID as ID,a.EXPERTNAME as EXPERTNAME,a.LOGINNAME as LOGINNAME,a.EMAILADDRESS as  EMAILADDRESS,c.SERIALNUM as SERIALNUM,c.REPORTNAME as REPORTNAME,c.BEREPORTNAME as BEREPORTNAME from TB_EXPERTEMAIL a,SYS_ED_USER b,TB_REPORTINFO c where a.LOGINNAME=b.LOGINNAME and a.REPORTID=c.REPORTID and b.ISUSE='0' " + temp;
			request.getSession().setAttribute("queryunLoginedExpertSql", sql);
			request.getSession().setAttribute("queryunLoginedExpertParams", params);
		}
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryunLoginedExpertSql");
			params = (String[])request.getSession().getAttribute("queryunLoginedExpertParams");
			if (request.getParameter("pageNum") != null && request.getParameter("pageNum") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("pageNum"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryUnLoginedExpertList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			unLoginedExpertForm.setRecordNotFind("false");
			unLoginedExpertForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			unLoginedExpertForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("unLoginedExpert");
	}
	
	
	/**
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");

		boolean result = false;
		String loginname = request.getParameter("loginname");
		DBTools dbTool = new DBTools();
		result = dbTool.deleteItemReal(loginname, "SYS_ED_USER", "LOGINNAME");
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
