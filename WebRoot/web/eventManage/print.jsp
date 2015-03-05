<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="UTF-8"%> 
<%@ page import="java.io.*" %> 
<%@ page import="com.whu.web.eventbean.PrintBean" %>
<%
	PrintBean printBean = (PrintBean)request.getAttribute("PrintBean");
	String reportID = "";
	String reportName = "";
	String templatePath = "";
	String templateName = "";
	String numYear = "";
	String numID = "";
	String year = "";
	String month = "";
	String day = "";

	reportID = printBean.getReportID();
	reportName = printBean.getReportName();
	
	numYear = printBean.getNumYear();
	numID = printBean.getNumID();
	year = printBean.getYear();
	month = printBean.getMonth();
	day = printBean.getDay();
		
	templatePath = printBean.getTemplatePath();
	templateName = printBean.getTemplateName();
		
	int bytesum=0;
    int byteread=0;
    
    String localTemplate = templateName;
    File localFile = new File(localTemplate);
    if(!localFile.getParentFile().exists()) {  
       localFile.getParentFile().mkdir();
    } 
	URL url = new URL(templatePath);
	URLConnection conn = url.openConnection();
	InputStream inStream = conn.getInputStream();
	FileOutputStream fs=new FileOutputStream(localTemplate);
	
	byte[]  buffer =new  byte[1444];
	int length;
	while ((byteread=inStream.read(buffer))!=-1)
	{
	   bytesum+=byteread;
	   fs.write(buffer,0,byteread);
	}
	inStream.close();
	fs.close();
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function createYBD(){
   var wdapp=new ActiveXObject("Word.Application");
   wdapp.visible=true;
   wddoc=wdapp.Documents.Open("<%=templateName%>");
   var title = document.getElementById("title").value;
   reportID="<%=reportID%>";
   reportName="<%=reportName%>";
   numYear = "<%=numYear %>";
   numID = "<%=numID %>";
   year = "<%=year %>";
   month = "<%=month %>";
   day = "<%=day %>";
   //输出编号
   range =wdapp.ActiveDocument.Bookmarks("numYear").Range;
   range.Text=numYear;
   range =wdapp.ActiveDocument.Bookmarks("numID").Range;
   range.Text=numID;
   range =wdapp.ActiveDocument.Bookmarks("year").Range;
   range.Text=year;
   range =wdapp.ActiveDocument.Bookmarks("month").Range;
   range.Text=month;
   range =wdapp.ActiveDocument.Bookmarks("day").Range;
   range.Text=day;
   //输出来件单位
   range =wdapp.ActiveDocument.Bookmarks("reportName").Range;
   range.Text=reportName; 
   range =wdapp.ActiveDocument.Bookmarks("title").Range;
   range.Text=title; 
   //wddoc.Application.Printout();
   wdapp=null;
   alert("生成成功");
}
</script>

<div class="pageContent">
	<form method="post" action="<%=path%>/configUserAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<dl class="nowrap">
				<dt>来件标题：</dt>
				<dd>
					<textarea rows="5" cols="60" name="title" id="title"></textarea>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div id="createButton" class="button"><div class="buttonContent"><button type="button" onclick="createYBD();">生成阅办单</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>