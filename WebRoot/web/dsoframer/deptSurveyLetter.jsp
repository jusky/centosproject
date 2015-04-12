<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.DeptSurveyLetter" %>
<%@ page import="com.whu.tools.SystemConstant" %>
<%@ page import="com.whu.web.common.SystemShare" %>
<%
String domainName = SystemConstant.domainName;
DeptSurveyLetter dsl = (DeptSurveyLetter)request.getAttribute("DeptSurveyLetter");
String id = dsl.getId();
String reportID =dsl.getReportID();
String title = dsl.getTitle();
String deptName = dsl.getDeptName();
String shortInfo = dsl.getShortInfo();
String fkTime = dsl.getFkTime();
String surveyContent = dsl.getSurveyContent();
String loginName = dsl.getLoginName();
String password = dsl.getPassword();
String year = dsl.getYear();
String month = dsl.getMonth();
String day = dsl.getDay();
String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");
String isEdit = (String)request.getAttribute("IsEdit");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<title>依托单位调查函</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
			var word = new word();
             //决定路径
		     word.setUploadUrl("<%=serverPath%>" + "/web/dsoframer/upload_handle.jsp");
		     var docurl = "";
		     var flag = "<%=isEdit%>";
		     function load()
			{
				word.openDoc('ytdwdch.doc',"<%=templatePath%>");
		         if(flag == "0")//如果是新增处理决定，则自动填充一些信息，如果是编辑，则由于标签位置可能发生改变，不用自动填充
		         {
		         	setFileVal();
		         }
			}
			
			function setFileVal(){
		       shortInfo = document.getElementById("shortInfoID").value;
			   surveyContent = document.getElementById("surveyContentID").value;
			   var time = "<%=fkTime%>";
			   if(time != "")
				{
					var year = time.substring(0, 4);
					var month = time.substring(5, 7);
					var day = time.substring(8, 10);
					time = year + "年" + month + "月" + day + "日";
				}
			   
		       document.getElementById('oframe').SetFieldValue("title","<%=title%>","");
		       document.getElementById('oframe').SetFieldValue("shortInfo",shortInfo,"");
		       document.getElementById('oframe').SetFieldValue("deptName","<%=deptName%>","");
		       document.getElementById('oframe').SetFieldValue("date",time,"");
		       document.getElementById('oframe').SetFieldValue("serverURL","<%=serverPath%>","");
		       document.getElementById('oframe').SetFieldValue("loginName","<%=loginName%>","");
		       document.getElementById('oframe').SetFieldValue("password","<%=password%>","");
		       document.getElementById('oframe').SetFieldValue("content",surveyContent,"");
		       document.getElementById('oframe').SetFieldValue("year","<%=year%>","");
		       document.getElementById('oframe').SetFieldValue("month","<%=month%>","");
		       document.getElementById('oframe').SetFieldValue("day","<%=day%>","");
		     }
		     function unload(){
		         word.close();
		     }
		     //保存文件到服务器上
		     function uploadFile(){
		     	word.saveDocAndParm("<%=reportID%>","<%=deptName%>"+"的调查函" + "<%=SystemShare.GetNowTime("yyyyMMddmmss")%>", "<%=id%>", "<%=isEdit%>", "deptSurveyLetter");
		     	//暂停3秒，防止用户操作过快直接关闭，会使IE出现异常！
		     	alert("保存成功");
		     	//setTimeout("alert('保存成功!')",5000);
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
		<input type="hidden" name="shortInfo" id="shortInfoID" value="<%=shortInfo %>"/>
		<input type="hidden" name="surveyContent" id="surveyContentID" value="<%=surveyContent %>"/>
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