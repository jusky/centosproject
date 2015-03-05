<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.SurveyReportBean" %>
<%
SurveyReportBean srb = (SurveyReportBean)request.getAttribute("SurveyReportBean");
String reportID = (String)request.getAttribute("ReportID");
String serialNum = (String)request.getAttribute("SerialNum");
String beReportName = srb.getBeReportName();
String reportContent = srb.getReportContent();
String checkInfo = srb.getCheckInfo();
String deptAdvice = srb.getDeptAdvice();
String expertAdvice = srb.getExpertAdvice();
String litigantState = srb.getLitigantState();
String facultyAdvice = srb.getFacultyAdvice();
String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");
String isEdit = (String)request.getAttribute("IsEdit");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = "1";
%>
<html>
	<head>
		<title>调查报告</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
			var word = new word();
             //决定路径
		     word.setUploadUrl("<%=serverPath%>" + "/web/dsoframer/upload_handle.jsp");

		     var docurl = "";
		     var flag = "<%=isEdit%>";
		     function load()
				{
					word.openDoc('dcbg.doc',"<%=templatePath%>");
		         if(flag == "0")//如果是新增处理决定，则自动填充一些信息，如果是编辑，则由于标签位置可能发生改变，不用自动填充
		        	 {
		         	setFileVal();
		         	}
				}
			function setFileVal(){
				document.getElementById('oframe').SetFieldValue("beReportName","<%=beReportName%>","");
				reportContent = document.getElementById("reportContent").value;
		       checkInfo = document.getElementById("checkInfoID").value;
			   deptAdvice = document.getElementById("deptAdviceID").value;
			   expertAdvice = document.getElementById("expertAdviceID").value;
			   litigantState = document.getElementById("litigantStateID").value;
			   facultyAdvice = document.getElementById("facultyAdviceID").value;
			   
		       document.getElementById('oframe').SetFieldValue("deptAdvice",deptAdvice,"");
		       document.getElementById('oframe').SetFieldValue("reportInfo",reportContent,"");
		       document.getElementById('oframe').SetFieldValue("checkInfo",checkInfo,"");
		       document.getElementById('oframe').SetFieldValue("expertAdvice",expertAdvice,"");
		       document.getElementById('oframe').SetFieldValue("litigantState",litigantState,"");
		       document.getElementById('oframe').SetFieldValue("facultyAdvice",facultyAdvice,"");		       
		     }
		     function unload(){
		         word.close();
		     }
		     //保存文件到服务器上
		     function uploadFile(){
		     	word.saveDocAndParm("<%=reportID%>","调查报告","<%=serialNum%>", "<%=isEdit%>", "surveyReport");
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
		<input type="hidden" name="reportID" value="<%=request.getAttribute("ReportID") %>"/>
		<input type="hidden" name="reportContent" id="reportContent" value="<%=reportContent%>"/>
		<input type="hidden" name="checkInfo" id="checkInfoID" value="<%=checkInfo %>"/>
		<input type="hidden" name="deptAdvice" id="deptAdviceID" value="<%=deptAdvice %>"/>
		<input type="hidden" name="expertAdvice" id="expertAdviceID" value="<%=expertAdvice %>"/>
		<input type="hidden" name="litigantState" id="litigantStateID" value="<%=litigantState %>"/>
		<input type="hidden" name="facultyAdvice" id="facultyAdviceID" value="<%=facultyAdvice %>"/>
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