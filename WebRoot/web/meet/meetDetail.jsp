<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/meetManageAction.do?method=editContent" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="meetManageForm" property="recordList">
     	<logic:iterate name="meetManageForm" property="recordList" id="MeetInfo">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${MeetInfo.id}">
			<dl>
				<dt>会议名称：</dt>
				<dd><input class='readonly' name="meetName" type="text" size="30" value='${MeetInfo.meetName}'/></dd>
			</dl>
			<dl class="nowrap">
				<dt>召开时间：</dt>
				<dd><input class="readonly" name="time" type="text" size="60" value='${MeetInfo.time}'/></dd>
			</dl>
			<dl class="nowrap">
				<dt>召开地点：</dt>
				<dd><input class="readonly" name="location" type="text" size="60" value='${MeetInfo.location}'/></dd>
			</dl>
			<dl class="nowrap">
				<dt>参会人员：</dt>
				<dd><textarea class="readonly" name="members" rows="10" cols="80">${MeetInfo.members }</textarea></dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
