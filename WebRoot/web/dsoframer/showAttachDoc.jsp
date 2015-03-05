<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.tools.SystemConstant" %>
<%
request.setCharacterEncoding("utf-8");
String fileName = request.getParameter("filename");
String reportID = request.getParameter("reportID");
if(reportID == null || reportID.equals(""))
{
	reportID = (String)request.getSession().getAttribute("reportID");
}
String serverPath = SystemConstant.GetServerPath();
//String templatePath = (String)request.getAttribute("templatePath");
String templatePath = serverPath + "/attachment/" + reportID + "/" + fileName;
String extName = fileName.substring(fileName.lastIndexOf(".")+1);
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = "1";
%>
<html>
	<head>
		<title>收件阅办单</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
             var word = new word();
             var ext = "<%=extName%>";
		     function load(){
		     	if(ext == "doc")
		     	{
		         	word.openDoc('temp.doc',"<%=templatePath%>");
		         }
		        else if(ext == "docx")
		        {
		        	word.openDoc('temp.docx',"<%=templatePath%>");
		        }
		     }
		     
		     function unload(){
		         word.close();
		     }
		</script>
	</head>
	<body onload="load();" onunload="unload();">
	<form action="" method="post">
      <object classid="clsid:00460182-9E5E-11d5-B7C8-B8269041DD57" codebase="dsoframer.CAB#Version=2.3.0.0" id="oframe" width="100%" height="100%">
	         <param name="BorderStyle" value="1">
	         <param name="TitlebarColor" value="52479">
	         <param name="TitlebarTextColor" value="0">
       </object> 
       </form>
	</body>
</html>