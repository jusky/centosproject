/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.credit;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.whu.tools.DBTools;
import com.whu.web.email.ContactBean;
import com.whu.web.credit.InstituteInfo;
import com.whu.web.credit.InstituteInfo;
import com.whu.web.credit.ConfigInstituteForm;

/** 
 * MyEclipse Struts
 * Creation date: 11-19-2014
 * 
 * XDoclet definition:
 * @struts.action path="configInstituteAction" name="configInstituteForm" parameter="method" scope="request" validate="true"
 */
public class ConfigInstituteAction extends DispatchAction {
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		ConfigInstituteForm configInstituteForm = (ConfigInstituteForm)form;
		String operation = request.getParameter("operation");
		String name = configInstituteForm.getName();
		String code = configInstituteForm.getCode();
		String category = configInstituteForm.getCategory();
		String phone = configInstituteForm.getPhone();
		String address = configInstituteForm.getAddress();
		
		DBTools dbTool = new DBTools();
		String sql = "";
		String[] params = new String[0];
		if(operation.equals("new")) {
			sql = "insert into SYS_INST_INFO(CODE,NAME,CATEGORY,PHONE,ADDRESS) values(?, ?, ?, ?, ?)";
			params = new String[]{code, name, category, phone, address};
		} 
		else if(operation.equals("edit")) {
			String id = configInstituteForm.getId();
			sql = "update SYS_INST_INFO set NAME=?, CODE=?, CATEGORY=?, PHONE=?, ADDRESS=? where ID=?";
			params = new String[]{name, code, category, phone, address, id};
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
	 * 编辑信息，跳转
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
		
		ConfigInstituteForm configInstituteForm = (ConfigInstituteForm)form;
		String id = request.getParameter("uid");
		DBTools dbTools = new DBTools();
		String sql = "select * from SYS_INST_INFO where ID=?";
		InstituteInfo InstituteInfo = dbTools.queryInstituteInfo(sql, new String[]{id});
		ArrayList result = new ArrayList();
		if(InstituteInfo != null){
			result.add(InstituteInfo);
			configInstituteForm.setRecordNotFind("false");
			configInstituteForm.setRecordList(result);
			
			return mapping.findForward("edit");
			
		} else {
			configInstituteForm.setRecordNotFind("true");
			return mapping.findForward("initError");
		}		
	}
	/**
	 * show institute credit detail
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public ActionForward detail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		ConfigInstituteForm configInstituteForm = (ConfigInstituteForm)form;
		String code = request.getParameter("code");
		DBTools dbTools = new DBTools();
		String sql = "select substr(TIME, 1, 4) as YEAR, count(*) as COUNT from TB_MISCOUNT where INSTID= '" + code + "' group by INSTID, YEAR order by YEAR desc limit 6";
		String name = dbTools.querySingleData("SYS_INST_INFO", "NAME", "CODE", code);
		String creditTrend = dbTools.queryInstTrend(sql, new String[]{code}, name);
		request.setAttribute("creditTrend", creditTrend);
		
		return mapping.findForward("detail");
	}
	
}