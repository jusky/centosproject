/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.user;

import java.io.IOException;
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
 * MyEclipse Struts
 * Creation date: 01-07-2014
 * 
 * XDoclet definition:
 * @struts.action path="/userManageAction" name="userManageForm" parameter="method" scope="request" validate="true"
 */
public class UserManageAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		UserManageForm userManageForm = (UserManageForm)form;
		
		CheckPage pageBean = new CheckPage();
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		if (request.getParameter("queryPageNo") != null) {
			queryPageNo = Integer.parseInt(request.getParameter("queryPageNo"));
		}
		pageBean.setQueryPageNo(queryPageNo);
		String sql = "select a.*,b.ZZNAME from SYS_USER a,SYS_ZZINFO b where a.ZZID=b.ZZID order by a.ID asc";
		String[] params = new String[0];
		request.getSession().setAttribute("queryUserSql", sql);
		request.getSession().setAttribute("queryUserParams", params);
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryUserList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			userManageForm.setRecordNotFind("false");
			userManageForm.setRecordList(result);
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			userManageForm.setRecordNotFind("true");
			SystemShare.SplitPageFun(request, pageBean, 0);
		}
		return mapping.findForward("init");
	}
	
	public ActionForward queryMsg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		UserManageForm userManageForm = (UserManageForm)form;
		String operation = request.getParameter("operation");
		//首先判断是否是“普通检索”，如果是，则将session中标记“高级检索”的字段设置为false
		if (operation.equalsIgnoreCase("search") || operation.equalsIgnoreCase("select")) {
			request.getSession().setAttribute("UserGjSearch", "false");
		}
		CheckPage pageBean = new CheckPage();
		String sql = "";
		String[] params = new String[0];
		int queryPageNo = 1;
		int rowsPerPage = 20;
		pageBean.setRowsPerPage(rowsPerPage);
		String gjSearchFlag = (String)request.getSession().getAttribute("UserGjSearch");
		//如果是高级检索，则从session中获得查询条件
		if(gjSearchFlag!=null && gjSearchFlag.equals("true"))
		{
			sql = (String)request.getSession().getAttribute("UserGjSearchSql");
			params = (String[])request.getSession().getAttribute("USerGjSearchParams");
			request.getSession().setAttribute("queryUserSql", sql);
			request.getSession().setAttribute("queryUserParams", params);
		}else
		{
			if (operation.equalsIgnoreCase("search")) {
				String userName = userManageForm.getUserName();
				String createBeginTime = userManageForm.getCreateBeginTime();
				String createEndTime = userManageForm.getCreateEndTime();
				String temp = "";
				if(!userName.equals(""))
				{
					temp += " and USERNAME like ?";
					params = new String[]{"%" + userName + "%"};
				}
				sql = "select a.*,b.ZZNAME from SYS_USER a,SYS_ZZINFO b where a.ZZID=b.ZZID" + temp + " order by a.ID asc";
				
				request.getSession().setAttribute("queryUserSql", sql);
				request.getSession().setAttribute("queryUserParams", params);
			}
		}
		if(operation.equalsIgnoreCase("changePage")){
			sql = (String)request.getSession().getAttribute("queryUserSql");
			params = (String[])request.getSession().getAttribute("queryUserParams");
			if (request.getParameter("currentPage") != null && request.getParameter("currentPage") != "") {
				queryPageNo = Integer.parseInt(request.getParameter("currentPage"));
			}
		}
		pageBean.setQuerySql(sql);
		pageBean.setParams(params);
		pageBean.setQueryPageNo(queryPageNo);
		DBTools db = new DBTools();
		ResultSet rs = db.queryRs(queryPageNo, pageBean, rowsPerPage);
		ArrayList result = db.queryUserList(rs, rowsPerPage);
		if(result.size() > 0)
		{
			userManageForm.setRecordNotFind("false");
			userManageForm.setRecordList(result);
			
			SystemShare.SplitPageFun(request, pageBean, 1);
		}
		else
		{
			userManageForm.setRecordNotFind("true");
			
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
			result = dbTool.deleteItemReal(uid, "SYS_USER", "ID");
		}
		else
		{
			String[] arrID = ids.split(",");
			result = dbTool.deleteItemsReal(arrID, "SYS_USER", "ID");
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
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		UserManageForm userManageForm = (UserManageForm)form;
		
		String id = request.getParameter("uid");
		DBTools dbTools = new DBTools();
		String sql = "select a.*,b.ZZNAME from SYS_USER a,SYS_ZZINFO b where a.ZZID=b.ZZID and a.ID=?";
		UserBean userBean = dbTools.queryUserBean(sql, new String[]{id});
		ArrayList result = new ArrayList();
		if(userBean!=null)
		{
			String roleIDs = userBean.getRoleIDs();
			String roleNames = "";
			if(roleIDs != null && !roleIDs.equals(""))
			{
				StringBuilder sqlBuilder = new StringBuilder("select ROLENAME from SYS_ROLE where SYS_ROLE where ID in (");
				String[] roleIdArray = roleIDs.split(",");
				int len =  roleIdArray.length;
				for(int i = 0; i < len; i++) {
					sqlBuilder.append(" ?,");
					if(i == len - 1) sqlBuilder.replace(sqlBuilder.length()-1, sqlBuilder.length(), ")");
				}
				sql = sqlBuilder.toString();
				roleNames = dbTools.queryRoleNames(sql, roleIdArray);
				if(!roleNames.equals(""))
				{
					roleNames = roleNames.substring(0, roleNames.length() - 1);
				}
			}
			userBean.setRoleNames(roleNames);
			
			String posIDs = userBean.getPosIDs();
			String posNames = "";
			if(posIDs != null && !posIDs.equals(""))
			{
				StringBuilder sqlBuilder = new StringBuilder("select POSNAME from SYS_POSITION where ID in (");
				String[] posIdArray = posIDs.split(",");
				int len = posIdArray.length;
				for (int i = 0; i < len; i++) {
					sqlBuilder.append(" ?,");
					if(i == len-1) sqlBuilder.replace(sqlBuilder.length()-1, sqlBuilder.length(), ")");
				}
				sql = sqlBuilder.toString();
				posNames = dbTools.queryPosNames(sql, posIdArray);
				if(!posNames.equals(""))
				{
					posNames = posNames.substring(0, posNames.length() - 1);
				}
			}
			userBean.setPosNames(posNames);
			result.add(userBean);
			userManageForm.setRecordNotFind("false");
			userManageForm.setRecordList(result);
			return mapping.findForward("detail");
		}
		else
		{
			userManageForm.setRecordNotFind("true");
			return mapping.findForward("initError");
		}
	}
	public ActionForward gjSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		UserManageForm userManageForm = (UserManageForm)form;
		String loginName = userManageForm.getLoginName();
		String userName = userManageForm.getUserName();
		String zzID = userManageForm.getZzID();
		//String posID = userManageForm.getPosID();
		String posID = request.getParameter("org8.posID");
		
		//String roleID = userManageForm.getRoleID();
		String roleID = request.getParameter("org7.roleID");
		String orderWay = userManageForm.getOrderWay();

		String sql = "select a.*,b.ZZNAME from SYS_USER a,SYS_ZZINFO b where a.ZZID=b.ZZID";
		ArrayList<String> paramList = new ArrayList<String>();
		String temp = "";
		if(loginName != null && !loginName.equals(""))
		{
			temp += " and a.LOGINNAME like ?";
			paramList.add("%" + loginName + "%");
		}
		if(userName !=null && !userName.equals(""))
		{
			temp += " and a.USERNAME like ?";
			paramList.add("%" + userName + "%");
		}
		if(zzID != null && !zzID.equals(""))
		{
			temp += " and a.ZZID=?";
			paramList.add(zzID);
		}
		if(posID != null && !posID.equals(""))
		{
			temp += " and a.POSIDS like ?";
			paramList.add("%" + posID + "%");
		}
		if(roleID != null && !roleID.equals(""))
		{
			temp += " and a.ROLEIDS like ?";
			paramList.add("%" + roleID + "%");
		}
		if(orderWay != null && !orderWay.equals("") && !orderWay.matches(".*[=<>].*"))
		{
			temp += " order by " + orderWay + " asc";
		}
		sql += temp;
		String[] params = paramList.toArray(new String[0]);
		request.getSession().setAttribute("UserGjSearch", "true");
		request.getSession().setAttribute("UserGjSearchSql", sql);
		request.getSession().setAttribute("UserGjSearchParams", params);
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		json.put("statusCode", 200);
		json.put("message", "正在检索中，请稍候...");
		json.put("callbackType", "closeCurrent");
		out.write(json.toString());
		out.flush();
		out.close();
		return null;
	}
	/**
	 * 重置用户密码
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward initPWD(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		DBTools dbTools = new DBTools();
		String id = request.getParameter("uid");
		String sql = "update SYS_USER set PASSWORD='123456' where ID=?";
		boolean result = dbTools.insertItem(sql, new String[]{id});
		if(result)
		{
			json.put("statusCode", 200);
			json.put("message", "密码初始化成功！");
		}
		else
		{
			json.put("statusCode", 300);
			json.put("message", "密码初始化失败！");
		}
		out.write(json.toString());
		out.flush();
		out.close();
		
		return null;
	}
}