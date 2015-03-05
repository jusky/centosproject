package com.whu.web.servlets;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import com.whu.tools.DBTools;
import com.whu.web.common.SystemShare;

public class UploadWordServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public UploadWordServlet() {
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
		try{
			// 解析 request，判断是否有上传文件   
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart) {
				String fileRealPath = "";//文件存放真实地址
				
				String fileRealResistPath = "";//文件存放真实相对路径
				String reportID="";//id
				String handleName=""; //处理人姓名
				String serialNum = "";
				String firstFileName="";
				String docUrl = "";
				String isEdit = "";
				String type="";
				
				// 创建磁盘工厂，利用构造器实现内存数据储存量和临时储存路径 
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// 设置最多只允许在内存中存储的数据,单位:字节   
				// factory.setSizeThreshold(4096);   
				// 设置文件临时存储路径   
				// factory.setRepository(new File("D:\\Temp"));   
				// 产生一新的文件上传处理程式   
				ServletFileUpload upload = new ServletFileUpload(factory);
				// 设置路径、文件名的字符集   
				upload.setHeaderEncoding("UTF-8");
				// 设置允许用户上传文件大小,单位:字节   
				upload.setSizeMax(-1);
				//upload.setSizeMax(1024 * 1024);
				// 解析请求，开始读取数据   
				// Iterator<FileItem> iter = (Iterator<FileItem>) upload.getItemIterator(request);   
				// 得到所有的表单域，它们目前都被当作FileItem  
				BufferedInputStream in = null;
				List fileItems = upload.parseRequest(request);
				// 依次处理请求   
				Iterator iter = fileItems.iterator();
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();
					if (item.isFormField()) {
						// 如果item是正常的表单域   
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						if(name.equals("reportID"))
							reportID=value;//时间编号赋值
						else if(name.equals("handleName"))
							handleName=java.net.URLDecoder.decode(value, "UTF-8");//处理人姓名
						else if(name.equals("serialNum"))
							serialNum=value;//处理决定编号赋值
						else if(name.equals("isEdit"))
							isEdit=value;//是否编辑，如果是编辑，则不需要将文件名保存到数据库中
						else if(name.equals("type"))
							type=value;
					} else {
						// 如果item是文件上传表单域   
						// 获得文件名及路径   
						String fileName = item.getName();
						if (fileName != null) {
							firstFileName=item.getName().substring(item.getName().lastIndexOf("\\")+1);
							in = new BufferedInputStream(item.getInputStream());// 获得文件输入流
						}
					}
				}
				//上传文件夹绝对路径
				String physicsPath ="";
				if(type.equals("combineReport"))//合并的调查报告
				{
					fileRealPath = request.getRealPath("") + "/attachment/surveyReport/" + handleName;
				}
				else
				{
					physicsPath = request.getRealPath("") + "/attachment/" + reportID + "/";
					File file = new File(physicsPath);
					if (!file.isDirectory()) {
						file.mkdir();
					}
					
					String formatName = firstFileName.substring(firstFileName.lastIndexOf("."));//获取文件后缀名	
					String fileName = "";
					if(handleName != null && !"".equals(handleName.trim())){
						fileName = handleName + formatName;
						fileRealPath = physicsPath + fileName;//文件存放真实地址
					}
					docUrl = reportID + "/" + fileName;
				}
				
				BufferedOutputStream outStream = new BufferedOutputStream(new FileOutputStream(new File(fileRealPath)));// 获得文件输出流
				Streams.copy(in, outStream, true);// 开始把文件写到你指定的上传文件夹			
		 
				//上传成功，则插入数据库
				if (new File(fileRealPath).exists() && isEdit.equals("0") && !type.equals("combineReport")) {
					DBTools dbTools = new DBTools();
					String tempsql="select * from TB_EXPERTFILE where REPORTID='" + reportID + "'";
					String sql = "";
					if(type.equals("surveyReport"))
					{
						
						String createTime = SystemShare.GetNowTime("yyyy-MM-dd");
						sql = "insert into TB_SURVEYREPORT(REPORTID, UPDATETIME, FILENAME) values('" + reportID + "','" + createTime + "','" + docUrl + "')";
					}
					else if(type.equals("handleDecide"))
					{
						sql = "update TB_HANDLEDECIDE set FILEPATH='" + docUrl + "' where SERIALNUM='" + serialNum + "'";
					}
					else if(type.equals("deptSurveyLetter"))
					{
						sql = "update TB_DEPTSURVEYLETTER set FILEPATH='" + docUrl + "' where ID=" + serialNum;
					}
					else if(type.equals("expertJDH"))
					{
						//sql = "if not exists(select * from TB_EXPERTFILE where REPORTID='" + reportID + "') insert into TB_EXPERTFILE(REPORTID, JDHPATH) values('" + reportID + "','" + docUrl + "') else update TB_EXPERTFILE set JDHPATH='" + docUrl + "' where REPORTID='" + reportID + "'";
						boolean flag=dbTools.queryISEXIST(tempsql);
						if(flag)
						{
							sql="insert into TB_EXPERTFILE(REPORTID, JDHPATH) values('" + reportID + "','" + docUrl + "')";
						}
						else
						{
							sql="update TB_EXPERTFILE set JDHPATH='" + docUrl + "' where REPORTID='" + reportID + "'";
						}
					}
					else if(type.equals("expertJDYJS"))
					{
						//sql = "if not exists(select * from TB_EXPERTFILE where REPORTID='" + reportID + "') insert into TB_EXPERTFILE(REPORTID, YJSPATH) values('" + reportID + "','" + docUrl + "') else update TB_EXPERTFILE set YJSPATH='" + docUrl + "' where REPORTID='" + reportID + "'";
						boolean flag=dbTools.queryISEXIST(tempsql);
						if(flag)
						{
							sql="insert into TB_EXPERTFILE(REPORTID, YJSPATH) values('" + reportID + "','" + docUrl + "')";
						}
						else
						{
							sql="update TB_EXPERTFILE set YJSPATH='" + docUrl + "' where REPORTID='" + reportID + "'";
						}
					}
					else if(type.equals("sjybd"))
					{
						sql = "insert into TB_SJYBDINFO(REPORTID,FILEPATH) values('" + reportID + "','" + docUrl + "')";
					}
					dbTools.insertItem(sql);
					//保存到数据库,供下次编辑时提供路径信息
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			//response.setContentType("text/html;charset=UTF-8");
			//out.print("<script>window.alert('上传失败！文件大小超过1MB！');</script>");
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
