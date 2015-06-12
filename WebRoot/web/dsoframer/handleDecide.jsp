<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.whu.web.eventbean.HandleDecide" %>
<%
HandleDecide hd = (HandleDecide)request.getAttribute("HandleDecide");
String isEdit = (String)request.getAttribute("IsEdit");
String reportID = hd.getReportID();
String handleName = hd.getHandleName();
String deptName = hd.getDeptName();
String shortInfo = hd.getShortInfo();
String handleTime = hd.getHandleTime();
String conference = hd.getConference();
String decideContent = hd.getDecideContent();

String serialNum = hd.getSerialNum();
String numYear =serialNum.substring(0, 4);
String numID =String.valueOf(Integer.parseInt(serialNum.substring(4, serialNum.length())));

String year = handleTime.substring(0, 4);
String month = handleTime.substring(5, 7);
String day = handleTime.substring(8, 10);

String conferenceTime = (String)request.getAttribute("conferenceTime");
String conferenceYear = "";
String conferenceMonth = "";
String conferenceDay = "";
if(conferenceTime != null && !conferenceTime.equals(""))
{
	conferenceYear = conferenceTime.substring(0, 4);
	conferenceMonth = conferenceTime.substring(5, 7);
	conferenceDay = conferenceTime.substring(8, 10);
}

String serverPath = (String)request.getAttribute("ServerPath");
String templatePath = (String)request.getAttribute("templatePath");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = "1";
%>
<html>
	<head>
		<title>处理决定</title>
		<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
		<script type="text/javascript">
             var word = new word();
             //决定路径
		     word.setUploadUrl("<%=serverPath%>" + "/web/dsoframer/upload_handle.jsp");

		     var docurl = "";
		     var flag = "<%=isEdit%>";
		     function load(){
		         word.openDoc('cljd.doc',"<%=templatePath%>");
		         if(flag == "0")//如果是新增处理决定，则自动填充一些信息，如果是编辑，则由于标签位置可能发生改变，不用自动填充
		         {
		         	setFileVal();
		         }
		     }
		     
		     function unload(){
		         //word.saveDoc();
		         //word.saveDocAndParm('1',docurl);
		         //word.saveDocAndParm("<%=reportID%>","<%=handleName%>","<%=serialNum%>", "<%=isEdit%>");
		         word.close();
		     }
		     
		     function setFileVal(){
		     	var decideContent = document.getElementById("decideContentID").value;
		     	var shortInfo = document.getElementById("shortInfoID").value;
		     	//document.getElementById('oframe').SetFieldValue("title",decideContent,"");
		     	document.getElementById('oframe').SetFieldValue("numYear","<%=numYear%>","");
		     	document.getElementById('oframe').SetFieldValue("numID","<%=numID%>","");
		     	document.getElementById('oframe').SetFieldValue("handleName","<%=handleName%>","");
		     	document.getElementById('oframe').SetFieldValue("deptName","<%=deptName%>","");
		     	document.getElementById('oframe').SetFieldValue("shortInfo",shortInfo,"");
		     	document.getElementById('oframe').SetFieldValue("conferenceYear","<%=conferenceYear%>","");
		     	document.getElementById('oframe').SetFieldValue("conferenceMonth","<%=conferenceMonth%>","");
		     	document.getElementById('oframe').SetFieldValue("conferenceDay","<%=conferenceDay%>","");
		     	document.getElementById('oframe').SetFieldValue("year","<%=year%>","");
		     	document.getElementById('oframe').SetFieldValue("month","<%=month%>","");
		     	document.getElementById('oframe').SetFieldValue("day","<%=day%>","");
		     	document.getElementById('oframe').SetFieldValue("conference","<%=conference%>","");
		     	document.getElementById('oframe').SetFieldValue("decideContent",decideContent,"");
		     }
		      
		     //保存文件到服务器上
		     function uploadFile(){
		     	word.saveDocAndParm("<%=reportID%>","关于" + "<%=handleName%>" + "的处理决定","<%=serialNum%>", "<%=isEdit%>", "handleDecide");
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
		<input type="hidden" id="decideContentID" value="<%=decideContent %>"/>
		<input type="hidden" id="shortInfoID" value="<%=shortInfo %>"/>
	   <input type="button" value="保存文档" onclick="uploadFile()" >
	 	 <input type="button" value="重调文档" onclick="load()" >
      <object classid="clsid:00460182-9E5E-11d5-B7C8-B8269041DD57" codebase="dsoframer.CAB#Version=2.3.0.0" id="oframe" width="100%" height="98%">
	         <param name="BorderStyle" value="1">
	         <param name="TitleBar" value="0">
       </object> 
       </form>
	</body>
</html>