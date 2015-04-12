package com.whu.web.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.whu.tools.DBTools;
import com.whu.tools.SystemConstant;
import com.whu.web.user.UserBean;

public class LoginServlet extends HttpServlet {

	protected boolean intranetAccessOnly = false;  // ture if only allow intranet user access case handle actions
	protected Pattern intranet = null;
	
	/**
	 * Constructor of the object.
	 */
	public LoginServlet() {
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
			String username = request.getParameter("username");
			String password = request.getParameter("password");
		//	String identity = request.getParameter("iden"); // query identity in DB
			String identity = "1";  // default 1 for officer and faculty officer
			
			if (username == null || username.trim() == "") {
				response.getWriter().write("用户名不能为空！");
			}
			else if(password == null || password.trim() == ""){
				response.getWriter().write("密码不能为空！");
			}
			else
			{
				DBTools dbc = new DBTools();
				String sql = "";
				String roleid= "";
				// query identity
				sql = "(select ROLEIDS from SYS_USER where LOGINNAME=?) union (select ROLEIDS from SYS_ED_USER where LOGINNAME=?)";
				//sql = "(select ROLEIDS from SYS_USER where LOGINNAME='" + userName + "')union (select ROLEIDS from SYS_ED_USER where LOGINNAME='" + userName + "')";
				ResultSet rs = dbc.queryRsList(sql, new String[]{username, username});
				if(rs != null && rs.next())
					roleid = rs.getString("ROLEIDS");
				dbc.closeConnection();
				if(roleid.equals("4")) 
					identity = "2";
				else if(roleid.equals("5"))
					identity = "3";
				
				// if intranetAccessOnly set and only allow user in SYS_ED_USER login
				if (intranetAccessOnly && identity.equals("1") && intranet != null && !intranet.matcher(request.getRemoteAddr()).matches()) {
					response.getWriter().write("用户名或密码有误，请重新输入！");
				} else {
				
				
					//办公室人员查询系统用户表 include faculty user
					if(identity.equals("1"))
					{
						sql = "select a.LOGINNAME,a.USERNAME,b.ZZNAME,a.ROLEIDS,a.ISHEAD from SYS_USER a, SYS_ZZINFO b where a.ZZID=b.ZZID and LOGINNAME=? and PASSWORD=?";
					}
					else if(identity.equals("2"))//鉴定专家登陆人员查询SYS_ED_USER表
					{
						sql = "select a.*,b.NAME as USERNAME from SYS_ED_USER a, SYS_EXPERTINFO b where a.EXPERTID=b.ID and a.LOGINNAME=? and a.PASSWORD=?";
					}
					else if(identity.equals("3"))//依托单位登陆人员查询SYS_ED_USER表
					{
						sql = "select *,DEPTNAME as USERNAME from SYS_ED_USER  where LOGINNAME=? and PASSWORD=?";
					}
					UserBean userBean = dbc.checkLogin(sql, username, password, identity);
					if (userBean != null) {					
						request.getSession().setAttribute("Identity", identity);
						request.getSession().setAttribute("RoleIDs", userBean.getRoleIDs());
						request.getSession().setAttribute("UserName", userBean.getUserName());
						request.getSession().setAttribute("LoginName", userBean.getLoginName());
						request.getSession().setAttribute("IsHead", userBean.getIsHead());
						
						dbc.insertLogInfo(userBean.getUserName(), SystemConstant.LOG_LOGIN, "登陆系统，登陆名为：" + userBean.getLoginName(), request.getRemoteAddr());
						
						response.getWriter().write("登录成功，即将转向管理页面！");
					} else {
						response.getWriter().write("用户名或密码有误，请重新输入！");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.getWriter().flush();
		response.getWriter().close();
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
	public void init(ServletConfig servletConfig) throws ServletException {
								
		this.intranetAccessOnly = Boolean.valueOf((servletConfig.getInitParameter("intranetAccessOnly")));
		setIntranet(servletConfig.getInitParameter("intranet"));
	}

	private void setIntranet(String intranet) {
		if (intranet == null || intranet.length() == 0) {
			this.intranet = null;
		} else {
			this.intranet = Pattern.compile(intranet);
		}
	} 
}
