<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
String serialNum = request.getParameter("serialNum");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>提交结果</title>
    <link href="../styles/css.css" rel="stylesheet" type="text/css" />
  </head>
  
<body>
  <div class="containter">
	<div class="top"></div>
	<div class="nav clearfix">
		<span class="nav_l"></span>
		<ul>
			 
		</ul>
		<span class="nav_r"></span>
	</div>
	<div class="subnav mar_b_5">
		
	</div>
	<div class="locaArea clearfix mar_b_10">
		<h2>当前位置：</h2>
		<div class="location">提交结果</div>
	</div>
	<div  class="main">
		<div class="nextCon_02">
			<br/>
			<br/>
			<br/>
			<br/>
			<%=request.getAttribute("result") %>
			<br/>
			<br/>
			<br/>
			<br/><br/>
			<br/>
			<br/>
			<br/>
		</div>
	</div>
	
	</div>
	<div class="footer">
		<div class="bottomNav"><a href="###">联系我们</a>|<a href="###">版权说明</a>|<a href="###">浏览建议</a></div>
		<div class="copyright">CopyRight © 版权所有 监督委员会  地址：北京市海淀区双清路83号   累计访问人次：<br />
	建议分辨率 1024X768</div>
	</div>
  </body>
</html>
