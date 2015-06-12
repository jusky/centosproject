package com.whu.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.whu.tools.DBTools;

public class CheckIdentityServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CheckIdentityServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");
		String reportID = (String)request.getSession().getAttribute("reportID");
		DBTools dbTools = new DBTools();
		String sql = "";
		boolean result = false;
		//举报者身份真实
		if(type.equals("real"))
		{
			//如果身份真实，则将ISNI修改为2，表示已经核实过，且身份真实
			sql = "update TB_REPORTINFO set ISNI = '2' where REPORTID = ?";
			result = dbTools.insertItem(sql, new String[]{reportID});
		}
		else if(type.equals("noreal"))//身份虚假，修改为匿名举报
		{
			result = dbTools.setNiMing(reportID);
		}
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(result)
		{
			json.put("statusCode", 200);
			json.put("message", "身份核实成功！");
		}
		else
		{
			json.put("statusCode", 300);
			json.put("message", "身份核实失败！");
		}
		out.write(json.toString());
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
