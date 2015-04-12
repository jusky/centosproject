<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function editAdvice(id, faculty, fktime)
{		
	document.getElementById("fktime").value=fktime;
	document.getElementById("faculty.zzName").value=faculty.facultyName;
	document.getElementById("facultyAdviceContent").value = $("#" + id + " div").html().trim();
	document.getElementById("faculty.zzID").value=faculty.facultyId;
	
	document.getElementById("isEdit").value = "1";
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="block";
}
function addAdvice()
{
	document.getElementById("fktime").value="";
	document.getElementById("faculty.zzId").value="";
	document.getElementById("faculty.zzName").value="";
	document.getElementById("facultyAdviceContent").value="";
	
	document.getElementById("isEdit").value = "0";
	document.getElementById("newButton").style.display="block";
	document.getElementById("editButton").style.display="none";
}
</script>
<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/facultyAdviceAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" name="reportId" value="<%=request.getAttribute("reportId") %>"/>
	<input type="hidden" id="isEdit" name="isEdit" value="0"/>
	<input type="hidden" id="adviceid" name="id" value=""/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" mask="true" href="<%=path %>/facultyAdviceAction.do?method=handleUpFaculty&reportId=<%=request.getAttribute("reportId")%>" target="ajaxTodo" title="提交给学部?"><span>提交学部</span></a></li>
				<li><a class="add" href="javascript:addAdvice();" title="录入学部意见"><span>录入学部意见</span></a></li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="430">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="70" align="center">事件编号</th>
					<th width="200" align="center">被举报人</th>					
					<th width="150" align="center">学部</th>
					<th align="center">学部意见</th>
					<th align="center" width="60">是否反馈</th>
					<th width="100" align="center">提交时间</th>
					<th width="100" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="facultyAdvice">
			      <tr target="facultyAdviceId" rel="${facultyAdvice.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${facultyAdvice.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="facultyAdvice" property="serialNum"/>
					</td>
			      	<td align="center" >
						<bean:write name="facultyAdvice" property="beReportName"/>
					</td>
			      	<td align="center" >
						<bean:write name="facultyAdvice" property="facultyName"/>
					</td>
					<td align="center" id="facultyAdvice${facultyAdvice.id}">
						<bean:write name="facultyAdvice" property="advice"/>
					</td>
					<td>
						<bean:write name="facultyAdvice" property="isfk"/>
					</td>
					<td align="center" >
						<bean:write name="facultyAdvice" property="fktime"/>
					</td>
					<td align="center">
						<a href="#">&nbsp;</a>
						<a href="javascript:editAdvice('facultyAdvice${facultyAdvice.id }', {'facultyId':'${facultyAdvice.facultyId }', 'facultyName':'${facultyAdvice.facultyName}'},'${facultyAdvice.fktime }');" title="编辑学部意见">编辑</a>
						<a href="<%=path%>/facultyAdviceAction.do?method=delete&id=${facultyAdvice.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何学部意见
					</td>
				</tr>
				</logic:equal>
					</tbody>
				</table>
				<div class="panelBar">
					<div class="pages">
						<span>共 <%=request.getAttribute("totalRows") %> 条</span>
					</div>
				</div>
			</div>
			<div class="pageContent">
			<div class="panel">
				<h1>学部意见</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>学部：</dt>
					<dd>
						<input id="faculty.zzID" style="display:none" name="faculty.zzID" type="text" value=""/>
						<input id="faculty.zzName" class="required" readonly name="faculty.zzName" type="text" size="60" value=""/>
						<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=faculty" lookupGroup="faculty">选择学部</a>
						<span class="info">选择</span>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>时间：</dt>
					<dd>
						<input id="fktime" type="text" name="time" class="required date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>内容：</dt>
					<dd>
						<textarea id="facultyAdviceContent" class="required" rows="15" cols="100" name="advice"></textarea>
					</dd>
				</dl>
				</div>
			</div>
			</div>
			</div>
			<div class="formBar">
			<ul>
				<li><div id="newButton" class="buttonActive" style="display:block;"><div class="buttonContent"><button type="submit">新增</button></div></div></li>
				<li><div id="editButton" class="buttonActive" style="display:none;"><div class="buttonContent"><button type="submit">编辑</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>