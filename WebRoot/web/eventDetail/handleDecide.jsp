<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
//得到记录的个数，用于确定div的高度
int size = (Integer)request.getAttribute("size");
int divHeight=25;
int totalHeight=480;

int topHeight=size*divHeight;
int contentHeight = totalHeight - topHeight;

String height= String.valueOf(contentHeight) + "px";
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="pageContent" layoutH="56" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
	<div class="accordion" style="width:99%;">
		<logic:notEqual value="true" name="eventDetailForm" property="recordNotFind">
			<logic:notEmpty name="eventDetailForm" property="recordList">
	     		<logic:iterate name="eventDetailForm" property="recordList" id="HandleDecide">
				<div class="accordionHeader">
					<h2>处理人：<font color="#ff0000">${HandleDecide.handleName }</font></h2>
				</div>
				<div class="accordionContent" style="height:<%=height %>">
					<br/>
					<h2>处理会议：</h2>
					<p style="line-height:20px;">${HandleDecide.conference }</p>
					<br/>
					<h2>处理时间：</h2>
					<p style="line-height:20px;">${HandleDecide.handleTime }</p>
					<br/>
					<h2>处理决定：</h2>
					<p style="line-height:20px;">${HandleDecide.decideContent }</p>
					<br/>
					<br/>
					<h2>下载处理决定：</h2>
					<p style="line-height:20px;">
						<logic:notEqual value="" name="HandleDecide" property="filePath">
							<a href="${HandleDecide.filePath }"><font color="blue">下载</font></a>
						</logic:notEqual>
						<logic:equal value="" name="HandleDecide" property="filePath">
							没有在线提交处理决定文档
						</logic:equal>
					</p>
				</div>
				</logic:iterate>
			</logic:notEmpty>
		</logic:notEqual>
		<logic:notEqual value="false" name="eventDetailForm" property="recordNotFind">
			<div class="accordionHeader">
				<h2>无处理意见</h2>
			</div>
			<div class="accordionContent" style="height:200px">
				
			</div>
		</logic:notEqual>
	</div>
</div>