<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.JDYJSBean" %>
<%
String reportID = (String)request.getAttribute("ReportID");
String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");
String isEdit = (String)request.getAttribute("IsEdit");
String eventReason = "";
String identifyContent = "";
String wtDept = "";
String jdConclusion = "";
if(isEdit.equals("0"))
{
	JDYJSBean jb = (JDYJSBean)request.getAttribute("JDYJSBean");
	eventReason = jb.getEventReason();
	identifyContent = jb.getIdentifyContent();
	wtDept = jb.getWtDept();
	jdConclusion = jb.getJdConclusion();
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<title>专家鉴定意见书</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
			var word = new word();
             //决定路径
		     word.setUploadUrl("<%=basePath%>" + "/web/dsoframer/upload_handle.jsp");
		     var docurl = "";
		     var flag = "<%=isEdit%>";
		     function load()
			{
				word.openDoc('jdyjs.doc',"<%=basePath%>" + "<%=templatePath%>");
				if(flag == "0")
				{
					setFileVal();
				}
			}			
			function setFileVal(){
				var jdCon = document.getElementById("jdConclusionID").value;
				var jdContent = document.getElementById("jdContentID").value;
				var temp = "";
				var strs= new Array(); //定义一数组 
				strs=jdCon.split("\n"); //字符分割 
				for (i=0;i<strs.length ;i++ ) 
				{ 
					temp += strs[i] + "\n" + "□是；    □否；    □不确定" + "\n";
				} 
   				document.getElementById('oframe').SetFieldValue("eventReason","<%=eventReason%>","");	
		     	document.getElementById('oframe').SetFieldValue("identifyContent",jdContent,"");	
		     	document.getElementById('oframe').SetFieldValue("wtDept","<%=wtDept%>","");	
		     	document.getElementById('oframe').SetFieldValue("jdConclusion",temp,"");	
		     }
		     function unload(){
		         word.close();
		     }
		     //保存文件到服务器上
		     function uploadFile(){
		     	word.saveDocAndParm("<%=reportID%>","专家鉴定意见书","", "<%=isEdit%>", "expertJDYJS");
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
		<input type="hidden" value="<%=jdConclusion %>" id="jdConclusionID"/>
		<input type="hidden" value="<%=identifyContent %>" id="jdContentID"/>
	    <input type="button" value="保存文档" onclick="uploadFile()" >
	 	 <input type="button" value="重调文档" onclick="load()" >
	      <object classid="clsid:00460182-9E5E-11d5-B7C8-B8269041DD57" codebase="dsoframer.CAB#Version=2.3.0.0" id="oframe" width="100%" height="98%">
		      <param name="BorderStyle" value="1">
	         <param name="TitleBar" value="0">
	       </object> 
	 </form>
	</body>
</html>