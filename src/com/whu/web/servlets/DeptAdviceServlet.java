package com.whu.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.whu.tools.DBTools;
import com.whu.web.common.SystemShare;

public class DeptAdviceServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DeptAdviceServlet() {
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
		if(type.equals("save"))
		{
			String deptName = request.getParameter("deptName");
			String reportID = request.getParameter("reportID");
			String serialNum = request.getParameter("serialNum");
			DBTools dbTools = new DBTools();
			
			String createTime = SystemShare.GetNowTime("yyyy-MM-dd");
			String sql = "insert into TB_DEPTADVICE(REPORTID,DEPT,TIME,SERIALNUM,ISFK) values('" + reportID + "','" + deptName + "','" + createTime + "','" + serialNum + "','0')";
			boolean result = dbTools.insertItem(sql);
			response.getWriter().write("生成成功！");
		}
		else if(type.equals("query"))
		{
			String serialNum = request.getParameter("serialNum");
			if(!serialNum.equals(""))
			{
				DBTools dbTools = new DBTools();
				String result = dbTools.querySingleDate("TB_DEPTADVICE", "ISFK", "SERIALNUM", serialNum);
				if(result.equals("1"))//已经反馈过，不能再次反馈
				{
					response.getWriter().write("已反馈");
				}
				else
				{
					response.getWriter().write("未反馈");
				}
			}
			else
			{
				response.getWriter().write("页面出错");
			}
		}
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
