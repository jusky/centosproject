/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.email;

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
import com.whu.web.common.SystemShare;
import com.whu.web.user.WYBean;
import com.whu.web.user.WyManageForm;

/** 
 * MyEclipse Struts
 * Creation date: 07-20-2014
 * 
 * XDoclet definition:
 * @struts.action path="/addressBookAction" name="addressBookForm" parameter="method" scope="request" validate="true"
 */
public class AddressBookAction extends DispatchAction {
	/*
	 * Generated Methods
	 */

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		AddressBookForm addressBookForm = (AddressBookForm)form;
		String loginName = (String)request.getSession().getAttribute("LoginName");
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null) {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		// String sql = "select ID,CONNAME,CONADDR from TB_CONTACT where LOGINNAME='" + loginName + "' or LOGINNAME='committee' or LOGINNAME='expert'";
		String sql = "select ID,CONNAME,CONADDR from TB_CONTACT where LOGINNAME=? or LOGINNAME='committee' or LOGINNAME='expert'";
		String[] params = new String[]{loginName};
		request.getSession().setAttribute("queryAddrSql", sql);
		request.getSession().setAttribute("queryAddrParams", params);
		
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryAddrList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			addressBookForm.setRecordNotFind("false");
			addressBookForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			addressBookForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		String loginName = (String)request.getSession().getAttribute("LoginName");
		AddressBookForm addressBookForm = (AddressBookForm)form;
		String operation = request.getParameter("operation");
		
		CheckPage pageBean = new CheckPage();
		String sql = "";
		String[] params = null;
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (operation.equalsIgnoreCase("search")) {
			String addrName = addressBookForm.getAddrName();
			params = new String[]{loginName};
			String temp = "";
			if(addrName != null && !addrName.equals(""))
			{
			//	temp += " and CONNAME like '%" + addrName + "%'";
				temp += " and CONNAME like ?";
				addrName = "%" + addrName + "%";
				params = new String[]{loginName , addrName};
			}
			sql = "select ID,CONNAME,CONADDR from TB_CONTACT where (LOGINNAME=? or LOGINNAME='committee' or LOGINNAME='expert') " + temp;
			// sql = "select ID,CONNAME,CONADDR from TB_CONTACT where (LOGINNAME='" + loginName + "' or LOGINNAME='committee' or LOGINNAME='expert') " + temp;
			request.getSession().setAttribute("queryAddrSql", sql);
			request.getSession().setAttribute("queryAddrParams", params);
		}
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryAddrSql");
			params = (String[])request.getSession().getAttribute("queryAddrParams");
			if (request.getParameter("pageNum") != null && request.getParameter("pageNum") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("pageNum"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryAddrList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			addressBookForm.setRecordNotFind("false");
			addressBookForm.setRecordList(result);
			
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			addressBookForm.setRecordNotFind("true");
			
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	public ActionForward configADDR(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		AddressBookForm addressBookForm = (AddressBookForm)form;
		String type = request.getParameter("type");
		ContactBean contactBean = new ContactBean();
		boolean flag = false;
		DBTools dbTools = new DBTools();
		if(type.equals("new"))
		{
			flag = true;
		}
		else if(type.equals("edit"))
		{
			String id = request.getParameter("uid");
			// String sql = "select * from TB_CONTACT where ID='" + id + "'";
			String sql = "select * from TB_CONTACT where ID=?";
			contactBean = dbTools.queryAddrBean(sql, new String[]{id});
			if(contactBean != null)
			{
				request.setAttribute("addrID", contactBean.getId());
			}
			else
			{
				flag = true;
			}
		}
		if(flag)
		{
			contactBean = new ContactBean();
			request.setAttribute("addrID", "");
			contactBean.setId("");
			contactBean.setContactName("");
			contactBean.setContactAddr("");
		}
		ArrayList list = new ArrayList();
		list.add(contactBean);
		addressBookForm.setRecordList(list);
		return mapping.findForward("configADDR");
	}
	public ActionForward saveADDR(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		AddressBookForm addressBookForm = (AddressBookForm)form;
		String loginName = (String)request.getSession().getAttribute("LoginName");
		String addrID = request.getParameter("addrID");
		String addrName = addressBookForm.getAddrName();
		String mailAddr = addressBookForm.getEmailAddr();
		DBTools dbTools = new DBTools();
		String sql = "";
		if(addrID==null||addrID.equals(""))//新增
		{
			sql = "insert into TB_CONTACT(LOGINNAME,CONNAME,CONADDR) values(?,?,?)";
		//	sql = "insert into TB_CONTACT(LOGINNAME,CONNAME,CONADDR) values('" + loginName + "','" + addrName + "','" + mailAddr + "')";
		}
		else
		{
			sql = "update TB_CONTACT set LOGINNAME=?, CONNAME=?, CONADDR=?";
		//	sql = "update TB_CONTACT set LOGINNAME='" + loginName + "',CONNAME='" + addrName + "',CONADDR='" + mailAddr + "' where ID='" + addrID + "'";
		}
		boolean result = dbTools.insertItem(sql, new String[]{loginName, addrName, mailAddr});
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
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");

		boolean result = false;
		String ids = request.getParameter("ids");
		DBTools dbTool = new DBTools();
		if(ids == null || ids.equals(""))
		{
			String uid = request.getParameter("uid");
			result = dbTool.deleteItemReal(uid, "TB_CONTACT", "ID");
		}
		else
		{
			String[] arrID = ids.split(",");
			result = dbTool.deleteItemsReal(arrID, "TB_CONTACT", "ID");
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
	public ActionForward export(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DBTools db = new DBTools();
		
		String sql = (String)request.getSession().getAttribute("queryAddrSql");
		String[] params= (String[])request.getSession().getAttribute("queryAddrParams");
		try
		{
			String fname = "addressList";
			OutputStream os = response.getOutputStream();
			response.reset();
			response.setHeader("Content-disposition", "attachment;filename=" + fname + ".xls");
			response.setContentType("application/msexcel");
			ResultSet rs = db.queryRsList(sql, params);
			rs.last();
			int length = rs.getRow();
			rs.beforeFirst();
			ArrayList result = db.queryAddrList(rs, length);
			ExcelTools et = new ExcelTools();
			//et.createSheet(rs, os);
			String sheetName = "联系人信息表";
			ArrayList titleList = new ArrayList();
			titleList.add("序号");
			titleList.add("联系人姓名");
			titleList.add("邮箱地址");
			et.createEventSheet(result, os, sheetName,6, titleList);
			rs.close();
		}
		catch(Exception e)
		{
			DebugLog.WriteDebug(e);
		}
		return null;
	}
}