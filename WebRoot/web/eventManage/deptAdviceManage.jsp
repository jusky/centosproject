<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="UTF-8"%> 
<%@ page import="java.io.*" %> 
<%@ page import="com.whu.tools.SystemConstant" %>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String domainName = SystemConstant.domainName;
	
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#deptUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'deptUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 1,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'buttonText' : 'BROWSE'
        });
    });
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	function uploadDeptAdvice(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<script type="text/javascript">
function editDeptAdvice(id, dept, time)
{
	showAdvicePanel();
	var advice = document.getElementById(id).value;
	var temp = "expert" + id;
	var expertAdvice = document.getElementById(temp).value;
	document.getElementById("dept").value=dept;
	document.getElementById("time").value=time;
	document.getElementById("advice").value=advice;
	document.getElementById("adviceid").value=id;
	document.getElementById("expertAdvice").value=expertAdvice;
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="block";
}
function addDeptAdvice()
{
	showAdvicePanel();
	document.getElementById("dept").value="";
	document.getElementById("time").value="";
	document.getElementById("advice").value="";
	document.getElementById("adviceid").value="";
	document.getElementById("expertAdvice").value="";
	
	document.getElementById("newButton").style.display="block";
	document.getElementById("editButton").style.display="none";
}
function showAdvicePanel()
{
	document.getElementById("advicePanel").style.display="block";
}
</script>

<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/deptAdviceAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" id="reportID" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="adviceid" name="id" value=""/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" mask="true" href="<%=path %>/deptAdviceAction.do?method=createDCH&type=new" target="dialog" rel="createDCH" width="800" height="600"  title="调查函内容"><span>新建调查函</span></a></li>
				<li><a class="add" href="javascript:addDeptAdvice();" title="新增依托单位意见"><span>人工录入</span></a></li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="430">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="100" align="center">依托单位名称</th>
					<th width="100" align="center">反馈时间</th>
					<th align="center">调查情况及意见</th>
					<th align="center" width="100">专家意见</th>
					<th align="center" width="60">是否反馈</th>
					<th align="center" width="60">附件</th>
					<th width="180" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="DeptAdvice">
			      <tr target="deptid" rel="${DeptAdvice.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${DeptAdvice.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="DeptAdvice" property="dept"/>
					</td>
					<td align="center" >
						<bean:write name="DeptAdvice" property="time"/>
					</td>
					<td align="center" >
						<input type="hidden" id="${DeptAdvice.id}" name="test" value="${DeptAdvice.advice }"/>
						<bean:write name="DeptAdvice" property="advice"/>
					</td>
					<td align="center" >
						<input type="hidden" id="expert${DeptAdvice.id}" name="test" value="${DeptAdvice.expertAdvice }"/>
						<bean:write name="DeptAdvice" property="expertAdvice"/>
					</td>
					<td align="center" >
						<logic:equal value="1" name="DeptAdvice" property="isFK">是</logic:equal>
						<logic:equal value="0" name="DeptAdvice" property="isFK">否</logic:equal>
					</td>
					<td align="center" >
						<logic:notEqual value="" name="DeptAdvice" property="attachName">
							<a href="${DeptAdvice.attachName }">下载</a>
						</logic:notEqual>
					</td>
					<td align="center">
						<a href="#">&nbsp;</a>
						<a href="javascript:editDeptAdvice('${DeptAdvice.id }', '${DeptAdvice.dept }','${DeptAdvice.time }');" title="编辑依托单位意见">编辑意见</a>
						<logic:equal value="1" name="DeptAdvice" property="isLetter">
							<a mask="true" href="<%=path %>/deptAdviceAction.do?method=createDCH&type=edit&id=${DeptAdvice.id }" target="dialog" rel="createDCH" width="800" height="600"  title="编辑调查函">编辑调查函</a>
						</logic:equal>
						<a href="<%=path%>/deptAdviceAction.do?method=delete&id=${DeptAdvice.id }" target="ajaxTodo" title="确定要删除吗?">删除</a>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何依托单位意见
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
			<div class="panel" id="advicePanel" style="display:block;">
				<h1>依托单位意见</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>依托单位名称：</dt>
					<dd>
						<input id="dept" name="dept" type="text" size="60" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>反馈时间：</dt>
					<dd>
						<input id="time" type="text" name="time" class="date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>依托单位意见：</dt>
					<dd>
						<textarea id="advice" rows="15" cols="100" name="advice"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>专家意见：</dt>
					<dd>
						<textarea id="expertAdvice" rows="10" cols="100" name="expertAdvice"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：</dt>
					<dd>
						<input type="file" name="deptUpload" id="deptUpload" />
        					<a href="javascript:uploadDeptAdvice('#deptUpload','event')">开始上传</a>&nbsp;
        					<a href="javascript:jQuery('#deptUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			
			</div>
			</div>
			<div class="formBar">
			<ul>
				<li><div id="newButton" class="button" style="display:block;"><div class="buttonContent"><button type="submit">新增意见</button></div></div></li>
				<li><div id="editButton" class="button" style="display:none;"><div class="buttonContent"><button type="submit">编辑意见</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>