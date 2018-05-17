package com.whu.web.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.whu.tools.DBTools;
import com.whu.tools.SystemConstant;
import com.whu.web.common.SystemShare;
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
		String table="SYS_ED_USER";
		int errornumber;
		String[] params = new String[0];
		DBTools dbc = new DBTools();
		String sql = "";
		String nowTime = SystemShare.GetNowTime("yyyy-MM-dd HH:mm:ss");
		String username = request.getParameter("username");
		try {
			String password = request.getParameter("password");
			String page = request.getParameter("page");
			String code = request.getParameter("code");//输入的验证码
			String rand = (String)request.getSession().getAttribute(page.trim() + "rand");
		//	String identity = request.getParameter("iden"); // query identity in DB
			String identity = "1";  // default 1 for officer and faculty officer
			
			if (username == null || username.trim().equals("")) {
				response.getWriter().write("用户名不能为空！");
			}
			else if(password == null || password.trim().equals("")){
				response.getWriter().write("密码不能为空！");
			}
			else if(code == null || code.trim().equals("")){
				response.getWriter().write("验证码不能为空！");
			}
			else
			{
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
					response.getWriter().write("用户名或密码有误，超过5次将被锁定！");
				} else {
					String warnout = (String)request.getSession().getAttribute("warnout");
					if(warnout != null && warnout.equals("1") && identity.equals("1")) {
						response.getWriter().write("禁止登录！");
						response.getWriter().flush();
						response.getWriter().close();
						return;
					}
					//办公室人员查询系统用户表 include faculty user
					if(identity.equals("1"))
					{
						sql = "select a.LOGINNAME,a.USERNAME,b.ZZNAME,a.ROLEIDS,a.ISHEAD from SYS_USER a, SYS_ZZINFO b where a.ZZID=b.ZZID and LOGINNAME=? and PASSWORD=?";
						table="SYS_USER";
					}
					else if(identity.equals("2"))//鉴定专家登陆人员查询SYS_ED_USER表
					{
						sql = "select a.*,b.EXPERTNAME as USERNAME from SYS_ED_USER a, TB_EXPERTEMAIL b where a.LOGINNAME=b.LOGINNAME and a.LOGINNAME=? and a.PASSWORD=?";//在专家鉴定意见中，给专家发送电子邮件中的登录账号密码登录不了时修改
						//sql = "select a.*,b.NAME as USERNAME from SYS_ED_USER a, SYS_EXPERTINFO b where a.EXPERTID=b.ID and a.LOGINNAME=? and a.PASSWORD=?";
					}
					else if(identity.equals("3"))//依托单位登陆人员查询SYS_ED_USER表
					{
						sql = "select *,DEPTNAME as USERNAME from SYS_ED_USER  where LOGINNAME=? and PASSWORD=?";
					}
					errornumber =dbc.querySingleIntData(table, "ERRORNUMBER", "LOGINNAME", username);//用户登录密码错误次数
					//检查用户名和密码
					UserBean userBean = dbc.checkLogin(sql, username, password, identity);
					/*String reportID=dbc.querySingleData("TB_CHECKINFO", "REPORTID", "AGENTOFFICER", userBean.getUserName());
					String isAgentOfficer;
					if(reportID==null|| reportID=="")
						isAgentOfficer="0";
					else 
						isAgentOfficer=dbc.querySingleData("TB_AGENTAPPROVE", "ISAGENTOFFICER", "REPORTID", reportID);*/
					if (userBean != null) 
					{					
						request.getSession().setAttribute("Identity", identity);
						request.getSession().setAttribute("RoleIDs", userBean.getRoleIDs());
						request.getSession().setAttribute("UserName", userBean.getUserName());
						request.getSession().setAttribute("LoginName", userBean.getLoginName());
						request.getSession().setAttribute("IsHead", userBean.getIsHead());
						//request.getSession().setAttribute("ISAGENTOFFICER", isAgentOfficer);
						//SystemConstant.LOG_LOGIN="登陆系统";
						if(!code.equals(rand))
						{
							response.getWriter().write("验证码有误，请重新输入！");
						}
						else if(identity.equals("2")||identity.equals("3"))
						{
								
								String isUse =dbc.querySingleData("SYS_ED_USER", "ISUSE", "LOGINNAME", username);
								if(isUse.equals("0"))
								{
									String endTime =dbc.querySingleData("SYS_ED_USER", "ENDTIME", "LOGINNAME", username);
									int comp=nowTime.compareTo(endTime);
									if(comp>0) response.getWriter().write("您的登录账号已经过了有效期！");
									else {
									sql = "update SYS_ED_USER set ISUSE='1' where LOGINNAME=?";
									params = new String[]{username};
									dbc.insertItem(sql, params);
									response.getWriter().write("登录成功，即将转向管理页面！");
									//更新登录时间
									sql = "update "+table+" set LOGINTIME=? where LOGINNAME=?";
									params = new String[]{nowTime,username};
									dbc.insertItem(sql, params);
									}
								}
								else
								{
									String endTime =dbc.querySingleData("SYS_ED_USER", "ENDTIME", "LOGINNAME", username);
									int comp=nowTime.compareTo(endTime);
									if(comp>0) response.getWriter().write("您的登录账号已经过了有效期！");
									else {
										response.getWriter().write("登录成功，即将转向管理页面！");
										//更新登录时间
										sql = "update "+table+" set LOGINTIME=? where LOGINNAME=?";
										params = new String[]{nowTime,username};
										dbc.insertItem(sql, params);
									}
								}
						}
						else{
							if(errornumber>=5){
								String loginTime =dbc.querySingleData("SYS_USER", "LOGINTIME", "LOGINNAME", username);
								//String loginTime ="2015-02-13";
								DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								Date effectivetime=null;
								effectivetime=df.parse(loginTime);
								// 创建 Calendar 对象
							   Calendar calendar = Calendar.getInstance();
							   calendar.setTime(effectivetime);
							   calendar.add(Calendar.MINUTE, 2);
							   effectivetime=calendar.getTime();
								df.format(effectivetime);
								System.out.print(df.format(effectivetime));
								
								Date nowdate=null;
								nowdate=df.parse(nowTime);
								int comp=nowdate.compareTo(effectivetime);
								if(comp>0){
										dbc.insertLogInfo(userBean.getUserName(), SystemConstant.LOG_LOGIN, "登陆系统，登陆名为：" + userBean.getLoginName(), request.getRemoteAddr());
										sql = "update "+table+" set ERRORNUMBER='0' where LOGINNAME=?";
										params = new String[]{username};
										dbc.insertItem(sql, params);
										response.getWriter().write("登录成功，即将转向管理页面！");
										//更新登录时间
										sql = "update "+table+" set LOGINTIME=? where LOGINNAME=?";
										params = new String[]{nowTime,username};
										dbc.insertItem(sql, params);
										}
								else{
									response.getWriter().write("您已经超过5次输入错误密码了，请30分钟后再重试！");
								}
							}
							else{
								sql = "update "+table+" set ERRORNUMBER='0' where LOGINNAME=?";
								params = new String[]{username};
								dbc.insertItem(sql, params);
								response.getWriter().write("登录成功，即将转向管理页面！");
								//更新登录时间
								sql = "update "+table+" set LOGINTIME=? where LOGINNAME=?";
								params = new String[]{nowTime,username};
								dbc.insertItem(sql, params);
							}
							}
					} 
					else {
						
						if(errornumber>=5){
							response.getWriter().write("您已经超过5次输入错误密码了，请30分钟后再重试！");
						}
						else{
							errornumber++;
							sql = "update "+table+" set ERRORNUMBER="+errornumber+" where LOGINNAME=?";
							params = new String[]{username};
							dbc.insertItem(sql, params);
							response.getWriter().write("用户名或密码有误，超过5次将被锁定！");
						}
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
