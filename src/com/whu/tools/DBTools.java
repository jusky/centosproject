package com.whu.tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.json.JSONObject;
import org.json.JSONArray;

import com.whu.tools.crypto.AESCrypto;
import com.whu.web.attach.AttachBean;
import com.whu.web.common.SystemShare;
import com.whu.web.dic.DicBean;
import com.whu.web.email.ContactBean;
import com.whu.web.email.EmailBean;
import com.whu.web.email.EmailInfo;
import com.whu.web.email.RecvMailInfo;
import com.whu.web.event.BeReportBean;
import com.whu.web.event.EventBean;
import com.whu.web.event.JBReasonBean;
import com.whu.web.eventbean.*;
import com.whu.web.eventmanage.ApproveBean;
import com.whu.web.eventmanage.GroupBean;
import com.whu.web.eventmanage.ItemAndNum;
import com.whu.web.expertAndDept.DeptAdviceBean;
import com.whu.web.expertAndDept.DeptDCBean;
import com.whu.web.expertAndDept.ExpertFile;
import com.whu.web.expertAndDept.ExpertIdentityBean;
import com.whu.web.expertAndDept.UrlAndName;
import com.whu.web.key.KeyBean;
import com.whu.web.log.LogBean;
import com.whu.web.msg.MsgBean;
import com.whu.web.msgnotify.MsgNotifyBean;
import com.whu.web.position.PosBean;
import com.whu.web.role.RoleBean;
import com.whu.web.user.UserBean;
import com.whu.web.user.WYBean;
import com.whu.web.wsjb.WsjbDBTools;
import com.whu.web.zuzhi.ZZBean;
import com.whu.web.credit.IndividualInfo;
import com.whu.web.credit.InstituteInfo;
import com.whu.web.credit.MiscountInfo;
import com.whu.web.credit.PunishBean;
import com.whu.web.credit.MistypeBean;



public class DBTools {

	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pst = null;
	private Statement stmt = null;

	public DBTools() {
		/*
		 * try { Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		 * conn = DriverManager.getConnection(
		 * "jdbc:sqlserver://localhost:1433;DatabaseName=DB_REPORT", "sa",
		 * "123456"); } catch (ClassNotFoundException e) { e.printStackTrace();
		 * } catch (SQLException e) { e.printStackTrace(); }
		 */
		// auto connected in context.xml
		/*try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/DB_REPORT",
					"root", "3951345");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} */
	}
	/**
	 * 查找用户名和密码是否正确，如果正确，返回用户信息；否则返回null
	 * @param userName 用户名
	 * @param pwd 密码
	 * @return
	 */
	public UserBean checkLogin(String sql,String userName,String pwd,String identity) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1,userName);
			pst.setString(2,pwd);
			rs = pst.executeQuery();
			while (rs.next()) {
				UserBean userBean = new UserBean();
				userBean.setLoginName(rs.getString("LOGINNAME"));
				userBean.setUserName(rs.getString("USERNAME"));
				//userBean.setZzName(rs.getString("ZZNAME"));
				userBean.setRoleIDs(rs.getString("ROLEIDS"));
				if (identity != null && identity.equals("1")) {
					userBean.setIsHead(rs.getString("ISHEAD"));
				}
				return userBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 修改密码时判断用户的旧密码和账号是否对应
	 * @param sql
	 * @return
	 */
	public boolean isHave(String sql, String loginName, String pwd) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, loginName);
			pst.setString(2, pwd);
			rs = pst.executeQuery();
			while (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return false;
	}

	public int getTotalRows(String sql, String[] params) {
		int count = 0;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs.next()) {
				count++;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
//			System.out.print("getTotalRows errors" + ex.getMessage());
		}
		return count;
	}

	public ResultSet queryRs(int queryPageNo, CheckPage pageBean,
			int rowsPerPage) {
		String sql = "";
		String[] params = new String[0];
		queryPageNo = pageBean.getQueryPageNo(); 
		// System.out.print("queryPageNo:"+queryPageNo+"||");
		rowsPerPage = pageBean.getRowsPerPage();
		if (pageBean.getQuerySql() != null)
			sql = pageBean.getQuerySql(); 
		if (pageBean.getParams() != null)
			params = pageBean.getParams();
		
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			
			rs.last();
			int totalRows = rs.getRow();
			rs.beforeFirst();
			pageBean.setTotalRows(totalRows);

			int totalPage = totalRows % rowsPerPage == 0 ? totalRows / rowsPerPage
					: totalRows / rowsPerPage + 1;
			pageBean.setTotalPage(totalPage);
			
			int lastPageRows = totalRows % rowsPerPage == 0 ? rowsPerPage
					: totalRows % rowsPerPage;
			pageBean.setLastPageRows(lastPageRows);
			
			int skipRows = (queryPageNo - 1) * rowsPerPage;
			for (int j = 0; j < skipRows; j++)
				rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	/**
	 * ���SQL����ѯ���
	 * 
	 * @param sql
	 * @return
	 */
	public ResultSet queryRsList(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
		} catch (SQLException ex) {
			ex.printStackTrace();
		} 
		return rs;
	}

	// ��ѯ�ѽ�����Ϣ
	public ArrayList queryRecvMsgList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				MsgBean msgBean = new MsgBean();
				msgBean.setSendName(rs.getString("SENDNAME"));
				msgBean.setTitle(rs.getString("TITLE"));
				msgBean.setMsgType(rs.getString("MSGTYPE"));
				msgBean.setSendTime(rs.getString("SENDTIME"));
				msgBean.setRecvTime(rs.getString("RECVTIME"));
				list.add(msgBean);
				count--;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * ��ѯ����ֵ���Ϣ
	 * 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryDicList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				DicBean db = new DicBean();
				db.setId(String.valueOf(rs.getInt("ID")));
				db.setCodeName(rs.getString("CODENAME"));
				db.setCode(rs.getString("CODE"));
				db.setCaption(rs.getString("CAPTION"));
				db.setRemark(rs.getString("REMARK"));
				list.add(db);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	public ArrayList queryPunishList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				PunishBean db = new PunishBean();
				db.setId(String.valueOf(rs.getInt("A.ID")));
				db.setCodename(rs.getString("CODENAME"));
				db.setCode(rs.getString("A.CODE"));
				db.setCaption(rs.getString("CAPTION"));
				db.setRemark(rs.getString("REMARK"));
				db.setYear(rs.getString("YEAR"));
				db.setRate(rs.getString("RATE"));
				list.add(db);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/**
	 * 查询调查组成员
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryGroupUser(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				GroupBean gb = new GroupBean();
				gb.setId(String.valueOf(rs.getInt("ID")));
				gb.setName(rs.getString("NAME"));
				gb.setUnit(rs.getString("UNIT"));
				gb.setAddress(rs.getString("ADDRESS"));
				gb.setTelPhone(rs.getString("TELPHONE"));
				gb.setWorkContent(rs.getString("WORKCONTENT"));
				list.add(gb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * ��ѯ�ҷ��������
	 * 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryMyStartList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			while (rs != null && rs.next() && count > 0) {
				EventBean eb = new EventBean();
				eb.setId(String.valueOf(rs.getInt("ID")));
				eb.setStatus(rs.getString("CAPTION"));
				//向从数据库取出加密后的二进制数据，调用解密方法得到字节数组，再将字节数据转换为字符串
				eb.setReportName(new String(aes.createDecryptor(rs.getBytes("REPORTNAME"), key)));
				eb.setReportTime(rs.getString("REPORTTIME"));
				eb.setBeReportName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				eb.setReportReason(new String(aes.createDecryptor(rs.getBytes("REPORTREASON"), key)));
				eb.setReportContent(new String(aes.createDecryptor(rs.getBytes("REPORTCONTENT"), key)));
				list.add(eb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * ��ѯ����˵�����
	 * 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryMyAppList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				EventBean eb = new EventBean();
				eb.setId(String.valueOf(rs.getInt("ID")));
				eb.setStatus(rs.getString("CAPTION"));
				eb.setReportName(rs.getString("REPORTNAME"));
				eb.setReportTime(rs.getString("REPORTTIME"));
				eb.setReportReason(rs.getString("REPORTREASON"));
				eb.setReportContent(rs.getString("REPORTCONTENT"));
				list.add(eb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询事件列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryEventList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			while (rs != null && rs.next() && count > 0) {
				EventBean eb = new EventBean();
				eb.setId(String.valueOf(rs.getInt("ID")));
				eb.setReportID(rs.getString("REPORTID"));
				eb.setStatus(rs.getString("CAPTION"));
				eb.setReportName(new String(aes.createDecryptor(rs.getBytes("REPORTNAME"), key)));
				eb.setReportTime(rs.getString("REPORTTIME"));
				eb.setBeReportName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				eb.setReportReason(new String(aes.createDecryptor(rs.getBytes("REPORTREASON"), key)));
				eb.setSerialNum(rs.getString("SERIALNUM"));
				
				// query UserName use LoginName
				eb.setOfficer(new DBTools().querySingleDate("SYS_USER", "USERNAME", "LOGINNAME", rs.getString("OFFICER")));
				list.add(eb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/**
	 * query FacultyAdvice List 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryFacultyAdviceList(ResultSet rs, int rowsPerPage, String serverPath) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			while (rs != null && rs.next() && count > 0) {
				FacultyAdviceBean fab = new FacultyAdviceBean();
				fab.setId(String.valueOf(rs.getInt("ID")));
				fab.setReportId(rs.getString("REPORTID"));
				fab.setSerialNum(rs.getString("SERIALNUM"));
				fab.setReportName(new String(aes.createDecryptor(rs.getBytes("REPORTNAME"), key)));
				fab.setBeReportName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				fab.setReportReason(new String(aes.createDecryptor(rs.getBytes("REPORTREASON"), key)));
				fab.setIsfk(rs.getString("ISFK"));
				fab.setFktime(rs.getString("FKTIME"));
				fab.setAdvice(rs.getString("ADVICE"));
				fab.setFilePath(serverPath + rs.getString("FILENAME"));
				
				list.add(fab);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	
	/**
	 * 查询会议信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryMeetList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int i = 0;
			while (rs != null && rs.next() && count > 0) {
				MeetInfo mi = new MeetInfo();
				mi.setId(String.valueOf(rs.getInt("ID")));
				mi.setSerialNum(String.valueOf(++i));
				mi.setMeetName(rs.getString("MEETNAME"));
				mi.setTime(rs.getString("TIME"));
				mi.setMembers(rs.getString("MEMBERS"));
				mi.setLocation(rs.getString("LOCATION"));
				mi.setStatus(rs.getString("STATUS"));
				list.add(mi);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询处理决定列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryCljdList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int i = 0;
			HandleDecide hd = null;
			String serverPath = SystemConstant.GetServerPath() + "/attachment/";
			String filePath = "";
			int temp = 0;
			while (rs != null && rs.next() && count > 0) {
				hd = new HandleDecide();
				temp++;
				hd.setXuhao(String.valueOf(temp));
				hd.setId(rs.getString("ID"));
				hd.setReportID(rs.getString("REPORTID"));
				hd.setSerialNum(rs.getString("SERIALNUM"));
				hd.setHandleName(rs.getString("HANDLENAME"));
				hd.setConference(rs.getString("CONFERENCE"));
				hd.setHandleTime(rs.getString("HANDLETIME"));
				hd.setDecideContent(rs.getString("DECIDECONTENT"));
				hd.setDeptName(rs.getString("DEPTNAME"));
				filePath = rs.getString("FILEPATH");
				if(filePath != null &&!filePath.equals(""))
				{
					hd.setFilePath(serverPath + filePath);
				}
				else
				{
					hd.setFilePath("");
				}
				list.add(hd);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询调查报告列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryDcbgList(ResultSet rs, int rowsPerPage, String serverPath) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int i = 0;
			SurveyReportBean srb = null;
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			while (rs != null && rs.next() && count > 0) {
				srb = new SurveyReportBean();
				srb.setId(rs.getString("ID"));
				srb.setReportID(rs.getString("REPORTID"));
				srb.setReportName(new String(aes.createDecryptor(rs.getBytes("REPORTNAME"), key)));
				srb.setBeReportName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				srb.setSerialNum(rs.getString("SERIALNUM"));
				srb.setCreateTime(rs.getString("UPDATETIME"));
				srb.setFilePath(serverPath + rs.getString("FILENAME"));
				list.add(srb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询系统日志信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryLogList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				LogBean lb = new LogBean();
				lb.setId(String.valueOf(rs.getInt("ID")));
				lb.setOperator(rs.getString("OPERATOR"));
				lb.setTime(rs.getString("TIME"));
				lb.setLogType(rs.getString("LOGTYPE"));
				lb.setDetail(rs.getString("DETAIL"));
				lb.setIpAddr(rs.getString("IPADDR"));
				list.add(lb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询密钥信息列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryKeyList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			String path = "";
			while (rs != null && rs.next() && count > 0) {
				KeyBean kb = new KeyBean();
				kb.setId(String.valueOf(rs.getInt("ID")));
				kb.setKeyName(rs.getString("KEYNAME"));
				kb.setStartTime(rs.getString("STARTTIME"));
				kb.setEndTime(rs.getString("ENDTIME"));
				path = rs.getString("PATH");
				if(path!=null && !path.equals(""))
				{
					path = SystemConstant.GetServerPath() + "/" + path;
				}
				else
				{
					path = "";
				}
				kb.setPath(path);
				kb.setLocalPath(rs.getString("LOCALPATH"));
				kb.setIsUse(rs.getString("ISUSE"));
				list.add(kb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询上传的附件信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryAttachList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int num = 0;
			String temp="";
			while (rs != null && rs.next() && count > 0) {
				AttachBean ab = new AttachBean();
				num++;
				ab.setId(String.valueOf(rs.getInt("ID")));
				ab.setSerialNum(String.valueOf(num));
				ab.setFileName(rs.getString("FILENAME"));
				ab.setCreateTime(rs.getString("CREATETIME"));
				ab.setExtName(rs.getString("EXTNAME"));
				ab.setSize(rs.getString("SIZE"));
				ab.setUploadName(rs.getString("UPLOADNAME"));
				temp=rs.getString("FILEPATH");
				if(temp.substring(0,4).equals("http"))
				{
					ab.setFilePath(rs.getString("FILEPATH"));
				}
				else
				{
					ab.setFilePath(SystemConstant.domainName + rs.getString("FILEPATH"));
				}
				list.add(ab);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询会议信息
	 * @param sql
	 * @return
	 */
	public MeetInfo queryMeetInfo(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				MeetInfo mi = new MeetInfo();
				mi.setId(String.valueOf(rs.getInt("ID")));
				mi.setMeetName(rs.getString("MEETNAME"));
				mi.setTime(rs.getString("TIME"));
				mi.setMembers(rs.getString("MEMBERS"));
				mi.setLocation(rs.getString("LOCATION"));
				mi.setStatus(rs.getString("STATUS"));
				return mi;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询组织信息列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryZZList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				ZZBean zzB = new ZZBean();
				zzB.setId(String.valueOf(rs.getInt("ID")));
				zzB.setZzID(rs.getString("ZZID"));
				zzB.setZzName(rs.getString("ZZNAME"));
				zzB.setZzDescribe(rs.getString("ZZDESCRIBE"));
				zzB.setIsJC(rs.getString("ISJC"));
				zzB.setPzzID(rs.getString("PZZID"));
				zzB.setPzzName(rs.getString("PZZNAME"));
				list.add(zzB);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * query Mistype list
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryMistypeList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				MistypeBean mistypeBean = new MistypeBean();
				mistypeBean.setId(String.valueOf(rs.getInt("ID")));
				mistypeBean.setRid(rs.getString("RID"));
				mistypeBean.setRname(rs.getString("RNAME"));
				mistypeBean.setPrid(rs.getString("PRID"));
				try {
					mistypeBean.setPname(rs.getString("PNAME"));
				} catch (final SQLException e) {
					mistypeBean.setPrid("");
				}
				mistypeBean.setIsjc(rs.getString("ISJC"));
				mistypeBean.setWeight(rs.getString("WEIGHT"));
				list.add(mistypeBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * query Mistype list for weight show
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public List queryMistype(ResultSet rs) {
		List<String> lstTree = new ArrayList<String>();
		try {
			String result="";
			String rid="";
			String rname="";
			String weight="";
			while (rs != null && rs.next()) {
				rid = rs.getString("RID");
				rname = rs.getString("RNAME");
				weight = rs.getString("WEIGHT");
				result = "{rid:" + rid + ", rname:\"" + rname + "\", weight:" + weight + "}";
				lstTree.add(result);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return lstTree;
	}
	
	/**
	 * 查询角色列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryRoleList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int i = 0;
			while (rs != null && rs.next() && count > 0) {
				RoleBean rb = new RoleBean();
				rb.setId(String.valueOf(rs.getInt("ID")));
				rb.setSerialNum(String.valueOf(++i));
				rb.setRoleName(rs.getString("ROLENAME"));
				rb.setRoleDescribe(rs.getString("ROLEDESCRIBE"));
				rb.setIsUse(rs.getString("ISUSE"));
				list.add(rb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询案件调查和鉴定的反馈记录（专家鉴定和单位调查）
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryEventFKList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		ReplyInfo ri;
		try {
			int count = rowsPerPage;
			int i = 0;
			while (rs != null && rs.next() && count > 0) {
				ri = new ReplyInfo();
				ri.setId(rs.getString("ID"));
				ri.setSerialNum(String.valueOf(++i));
				ri.setReportID(rs.getString("REPORTID"));
				ri.setTime(rs.getString("TIME"));
				ri.setType(rs.getString("TYPE"));
				ri.setFkName(rs.getString("FKNAME"));
				list.add(ri);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * ��ѯ�����¼�
	 * 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryAllEventList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				EventBean eb = new EventBean();
				eb.setId(String.valueOf(rs.getInt("ID")));
				eb.setStatus(rs.getString("CAPTION"));
				eb.setReportName(rs.getString("REPORTNAME"));
				eb.setReportTime(rs.getString("REPORTTIME"));
				eb.setReportReason(rs.getString("REPORTREASON"));
				list.add(eb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/*
	 * 查询用户信息
	 */
	public ArrayList queryUserList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				UserBean userBean = new UserBean();
				userBean.setId(String.valueOf(rs.getInt("ID")));
				userBean.setUserName(rs.getString("USERNAME"));
				userBean.setLoginName(rs.getString("LOGINNAME"));
				userBean.setSex(rs.getString("SEX"));
				userBean.setBgPhone(rs.getString("BGPHONE"));
				userBean.setBgsNum(rs.getString("BGSNUM"));
				userBean.setTelPhone(rs.getString("TELPHONE"));
				userBean.setZzName(rs.getString("ZZNAME"));
				userBean.setCreateTime(rs.getString("CREATETIME"));
				userBean.setIsHead(rs.getString("ISHEAD"));
				list.add(userBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/*
	 * 
	 */
	public String queryUserByZZName(String facultys) {
		String result = "";
		if(facultys == null || facultys.equals("")) return "";
		StringBuilder sqlBuilder = new StringBuilder("select a.USERNAME from SYS_USER a, SYS_ZZINFO b where a.ZZID=b.ZZID and b.ZZNAME in (");
		String[] facultyArray = facultys.split(",");
		int len = facultyArray.length;
		for (int i = 0; i < len; i++) {
			sqlBuilder.append(" ?,");
			if(i == len-1) sqlBuilder.replace(sqlBuilder.length()-1, sqlBuilder.length(), ")");
		}
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sqlBuilder.toString());
			int i = 1;
			for(String param : facultyArray) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			
			while(rs != null && rs.next()) {
				result += rs.getString("USERNAME") + ",";
			}
			return result.equals("")? result : result.substring(0, result.length() - 1);
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		} finally {
			closeConnection();
		}
	}
	
	/**
	 * ��ѯ���õ��û��б?����ѡ���û�ʹ�ã�ֻ�����У���ţ�������֯
	 * 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryGYUserList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				UserBean userBean = new UserBean();
				userBean.setId(String.valueOf(rs.getInt("ID")));
				userBean.setUserName(rs.getString("USERNAME"));
				userBean.setZzName(rs.getString("ZZNAME"));
				list.add(userBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/* query officer users for dispatch event
	 * 
	 */
	public ArrayList queryOfficerList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int i = 0;
			while (rs != null && rs.next() && count > 0) {
				UserBean userBean = new UserBean();
				userBean.setId(String.valueOf(rs.getInt("ID")));
				userBean.setUserName(rs.getString("USERNAME"));
				userBean.setLoginName(rs.getString("LOGINNAME"));
				userBean.setSerialNum(String.valueOf(++i));
				list.add(userBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	// ��ѯ����������Ϣ
	public ArrayList queryMailList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				EmailBean emailBean = new EmailBean();
				emailBean.setID(String.valueOf(rs.getInt("ID")));
				emailBean.setAccountName(rs.getString("ACCOUNTNAME"));
				emailBean.setMailBoxAddress(rs.getString("MAILADDRESS"));
				emailBean.setIsDefault(rs.getString("ISDEFAULT"));
				list.add(emailBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 检索通讯录表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryAddrList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				ContactBean contactBean = new ContactBean();
				contactBean.setId(String.valueOf(rs.getInt("ID")));
				contactBean.setContactName(rs.getString("CONNAME"));
				contactBean.setContactAddr(rs.getString("CONADDR"));
				list.add(contactBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	// ��ѯ��λ��Ϣ
	public ArrayList queryPosList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int i = 0;
			while (rs != null && rs.next() && count > 0) {
				PosBean posBean = new PosBean();
				posBean.setId(String.valueOf(rs.getInt("ID")));
				posBean.setSerialNum(String.valueOf(++i));
				posBean.setPosName(rs.getString("POSNAME"));
				posBean.setPosDescribe(rs.getString("POSDESCRIBE"));
				list.add(posBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * 查询举报事由
	 * 
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryJBReList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				JBReasonBean jbrb = new JBReasonBean();
				jbrb.setId(String.valueOf(rs.getInt("ID")));
				jbrb.setReasonID(rs.getString("REASONID"));
				jbrb.setJbReason(rs.getString("JBREASON"));
				list.add(jbrb);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询举报事由，生成树形菜单
	 * @param sql
	 * @return
	 */
	public List queryReasonTree(String sql, String type) {
		List<String> lstTree = new ArrayList<String>();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			String result = "";
			String id = "";
			String pId = "";
			String name = "";
			String open = "";//是否有下级功能
			
			while (rs != null && rs.next()) {
				id = rs.getString("RID");
				pId = rs.getString("PRID");
				name = rs.getString("RNAME");
				open = rs.getString("ISJC");
				result = "{id:" + id + ", pId:" + pId + ", name:\"" + name + "\"";
				if(type.equals("0") && open.equals("1"))	// for jbreason select tree
				{
					result += ",open:true}";
				}
				else
				{
					result += "}";
				}
				
				lstTree.add(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return lstTree;
	}
	
	/**
	 * query punishment to generate tree
	 * @param sql
	 * @return
	 */
	public List queryPunishTree(String sql, String[] params) {
		List<String> lstTree = new ArrayList<String>();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			String result = "";
			String code = "";
			String caption = "";
			
			while (rs != null && rs.next()) {
				code = rs.getString("CODE");
				caption = rs.getString("CAPTION");
				
				result = "{id:" + code + ", name:\"" + caption + "\"}";
				
				lstTree.add(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return lstTree;
	}

	/**
	 * 查询用户信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList querySysUser(ResultSet rs, int rowsPerPage)
	{
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				UserBean userBean = new UserBean();
				userBean.setId(String.valueOf(rs.getInt("ID")));
				userBean.setUserID(rs.getString("USERID"));
				userBean.setLoginName(rs.getString("LOGINNAME"));
				userBean.setUserName(rs.getString("USERNAME"));
				userBean.setBgPhone(rs.getString("BGPHONE"));
				userBean.setBgsNum(rs.getString("BGSNUM"));
				userBean.setZzName(rs.getString("ZZNAME"));
				list.add(userBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	public ArrayList queryMailList(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				EmailBean emailBean = new EmailBean();
				emailBean.setID(String.valueOf(rs.getInt("ID")));
				emailBean.setAccountName(rs.getString("ACCOUNTNAME"));
				emailBean.setMailBoxAddress(rs.getString("MAILADDRESS"));
				emailBean.setIsDefault(rs.getString("ISDEFAULT"));
				list.add(emailBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * 查询邮箱通讯录列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryConList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				ContactBean conBean = new ContactBean();
				conBean.setId(String.valueOf(rs.getInt("ID")));
				conBean.setContactName(rs.getString("CONNAME"));
				conBean.setContactAddr(rs.getString("CONADDR"));
				list.add(conBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询依托单位信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryInstituteList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int temp = 0;
			while (rs != null && rs.next() && count > 0) {
				InstituteInfo instituteInfo = new InstituteInfo();
				temp++;
				instituteInfo.setSerialNum(String.valueOf(temp));
				instituteInfo.setId(rs.getString("ID"));
				instituteInfo.setCode(rs.getString("CODE"));
				instituteInfo.setName(rs.getString("NAME"));
				instituteInfo.setCategory(rs.getString("CATEGORY"));
				instituteInfo.setAddress(rs.getString("ADDRESS"));
				instituteInfo.setPrincipal(rs.getString("PRINCIPAL"));
				instituteInfo.setPhone(rs.getString("PHONE"));
				instituteInfo.setCredit(rs.getString("CREDIT"));
				instituteInfo.setCount(rs.getString("COUNT"));
				list.add(instituteInfo);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/**
	 * 查询不端行为记录信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryMiscountList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				MiscountInfo miscountInfo = new MiscountInfo();
				miscountInfo.setId(String.valueOf(rs.getInt("ID")));
				miscountInfo.setMiscountId(rs.getString("MISCOUNTID"));
				miscountInfo.setTitle(rs.getString("TITLE"));
				miscountInfo.setIndividual(rs.getString("INDI"));
				miscountInfo.setInstitute(rs.getString("INST"));
				miscountInfo.setMistype(rs.getString("MISNAME"));
				miscountInfo.setReportId(rs.getString("REPORTID"));
				miscountInfo.setPunish(rs.getString("PUNISHMENT"));
				miscountInfo.setTime(rs.getString("TIME"));
				miscountInfo.setDetail(rs.getString("DETAIL"));
				list.add(miscountInfo);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/**
	 * 查询科研人员信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryIndividualList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				IndividualInfo individualInfo = new IndividualInfo();
				individualInfo.setId(rs.getString("ID"));
				individualInfo.setPid(rs.getString("PID"));
				individualInfo.setName(rs.getString("NAME"));
				individualInfo.setSex(rs.getString("SEX"));
				individualInfo.setTitle(rs.getString("TITLE"));
				individualInfo.setIsExpert(rs.getString("ISEXPERT"));
				individualInfo.setSpecialty(rs.getString("SPECIALTY"));
				individualInfo.setPhone(rs.getString("PHONE"));
				individualInfo.setEmail(rs.getString("EMAIL"));
				individualInfo.setAddress(rs.getString("ADDRESS"));
				individualInfo.setInstCode(rs.getString("INSTITUTE"));
				individualInfo.setInstitute(rs.getString("INST_NAME"));	
				individualInfo.setCredit(rs.getString("CREDIT"));
				list.add(individualInfo);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	
	/**
	 * 查询专家信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryExpertList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int temp = 0;
			while (rs != null && rs.next() && count > 0) {
				ExpertInfo expertInfo = new ExpertInfo();
				temp++;
				expertInfo.setSerialNum(String.valueOf(temp));
				expertInfo.setId(String.valueOf(rs.getInt("ID")));
				expertInfo.setName(rs.getString("NAME"));
				expertInfo.setSex(rs.getString("SEX"));
				expertInfo.setAge(rs.getString("AGE"));
				expertInfo.setTitle(rs.getString("TITLE"));
				expertInfo.setIsPHD(rs.getString("ISPHD"));
				expertInfo.setDept(rs.getString("DEPT"));
				expertInfo.setSpecialty(rs.getString("SPECIALTY"));
				expertInfo.setResearch(rs.getString("RESEARCH"));
				expertInfo.setPhone(rs.getString("PHONE"));
				expertInfo.setEmail(rs.getString("EMAIL"));
				expertInfo.setAddress(rs.getString("ADDRESS"));
				expertInfo.setFaculty(rs.getString("FACULTY"));
				list.add(expertInfo);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询委员信息
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryWYList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			int temp = 0;
			while (rs != null && rs.next() && count > 0) {
				WYBean wyBean = new WYBean();
				temp++;
				wyBean.setSerialNum(String.valueOf(temp));
				wyBean.setId(rs.getString("ID"));
				wyBean.setName(rs.getString("NAME"));
				wyBean.setSex(rs.getString("SEX"));
				wyBean.setDept(rs.getString("DEPT"));
				wyBean.setTitle(rs.getString("TITLE"));
				wyBean.setEmail(rs.getString("EMAIL"));
				wyBean.setTxAddress(rs.getString("TXADDRESS"));
				wyBean.setPhone(rs.getString("PHONE"));
				list.add(wyBean);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	// ɾ����ݿ�ļ�¼
	public boolean deleteItem(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i=1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}

	/**
	 * 向数据库中插入一条记录
	 * @param sql 需要执行的插入sql
	 * @return 插入语句是否执行成功
	 */
	public boolean insertItem(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}

	/*
	 * 
	 */
	public boolean insertMiscountList(String miscountId, String[] mistypeList) {
		String sql = "insert into TB_MISCOUNT_LIST(MISCOUNTID, MISTYPE) values(?, ?)";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			conn.setAutoCommit(false);
			for (String mistype : mistypeList) {
				pst.setString(1, miscountId);
				pst.setString(2, mistype);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		}
		finally {
			closeConnection();
		}
		return true;
	}
	
	
	/**
	 * 向数据库中插入记录
	 * @param sql 需要执行的插入sql
	 * @return 插入语句是否执行成功
	 * @throws SQLException 
	 */
	public boolean insertFacultyAdvice(String reportId, String[] facultyArray) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "insert into TB_FACULTYADVICE(REPORTID,FACULTYID,ISFK) values(?, ?, ?)";
			conn.setAutoCommit(false);
			for (String facultyId:facultyArray){
				if(!facultyId.equals("")) {
					pst.setString(1, reportId);
					pst.setString(2, facultyId);
					pst.setString(3, "0");
					pst.addBatch();
				}
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}

	/**
	 * check loginName exists or not
	 * @param loginName
	 * @return true for not exists, otherwise false
	 */
	public boolean checkNotExist(String loginName) {
		try {
			String sql = "select * from SYS_USER where LOGINNAME=?";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, loginName);
			rs = pst.executeQuery();
			if (rs != null && rs.next()) {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	
	// ������ݿ�ļ�¼
	public boolean updateItem(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	// ��ݱ�Ų�ѯ����������Ϣ
	public EmailBean queryEmailConfig(String sql, String[] params) {
		EmailBean emailBean = null;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				emailBean = new EmailBean();
				emailBean.setID(String.valueOf(rs.getInt("ID")));
				emailBean.setAccountName(rs.getString("ACCOUNTNAME"));
				emailBean.setMailBoxAddress(rs.getString("MAILADDRESS"));
				emailBean.setMailBoxType(rs.getString("MAILBOXTYPE"));
				emailBean.setMailBoxPwd(rs.getString("PWD"));
				emailBean.setSmtpPC(rs.getString("SMTPPC"));
				emailBean.setSmtpPort(String.valueOf(rs.getInt("SMTPPORT")));
				emailBean.setPopPC(rs.getString("POPPC"));
				emailBean.setPopPort(String.valueOf(rs.getInt("POPPORT")));
				emailBean.setIsDefault(rs.getString("ISDEFAULT"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return emailBean;
	}

	/**
	 * ����ֵ��Ų�ѯ�ֵ���Ϣ
	 * 
	 * @param id
	 * @return
	 */
	public DicBean queryDicConfig(String id) {
		DicBean dicBean = null;
		try {
			String sql = "select * from SYS_DATA_DIC where ID=?";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				dicBean = new DicBean();
				dicBean.setId(String.valueOf(rs.getInt("ID")));
				dicBean.setCodeName(rs.getString("CODENAME"));
				dicBean.setCode(rs.getString("CODE"));
				dicBean.setCaption(rs.getString("CAPTION"));
				dicBean.setRemark(rs.getString("REMARK"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return dicBean;
	}

	public PunishBean queryPunishConfig(String id) {
		PunishBean punishBean = null;
		try {
			String sql = "select * from SYS_DATA_DIC where ID=?";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				punishBean = new PunishBean();
				punishBean.setId(String.valueOf(rs.getInt("ID")));
				punishBean.setCodename(rs.getString("CODENAME"));
				punishBean.setCode(rs.getString("CODE"));
				punishBean.setCaption(rs.getString("CAPTION"));
				punishBean.setRemark(rs.getString("REMARK"));
			}
			sql = "select * from SYS_CLJD_RATE where CODE='" + punishBean.getCode() + "'";
			rs = stmt.executeQuery(sql);
			while (rs !=null && rs.next()) {
				punishBean.setYear(rs.getString("YEAR"));
				punishBean.setRate(rs.getString("RATE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return punishBean;
	}
	/**
	 * 
	 * ����˻���Ų�ѯ�Ѿ����յ����ʼ��б�
	 * */
	public ArrayList queryRecvMailList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			while (rs != null && rs.next() && count > 0) {
				RecvMailInfo reInfo = new RecvMailInfo();
				reInfo.setId(String.valueOf(rs.getInt("ID")));
				reInfo.setSendName(rs.getString("SENDNAME"));
				reInfo.setTitle(rs.getString("TITLE"));
				reInfo.setRecvTime(rs.getString("RECVTIME"));
				reInfo.setIsRead(rs.getString("ISREAD"));
				list.add(reInfo);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * �����ʼ���������ȡ�����ʼ���Ϣ�洢�ڱ�����ݿ�
	 * 
	 * @param resultList
	 *            �ʼ����
	 * @param id
	 *            �����������˻����
	 * @return
	 * @throws SQLException
	 */
	public boolean insertRecvMail(ArrayList resultList, String id)
			throws SQLException {
		try {
			RecvMailInfo rmiInfo = null;
			conn.setAutoCommit(false);
			String sql = "insert into TB_RECVMAIL(EMAILID,SENDNAME,RECVNAME,CSNAME,ASNAME,TITLE,ACCESSORY,MAILCONTENT,RECVTIME,SENDTIME,ISREAD,NEEDREPLY,MAILCONFIGID) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pst = conn.prepareStatement(sql);

			for (int i = 0; i < resultList.size(); i++) {
				rmiInfo = (RecvMailInfo) resultList.get(i);
				pst.setString(1, rmiInfo.getEmailID());
				pst.setString(2, rmiInfo.getSendName());
				pst.setString(3, rmiInfo.getRecvName());
				pst.setString(4, rmiInfo.getCsName());
				pst.setString(5, rmiInfo.getAsName());
				pst.setString(6, rmiInfo.getTitle());
				pst.setString(7, rmiInfo.getAccessory());
				pst.setString(8, rmiInfo.getContent());
				pst.setString(9, rmiInfo.getRecvTime());
				pst.setString(10, rmiInfo.getSendTime());
				pst.setString(11, rmiInfo.getIsRead());
				pst.setString(12, rmiInfo.getNeedReply());
				pst.setString(13, id);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			conn.rollback();
			e.printStackTrace();
			return false;
		} finally {
			pst.close();
		}
		return true;
	}

	/**
	 * ����ʼ���Ų�ѯ���ʼ��Ƿ����ڱ�����ݿ���
	 * 
	 * @param emailID
	 *            ���ʼ���������ȡ�����ʼ����
	 * @param flat
	 *            ��ʾ�Ƿ��ǲ�ѯ�����һ����trueʱ�ر�conn
	 * @return ���ڷ���true�������ڷ���false;
	 */
	public boolean checkEmail(String emailID, boolean flat) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "select ID from TB_RECVMAIL where EMAILID=?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, emailID);
			rs = pst.executeQuery();
			
			if (rs.next())
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			/*
			if (flat) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			*/
			closeConnection();
		}
		return false;
	}

	/**
	 * ��ѯָ��Ͷ�����壨�����ߡ��е��ߡ������ߡ����е�λ���ľٱ������б�
	 * 
	 * @param sql
	 * @return
	 */
	public ArrayList queryJBReasonList(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				JBReasonBean jbrb = new JBReasonBean();
				jbrb.setId(String.valueOf(rs.getInt("ID")));
				jbrb.setJbReason(rs.getString("JBREASON"));
				list.add(jbrb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * ������û���ӵ�ĳ��ָ���ĸ�λ��
	 * 
	 * @param posID
	 * @param ids
	 * @return
	 * @throws SQLException
	 */
	public boolean insertPosUser(String posID, String ids) throws SQLException {
		try {
			conn.setAutoCommit(false);
			String sql = "insert into SYS_POSITION_USER(USERID,POSID,ISMAINPOS) values(?,?,'0')";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);

			String[] arrID = ids.split(",");
			for (int i = 0; i < arrID.length; i++) {
				pst.setString(1, posID);
				pst.setString(2, arrID[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		} finally {
			pst.close();
			conn.close();
		}
		return true;
	}

	/**
	 * 向数据库中插入被举报人信息，被举报人可以有多个，放在List集合中
	 * @param resultList
	 * @return
	 * @throws SQLException
	 */
	public boolean insertBeReport(ArrayList resultList) throws SQLException 
	{
		try {
			BeReportBean brb = null;
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "insert into TB_BEREPORTPE(REPORTID,BEREPORTNAME,DEPTNAME,TELPHONE,POSITION) values(?,?,?,?,?)";
			pst = conn.prepareStatement(sql);
			
			AESCrypto aes = new AESCrypto();
			String key = "TB_BEREPORTPE";
			
			for (int i = 0; i < resultList.size(); i++) {
				brb = (BeReportBean) resultList.get(i);
				pst.setString(1, brb.getReportID());
				pst.setBytes(2, aes.createEncryptor(brb.getBeName(), key));
				pst.setBytes(3, aes.createEncryptor(brb.getBeDept(), key));
				pst.setBytes(4, aes.createEncryptor(brb.getBeTelPhone(), key));
				pst.setString(5, brb.getBePosition());
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 关闭数据库连接
	 */
	public void closeConnection()
	{
		try {
			if(stmt!=null)
			{
				stmt.close();
			}
			if(pst!=null)
			{
				pst.close();
			}
			if(conn!=null)
			{
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据sql查询举报信息
	 * @param sql
	 * @return
	 */
	public EventBean queryEvent(String sql, String[] params)
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			
			String attachName = "";
			String isNi = "";
			String faculty = "";
			while (rs != null && rs.next()) {
				EventBean eb = new EventBean();
				eb.setReportID(rs.getString("REPORTID"));
				eb.setSerialNum(rs.getString("SERIALNUM"));
				isNi = rs.getString("ISNI");
				eb.setIsNI(isNi);
				eb.setReportName(new String(aes.createDecryptor(rs.getBytes("REPORTNAME"), key)));
				if(isNi.equals("1"))
				{
					eb.setDept("");
					eb.setGdPhone("");
					eb.setTelPhone("");
					eb.setMailAddress("");
				}
				else
				{
					eb.setDept(new String(aes.createDecryptor(rs.getBytes("REPORTDEPT"), key)));
					eb.setGdPhone(new String(aes.createDecryptor(rs.getBytes("REPORTDH"), key)));
					eb.setTelPhone(new String(aes.createDecryptor(rs.getBytes("REPORTPHONE"), key)));
					eb.setMailAddress(new String(aes.createDecryptor(rs.getBytes("REPORTMAIL"), key)));
				}
				eb.setReportTime(rs.getString("REPORTTIME"));
				eb.setReportType(rs.getString("REPORTTYPE"));
				eb.setCreateTime(rs.getString("CREATETIME"));
				eb.setBeReportName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				eb.setReportReason(new String(aes.createDecryptor(rs.getBytes("REPORTREASON"), key)));
				eb.setReportContent(new String(aes.createDecryptor(rs.getBytes("REPORTCONTENT"), key)));
				eb.setStatus(rs.getString("STATUS"));
				eb.setCreateName(rs.getString("CREATENAME"));
				attachName = rs.getString("ACCESSORY");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/attachment/" + attachName;
				}
				else
				{
					attachName = "";
				}
				eb.setAccessory(attachName);
				eb.setBz(rs.getString("BZ"));
				faculty = rs.getString("FACULTY");
				if(faculty == null)
				{
					faculty = "";
				}
				eb.setFaculty(faculty);
				return eb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询组织信息
	 * @param sql
	 * @return
	 */
	public ZZBean queryZZInfo(String sql, String[] params)
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				ZZBean zzB = new ZZBean();
				zzB.setId(String.valueOf(rs.getInt("ID")));
				zzB.setZzID(rs.getString("ZZID"));
				zzB.setZzName(rs.getString("ZZNAME"));
				zzB.setZzDescribe(rs.getString("ZZDESCRIBE"));
				zzB.setIsJC(rs.getString("ISJC"));
				zzB.setPzzID(rs.getString("PZZID"));
				zzB.setPzzName(rs.getString("PZZNAME"));
				return zzB;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询被举报人信息，返回list
	 * @param sql
	 * @return
	 */
	public ArrayList queryBeReport(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			AESCrypto aes = new AESCrypto();
			String key = "TB_BEREPORTPE";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			BeReportBean brb = null;
			while (rs != null && rs.next()) {
				brb = new BeReportBean();
				brb.setBeName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				brb.setBePosition(rs.getString("POSITION"));
				brb.setBeTelPhone(new String(aes.createDecryptor(rs.getBytes("TELPHONE"), key)));
				brb.setBeDept(new String(aes.createDecryptor(rs.getBytes("DEPTNAME"), key)));
				list.add(brb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}

	/**
	 * 查询核实信息
	 * @param sql
	 * @return
	 */
	public CheckBean queryCheckInfo(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				CheckBean cb = new CheckBean();
				cb.setReportID(rs.getString("REPORTID"));
				cb.setPreAdvice(rs.getString("PREADVICE"));
				cb.setCheckName(rs.getString("CHECKNAME"));
				cb.setCheckTime(rs.getString("CHECKTIME"));
				return cb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询审核信息
	 * @param sql
	 * @return
	 */
	public ApproveBean queryApproveInfo(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				ApproveBean ab = new ApproveBean();
				ab.setReportID(rs.getString("REPORTID"));
				ab.setIsLA(rs.getString("ISLA"));
				ab.setLaAdvice(rs.getString("LAADVICE"));
				ab.setApproveName(rs.getString("APPROVENAME"));
				ab.setApproveTime(rs.getString("APPROVETIME"));
				return ab;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询所有的组织信息，用于生成组织机构树形菜单
	 * @param sql
	 * @return
	 */
	public List queryAllZZ(String sql, String[] params, String type) {
		List<String> lstTree = new ArrayList<String>();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			String result = "";
			String id = "";
			String pId = "";
			String name = "";
			String isJc = "";//是否有下级组织
			
			while (rs != null && rs.next()) {
				id = rs.getString("ZZID");
				pId = rs.getString("PZZID");
				name = rs.getString("ZZNAME");
				isJc = rs.getString("ISJC");
				if(type.equals("1"))
				{
					if(isJc.equals("1"))
					{
						isJc = "true";//有下属组织，不能点击(暂时允许都可以点击)
					}
					else
					{
						isJc = "true";
					}
					result = "{id:" + id + ", pId:" + pId + ", name:\"" + name + "\", click:" + isJc + ", t:\"" + name + "\"}";
				}
				else if(type.equals("2"))
				{
					result = "{id:" + id + ", pId:" + pId + ", name:\"" + name + "\"}";
					/*
					if(isJc.equals("1"))
					{
						result += ",open:true}";
					}
					else
					{
						result += "}";
					}
					*/
				}
				lstTree.add(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return lstTree;
	}
	
	/**
	 * 查询功能的树形菜单
	 * @param sql
	 * @return
	 */
	public List queryModuleTree(String sql, String[] params, List<String> moduleList) {
		List<String> lstTree = new ArrayList<String>();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			String result = "";
			String id = "";
			String pId = "";
			String name = "";
			String open = "";//是否有下级功能
			
			while (rs != null && rs.next()) {
				id = rs.getString("MODULEID");
				pId = rs.getString("PID");
				name = rs.getString("MODULENAME");
				open = rs.getString("ISJC");
				result = "{id:" + id + ", pId:" + pId + ", name:\"" + name + "\"";
				if(open.equals("1"))
				{
					result += ",open:true";
				}
				if(moduleList.contains(id))
				{
					result += ",checked:true}";
				}
				else
				{
					result += "}";
				}
				
				lstTree.add(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return lstTree;
	}
	/**
	 * 对举报者的身份进行核实后，如果身份不真实，将其设置为匿名举报
	 * @param reportID
	 * @return
	 */
	public boolean setNiMing(String reportID)
	{
		try
		{
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "update TB_REPORTINFO set REPORTNAME=?,ISNI='1' where REPORTID='" + reportID + "'";
			pst = conn.prepareStatement(sql);
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			byte[] nameB = aes.createEncryptor("匿名举报", key);
			pst.setBytes(1, nameB);
			pst.execute();
		}
		catch(Exception e)
		{
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	
	public boolean InsertReportInfo(EventBean eb)
	{
		try {
    		String time = SystemShare.GetNowTime("yyyy-MM-dd");
    		
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "insert into TB_REPORTINFO(REPORTID, REPORTNAME,REPORTDEPT,REPORTDH,REPORTPHONE,REPORTMAIL,REPORTTIME,CREATETIME,REPORTTYPE,BEREPORTNAME,REPORTREASON,REPORTCONTENT,BZ,STATUS,CREATENAME,ACCESSORY,ISDELETE,ISNI,SERIALNUM,LASTTIME, SEARCHID) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pst = conn.prepareStatement(sql);
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			byte[] nameB = aes.createEncryptor(eb.getReportName(), key);
			byte[]  deptB= aes.createEncryptor(eb.getDept(), key);
			byte[] dhB = aes.createEncryptor(eb.getGdPhone(), key);
			byte[]  telPhB= aes.createEncryptor(eb.getTelPhone(), key);
			byte[]  mailB= aes.createEncryptor(eb.getMailAddress(), key);
			byte[]  reasonB= aes.createEncryptor(eb.getReportReason(), key);
			byte[]  contentB= aes.createEncryptor(eb.getReportContent(), key);
			byte[] beReB = aes.createEncryptor(eb.getBeReportName(), key);
			pst.setString(1, eb.getReportID());
			pst.setBytes(2, nameB);
			pst.setBytes(3, deptB);
			pst.setBytes(4, dhB);
			pst.setBytes(5, telPhB);
			pst.setBytes(6, mailB);
			pst.setString(7, eb.getReportTime());
			pst.setString(8, eb.getCreateTime());
			pst.setString(9, eb.getReportType());
			pst.setBytes(10, beReB);
			pst.setBytes(11, reasonB);
			//pst.setString(11, eb.getReportReason());
			pst.setBytes(12, contentB);
			pst.setString(13, "");
			pst.setString(14, eb.getStatus());
			pst.setString(15, eb.getCreateName());
			pst.setString(16, eb.getAccessory());
			pst.setString(17, eb.getIsDelete());
			pst.setString(18, eb.getIsNI());
			pst.setString(19, eb.getSerialNum());
			pst.setString(20, time);
			pst.setString(21, eb.getSearchID());
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}

	/**
	 * 关闭conn和pst
	 */
	private void closeConnPst() {
		try {
			pst.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 从指定数据表中批量删除多条记录（真正的删除数据）
	 * @param ids 记录的ID数组
	 * @param tableName 表名
	 * @return
	 * @throws SQLException 
	 */
	public boolean deleteItemsReal(String[] ids, String tableName, String colName) throws SQLException
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "delete from " + tableName + " where " + colName + "=(?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < ids.length; i++) {
				pst.setString(1, ids[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 从指定数据库表中删除指定编号的记录(真正的删除数据)
	 * @param id 编号
	 * @param tableName 表名
	 * @return
	 */
	public boolean deleteItemReal(String id, String tableName, String colName) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "delete from " + tableName + " where " + colName + "=?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 移除用户（从某个组织中，不是删除用户，而是将ZZID设为空）
	 * @param id
	 * @param tableName
	 * @return
	 */
	public boolean removeUser(String id, String tableName) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "update " + tableName + " set ZZID='' where ID=?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 批量移除用户（从某个组织中，不是删除用户，而是将ZZID设为空）
	 * @param ids
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	public boolean removeUsers(String[] ids, String tableName) throws SQLException
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "update " + tableName + " set ZZID='' where ID=(?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < ids.length; i++) {
				pst.setString(1, ids[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		} 
		return true;
	}
	/**
	 * 从指定数据表中批量删除多条记录(仅仅标记删除字段为1,并不真正删除数据，便于以后的恢复和查询)
	 * @param ids 记录的ID数组
	 * @param tableName 表名
	 * @return
	 * @throws SQLException 
	 */
	public boolean deleteItems(String[] ids, String tableName, String colName) throws SQLException
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "update " + tableName + " set ISDELETE='1' where " + colName + "=(?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < ids.length; i++) {
				pst.setString(1, ids[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		} 
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 从指定数据库表中删除指定编号的记录(仅仅标记删除字段为1,并不真正删除数据，便于以后的恢复和查询)
	 * @param id 编号
	 * @param tableName 表名
	 * @return
	 */
	public boolean deleteItem(String id, String tableName, String colName) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "update " + tableName + " set ISDELETE='1' where " + colName + "=?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, id);
			pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 查询统计信息
	 * @param sql
	 * @return
	 */
	public ArrayList queryTjInfo(String sql, String[] params) {
		ArrayList result = new ArrayList();
		ItemAndNum ian;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			String key = "";
			String value = "";
			while (rs != null && rs.next()) {
				ian = new ItemAndNum();
				ian.setItem(rs.getString("TITLE"));
				ian.setNum(rs.getString("NUM"));
				result.add(ian);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 查询受理与立案统计信息
	 * @param sql
	 * @return
	 */
	public HashMap querySlAndLaInfo(String sql, String[] params) {
		HashMap result = new HashMap();
		ItemAndNum ian;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			String key = "";
			String value = "";
			while (rs != null && rs.next()) {
				key = rs.getString("MONTH");
				value = rs.getString("NUM");
				result.put(key, value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return result;
	}

	/**
	 * 查询用户信息
	 * @param sql
	 * @return
	 */
	public UserBean queryUserBean(String sql, String[] params) {
		UserBean userBean;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				userBean = new UserBean();
				userBean.setId(String.valueOf(rs.getInt("ID")));
				userBean.setUserID(rs.getString("USERID"));
				userBean.setUserName(rs.getString("USERNAME"));
				userBean.setLoginName(rs.getString("LOGINNAME"));
				userBean.setPwd(rs.getString("PASSWORD"));
				userBean.setSex(rs.getString("SEX"));
				userBean.setBgPhone(rs.getString("BGPHONE"));
				userBean.setBgsNum(rs.getString("BGSNUM"));
				userBean.setTelPhone(rs.getString("TELPHONE"));
				userBean.setZzID(rs.getString("ZZID"));
				userBean.setZzName(rs.getString("ZZNAME"));
				userBean.setRoleIDs(rs.getString("ROLEIDS"));
				userBean.setMailAddress(rs.getString("MAILADDRESS"));
				userBean.setCreateTime(rs.getString("CREATETIME"));
				userBean.setPosIDs(rs.getString("POSIDS"));
				userBean.setIsHead(rs.getString("ISHEAD"));
				return userBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询专家信息
	 * @param sql
	 * @return
	 */
	public ExpertInfo queryExpertInfo(String sql, String[] params) {
		ExpertInfo expertInfo;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				expertInfo = new ExpertInfo();
				expertInfo.setId(String.valueOf(rs.getInt("ID")));
				expertInfo.setAddress(rs.getString("ADDRESS"));
				expertInfo.setAge(rs.getString("AGE"));
				expertInfo.setDept(rs.getString("DEPT"));
				expertInfo.setEmail(rs.getString("EMAIL"));
				expertInfo.setFaculty(rs.getString("FACULTY"));
				expertInfo.setIsPHD(rs.getString("ISPHD"));
				expertInfo.setName(rs.getString("NAME"));
				expertInfo.setPhone(rs.getString("PHONE"));
				expertInfo.setResearch(rs.getString("RESEARCH"));
				expertInfo.setSex(rs.getString("SEX"));
				expertInfo.setSpecialty(rs.getString("SPECIALTY"));
				expertInfo.setTitle(rs.getString("TITLE"));
				return expertInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询依托单位信息
	 * @param sql
	 * @return
	 */
	public InstituteInfo queryInstituteInfo(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				InstituteInfo instituteInfo = new InstituteInfo();
				instituteInfo.setId(rs.getString("ID"));
				instituteInfo.setCode(rs.getString("CODE"));
				instituteInfo.setName(rs.getString("NAME"));
				instituteInfo.setCategory(rs.getString("CATEGORY"));
				instituteInfo.setAddress(rs.getString("ADDRESS"));
				instituteInfo.setPrincipal(rs.getString("PRINCIPAL"));
				instituteInfo.setPhone(rs.getString("PHONE"));
				return instituteInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	
	/**
	 * query miscount number in the past five years 
	 * @param sql
	 * @return
	 */
	public String queryInstTrend(String sql, String[] params,String name) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			JSONArray array = new JSONArray();
			i = 0;
			int year = Calendar.getInstance().get(Calendar.YEAR);
			while (rs != null && rs.next() && i < 6) {
				JSONObject obj = new JSONObject();
				obj.put("label", String.valueOf(year));
				if(rs.getString("YEAR").equals(String.valueOf(year))) {
					obj.put("value", rs.getString("COUNT"));
				} else {
					obj.put("value", "0");
					rs.previous();
				}
				obj.put("color", "008ee4");
				array.put(5-i, obj);
				year--;
				i++;
			}
			while(i < 6) {
				JSONObject obj = new JSONObject();
				obj.put("label", String.valueOf(year));
				obj.put("value", "0");
				obj.put("color", "008ee4");
				array.put(5-i,obj);
				year--;
				i++;
			}		
						
			JSONObject ret = new JSONObject();
			JSONObject chart = new JSONObject();
			chart.put("caption", name + " 近六年违规人次 " + ++year + "-"  + (year + 5));
			chart.put("bgcolor", "FFFFFF");
			chart.put("showalternatehgridcolor", "0");
			chart.put("plotbordercolor", "008ee4");
		   chart.put("plotborderthickness", "3");
		   chart.put("showvalues", "1");
		   chart.put("divlinecolor", "CCCCCC");
		   chart.put("showcanvasborder", "1");
		   chart.put("tooltipbgcolor", "003333");
		   chart.put("tooltipcolor", "FFFFFF");
		   chart.put("tooltipbordercolor", "003933");
		   chart.put("numdivlines", "2");
		   chart.put("yaxisvaluespadding", "20");
		   chart.put("anchorbgcolor", "003333");
		   chart.put("anchorborderthickness", "0");
		   chart.put("showshadow", "0");
		   chart.put("anchorradius", "4");
		   chart.put("chartrightmargin", "25");
		   chart.put("canvasborderalpha", "0");
		   chart.put("showborder", "0");
		   
		   ret.put("chart", chart);
		   ret.put("data", array);
			return ret.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询科研人员信息
	 * @param sql
	 * @return
	 */
	public IndividualInfo queryIndividualInfo(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				IndividualInfo individualInfo = new IndividualInfo();
				individualInfo.setId(rs.getString("ID"));
				individualInfo.setPid(rs.getString("PiD"));
				individualInfo.setName(rs.getString("NAME"));
				individualInfo.setSex(rs.getString("SEX"));
				individualInfo.setTitle(rs.getString("TITLE"));
				individualInfo.setIsExpert(rs.getString("ISEXPERT"));
				individualInfo.setSpecialty(rs.getString("SPECIALTY"));
				individualInfo.setPhone(rs.getString("PHONE"));
				individualInfo.setEmail(rs.getString("EMAIL"));
				individualInfo.setAddress(rs.getString("ADDRESS"));
				individualInfo.setInstCode(rs.getString("INSTITUTE"));
				individualInfo.setInstitute(rs.getString("INSTNAME"));
				return individualInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询不端行为记录信息
	 * @param sql
	 * @return
	 */
	public MiscountInfo queryMiscountInfo(String sql, String[] params) {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				MiscountInfo miscountInfo = new MiscountInfo();
				miscountInfo.setId(String.valueOf(rs.getInt("ID")));
				miscountInfo.setMiscountId(rs.getString("MISCOUNTID"));
				miscountInfo.setTitle(rs.getString("TITLE"));
				miscountInfo.setIndividual(rs.getString("INDI"));
				miscountInfo.setInstitute(rs.getString("INST"));
				miscountInfo.setReportId(rs.getString("REPORTID"));
				miscountInfo.setMistype(rs.getString("MISNAME"));
				miscountInfo.setPunish(rs.getString("PUNISHMENT"));
				miscountInfo.setTime(rs.getString("TIME"));
				miscountInfo.setDetail(rs.getString("DETAIL"));
				return miscountInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
		
	
	/**
	 * 查询联系人
	 * @param sql
	 * @return
	 */
	public ContactBean queryAddrBean(String sql, String[] params) {
		ContactBean contactBean;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				contactBean = new ContactBean();
				contactBean.setId(String.valueOf(rs.getInt("ID")));
				contactBean.setContactName(rs.getString("CONNAME"));
				contactBean.setContactAddr(rs.getString("CONADDR"));
				return contactBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询委员信息
	 * @param sql
	 * @return
	 */
	public WYBean queryWYBean(String sql, String[] params) {
		WYBean wyBean;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				wyBean = new WYBean();
				wyBean.setId(String.valueOf(rs.getInt("ID")));
				wyBean.setName(rs.getString("NAME"));
				wyBean.setSex(rs.getString("SEX"));
				wyBean.setDept(rs.getString("DEPT"));
				wyBean.setTitle(rs.getString("TITLE"));
				wyBean.setTxAddress(rs.getString("TXADDRESS"));
				wyBean.setEmail(rs.getString("EMAIL"));
				wyBean.setPhone(rs.getString("PHONE"));
				return wyBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询岗位信息
	 * @param sql
	 * @return
	 */
	public PosBean queryPosBean(String sql, String[] params) {
		PosBean posBean;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				posBean = new PosBean();
				posBean.setId(String.valueOf(rs.getInt("ID")));
				posBean.setPosName(rs.getString("POSNAME"));
				posBean.setPosDescribe(rs.getString("POSDESCRIBE"));
				return posBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询组织信息
	 * @param sql
	 * @return
	 */
	public ZZBean queryZZBean(String sql, String[] params) {
		ZZBean zzBean;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				zzBean = new ZZBean();
				zzBean.setId(String.valueOf(rs.getInt("ID")));
				zzBean.setZzID(rs.getString("ZZID"));
				zzBean.setZzDescribe(rs.getString("ZZDESCRIBE"));
				zzBean.setZzName(rs.getString("ZZNAME"));
				zzBean.setPzzID(rs.getString("PZZID"));
				zzBean.setPzzName(rs.getString("PZZNAME"));
				return zzBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * query mistype information
	 * @param sql
	 * @return
	 */
	public MistypeBean queryMistypeBean(String sql, String[] params) {
		MistypeBean mistypeBean;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				mistypeBean = new MistypeBean();
				mistypeBean.setId(String.valueOf("ID"));
				mistypeBean.setRid(rs.getString("RID"));
				mistypeBean.setRname(rs.getString("RNAME"));
				mistypeBean.setPrid(rs.getString("PRID"));
				mistypeBean.setPname(rs.getString("PNAME"));
				mistypeBean.setRsort(rs.getString("RSORT"));
				mistypeBean.setIsjc(rs.getString("ISJC"));
				mistypeBean.setWeight(rs.getString("WEIGHT"));
				
				return mistypeBean;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	
	/**
	 * 查询角色信息
	 * @param sql
	 * @return
	 */
	public RoleBean queryRoleBean(String sql, String[] params) {
		RoleBean rb;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				rb = new RoleBean();
				rb.setId(String.valueOf(rs.getInt("ID")));
				rb.setRoleName(rs.getString("RoleName"));
				rb.setRoleDescribe(rs.getString("ROLEDESCRIBE"));
				rb.setIsUse(rs.getString("ISUSE"));
				return rb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 保存消息提醒内容到数据库表中
	 * @param userName 发起人
	 * @param recvName 接收人数组
	 * @param reportID 举报事件编号
	 * @param sendTime 发起时间
	 * @param msgType 消息类型（1工作提醒，2消息提醒，3邮件提醒）
	 * @param isHandle 是否处理
	 * @param isNotify 是否已提醒
	 * @return
	 * @throws SQLException 
	 */
	public boolean saveMsgNotify(String sendName, String[] recvName,
			String reportID, String sendTime, String msgType, String isHandle, String isNotify) throws SQLException {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "insert into TB_MSGNOTIFY(RECVNAME,SENDNAME,REPORTID,SENDTIME,TYPE,ISHANDLE,ISNOTIFY) values(?,?,?,?,?,?,?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i <recvName.length; i++) {
				pst.setString(1, recvName[i]);
				pst.setString(2, sendName);
				pst.setString(3, reportID);
				pst.setString(4, sendTime);
				pst.setString(5, msgType);
				pst.setString(6, isHandle);
				pst.setString(7, isNotify);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		} 
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 查询消息提醒内容
	 * @param sql
	 * @return
	 */
	public ArrayList queryMsgNotify(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				MsgNotifyBean mnb = new MsgNotifyBean();
				mnb.setId(rs.getString("ID"));
				mnb.setReportID(rs.getString("REPORTID"));
				mnb.setSendName(rs.getString("SENDNAME"));
				if(type.equals("1") || type.equals("4"))//待办事项，将类型转变为消息
				{
					mnb.setType(GetDBSXFromType(rs.getString("TYPE")));
				}
				else
				{
					mnb.setType(rs.getString("TYPE"));
				}
				mnb.setSendTime(rs.getString("SENDTIME"));
				list.add(mnb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 根据消息类型得到待办事项显示的信息
	 * @param type
	 * @return
	 */
	public String GetDBSXFromType(String type)
	{
		String result = "";
		if(type.equals("1"))
		{
			result = SystemConstant.DBSX_CHECK;
		}
		else if (type.equals("4")) {
			result = SystemConstant.DBSX_XBYJ;
		}
		else
		{
			result = "";
		}
		return result;
	}
	/**
	 * 将指定的消息提醒状态修改为已提醒，避免持续弹窗！result中存放需要更新状态的MsgNotifyBean
	 * @param result
	 * @throws SQLException 
	 */
	public boolean updateMsgNotify(ArrayList result) throws SQLException {
		
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "update TB_MSGNOTIFY set ISNOTIFY='1' where ID=?";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i <result.size(); i++) {
				MsgNotifyBean mnb = (MsgNotifyBean)result.get(i);
				pst.setString(1, mnb.getId());
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		} 
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 查询某一个组织下的所有子组织编号，返回最大的编号，用于添加新的组织时确定下一个组织编号
	 * @param sql
	 * @return
	 */
	public String queryZZID(String sql, String[] params) {
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			//已经按照编号倒序查询，第一条记录即是最大的编号
			while (rs != null && rs.next()) {
				result = rs.getString("ZZID");
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 查询某一个组织下的所有子组织编号，返回最大的编号，用于添加新的组织时确定下一个组织编号
	 * @param sql
	 * @return
	 */
	public String queryZZName(String sql, String[] params) {
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			//已经按照编号倒序查询，第一条记录即是最大的编号
			while (rs != null && rs.next()) {
				result = rs.getString("ZZNAME");
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally
		{
			closeConnection();
		}
		return result;
	}
	
	/**
	 * query max RID of the group has the same prid
	 * @param sql
	 * @return
	 */
	public String queryMistypeRid(String sql, String[] params) {
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			// order by RID desc limit 1
			while (rs != null && rs.next()) {
				result = rs.getString("RID");
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally
		{
			closeConnection();
		}
		return result;
	}
	
	/**
	 * 查询专家鉴定意见(根据举报单编号)
	 * @param sql
	 * @return
	 */
	public ArrayList queryExpertAdvice(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int j = 1;
			for(String param: params) {
				pst.setString(j++, param);
			}
			rs = pst.executeQuery();
			ExpertAdvice ea = null;
			String attachName = "";
			String advice = "";
			String conclusion = "";
			String jdConclusion = "";
			String[] jdConArr;
			String[] conArr;
			String isEmail = "";
			while (rs != null && rs.next()) {
				ea = new ExpertAdvice();
				ea.setExpertName(rs.getString("EXPERTNAME"));
				ea.setId(rs.getString("ID"));
				conclusion = rs.getString("CONCLUSION");
				ea.setTime(rs.getString("TIME"));
				advice = rs.getString("ADVICE");
				
				//只有通过发送邮件，并且鉴定专家在线提交的鉴定结论，需要将结论“是、否、不确定”与问题进行关联！人工录入的专家鉴定鉴定意见不需要关联
				isEmail = rs.getString("ISEMAIL");
				if(type.equals("2"))
				{
					jdConclusion = rs.getString("JDCONCLUSION");
					if(conclusion != null && !conclusion.equals(""))
					{
						if(jdConclusion != null && !jdConclusion.equals("") && isEmail.equals("1"))
						{
							jdConArr = jdConclusion.split("\n");
							conArr = conclusion.split(",");
							if(jdConArr.length == conArr.length)
							{
								conclusion = "";
								for(int i = 0; i < jdConArr.length; i++)
								{
									conclusion += jdConArr[i] + "，鉴定结论：" + conArr[i] + "\n\n";
								}
							}
						}
						conclusion = conclusion.replaceAll("\n", "<br/>");
					}
					if(advice != null && !advice.equals(""))
					{
						advice = advice.replaceAll("\n", "<br/>");
					}
				}
				ea.setConclusion(conclusion);
				ea.setAdvice(advice);
				ea.setIsFK(rs.getString("ISFK"));
				attachName = rs.getString("ATTACHNAME");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/attachment/" + attachName;
					ea.setAttachName(attachName);
				}
				else
				{
					ea.setAttachName("");
				}
				ea.setIsEmail(isEmail);
				list.add(ea);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询当事人陈述
	 * @param sql
	 * @return
	 */
	public ArrayList queryLitigantState(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			LitigantState ls = null;
			String attachName = "";
			String litigantContent = "";
			String talkRecorder = "";
			while (rs != null && rs.next()) {
				ls = new LitigantState();
				ls.setId(rs.getString("ID"));
				ls.setLitigantName(rs.getString("LITIGANTNAME"));
				ls.setLitigantTime(rs.getString("LITIGANTTIME"));
				litigantContent = rs.getString("LITIGANTCONTENT");
				talkRecorder = rs.getString("TALKRECORDER");
				if(type.equals("2"))
				{
					if(litigantContent != null && !litigantContent.equals(""))
					{
						litigantContent = litigantContent.replaceAll("\n", "<br/>");
					}
					if(talkRecorder != null && !talkRecorder.equals(""))
					{
						talkRecorder = talkRecorder.replaceAll("\n", "<br/>");
					}
				}
				ls.setLitigantContent(litigantContent);
				ls.setTalkRecorder(talkRecorder);
				attachName = rs.getString("ATTACHNAME");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/attachment/" + attachName;
					ls.setFilePath(attachName);
				}
				else
				{
					ls.setFilePath("");
				}
				list.add(ls);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	
	/**
	 * query faculty advice
	 * @param sql
	 * @return
	 */
	public ArrayList queryFacultyAdvice(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();

			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			while (rs != null && rs.next()) {
				FacultyAdviceBean facultyAdvice = new FacultyAdviceBean();
				facultyAdvice.setId(rs.getString("ID"));
				facultyAdvice.setIsfk(rs.getString("ISFK"));
				facultyAdvice.setFktime(rs.getString("FKTIME"));
				facultyAdvice.setFacultyId(rs.getString("FACULTYID"));
				facultyAdvice.setReportId(rs.getString("REPORTID"));
				if(type.equals("1") || type.equals("2")) {
					facultyAdvice.setFacultyName(rs.getString("FACULTYNAME"));
				}
				String advice = rs.getString("ADVICE");
				if(type.equals("2"))
				{
					advice.replace("\n", "<br/>");
				}
				facultyAdvice.setAdvice(advice);
				if(type.equals("0") || type.equals("1")) {
					facultyAdvice.setSerialNum(rs.getString("SERIALNUM"));
					facultyAdvice.setReportName(new String(aes.createDecryptor(rs.getBytes("REPORTNAME"), key)));
					facultyAdvice.setBeReportName(new String(aes.createDecryptor(rs.getBytes("BEREPORTNAME"), key)));
				}
				if(type.equals("0"))
					facultyAdvice.setFilePath(SystemConstant.GetServerPath() + "/attachment/" + rs.getString("FILENAME"));
				list.add(facultyAdvice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/* queary multi dcbg files
	 * 
	 */
	public String[] queryDcbgFiles(String sql, String[] params, String dirPath) {
		
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			int i = 0;
			ArrayList<String> pathList = new ArrayList<String>();
			while (rs != null && rs.next()) {
				pathList.add(dirPath + "/attachment/" +  rs.getString("FILENAME"));
			}
			return pathList.toArray(new String[0]);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally
		{
			closeConnection();
		}
	}
	
	/**
	 * 查询依托单位意见
	 * @param sql
	 * @return
	 */
	public ArrayList queryDeptAdvice(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			DeptAdvice da = null;
			String attachName = "";
			String advice = "";
			String expertAdvice = "";
			while (rs != null && rs.next()) {
				da = new DeptAdvice();
				da.setId(rs.getString("ID"));
				da.setDept(rs.getString("DEPT"));
				da.setTime(rs.getString("TIME"));
				advice = rs.getString("ADVICE");
				expertAdvice = rs.getString("EXPERTADVICE");
				if(type.equals("2"))
				{
					if(advice != null && !advice.equals(""))
					{
						advice = advice.replaceAll("\n", "<br/>");
					}
					if(expertAdvice != null && !expertAdvice.equals(""))
					{
						expertAdvice = expertAdvice.replaceAll("\n", "<br/>");
					}
				}
				da.setAdvice(advice);
				da.setIsFK(rs.getString("ISFK"));
				attachName = rs.getString("ATTACHNAME");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/" +  "attachment" + "/" + attachName;
					da.setAttachName(attachName);
				}
				else
				{
					da.setAttachName("");
				}
				da.setExpertAdvice(expertAdvice);
				da.setIsLetter(rs.getString("ISLETTER"));
				list.add(da);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查看复议申请列表
	 * @param sql
	 * @param type
	 * @return
	 */
	public ArrayList queryFYApplyList(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			FYApply fyApply = null;
			String attachName = "";
			String shortInfo = "";
			while (rs != null && rs.next()) {
				fyApply = new FYApply();
				fyApply.setId(rs.getString("ID"));
				fyApply.setFyApplyName(rs.getString("FYAPPLYNAME"));
				fyApply.setFyTime(rs.getString("FYTIME"));
				shortInfo = rs.getString("SHORTINFO");
				if(type.equals("2"))
				{
					if(shortInfo != null && !shortInfo.equals(""))
					{
						shortInfo = shortInfo.replaceAll("\n", "<br/>");
					}
				}
				fyApply.setShortInfo(shortInfo);
				attachName = rs.getString("ATTACHPATH");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/" + attachName;
					fyApply.setAttachPath(attachName);
				}
				else
				{
					fyApply.setAttachPath("");
				}
				list.add(fyApply);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询处理决定
	 * @param sql
	 * @return
	 */
	public ArrayList queryHandleDecide(String sql, String type, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			HandleDecide hd = null;
			String attachName = "";
			String decideContent = "";
			String filePath = "";
			while (rs != null && rs.next()) {
				hd = new HandleDecide();
				hd.setId(rs.getString("ID"));
				hd.setReportID(rs.getString("REPORTID"));
				hd.setSerialNum(rs.getString("SERIALNUM"));
				hd.setHandleName(rs.getString("HANDLENAME"));
				hd.setDeptName(rs.getString("DEPTNAME"));
				hd.setShortInfo(rs.getString("SHORTINFO"));
				hd.setConference(rs.getString("CONFERENCE"));
				hd.setHandleTime(rs.getString("HANDLETIME"));
				decideContent = rs.getString("DECIDECONTENT");
				filePath = rs.getString("FILEPATH");
				if(filePath != null && !filePath.equals(""))
				{
					filePath = SystemConstant.GetServerPath() + "/attachment/" + filePath;
					hd.setFilePath(filePath);
				}
				else
				{
					hd.setFilePath("");
				}
				if(type.equals("2"))
				{
					if(decideContent != null && !decideContent.equals(""))
					{
						decideContent = decideContent.replaceAll("\n", "<br/>");
					}
				}
				hd.setDecideContent(decideContent);
				attachName = rs.getString("ATTACHNAME");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/attachment/" + attachName;
					hd.setAttachName(attachName);
				}
				else
				{
					hd.setAttachName("");
				}
				list.add(hd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询处理决定
	 * @param sql
	 * @return
	 */
	public HandleDecide queryHandleDecideBean(String sql, String[] params) {
		HandleDecide hd = null;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				hd = new HandleDecide();
				hd.setId(rs.getString("ID"));
				hd.setReportID(rs.getString("REPORTID"));
				hd.setSerialNum(rs.getString("SERIALNUM"));
				hd.setHandleName(rs.getString("HANDLENAME"));
				hd.setDeptName(rs.getString("DEPTNAME"));
				hd.setShortInfo(rs.getString("SHORTINFO"));
				hd.setConference(rs.getString("CONFERENCE"));
				hd.setHandleTime(rs.getString("HANDLETIME"));
				hd.setDecideContent(rs.getString("DECIDECONTENT"));
				hd.setFilePath(rs.getString("FILEPATH"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return hd;
	}
	/**
	 * 查询复议申请信息，单个
	 * @param sql
	 * @return
	 */
	public FYApply queryFYApplyInfo(String sql, String[] params) {
		FYApply fyApply = null;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				fyApply = new FYApply();
				fyApply.setId(rs.getString("ID"));
				fyApply.setReportID(rs.getString("REPORTID"));
				fyApply.setFyApplyName(rs.getString("FYAPPLYNAME"));
				fyApply.setFyTime(rs.getString("SHORTINFO"));
				fyApply.setAttachPath(rs.getString("ATTACHPATH"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return fyApply;
	}
	/**
	 * 查询依托单位调查函
	 * @param sql
	 * @return
	 */
	public DeptSurveyLetter queryDeptSurveyLetter(String sql, String[] params) {
		DeptSurveyLetter dsl = null;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			
			while (rs != null && rs.next()) {
				dsl = new DeptSurveyLetter();
				dsl.setId(rs.getString("ID"));
				dsl.setReportID(rs.getString("REPORTID"));
				dsl.setAdviceID(rs.getString("DEPTADVICEID"));
				dsl.setTitle(rs.getString("TITLE"));
				dsl.setDeptName(rs.getString("DEPTNAME"));
				dsl.setShortInfo(rs.getString("SHORTINFO"));
				dsl.setFkTime(rs.getString("FKTIME"));
				dsl.setSurveyContent(rs.getString("SURVEYCONTENT"));
				dsl.setFilePath(rs.getString("FILEPATH"));
				dsl.setLoginName(rs.getString("LOGINNAME"));
				dsl.setPassword(rs.getString("PASSWORD"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return dsl;
	}
	/**
	 * 查询处理流程
	 * @param sql
	 * @return
	 */
	public ArrayList queryHandleFlow(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			HandleFlow hf = null;
			int i = 0;
			while (rs != null && rs.next()) {
				hf = new HandleFlow();
				hf.setId(rs.getString("ID"));
				hf.setSerialNum(String.valueOf(++i));
				hf.setName(rs.getString("NAME"));
				hf.setTime(rs.getString("TIME"));
				hf.setType(rs.getString("TYPE"));
				hf.setStatus(rs.getString("CAPTION"));
				hf.setFlowType(rs.getString("FLOWTYPE"));
				hf.setDescribe(rs.getString("DESCRIPTION"));
				hf.setSel("true");
				list.add(hf);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 插入系统操作日志
	 * @param li
	 * @return
	 */
	public boolean insertLogInfo(LogBean lb)
	{
		try {
			Date currentTime = new Date();
			SimpleDateFormat forma = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String createTime = forma.format(currentTime);
			
		//	String sql = "insert into SYS_LOGINFO(OPERATOR,TIME,LOGTYPE,DETAIL,IPADDR) values('" + lb.getOperator() + "','" + createTime + "','" + lb.getLogType() + "','" + lb.getDetail() + "','" + lb.getIpAddr() + "')";
			String sql = "insert into SYS_LOGINFO(OPERATOR,TIME,LOGTYPE,DETAIL,IPADDR) values(?, ?, ?, ?, ?)";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, lb.getOperator());
			pst.setString(2, createTime);
			pst.setString(3, lb.getLogType());
			pst.setString(4, lb.getDetail());
			pst.setString(5, lb.getIpAddr());
			
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 插入日志文件
	 * @param operator 操作员
	 * @param logType 日志类型
	 * @param detail 详情
	 * @param ipAddr IP地址
	 * @return
	 */
	public boolean insertLogInfo(String operator, String logType, String detail, String ipAddr)
	{
		try {
			String createTime = SystemShare.GetNowTime("yyyy-MM-dd HH:mm:ss");
			String sql = "insert into SYS_LOGINFO(OPERATOR,TIME,LOGTYPE,DETAIL,IPADDR) values(?, ?, ?, ?, ?)";
		//	String sql = "insert into SYS_LOGINFO(OPERATOR,TIME,LOGTYPE,DETAIL,IPADDR) values('" + operator + "','" + createTime + "','" + logType + "','" + detail + "','" + ipAddr+ "')";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, operator);
			pst.setString(2, createTime);
			pst.setString(3, logType);
			pst.setString(4, detail);
			pst.setString(5, ipAddr);
			
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}	
	
	/**
	 * 根据提供的表名、字段名、和字段值查询指定字段的值
	 * @param tableName 表名
	 * @param resultCol 结果列
	 * @param colName 判断条件的列
	 * @param value 值
	 * @return
	 */
	public String querySingleDate(String tableName, String resultCol, String colName, String value)
	{
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "select " + resultCol + " from " + tableName + " where " + colName + " =?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, value);
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result = rs.getString(resultCol);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 查询当前最大编号
	 * @param sql
	 * @return
	 */
	public String querySerialNum(String sql, String[] params)
	{
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result = rs.getString("SERIALNUM");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	
	/**
	 * 查询指定数据库表最近插入记录的主键ID
	 * @param tableName 数据库表名
	 * @return
	 */
	public String queryLastInsertID(String tableName)
	{
		String result = "";
		try {
			String sql = "select ID from " + tableName + " order by ID desc limit 1";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result = rs.getString("ID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 将上传的附件信息保存到数据库中
	 * @param fileName 附件名称
	 * @param filePath 附件目录
	 * @param uploadName 上传者
	 * @return
	 */
	public boolean InsertAttachment(String fileName, String filePath, String uploadName)
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			Date currentTime = new Date();
    		SimpleDateFormat forma = new SimpleDateFormat("yyyy-MM-dd");
    		String createTime = forma.format(currentTime);
			String sql = "insert into SYS_ATTACHMENT(FILENAME,CREATETIME,EXTNAME,SIZE,UPLOADNAME,FILEPATH) values(?, ?, '', '', ?, ?)";
			pst = conn.prepareStatement(sql);
			pst.setString(1, fileName);
			pst.setString(2, createTime);
			pst.setString(3, uploadName);
			pst.setString(4, filePath);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 同时插入多条附件信息到数据库
	 * @param list
	 * @return
	 * @throws SQLException
	 */
	public boolean InsertAttachList(ArrayList list) throws SQLException
	{
		try {
			AttachBean ab = null;
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			
    		String createTime = SystemShare.GetNowTime("yyyy-MM-dd");
    		
			String sql = "insert into SYS_ATTACHMENT(FILENAME,CREATETIME,UPLOADNAME,FILEPATH) values(?,'" + createTime + "',?,?)";
			pst = conn.prepareStatement(sql);
			
			AESCrypto aes = new AESCrypto();
			String key = "TB_BEREPORTPE";
			
			for (int i = 0; i < list.size(); i++) {
				ab = (AttachBean) list.get(i);
				pst.setString(1, ab.getFileName());
				pst.setString(2, ab.getUploadName());
				pst.setString(3, ab.getFilePath());
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			conn.rollback();
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 插入事件的处理过程，例如：接收举报、初步核实、审核等
	 * @param reportID 事件编号
	 * @param name 处理人姓名
	 * @param type 处理类型
	 * @param status 当前状态
	 * @return
	 */
	public boolean InsertHandleProcess(String reportID, String name, String type, String status, String flowType, String describe)
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
    		String time = SystemShare.GetNowTime("yyyy-MM-dd");
			String sql = "insert into TB_HANDLEPROCESS(REPORTID,NAME,TIME,TYPE,STATUS,FLOWTYPE,DESCRIPTION) values(?, ?, ?, ?, ?, ?, ?)";
			pst = conn.prepareStatement(sql);
			pst.setString(1, reportID);
			pst.setString(2, name);
			pst.setString(3, time);
			pst.setString(4, type);
			pst.setString(5, status);
			pst.setString(6, flowType);
			pst.setString(7, describe);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 更新某事件最近一次操作的时间，用于统计
	 * @param reportID
	 * @return
	 */
	public boolean UpdateLastTime(String reportID)
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
    		String time = SystemShare.GetNowTime("yyyy-MM-dd");
			String sql = "update TB_REPORTINFO set LASTTIME=? where REPORTID=?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, time);
			pst.setString(2, reportID);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 插入角色和功能模块的对应关系
	 * @param ids 功能模块的数组
	 * @param roleID 角色编号
	 * @return
	 * @throws SQLException
	 */
	public boolean InsertRoleModule(String[] ids, String roleID) throws SQLException
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "insert into SYS_ROLE_MODULE(ROLEID,MODULEID) values('" + roleID + "',?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < ids.length; i++) {
				pst.setString(1, ids[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 插入用户所属的角色信息
	 * @param ids 角色编号，
	 * @param loginName 用户账号
	 * @return
	 * @throws SQLException
	 */
	public boolean InsertUserRole(String[] ids, String loginName) throws SQLException
	{
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "insert into SYS_ROLE_USER(LOGINNAME,ROLEID) values('" + loginName + "',?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < ids.length; i++) {
				pst.setString(1, ids[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 根据角色编号，查询对应的功能模块
	 * @param sql
	 * @return
	 */
	public ArrayList queryModuleFormRole(String sql, String[] params) {
		ArrayList moduleList = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			String moduleID = "";
			String[] temp;
			while (rs != null && rs.next()) {
				moduleID = rs.getString("MODULEIDS");
				if(!moduleID.equals(""))
				{
					temp = moduleID.split(",");
					for(i = 0; i < temp.length; i++)
					{
						moduleList.add(temp[i]);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return moduleList;
	}
	/**
	 * 查询指定角色的功能模块
	 * @param sql
	 * @return
	 */
	public String queryModuleIDs(String sql, String[]params)
	{
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param : params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result = rs.getString("MODULEIDS");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 根据角色编号查询角色名称
	 * @param sql
	 * @return
	 */
	public String queryRoleNames(String sql, String[] params) {
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result += rs.getString("ROLENAME") + ",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 查询担任职务信息
	 * @param sql
	 * @return
	 */
	public String queryPosNames(String sql, String[] params) {
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for(String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result += rs.getString("POSNAME") + ",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 插入反馈信息到数据库，用于实名举报者根据查询码在线查询
	 * @param reportID
	 * @param info
	 * @param time
	 * @return
	 */
	public boolean InsertFKInfo(String reportID, String info, String time)
	{
		boolean result = false;
		try {
			//仅仅反馈那些实名的网络举报
		//	String sql = "select SEARCHID from TB_REPORTINFO where REPORTID='" + reportID + "' and REPORTTYPE='" + SystemConstant.JBFS_WLJB + "' and ISNI='0'";
			String sql = "select SEARCHID from TB_REPORTINFO where REPORTID=?  and REPORTTYPE='" + SystemConstant.JBFS_WLJB + "' and ISNI='0'";
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, reportID);
			rs = pst.executeQuery();
			String searchID = "";
			while (rs != null && rs.next()) {
				searchID = rs.getString("SEARCHID");
			}
			if(searchID != null && !searchID.equals(""))
			{
				WsjbDBTools db = new WsjbDBTools();
				db.InsertFKInfo(time, info, searchID);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 查询未审核的事件
	 * @param sql
	 * @return
	 */
	public String queryUnApprove(String sql, String[] params)
	{
		String result = "";
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				result += rs.getString("REPORTID") + ",";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	/**
	 * 批量更新某表中某个字段的指定ID为指定值
	 * @param arrID ID数组
	 * @param tableName 数据表名称
	 * @param colName 比较的列名称
	 * @param targetCol 更新的列名称
	 * @param value 值
	 * @return
	 * @throws SQLException 
	 */
	public boolean updateItems(String[] arrID, String tableName, String colName, String targetCol,
			String value) throws SQLException {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
			String sql = "update " + tableName + " set " + targetCol + "='" + value + "' where " + colName + "=(?)" ;
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < arrID.length; i++) {
				pst.setString(1, arrID[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 选择一些案件后，提交全委会讨论，将每个案件的处理过程都增加一条记录
	 * @param arrID
	 * @param userName
	 * @param time
	 * @param type
	 * @param status
	 * @param flowType
	 * @param describe
	 * @return
	 * @throws SQLException
	 */
	public boolean qwhtlRecorder(String[] arrID, String userName, String time, String type, String status, String flowType, String describe) throws SQLException {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
		//	String sql = "insert into TB_HANDLEPROCESS(REPORTID,NAME,TIME,TYPE,STATUS, FLOWTYPE, DESCRIPTION) values((?),'" + userName + "', '" + time + "', '" + type + "','" + status + "','" + flowType + "','" + describe + "')";
			String sql = "insert into TB_HANDLEPROCESS(REPORTID,NAME,TIME,TYPE,STATUS, FLOWTYPE, DESCRIPTION) values( ?, ?, ?, ?, ?, ?, ?)";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < arrID.length; i++) {
				pst.setString(1, arrID[i]);
				pst.setString(2, userName);
				pst.setString(3, time);
				pst.setString(4, type);
				pst.setString(5, status);
				pst.setString(6, flowType);
				pst.setString(7, describe);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 向鉴定专家发送完邮件后，自动往数据库中增加一条记录
	 * @param arrID
	 * @param reportID
	 * @return
	 * @throws SQLException
	 */
	public boolean InsertExpertAdviceInfo(String[] arrID, String reportID) throws SQLException {
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			conn.setAutoCommit(false);
    		String time = SystemShare.GetNowTime("yyyy-MM-dd");
			String sql = "insert into TB_EXPERTADVICE(REPORTID,EXPERTNAME,TIME) values('" + reportID + "',(?),'" + time + "')";
			
			pst = conn.prepareStatement(sql);
			for (int i = 0; i < arrID.length; i++) {
				pst.setString(1, arrID[i]);
				pst.addBatch();
			}
			pst.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}
	/**
	 * 查询给某个专家发送的邮件信息
	 * @param sql
	 * @return
	 */
	public EmailInfo queryExpertEmail(String sql, String[] params) {
		EmailInfo ei = null;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int i = 1;
			for (String param: params) {
				pst.setString(i++, param);
			}
			rs = pst.executeQuery();
			
			String attachNames = "";
			String reportID = "";
			while (rs != null && rs.next()) {
				ei = new EmailInfo();
				reportID = rs.getString("REPORTID");
				ei.setSendName(rs.getString("EXPERTNAME"));
				ei.setRecvName(rs.getString("EMAILADDRESS"));
				ei.setTitle(rs.getString("TITLE"));
				ei.setContent(rs.getString("EMAILCONTENT"));
				ei.setLoginName(rs.getString("LOGINNAME"));
				ei.setPassword(rs.getString("PASSWORD"));
				
				attachNames = rs.getString("ATTACHMENT");
				if(attachNames != null && !attachNames.equals(""))
				{
					ArrayList attachList = new ArrayList();
					String[] attachArr = attachNames.split(":");
					String attachPath = "";
					String serverPath = SystemConstant.GetServerPath() + "/" + "attachment/expert/";
					for(i = 0; i < attachArr.length; i++)
					{
						attachPath = serverPath + "/" + reportID + "/" + attachArr[i];
						UrlAndName uan = new UrlAndName();
						uan.setName(attachArr[i]);
						uan.setUrl(attachPath);
						attachList.add(uan);
					}
					ei.setAttachList(attachList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return ei;
	}
	/**
	 * 根据编号查询选择要合并的调查报告的文件路径
	 * @param sql
	 * @return
	 */
	public ArrayList queryCombineReport(String sql, String[] params) {
		ArrayList result = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			
			while (rs != null && rs.next()) {
				result.add(rs.getString("FILENAME"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return result;
	}
	
	/**
	 * 查询已合并的调查报告列表
	 * @param rs
	 * @param rowsPerPage
	 * @return
	 */
	public ArrayList queryCombineReportList(ResultSet rs, int rowsPerPage) {
		ArrayList list = new ArrayList();
		try {
			int count = rowsPerPage;
			CombineReport cr = null;
			String reportIDs = "";
			while (rs != null && rs.next() && count>0) {
				cr = new CombineReport();
				cr.setId(rs.getString("ID"));
				reportIDs = rs.getString("REPORTIDS");
				if(!reportIDs.equals(""))
				{
					EventBean eb = null;
					ArrayList tempList = new ArrayList();
					String[] arrIDs = reportIDs.split(",");
					for(int j = 0; j < arrIDs.length; j++)
					{
						eb = new EventBean();
						eb.setReportID(arrIDs[j]);
						tempList.add(eb);
					}
					cr.setReportIDList(tempList);
				}
				cr.setReportIDs(rs.getString("REPORTIDS"));
				cr.setFileName(rs.getString("FILEPATH"));
				cr.setFilePath(SystemConstant.GetServerPath() + "/attachment/surveyReport/" +  rs.getString("FILEPATH"));
				cr.setCreateTime(rs.getString("CREATETIME"));
				list.add(cr);
				count--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/**
	 * 查询已合并的调查报告列表
	 * @param sql
	 * @return
	 */
	public ArrayList queryCombineReportList(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			CombineReport cr = null;
			String reportIDs = "";
			while (rs != null && rs.next()) {
				cr = new CombineReport();
				cr.setId(rs.getString("ID"));
				reportIDs = rs.getString("REPORTIDS");
				if(!reportIDs.equals(""))
				{
					EventBean eb = null;
					ArrayList tempList = new ArrayList();
					String[] arrIDs = reportIDs.split(",");
					for(int i = 0; i < arrIDs.length; i++)
					{
						eb = new EventBean();
						eb.setReportID(arrIDs[i]);
						tempList.add(eb);
					}
					cr.setReportIDList(tempList);
				}
				cr.setReportIDs(rs.getString("REPORTIDS"));
				cr.setFileName(rs.getString("FILEPATH"));
				cr.setFilePath(SystemConstant.GetServerPath() + "/attachment/surveyReport/" +  rs.getString("FILEPATH"));
				cr.setCreateTime(rs.getString("CREATETIME"));
				list.add(cr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	
	/**
	 * 查询反馈信息：包括单位调查结果、专家鉴定意见等
	 * @param sql
	 * @return
	 */
	public ArrayList queryReplyList(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			
			ReplyInfo ri = null;
			while (rs != null && rs.next()) {
				ri = new ReplyInfo();
				ri.setId(rs.getString("ID"));
				ri.setReportID(rs.getString("REPORTID"));
				ri.setTime(rs.getString("TIME"));
				ri.setType(rs.getString("TYPE"));
				ri.setFkName(rs.getString("FKNAME"));
				list.add(ri);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询鉴定专家需要鉴定的案件列表
	 * @param sql
	 * @return
	 */
	public ArrayList queryExpertJDList(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			int count = 0;
			ExpertIdentityBean eib = null;
			String jdhpath = "";
			String yjspath = "";
			String attachNames = "";
			String attachPath = "";
			String reportID = "";
			String status = "";
			String[] attachArr;
			ArrayList attachList;
			String serverPath = SystemConstant.GetServerPath() + "/" + "attachment" + "/";
			while (rs != null && rs.next()) {
				count ++;
				eib = new ExpertIdentityBean();
				eib.setId(rs.getString("ID"));
				reportID = rs.getString("REPORTID");
				eib.setReportID(reportID);
				eib.setSerialNum(String.valueOf(count));
				eib.setEventTitle(rs.getString("EVENTTITLE"));
				eib.setAdviceID(rs.getString("ADVICEID"));
				eib.setIsSubmit(rs.getString("ISSUBMIT"));
				/*
				jdhpath = rs.getString("JDHPATH");
				if(jdhpath != null && !jdhpath.equals(""))
				{
					jdhpath = serverPath + jdhpath;
				}
				else
				{
					jdhpath = "";
				}
				yjspath = rs.getString("YJSPATH");
				if(yjspath != null && !yjspath.equals(""))
				{
					yjspath = serverPath + yjspath;
				}
				else
				{
					yjspath = "";
				}
				eib.setLetterPath(jdhpath);
				eib.setAdviceLetterPath(yjspath);
				*/
				attachNames = rs.getString("ATTACHMENT");
				if(attachNames != null && !attachNames.equals(""))
				{
					attachList = new ArrayList();
					attachArr = attachNames.split(":");
					for(int i = 0; i < attachArr.length; i++)
					{
						attachPath = serverPath + "/" + reportID + "/" + attachArr[i];
						UrlAndName uan = new UrlAndName();
						uan.setName(attachArr[i]);
						uan.setUrl(attachPath);
						attachList.add(uan);
					}
					eib.setAttachList(attachList);
				}
				status = rs.getString("STATUS");
				if(!status.equals(SystemConstant.SS_SURVEYING))
				{
					status = "";
				}
				eib.setStatus(status);
				list.add(eib);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询案件相关的专家鉴定函和鉴定意见书文档路径
	 * @param sql
	 * @return
	 */
	public ExpertFile queryExpertFile(String sql, String[] params) {
		ExpertFile ef = new ExpertFile();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			String jdhpath = "";
			String yjspath = "";
			String serverPath = SystemConstant.GetServerPath() + "/" + "attachment" + "/";
			while (rs != null && rs.next()) {
				jdhpath = rs.getString("JDHPATH");
				if(jdhpath != null && !jdhpath.equals(""))
				{
					jdhpath = serverPath + jdhpath;
				}
				else
				{
					jdhpath = "";
				}
				yjspath = rs.getString("YJSPATH");
				if(yjspath != null && !yjspath.equals(""))
				{
					yjspath = serverPath + yjspath;
				}
				else
				{
					yjspath = "";
				}
				ef.setJdhPath(jdhpath);
				ef.setYjsPath(yjspath);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return ef;
	}
	/**
	 * 查询依托单位调查案件列表
	 * @param sql
	 * @return
	 */
	public ArrayList queryDeptDCList(String sql, String[] params) {
		ArrayList list = new ArrayList();
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			int count = 0;
			DeptDCBean db = null;
			String filePath = "";
			String status = "";
			String serverPath = SystemConstant.GetServerPath() + "/attachment/";
			while (rs != null && rs.next()) {
				count ++;
				db = new DeptDCBean();
				db.setId(rs.getString("ID"));
				db.setSerialNum(String.valueOf(count));
				db.setReportID(rs.getString("REPORTID"));
				db.setIsSubmit(rs.getString("ISSUBMIT"));
				db.setAdviceID(rs.getString("ADVICEID"));
				db.setTitle(rs.getString("TITLE"));
				db.setDeptName(rs.getString("DEPTNAME"));
				db.setShortInfo(rs.getString("SHORTINFO"));
				db.setFkTime(rs.getString("FKTIME"));
				db.setSurveyContent(rs.getString("SURVEYCONTENT"));
				filePath = rs.getString("FILEPATH");
				if(filePath != null && !filePath.equals(""))
				{
					filePath = serverPath + filePath;
				}
				else
				{
					filePath = "";
				}
				db.setFilePath(filePath);
				status = rs.getString("STATUS");
				if(!status.equals(SystemConstant.SS_SURVEYING))
				{
					status = "";
				}
				db.setStatus(status);
				list.add(db);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return list;
	}
	/**
	 * 查询鉴定意见书内容
	 * @param sql
	 * @return
	 */
	public JDYJSBean queryJDYJS(String sql, String[] params) {
		JDYJSBean jb;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				jb = new JDYJSBean();
				jb.setId(rs.getString("ID"));
				jb.setReportID(rs.getString("REPORTID"));
				jb.setEventReason(rs.getString("EVENTREASON"));
				jb.setIdentifyContent(rs.getString("IDENTIFYCONTENT"));
				jb.setWtDept(rs.getString("WTDEPT"));
				jb.setJdConclusion(rs.getString("JDCONCLUSION"));
				return jb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询专家鉴定函信息
	 * @param sql
	 * @return
	 */
	public ExpertJDH queryExpertJDH(String sql, String[] params) {
		ExpertJDH ejdh;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				ejdh = new ExpertJDH();
				ejdh.setId(rs.getString("ID"));
				ejdh.setReportID(rs.getString("REPORTID"));
				ejdh.setTitle(rs.getString("TITLE"));
				ejdh.setShortInfo(rs.getString("SHORTINFO"));
				ejdh.setFkTime(rs.getString("FKTIME"));
				ejdh.setTarget(rs.getString("TARGET"));
				ejdh.setJdContent(rs.getString("JDCONTENT"));
				return ejdh;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * check is exist?
	 */
	public boolean queryISEXIST(String sql, String[] params) {
		boolean flag=false;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			
			if (!rs.next()) {
				flag=true;
			}
			else
			{
				flag=false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return flag;
	}
	/**
	 * 查询鉴定意见已经提交的信息
	 * @param sql
	 * @return
	 */
	public JDYJSBean queryExpertFK(String sql, String[] params) {
		JDYJSBean jb;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				jb = new JDYJSBean();
				jb.setEventReason(rs.getString("EVENTREASON"));
				jb.setIdentifyContent(rs.getString("IDENTIFYCONTENT"));
				jb.setWtDept(rs.getString("WTDEPT"));
				jb.setJdConclusion(rs.getString("JDCONCLUSION"));
				jb.setConclusion(rs.getString("CONCLUSION"));
				jb.setJdAdvice(rs.getString("ADVICE"));
				String attachName = rs.getString("ATTACHMENT");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/" +  "attachment" + "/" + attachName;
					jb.setFilePath(attachName);
				}
				else
				{
					jb.setFilePath("");
				}
				return jb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询收件阅办单信息
	 * @param sql
	 * @return
	 */
	public SjybdBean querySJYBD(String sql, String[] params) {
		SjybdBean sb;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				sb = new SjybdBean();
				sb.setId(rs.getString("ID"));
				sb.setSerialNum(rs.getString("SERIALNUM"));
				sb.setReportID(rs.getString("REPORTID"));
				sb.setComeName(rs.getString("COMENAME"));
				sb.setTitle(rs.getString("TITLE"));
				sb.setRecvTime(rs.getString("RECVTIME"));
				sb.setFilePath(rs.getString("FILEPATH"));
				return sb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 查询单位提交的调查结果
	 * @param sql
	 * @return
	 */
	public DeptAdviceBean queryDeptAdvice(String sql, String[] params) {
		DeptAdviceBean dab;
		try {
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			pst = conn.prepareStatement(sql);
			int paramIndex = 1;
			for(String param: params) {
				pst.setString(paramIndex++, param);
			}
			rs = pst.executeQuery();
			while (rs != null && rs.next()) {
				dab = new DeptAdviceBean();
				dab.setDeptAdvice(rs.getString("ADVICE"));
				dab.setExpertAdvice(rs.getString("EXPERTADVICE"));
				dab.setLitigantName(rs.getString("LITIGANTNAME"));
				dab.setAttitude(rs.getString("LITIGANTCONTENT"));
				dab.setLitigantTime(rs.getString("LITIGANTTIME"));	
				String attachName = rs.getString("ATTACHNAME");
				if(attachName != null && !attachName.equals(""))
				{
					attachName = SystemConstant.GetServerPath() + "/" +  "attachment" + "/" + attachName;
					dab.setFilePath(attachName);
				}
				else
				{
					dab.setFilePath("");
				}			
				return dab;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			closeConnection();
		}
		return null;
	}
	/**
	 * 更新事件信息
	 * @param eb
	 * @return
	 */
	public boolean updateReportInfo(EventBean eb)
	{
		try {
    		
			conn = DBPools.getSimpleModel().getDataSource().getConnection();
			String sql = "update TB_REPORTINFO set REPORTREASON=(?),REPORTCONTENT=(?) where REPORTID='" + eb.getReportID() + "'";
			pst = conn.prepareStatement(sql);
			AESCrypto aes = new AESCrypto();
			String key = "TB_REPORTINFO";
			byte[] reportReasonB = aes.createEncryptor(eb.getReportReason(), key);
			byte[] reportContentB= aes.createEncryptor(eb.getReportContent(), key);
			
			pst.setBytes(1, reportReasonB);
			pst.setBytes(2, reportContentB);
			
			pst.execute();
		} catch (Exception e) {
			return false;
		}
		finally
		{
			closeConnection();
		}
		return true;
	}

}
