<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.ExpertJDH" %>
<%
String reportID = (String)request.getAttribute("ReportID");
String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");

String isEdit = (String)request.getAttribute("IsEdit");
ExpertJDH ejdh = (ExpertJDH)request.getAttribute("ExpertJDH");
String title = "";
String shortInfo = "";
String fkTime = "";
String target = "";
String jdContent = "";
String year = "";
String month = "";
String day = "";

String fkYear = "";
String fkMonth = "";
String fkDay = "";
if(isEdit.equals("0"))
{
	title = ejdh.getTitle();
	shortInfo = ejdh.getShortInfo();
	fkTime = ejdh.getFkTime();
	target = ejdh.getTarget();
	jdContent = ejdh.getJdContent();
	year = ejdh.getYear();
	month = ejdh.getMonth();
	day = ejdh.getDay();
	if(!fkTime.equals(""))
	{
		fkYear = fkTime.substring(0, 4);
		fkMonth = fkTime.substring(5, 7);
		fkDay = fkTime.substring(8, 10);
	}
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<title>专家鉴定函</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
			var word = new word();
             //决定路径
		     word.setUploadUrl("<%=serverPath%>" + "/web/dsoframer/upload_handle.jsp");

		     var docurl = "";
		     var flag = "<%=isEdit%>";
		     function load()
			{
				word.openDoc('zjjdh.doc',"<%=templatePath%>");
				if(flag == "0")
				{
					setFileVal();
				}
			}
			
			function setFileVal(){
				var shortInfo = document.getElementById("shortInfoID").value;
				var target = document.getElementById("targetID").value;
				var jdContent = document.getElementById("jdContentID").value;
   				document.getElementById('oframe').SetFieldValue("title","<%=title%>","");
   				document.getElementById('oframe').SetFieldValue("shortInfo",shortInfo,"");
   				document.getElementById('oframe').SetFieldValue("content",jdContent,"");
   				document.getElementById('oframe').SetFieldValue("target",target,"");
   				document.getElementById('oframe').SetFieldValue("fkYear","<%=fkYear%>","");	
   				document.getElementById('oframe').SetFieldValue("fkMonth","<%=fkMonth%>","");
   				document.getElementById('oframe').SetFieldValue("fkDay","<%=fkDay%>","");
   				document.getElementById('oframe').SetFieldValue("year","<%=year%>","");	
   				document.getElementById('oframe').SetFieldValue("month","<%=month%>","");
   				document.getElementById('oframe').SetFieldValue("day","<%=day%>","");
		     }
		     function unload(){
		         word.close();
		     }
		     //保存文件到服务器上
		     function uploadFile(){
		     	word.saveDocAndParm("<%=reportID%>","专家鉴定函","", "<%=isEdit%>", "expertJDH");
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
	<input type="hidden" value="<%=shortInfo %>" id="shortInfoID"/>
	<input type="hidden" value="<%=target %>" id="targetID"/>
	<input type="hidden" value="<%=jdContent %>" id="jdContentID"/>
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