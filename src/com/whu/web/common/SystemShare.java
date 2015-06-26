package com.whu.web.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.whu.tools.CheckPage;
import com.whu.tools.DBTools;
import com.whu.tools.DebugLog;
import com.whu.tools.SystemConstant;
import com.whu.web.attach.AttachBean;
public class SystemShare {
	/**
	 * 该方法被需要使用分页的Action公用，用于生成分页数据
	 * @param request
	 * @param pageBean
	 * @param flag 1表示有数据，0表示没有数据
	 */
	public static void SplitPageFun(HttpServletRequest request, CheckPage pageBean, int flag) {
		if(flag == 1)
		{
			int totalRows = pageBean.getTotalRows();
			int pagecount = pageBean.getTotalPage();
			int currentPage = pageBean.getQueryPageNo();
			request.setAttribute("pageNum",String.valueOf(currentPage));
			request.setAttribute("totalRows",String.valueOf(totalRows));
			request.setAttribute("pageCount",String.valueOf(pagecount));
		}
		else if(flag == 0)
		{
			request.setAttribute("pageNum",String.valueOf(0));
			request.setAttribute("totalRows",String.valueOf(0));
			request.setAttribute("pageCount",String.valueOf(0));
		}
	}
	/**
	 * 创建JSON语句
	 * @param hashTable
	 * @param response
	 */
	public static void CreateJSON(Hashtable hashTable, HttpServletResponse response)
	{
		try
		{
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		
		String key = "";
		
		for(Iterator it = hashTable.keySet().iterator(); it.hasNext();)
		{
			key = (String)it.next();
			json.put(key, hashTable.get(key));
		}
		out.write(json.toString());
		out.flush();
		out.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	/**
	 * 将字节数组转换为十六进制字符串，主要用于加密数据的查询
	 * @param b
	 * @return
	 * @throws Exception
	 */
		public static String getHexString(byte[] b) throws Exception {
		  String result = "";
		  for (int i=0; i < b.length; i++) {
		    result += Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring( 1 );
		  }
		  return result;
		}

		/**
		 * 将十六进制字符串转换为字节数组
		 * @param hexString
		 * @return
		 */
		public static byte[] getByteArray(String hexString) {
		  return new BigInteger(hexString,16).toByteArray(); 
		}
		/**
		 * 根据阶段编号得到阶段名称
		 * @param jdID
		 * @return
		 */
		public static String GetJDName(String jdID)
		{
			String result = "";
			//受理阶段
			if(jdID.equals(SystemConstant.SS_SLJD))
			{
				result = "sljd";
			}
			else if(jdID.equals(SystemConstant.SS_LADCJD))//立案调查阶段
			{
				result = "ladcjd";
			}
			else if(jdID.equals(SystemConstant.SS_CLJD))//处理阶段
			{
				result = "cljd";
			}
			else if(jdID.equals(SystemConstant.SS_SJSH))//事件审核
			{
				result = "sjsh";
			}
			else if(jdID.equals(SystemConstant.SS_ALL))//所有事件
			{
				result = "all";
			}
			else if(jdID.equals(SystemConstant.SS_DELETE))//已删除事件
			{
				result = "delete";
			}
			return result;
		}
		/**
		 * 将文件夹path1中的文件移动到path2，用于文件上传之后，移动到相应的事件目录下
		 * @param path1
		 * @param path2
		 * @return
		 */
		public static boolean IOCopy(String originDirectory, String targetDirectory, String relDirectory, String userName) {			
			File origindirectory = new File(originDirectory);   //源路径File实例
            File targetdirectory = new File(targetDirectory);  //目标路径File实例
            
            if(!origindirectory.isDirectory()){    //判断是不是正确的路径
        		    //System.out.println("源目录不存在！");
                    //return false;
            	origindirectory.mkdir();
            }
            if(!targetdirectory.isDirectory())
            {
         	   targetdirectory.mkdir();
            }
            
            String filePath = "";
            String serverIPAddr  = "/" + relDirectory;
            ArrayList list = new ArrayList();
            AttachBean ab = null;
            File[] fileList = origindirectory.listFiles();  //目录中的所有文件
            
            for(File file : fileList){
                      if(!file.isFile())   //判断是不是文件
                      continue;
                      try{
                               FileInputStream fin = new FileInputStream(file);
                               BufferedInputStream bin = new BufferedInputStream(fin);
                               filePath = targetdirectory.getAbsolutePath()+"/"+file.getName();
                               serverIPAddr += "/" + file.getName();
                               PrintStream pout = new PrintStream(filePath);
                               BufferedOutputStream bout = new BufferedOutputStream(pout);
                               int total =bin.available();  //文件的总大小
                               int percent = total/100;    //文件总量的百分之一
                               int count;
                               while((count = bin.available())!= 0){
                                          int c = bin.read();  //从输入流中读一个字节
                                          bout.write((char)c);  //将字节（字符）写到输出流中     

                                          if(((total-count) % percent) == 0){
                                                   double d = (double)(total-count) / total; //必须强制转换成double
                                           }
                               }
                               
                               String extName = filePath.substring(filePath.lastIndexOf(".")+1);
                               if(!extName.equals("swf"))//不保存swf文件
                               {
	                               //保存附件信息到数据库中
	                               ab = new AttachBean();
	                               ab.setFileName(file.getName());
	                               ab.setUploadName(userName);
	                               ab.setFilePath(serverIPAddr);
	                               list.add(ab);
                               }
                               serverIPAddr = "/" + relDirectory;
                               
                               bout.close();
                               pout.close();
                               bin.close();
                               fin.close();
                      }catch(IOException e){
                               e.printStackTrace();
                               return false;
                      }
                      finally
                      {
                          //删除临时文件夹中的文件
                          file.delete();
                      }
           }
            
            //保存附件信息到数据库
           if(list.size()>0)
      	   {
      		  DBTools dbTools = new DBTools();
      		  try {
					dbTools.InsertAttachList(list);
				} catch (SQLException e) {
					e.printStackTrace();
					DebugLog.WriteDebug(e);
					return false;
				}
      	  }
          return true;
		}
		/**
		 * 向专家发送邮件时，将发送的附件保存到系统文件夹下，用于专家反馈是查看所有接收到附件
		 * @param originDirectory
		 * @param targetDirectory
		 * @return
		 */
		public static String SaveEmailAttach(String originDirectory, String targetDirectory) {			
			File origindirectory = new File(originDirectory);   //源路径File实例
            File targetdirectory = new File(targetDirectory);  //目标路径File实例
            
            if(!origindirectory.isDirectory()){
            	origindirectory.mkdir();
            }
            if(!targetdirectory.isDirectory())
            {
         	   targetdirectory.mkdir();
            }
            
            String filePath = "";
            String result = "";
            File[] fileList = origindirectory.listFiles();  //目录中的所有文件
            
            for(File file : fileList){
                      if(!file.isFile())   //判断是不是文件
                      continue;
                      try{
                               FileInputStream fin = new FileInputStream(file);
                               BufferedInputStream bin = new BufferedInputStream(fin);
                               filePath = targetdirectory.getAbsolutePath()+"/"+file.getName();
                               PrintStream pout = new PrintStream(filePath);
                               BufferedOutputStream bout = new BufferedOutputStream(pout);
                               int total =bin.available();  //文件的总大小
                               int percent = total/100;    //文件总量的百分之一
                               int count;
                               while((count = bin.available())!= 0){
                                          int c = bin.read();  //从输入流中读一个字节
                                          bout.write((char)c);  //将字节（字符）写到输出流中     

                                          if(((total-count) % percent) == 0){
                                                   double d = (double)(total-count) / total; //必须强制转换成double
                                           }
                               }
                               
                               //以“：”分割
                               result += file.getName() + ":";
                               
                               bout.close();
                               pout.close();
                               bin.close();
                               fin.close();
                      }catch(IOException e){
                               //e.printStackTrace();
                               return "";
                      }
                      finally
                      {
                          file.delete();
                      }
           }
            if(!result.equals(""))
            {
            	result = result.substring(0, result.length() - 1);
            }
          return result;
		}
		/**
		 * 将文件从一个路径转存到另一个目录下
		 * @param filePath 源文件的绝对路径
		 * @param dirPath 目的文件夹
		 * @param createName 操作者
		 * @return
		 */
		public static boolean IOCopyFile(String filePath, String dirPath, String createName)
		{
			File srcFile = new File(filePath);
			File targetdirectory = new File(dirPath);
			if(!targetdirectory.isDirectory())
            {
         	   targetdirectory.mkdir();
            }
			try
			{
				FileInputStream fin = new FileInputStream(srcFile);
	            BufferedInputStream bin = new BufferedInputStream(fin);
	            filePath = targetdirectory.getAbsolutePath()+"/"+srcFile.getName();
	            PrintStream pout = new PrintStream(filePath);
	            BufferedOutputStream bout = new BufferedOutputStream(pout);
	            int total =bin.available();  //文件的总大小
	            int percent = total/100;    //文件总量的百分之一
	            int count;
	            while((count = bin.available())!= 0){
	                       int c = bin.read();  //从输入流中读一个字节
	                       bout.write((char)c);  //将字节（字符）写到输出流中     
	
	                       if(((total-count) % percent) == 0){
	                                double d = (double)(total-count) / total; //必须强制转换成double
	                        }
	            }
	            
	            //保存附件信息到数据库中
                AttachBean ab = new AttachBean();
                ab.setFileName(srcFile.getName());
                ab.setUploadName(createName);
                ab.setFilePath(filePath);
                ArrayList list = new ArrayList();
                list.add(ab);
                DBTools dbTools = new DBTools();
        		  try {
  					dbTools.InsertAttachList(list);
  				} catch (SQLException e) {
  					e.printStackTrace();
  					return false;
  				}
  				
	            bout.close();
                pout.close();
                bin.close();
                fin.close();
			}
			catch (Exception e) {
				return false;
			}
			return true;
		}
		/**
		 * 从远程下载文件
		 * @param srcPath 源文件路径，格式为http://192.168.*.*:80/NSFCOSC/upload/xxxx.doc
		 * @param dirPath 保存路径，本地路径，格式为C:/program files/...，注意，没有文件名，是目录
		 * @param fileName 保存的文件名
		 * @param serverPath 本地服务器保存的路径,格式为http://192.168.*.*:80/KXJJBDXW/upload/xxxx.doc
		 * @return
		 */
		public static boolean DownloadFile(String srcPath, String dirPath, String fileName, String serverPath, String name)
		{
			int bytesum = 0;
			int byteread = 0;
			File targetdirectory = new File(dirPath);
			if(!targetdirectory.isDirectory())
            {
				targetdirectory.mkdir();
            }
			try {
				String urlStr = encode(srcPath, "utf-8");
				URL url = new URL(urlStr);
				URLConnection conn = url.openConnection();
				InputStream inStream = conn.getInputStream();
				FileOutputStream fs = new FileOutputStream(dirPath + fileName);
				byte[] buffer = new byte[1204];
				int length;
				while ((byteread = inStream.read(buffer)) != -1) {
					bytesum += byteread;
					//System.out.println(bytesum);
					fs.write(buffer, 0, byteread);
				}
				 //保存附件信息到数据库中
                AttachBean ab = new AttachBean();
                ab.setFileName(fileName);
                ab.setUploadName(name);
                ab.setFilePath(serverPath);
                ArrayList list = new ArrayList();
                list.add(ab);
                DBTools dbTools = new DBTools();
        		  try {
  					dbTools.InsertAttachList(list);
  				} catch (SQLException e) {
  					e.printStackTrace();
  					return false;
  				}
  				
				inStream.close();
				fs.close();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return true;
		}
		/**
		 * 为了支持中文的路径，必须转码
		 * @param str
		 * @param charset
		 * @return
		 * @throws UnsupportedEncodingException
		 */
		public static String encode(String str, String charset)  throws UnsupportedEncodingException {  
		    String zhPattern = "[\u4e00-\u9fa5]+";  
		    Pattern p = Pattern.compile(zhPattern);  
		    Matcher m = p.matcher(str);  
		    StringBuffer b = new StringBuffer();  
		    while (m.find()) {  
		        m.appendReplacement(b, URLEncoder.encode(m.group(0), charset));  
		    }  
		    m.appendTail(b);  
		    return b.toString();  
		}
		/**
		 * 根据扩展名判断文件是否属于doc,docx,ppt,pptx,xls,xlsx
		 * @param extName
		 * @return
		 */
		public static boolean ISDoc(String extName)
		{
			if(extName.equals("doc") || extName.equals("docx") || extName.equals("ppt") || extName.equals("pptx") || extName.equals("xls") || extName.equals("xlsx"))
			{
				return true;
			}
			return false;
		}
		/**
		 * 得到下一个编号
		 * @return
		 */
		public static String GetSerialNum(String sql, String[] params)
		{
			DBTools dbTools = new DBTools();
			String maxSerialNum = dbTools.querySerialNum(sql, params);
			String serialNum = "001";
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			if(!maxSerialNum.equals(""))
			{
				String num = maxSerialNum.substring(4, maxSerialNum.length());
				int lastYear = Integer.parseInt(maxSerialNum.substring(0, 4));
				
				int tempNum = 0;
				//生成最新编号，如果当前年份与上一条记录相同，则累加；如果不同，则从1开始编号
				if(lastYear == year)
				{
					tempNum = Integer.parseInt(num)+1;
				}
				else
				{
					tempNum = 1;
				}
				
				String lastNum =  String.valueOf(tempNum);
				
				int lastNumLength = lastNum.length();
				//在编号前面补0，例如：5变为005,45变成045,120保持不变
				switch(lastNumLength)
				{
				case 1:
					lastNum = "00" + lastNum;
					break;
				case 2:
					lastNum = "0" + lastNum;
					break;
				default:
						break;
				}
				serialNum = String.valueOf(year) + lastNum;
			}
			else
			{
				serialNum = String.valueOf(year) + serialNum;
			}
			return serialNum;
		}
		/**
		 * 得到服务器的IP地址
		 * @return
		 */
		public static String GetIPAddr()
		{
			try
			{
				Enumeration<NetworkInterface> e=NetworkInterface.getNetworkInterfaces();
		        while(e.hasMoreElements())
		        {
		        	NetworkInterface ni = e.nextElement();
		        	 if (ni.isLoopback() || ni.isVirtual() || !ni.isUp())
		                    continue;
		        	 for (Enumeration<InetAddress> ias = ni.getInetAddresses(); ias.hasMoreElements();) {
		                    InetAddress ia = ias.nextElement();
		                    if (ia instanceof Inet6Address) continue;
		                   return ia.getHostAddress();
		                }
		        }
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			return "127.0.0.1";
		}
		/**
		 * 从磁盘删除指定路径的文件
		 * @param filePath
		 * @return
		 */
		public static boolean  deleteFileFromDisk(String filePath)
		{
			try
			{
				if(filePath.equals(""))
				{
					return true;
				}
				File file = new File(filePath);
				if(file.exists())
				{
					file.delete();
					return true;
				}
			}
			catch (Exception e) {
				e.printStackTrace();
				return false;
			}
			return true;
		}
		/**
		 * 删除指定文件夹下的所有文件
		 * @param dirPath 目标文件夹
		 * @return
		 */
		public static boolean deleteAllFiles(String dirPath)
		{
			File targetPath = new File(dirPath);
			if(!targetPath.isDirectory())//如果目录不存在，直接返回
			{
				return true;
			}
			File[] fileList = targetPath.listFiles();  //目录中的所有文件
            try
            {
	            for(File file : fileList){
	                      if(!file.isFile())   //判断是不是文件
	                    	  continue;
	                      file.delete();
	            }
            }
            catch (Exception e) {
				return false;
			}
			return true;
		}
		/**
		 * 根据状态的名称得到编码，用于统计时
		 * @param status
		 * @return
		 */
		public static String GetStatusFormName(String status)
		{
			String result = "";
			if(status.equals("已初步核实"))
			{
				result = "11";
			}
			else if(status.equals("已受理"))
			{
				result = "12";
			}
			else if(status.equals("不予调查"))
			{
				result = "41";
			}
			else if(status.equals("调查中"))
			{
				result = "22";
			}
			else if(status.equals("处理讨论中"))
			{
				result = "30";
			}
			else if(status.equals("已处理"))
			{
				result = "31";
			}
			else if(status.equals("已结束"))
			{
				result = "40";
			}
			else if(status.equals("异议申请"))
			{
				result = "32";
			}
			else if(status.equals("未受理"))
			{
				result = "42";
			}
			return result;
		}
		/**
		 * 根据id得到阶段名称，1受理阶段，2立案调查阶段，3处理阶段，4结束
		 * @param id
		 * @return
		 */
		public static String GetJDNameFormID(String id)
		{
			String result = "";
			if(id.equals("1"))
			{
				result = "受理阶段";
			}
			else if(id.equals("2"))
			{
				result = "立案调查阶段";
			}
			else if(id.equals("3"))
			{
				result = "处理阶段";
			}
			else if(id.equals("4"))
			{
				result = "存档备查";
			}
			return result;
		}
		/**
		 * 得到指定位数随机数
		 * @return
		 */
		public static String GetRandomString(int n)
		{
			String result = "";
			String[] jschars = new String[]{"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		    double id = 0;
			for(int i = 0; i < n ; i ++) {
		         id = Math.ceil(Math.random()*35);
		        result += jschars[(int) id];
		    }
			return result;
		}
		/**
		 * 获得当前时间
		 * @param format 时间格式化，例如：yyyy-MM-dd
		 * @return
		 */
		public static String GetNowTime(String format)
		{
			String result = "";
			Date currentTime = new Date();
			SimpleDateFormat forma = new SimpleDateFormat(format);
			result = forma.format(currentTime);
			return result;
		}
}