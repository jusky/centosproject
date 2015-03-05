<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.SurveyReportBean" %>
<%
String filePath = (String)request.getAttribute("filePath");
String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String isEdit = (String)request.getAttribute("isEdit");
String reportIDs = (String)request.getAttribute("reportIDs");
String reportFiles = (String)request.getAttribute("reportFiles");
%>
<html>
	<head>
		<title>调查报告</title>
		<script src="<%=path%>/dwz/js/jquery-1.7.2.js" type="text/javascript"></script>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
			var word = new word();
             //决定路径
		     word.setUploadUrl("<%=serverPath%>" + "/web/dsoframer/upload_handle.jsp");
		     var docurl = "";
		     function load()
				{
					word.openDoc('dcbg.doc',"<%=templatePath%>");
					if('<%=isEdit%>'==="0") {
						$.map('<%=reportFiles%>'.split(","), (function(val){
							 document.getElementById('oframe').InsertFile(encodeURI("<%=serverPath%>" + "/attachment/" + val),2);					 
						 }));
					}
				}
			 
		     function unload(){
		         word.close();
		     }
		     //保存文件到服务器上
		     function uploadFile(){
		    	word.saveDocAndParm("<%=reportIDs%>","<%=filePath%>","", "<%=isEdit%>", "combineReport");
		     	//setTimeout("alert('保存成功!')",5000);
		     	alert('保存成功!');
		     	//word.close();
		     }
		     //保存到本地
		     function saveLocal()
		     {
		     	
		     }
		</script>
		
	</head>
	<body onload="load();" onunload="unload();">
	<form action="" method="post">
	    <input type="button" value="保存文档" onclick="uploadFile()" >
	 	 <input type="button" value="重调文档" onclick="load()" >
	      <object classid="clsid:00460182-9E5E-11d5-B7C8-B8269041DD57" codebase="dsoframer.CAB#Version=2.3.0.0" id="oframe" width="100%" height="98%">
		         <param name="BorderStyle" value="1">
		         <param name="TitlebarColor" value="52479">
		         <param name="TitlebarTextColor" value="0">
	       </object>
	 </form>
	</body>
</html>