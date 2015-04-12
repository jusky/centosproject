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
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import com.whu.tools.DBTools;
import com.whu.tools.SystemConstant;
import com.whu.web.common.DocConverter;
import com.whu.web.common.SystemShare;

public class UploadServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public UploadServlet() {
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
		String loginName = (String)request.getSession().getAttribute("LoginName");
		
		String dirPath = "";
		if(type.equals("event") || type.equals("survey") || type.equals("email") || type.equals("fyApply") || type.equals("adviceFK"))
		{
			dirPath = request.getSession().getServletContext().getRealPath("/") + "/temp/" + loginName + "/";
			//删除临时文件夹下的所有文件，防止异常情况下，该目录存在其他已经上传的文件
			File temp = new File(dirPath);
			if(!temp.isDirectory())
			{
				temp.mkdir();
			}
			/*
			 File[] fileList = temp.listFiles();  //目录中的所有文件
			 for(File file : fileList){
                 if(!file.isFile())   //判断是不是文件
                 continue;
                 file.delete();
			 }
			 */
		}
		else if(type.equals("attach"))//系统上传的附件
		{
			dirPath = request.getSession().getServletContext().getRealPath("/")+"/attachment/attach/";
		}
		else if(type.equals("key"))//密钥文件
		{
			dirPath = request.getSession().getServletContext().getRealPath("/")+"/key/";
		}
		else
		{
			dirPath = request.getSession().getServletContext().getRealPath("/")+"/attachment/temp/";
		}
		
		
        File tempDirPath =new File(dirPath);
        
        if(!tempDirPath.exists()){  
            tempDirPath.mkdirs();  
        }  
          
        DiskFileItemFactory fac = new DiskFileItemFactory();      
        ServletFileUpload upload = new ServletFileUpload(fac);      
        List fileList = null; 
        try {      
            fileList = upload.parseRequest(request);
        } catch (FileUploadException ex) {      
            ex.printStackTrace();      
            return;      
        }   
        String imageName = null;  
        Iterator it = fileList.iterator();     
        while(it.hasNext()){
            FileItem item =  (FileItem) it.next();     
            if(!item.isFormField()){  
            	imageName = item.getName();
            	  //获取上传文件的扩展名  
                String extName=imageName.substring(imageName.lastIndexOf(".")+1);
            	if(type.equals("adviceFK"))
            	{
            		String time = SystemShare.GetNowTime("yyyyMMddhhmmss");
            		imageName = time + "." + extName;
            	}
                BufferedInputStream in = new BufferedInputStream(item.getInputStream());     
                BufferedOutputStream out = new BufferedOutputStream(        
                        new FileOutputStream(new File(tempDirPath+"/"+imageName)));  
                Streams.copy(in, out, true);
                
                try
                {
		                String lastFileName= dirPath + imageName;
		                //密钥文件信息保存到数据库中
		                if(type.equals("key"))
		                {
		                	String serverPath = SystemConstant.GetServerPath() + "/" + "key" + "/" + imageName;
		                	 request.getSession().setAttribute("keyPath", "key" + "/" + imageName);
		                	 request.getSession().setAttribute("LocalPath", lastFileName);
		                	 request.getSession().setAttribute("keyName", imageName);
		                }
		                //如果是与事件相关联的附件，则上传后的目录为临时目录，需要在提交之后再保存到数据库中；其他的需要直接保存到数据库，没有提交
		                if(!type.equals("event") && !type.equals("survey")&&!type.equals("fyApply")&&!type.equals("email")&&!type.equals("adviceFK"))
		                {
			                //将上传的附件信息保存到数据库中
			                DBTools dbTools = new DBTools();
			                if(type.equals("key"))
			                {
			                	lastFileName = "/key/" + imageName;
			                }
			                else if(type.equals("attach"))
			                {
			                	lastFileName = "/attachment/attach/" + imageName;
			                }
			                else
			                {
			                	lastFileName = "/attachment/temp/" + imageName;
			                }
			        		String uploadName = (String)request.getSession().getAttribute("UserName");
			                dbTools.InsertAttachment(imageName, lastFileName, uploadName);
		                }
		                else if(type.equals("survey"))
		                {
		                	//如果上传的是调查报告，则将调查报告的名字保存起来，这样在上传完成后可以保存到数据中，便于下次可以直接编辑
		                	request.getSession().setAttribute("SurveyReportName", imageName);
		                }
		                else if(type.equals("fyApply"))//复议申请
		                {
		                	request.getSession().setAttribute("FYApplyAttach", imageName);
		                }
		                else if(type.equals("event"))//事件相关，新增专家意见、当事人陈述、依托单位意见上传的附件等
		                {
		                	request.getSession().setAttribute("EventAttachName", imageName);
		                }
		                else if(type.equals("adviceFK"))
		                {
		                	request.getSession().setAttribute("AdviceFKAttach", imageName);
		                }
		                /*
		                if(SystemShare.ISDoc(extName))
		                {
			                //System.out.println("lastFileName:" + lastFileName);
			                //获取需要转换的文件名,将路径名中的'\'替换为'/'  
			                String converfilename = dirPath.replaceAll("\\\\", "/")+"/"+imageName;  
			                //调用转换类DocConverter,并将需要转换的文件传递给该类的构造方法  
			                DocConverter d = new DocConverter(converfilename);  
			                //调用conver方法开始转换，先执行doc2pdf()将office文件转换为pdf;再执行pdf2swf()将pdf转换为swf;  
			                d.conver();  
			              //调用getswfPath()方法，打印转换后的swf文件路径  
			                //生成swf相对路径，以便传递给flexpaper播放器  
			                //String swfpath = "upload"+d.getswfPath().substring(d.getswfPath().lastIndexOf("/"));
		                }
		                */
                }
                catch (Exception e) {
					e.printStackTrace();
				}
            }  
        }  
        //  
        PrintWriter out = null;  
        try {  
            out = encodehead(request, response);  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        out.write("1");  
        out.close();  
	}
	
	/** 
     * Ajax���� ��ȡ PrintWriter 
     * @return 
     * @throws IOException  
     * @throws IOException  
     * request.setCharacterEncoding("utf-8"); 
        response.setContentType("text/html; charset=utf-8"); 
     */  
    private PrintWriter encodehead(HttpServletRequest request,HttpServletResponse response) throws IOException{  
        request.setCharacterEncoding("utf-8");  
        response.setContentType("text/html; charset=utf-8");  
        return response.getWriter();  
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
