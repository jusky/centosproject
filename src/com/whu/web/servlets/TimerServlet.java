package com.whu.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.whu.tools.DBTools;
import com.whu.web.msgnotify.MsgNotifyBean;

public class TimerServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TimerServlet() {
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
		try {
			String userName = (String)request.getSession().getAttribute("UserName");
			//String loginName =  (String)request.getSession().getAttribute("LoginName");
			String sql = "select * from TB_MSGNOTIFY where RECVNAME='" + userName + "' and ISNOTIFY='0'";
			DBTools dbTool = new DBTools();
			ArrayList result = dbTool.queryMsgNotify(sql, "0");
			if(result.size() > 0)
			{
				//将消息提醒状态修改为已提醒
				dbTool.updateMsgNotify(result);
				String msgStr = "";
				String msgType = "";
				int gzCount=0,msgCount=0,mailCount=0;
				for(int i = 0; i < result.size(); i++)
				{
					MsgNotifyBean mnb = (MsgNotifyBean)result.get(i);
					msgType = mnb.getType();
					if(msgType.equals("1"))
					{
						//工作提醒个数
						gzCount++;
					}
					else if(msgType.equals("2"))
					{
						//消息提醒个数
						msgCount++;
					}
					else if(msgType.equals("3"))
					{
						//工作提醒个数
						mailCount ++;
					}
				}
				//msgStr = "您有<font color='#ff0000'>" + gzCount + "</font>个工作提醒，有<font color='#ff0000'>" + msgCount + "</font>条未读消息，有<font color='#ff0000'>" + mailCount + "</font>封未读邮件，请及时处理！";
				msgStr = "您有<font color='#ff0000'>" + gzCount + "</font>个事件需要审批!";
				response.getWriter().write("提醒:" + msgStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
