<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%>
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/meetManageAction.do?method=editContent" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="meetManageForm" property="recordList">
     	<logic:iterate name="meetManageForm" property="recordList" id="MeetInfo">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${MeetInfo.id}">
			<dl>
				<dt>会议名称：</dt>
				<dd><input name="meetName" type="text" size="30" value='${MeetInfo.meetName}'/></dd>
			</dl>
			<dl class="nowrap">
				<dt>召开时间：</dt>
				<dd><input type="text" name="time" class="required date" size="20" readonly value='${MeetInfo.time}'/><a class="inputDateButton" href="javascript:;">选择</a></dd>
			</dl>
			<dl class="nowrap">
				<dt>召开地点：</dt>
				<dd><input class="required" name="location" type="text" size="60" value='${MeetInfo.location}'/></dd>
			</dl>
			<dl class="nowrap">
				<dt>参会人员：</dt>
				<dd>
					<textarea id="wyNames" rows="10" cols="80" name="orgw.wyName">${MeetInfo.members }</textarea>
					<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=wylook" lookupGroup="orgw">选择委员</a>
					<span class="info">选择委员</span>
				</dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
