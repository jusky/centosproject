/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.position;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.whu.tools.DBTools;
import com.whu.web.role.ConfigRoleForm;
import com.whu.web.role.RoleBean;

/** 
 * MyEclipse Struts
 * Creation date: 08-07-2013
 * 
 * XDoclet definition:
 * @struts.action path="/posConfigAction" name="posConfigForm" parameter="method" scope="request" validate="true"
 */
public class PosConfigAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		PosConfigForm posConfigForm = (PosConfigForm)form;
		String operation = request.getParameter("operation");
		
		String posName = posConfigForm.getPosName();
		String posDescribe = posConfigForm.getPosDescribe();
		DBTools dbTool = new DBTools();
		
		String sql = "";
		String[] params = new String[0];
		if(operation.equals("new"))
		{
			sql = "insert into SYS_POSITION(POSNAME,POSDESCRIBE) values(?, ?)";
			params = new String[]{posName, posDescribe};
		}
		else if(operation.equals("edit"))
		{
			String id = posConfigForm.getId();
			sql = "update SYS_POSITION set POSNAME=?, POSDESCRIBE=? where ID=?";
			params = new String[]{posName, posDescribe, id};
		}
		boolean result = dbTool.insertItem(sql, params);
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
	/**
	 * 编辑用户信息，跳转
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		PosConfigForm posConfigForm = (PosConfigForm)form;
		
		String id = request.getParameter("uid");
		DBTools dbTools = new DBTools();
		String sql = "select * from SYS_POSITION where ID=?";
		PosBean posBean = dbTools.queryPosBean(sql, new String[]{id});
		ArrayList result = new ArrayList();
		if(posBean != null)
		{
			result.add(posBean);
			posConfigForm.setRecordNotFind("false");
			posConfigForm.setRecordList(result);
			return mapping.findForward("edit");
		}
		else
		{
			posConfigForm.setRecordNotFind("true");
			return mapping.findForward("initError");
		}
	}
}