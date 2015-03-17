/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.user;

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
import com.whu.web.email.ContactBean;
import com.whu.web.expert.ExpertManageForm;

/** 
 * MyEclipse Struts
 * Creation date: 06-23-2014
 * 
 * XDoclet definition:
 * @struts.action path="/wyManageAction" name="wyManageForm" parameter="method" scope="request" validate="true"
 */
public class WyManageAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		WyManageForm wyManageForm = (WyManageForm)form;
		
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null) {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		String sql = "select * from TB_WYINFO";
		String[] params = new String[0];
		request.getSession().setAttribute("queryWYSql", sql);
		request.getSession().setAttribute("queryWYParams", params);
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryWYList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			wyManageForm.setRecordNotFind("false");
			wyManageForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			wyManageForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		WyManageForm wyManageForm = (WyManageForm)form;
		String operation = request.getParameter("operation");
		CheckPage pageBean = new CheckPage();
		String sql = "";
		String[] params = new String[0];
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (operation.equalsIgnoreCase("search")) {
			String wyName = wyManageForm.getWyName();
			String dept = wyManageForm.getDept();
			String temp = "";
			ArrayList<String> paramList = new ArrayList<String>();
			if(!wyName.equals(""))
			{
				temp += " and NAME like ?";
				paramList.add("%" + wyName + "%");
			}
			if(!dept.equals(""))
			{
				temp += " and DEPT like ?";
				paramList.add("%" + dept + "%");
			}
			
			sql = "select * from TB_WYINFO where 1=1 " + temp;
			params = paramList.toArray(new String[0]);
			request.getSession().setAttribute("queryWYSql", sql);
			request.getSession().setAttribute("queryWYParams", params);
		}
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryWYSql");
			params = (String[])request.getSession().getAttribute("queryWYParams");
			if (request.getParameter("currentPage") != null && request.getParameter("currentPage") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("currentPage"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryWYList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			wyManageForm.setRecordNotFind("false");
			wyManageForm.setRecordList(result);
			
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			wyManageForm.setRecordNotFind("true");
			
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
			result = dbTool.deleteItemReal(uid, "TB_WYINFO", "ID");
		}
		else
		{
			String[] arrID = ids.split(",");
			result = dbTool.deleteItemsReal(arrID, "TB_WYINFO", "ID");
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
	/**
	 * 编辑委员信息，用于跳转，新增或者编辑
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward configWY(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		WyManageForm wyManageForm = (WyManageForm)form;
		String type = request.getParameter("type");
		WYBean wyBean = new WYBean();
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
			String sql = "select * from TB_WYINFO where ID=?";
			wyBean = dbTools.queryWYBean(sql, new String[]{id});
			if(wyBean != null)
			{
				request.setAttribute("wyID", wyBean.getId());
				String addrName=wyBean.getName();
				String sqlAddr="select * from TB_CONTACT where CONNAME=? and  LOGINNAME='committee'";
				contactBean=dbTools.queryAddrBean(sqlAddr, new String[]{addrName});
				if(contactBean != null)
				{
					request.setAttribute("addrID", contactBean.getId());
					//System.out.println(contactBean.getId());
				}
				else
				{
					flag = true;
				}
			}
			else
			{
				flag = true;
			}
		}
		if(flag)
		{
			wyBean = new WYBean();
			request.setAttribute("wyID", "");
			wyBean.setId("");
			wyBean.setName("");
			wyBean.setSex("");
			wyBean.setDept("");
			wyBean.setTitle("");
			wyBean.setTxAddress("");
			wyBean.setEmail("");
			wyBean.setPhone("");
		}
		request.setAttribute("wySex", wyBean.getSex());
		ArrayList list = new ArrayList();
		list.add(wyBean);
		wyManageForm.setRecordList(list);
		return mapping.findForward("configWY");
	}
	/**
	 * 委员信息查看
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		WyManageForm wyManageForm = (WyManageForm)form;
		String id = request.getParameter("uid");
		DBTools dbTools = new DBTools();
		String sql = "select * from TB_WYINFO where ID=?";
		WYBean wyBean  = dbTools.queryWYBean(sql, new String[]{id});
		ArrayList list = new ArrayList();
		list.add(wyBean);
		wyManageForm.setRecordList(list);
		return mapping.findForward("detail");
	}
	/**
	 * 保存编辑好的委员信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward saveWY(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		WyManageForm wyManageForm = (WyManageForm)form;
		String wyID = request.getParameter("wyID");
		String addrID = request.getParameter("addrID");
		String name = wyManageForm.getWyName();
		String sex = wyManageForm.getSex();
		String dept = wyManageForm.getDept();
		String title = wyManageForm.getTitle();
		String txAddress = wyManageForm.getTxAddress();
		String email = wyManageForm.getEmail();
		String phone = wyManageForm.getPhone();
		DBTools dbTools = new DBTools();
		String mark="committee";
		String sql = "";
		String sqlAddr="";
		String[] params = null;
		String[] addrParams = null;
		if(wyID.equals(""))//新增
		{
			sql = "insert into TB_WYINFO(NAME,SEX,DEPT,TITLE,TXADDRESS,EMAIL,PHONE) values(?, ?, ?, ?, ?, ?, ?)";
			params = new String[]{name, sex, dept, title, txAddress, email, phone};
			sqlAddr="insert into TB_CONTACT(LOGINNAME,CONNAME,CONADDR) values(?, ?, ?)";
			params = new String[]{mark, name, email};
		}
		else
		{
			//System.out.println(addrID);
			sql = "update TB_WYINFO set NAME=?,SEX=?,DEPT=?,TITLE=?,TXADDRESS=?,EMAIL=?,PHONE=? where ID=?";
			params = new String[]{name, sex, dept, title, txAddress, email, phone, wyID};
			sqlAddr="update TB_CONTACT set LOGINNAME=?,CONNAME=?,CONADDR=? where ID=?";
			addrParams = new String[]{mark, name, email, addrID};
		}
		boolean result = dbTools.insertItem(sql, params);
		boolean resuatAddr=dbTools.insertItem(sqlAddr, addrParams);
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(result&&resuatAddr)
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
	public ActionForward export(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DBTools db = new DBTools();
		
		String sql = (String)request.getSession().getAttribute("queryWYSql");
		String[] params = (String[])request.getSession().getAttribute("queryWYParams");;
		try
		{
			String fname = "wyList";
			OutputStream os = response.getOutputStream();
			response.reset();
			response.setHeader("Content-disposition", "attachment;filename=" + fname + ".xls");
			response.setContentType("application/msexcel");
			ResultSet rs = db.queryRsList(sql, params);
			rs.last();
			int length = rs.getRow();
			rs.beforeFirst();
			ArrayList result = db.queryWYList(rs, length);
			ExcelTools et = new ExcelTools();
			//et.createSheet(rs, os);
			String sheetName = "委员信息表";
			ArrayList titleList = new ArrayList();
			titleList.add("序号");
			titleList.add("委员姓名");
			titleList.add("性别");
			titleList.add("单位");
			titleList.add("职务/职称");
			titleList.add("通讯地址");
			titleList.add("邮箱");
			titleList.add("联系方式");
			et.createEventSheet(result, os, sheetName,4, titleList);
			rs.close();
		}
		catch(Exception e)
		{
			DebugLog.WriteDebug(e);
		}
		return null;
	}
}