<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String swfFilePath=session.getAttribute("swfpath").toString(); 
//在附件列表页面，直接从url获得fileName
//在处理决定查看详情等页面，则需要从后台得到fileName 
String fileName = request.getParameter("filename");
if(fileName==null || fileName.equals(""))
{
	fileName = (String)request.getAttribute("fileName");
}
String reportID = (String)request.getSession().getAttribute("reportID");
//String dirPath = request.getSession().getServletContext().getRealPath("/")+"\\attachment\\" + reportID;
//String swfFilePath = dirPath + "\\" + fileName + ".swf";
String swfFilePath = "attachment/" + reportID + "/" + fileName + ".swf";
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>附件预览</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>  
<script type="text/javascript" src="<%=path %>/js/flexpaper.js"></script>  
<script type="text/javascript" src="<%=path %>/js/flexpaper_handlers.js"></script>  
<script type="text/javascript" src="<%=path %>/js/flexpaper_handlers_debug.js"></script>  
<style type="text/css" media="screen">   
            html, body  { height:100%; }  
            body { margin:0; padding:0; overflow:auto; }     
            #flashContent { display:none; }  
        </style>

  </head>
  
  <body>
    <div style="position:absolute;left:30px;top:10px;">  
     <div id="documentViewer" class="flexpaper_viewer" style="width:940px;height:680px"></div> 
              
            <script type="text/javascript">
                $('#documentViewer').FlexPaperViewer(
	            { config : {
	                SWFFile : '<%=swfFilePath%>',
	                Scale : 0.6,
	                ZoomTransition : 'easeOut',
	                ZoomTime : 0.5,
	                ZoomInterval : 0.2,
	                FitPageOnLoad : true,
	                FitWidthOnLoad : false,
	                FullScreenAsMaxWindow : false,
	                ProgressiveLoading : false,
	                MinZoomSize : 0.2,
	                MaxZoomSize : 5,
	                SearchMatchAll : false,
	                InitViewMode : 'Portrait',
	                RenderingOrder : 'flash',
	                StartAtPage : '',
	
	                ViewModeToolsVisible : true,
	                ZoomToolsVisible : true,
	                NavToolsVisible : true,
	                CursorToolsVisible : true,
	                SearchToolsVisible : true,
	                WMode : 'window',
	                localeChain: 'en_US'
	            }}
	    		);
            </script>    
        </div>  
  </body>
</html>
