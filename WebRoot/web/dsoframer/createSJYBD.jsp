<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.SjybdBean" %>
<%
SjybdBean sjybdBean = (SjybdBean)request.getAttribute("SJYBDBean");
String reportID = (String)request.getAttribute("ReportID");
String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");
String isEdit = (String)request.getAttribute("IsEdit");
String numYear = "";
String numID = "";
String year = "";
String month = "";
String day = "";
String reportName = "";
String title = "";
if(isEdit.equals("0") && sjybdBean != null)
{
	numYear = sjybdBean.getNumYear();
	numID = sjybdBean.getNumID();
	year = sjybdBean.getYear();
	month = sjybdBean.getMonth();
	day = sjybdBean.getDay();
	reportName = sjybdBean.getReportName();
	title = sjybdBean.getTitle();
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
String id = "1";
%>
<html>
	<head>
		<title>收件阅办单</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
             var word = new word();
             //决定路径
		     word.setUploadUrl("<%=serverPath%>" + "/web/dsoframer/upload_handle.jsp");

		     var docurl = "";
		     var flag = "<%=isEdit%>";
		     function load(){
		         word.openDoc('sjybd.doc',"<%=templatePath%>");
		         if(flag == "0")
		         {
		         	setFileVal();
		         }
		     	}
		     //
		     function unload(){
		         word.close();
		     }
		     
		     function setFileVal(){
		     	var title = document.getElementById("titleID").value;
   				document.getElementById('oframe').SetFieldValue("numYear","<%=numYear%>","");	
		     	document.getElementById('oframe').SetFieldValue("numID","<%=numID%>","");	
		     	document.getElementById('oframe').SetFieldValue("year","<%=year%>","");
		     	document.getElementById('oframe').SetFieldValue("month","<%=month%>","");	
		     	document.getElementById('oframe').SetFieldValue("day","<%=day%>","");	
		     	document.getElementById('oframe').SetFieldValue("reportName","<%=reportName%>","");	
		     	document.getElementById('oframe').SetFieldValue("title",title,"");	
		     	document.getElementById('oframe').SetFieldValue("count","1","");
		     }
		      
		     //保存文件到服务器上
		     function uploadFile(){
		     	word.saveDocAndParm("<%=reportID%>","收件阅办单","", "<%=isEdit%>", "sjybd");
		     	//setTimeout("alert('保存成功!')",5000);
		     	alert("保存成功");
		     }
		     //保存关闭
		     function saveclose()
		     {
		     	word.saveDocAndParm("<%=reportID%>","收件阅办单","", "<%=isEdit%>", "sjybd");
		     	word.close();
		     	this.close();
		     }
		     //保存到本地
		     function saveLocal()
		     {
		     	
		     }
		     //重调文档
		     function reloadFile()
		     {
		     	load();
		     }
		</script>
	</head>
	<body onload="load();" onunload="unload();">
	<form action="" method="post">
		<input type="hidden" id="titleID" name="title" value="<%=title %>"/>
		<!-- 
	  <input type="button" value="保存关闭" onclick="saveclose()" >
	   -->
	  <input type="button" value="保存文档" onclick="uploadFile()" >
	  <input type="button" value="重调文档" onclick="reloadFile()" >
      <object classid="clsid:00460182-9E5E-11d5-B7C8-B8269041DD57" codebase="dsoframer.CAB#Version=2.3.0.0" id="oframe" width="100%" height="98%">
	         <param name="BorderStyle" value="1">
	         <param name="TitlebarColor" value="52479">
	         <param name="TitlebarTextColor" value="0">
       </object> 
       </form>
	</body>
</html>