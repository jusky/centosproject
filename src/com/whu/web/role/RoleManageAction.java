/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.role;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.whu.tools.CheckPage;
import com.whu.tools.DBTools;
import com.whu.web.common.SystemShare;
import com.whu.web.user.UserManageForm;
import com.whu.web.zuzhi.ZzManageForm;

/** 
 * MyEclipse Struts
 * Creation date: 02-19-2014
 * 
 * XDoclet definition:
 * @struts.action path="/roleManageAction" name="roleManageForm" parameter="method" scope="request" validate="true"
 */
public class RoleManageAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		RoleManageForm roleManageForm = (RoleManageForm)form;
		
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null) {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		String sql = "select * from SYS_ROLE";
		request.getSession().setAttribute("queryRoleSql", sql);
		pageBean.setQuerySql(sql);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryRoleList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			roleManageForm.setRecordNotFind("false");
			roleManageForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			roleManageForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		RoleManageForm roleManageForm = (RoleManageForm)form;
		String operation = request.getParameter("operation");
		
		CheckPage pageBean = new CheckPage();
		String sql = "";
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (operation.equalsIgnoreCase("search")) {
			String roleName = roleManageForm.getRoleName();
			String temp = "";
			if(!roleName.equals(""))
			{
				temp += " and ROLENAME like '%" + roleName + "%'";
			}
			sql = "select * from SYS_ROLE where 1=1 " + temp;
			request.getSession().setAttribute("queryRoleSql", sql);
		}
		else if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryRoleSql");
			if (request.getParameter("currentPage") != null && request.getParameter("currentPage") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("currentPage"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryRoleList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			roleManageForm.setRecordNotFind("false");
			roleManageForm.setRecordList(result);
			
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			roleManageForm.setRecordNotFind("true");
			
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
			result = dbTool.deleteItemReal(uid, "SYS_ROLE", "ID");
		}
		else
		{
			String[] arrID = ids.split(",");
			result = dbTool.deleteItemsReal(arrID, "SYS_ROLE", "ID");
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
	 * 为角色分配资源，即功能
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward resAllocation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		request.getSession().setAttribute("RoleID", id);
		return mapping.findForward("resAllocation");
	}
	/**
	 * 初始化功能树
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void initTree(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		RoleManageForm roleManageForm = (RoleManageForm) form;// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String roleID = (String)request.getSession().getAttribute("RoleID");
		DBTools dbTools = new DBTools();
		//查询与该角色关联的功能列表，用于控制前台树的复选框是否勾选
		List<String> moduleList = new ArrayList<String>();
		String sql = "select MODULEIDS from SYS_ROLE where ID=" + roleID;
		String moduleIDs = dbTools.queryModuleIDs(sql);
		if(!moduleIDs.equals(""))
		{
			String[] temp = moduleIDs.split(",");
			for(int i = 0; i < temp.length; i++)
			{
				moduleList.add(temp[i]);
			}
		}
		
		sql = "select * from SYS_MODULE";
        List<String> lstTree = dbTools.queryModuleTree(sql, moduleList);
        //利用Json插件将Array转换成Json格式
        response.getWriter().print(JSONArray.fromObject(lstTree).toString()); 

	}
	/**
	 * 保存选择的功能模块
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public ActionForward moduleSave(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		RoleManageForm roleManageForm = (RoleManageForm) form;// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String ids = roleManageForm.getModuleIds();
		String roleID = (String)request.getSession().getAttribute("RoleID");
		DBTools dbTools = new DBTools();
		boolean result = true;
		if(ids.equals(""))
		{
			result = false;
		}
		else
		{
			ids = ids.substring(0, ids.length() - 1);
			/*
			String[] arrID = ids.split(",");
			try {
				result = dbTools.InsertRoleModule(arrID, roleID);
			} catch (SQLException e) {
				result = false;
			}
			*/
			String sql = "update SYS_ROLE set MODULEIDS='" + ids + "' where ID='" + roleID + "'";
			result = dbTools.insertItem(sql);
		}
		
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
			if(ids.equals(""))
			{
				json.put("message", "没有选择任何功能模块！");
			}
			else
			{
				json.put("message", "保存失败！");
			}
		}
		out.write(json.toString());
		out.flush();
		out.close();
		return null;
	}
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		RoleManageForm roleManageForm = (RoleManageForm) form;
		
		String id = request.getParameter("id");
		DBTools dbTools = new DBTools();
		String sql = "select * from SYS_ROLE where ID=" + id;
		RoleBean rb = dbTools.queryRoleBean(sql);
		ArrayList result = new ArrayList();
		if(rb!=null)
		{
			result.add(rb);
			roleManageForm.setRecordNotFind("false");
			roleManageForm.setRecordList(result);
			return mapping.findForward("detail");
		}
		else
		{
			roleManageForm.setRecordNotFind("true");
			return mapping.findForward("initError");
		}
	}
}