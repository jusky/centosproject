<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="UTF-8"%> 
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#fyUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=fyApply',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'fyUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 5,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'buttonText' : 'BROWSE'
        });
    });
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	function uploadFYApply(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<script type="text/javascript">
function editFYApply(id, name, time)
{
	var advice = document.getElementById(id).value;
	document.getElementById("fyApplyName").value=name;
	document.getElementById("fyTime").value=time;
	document.getElementById("shortInfo").value=advice;
	document.getElementById("adviceid").value=id;

	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="block";
}
function addFYApply()
{
	document.getElementById("fyApplyName").value="";
	document.getElementById("fyTime").value="";
	document.getElementById("shortInfo").value="";
	document.getElementById("adviceid").value="";
	
	document.getElementById("newButton").style.display="block";
	document.getElementById("editButton").style.display="none";
}
</script>

<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/fYApplyManageAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" id="reportID" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="adviceid" name="id" value=""/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" href="javascript:addFYApply();" title="新增复议申请"><span>新增复议申请</span></a></li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="430">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="100" align="center">复议申请人</th>
					<th width="100" align="center">申请时间</th>
					<th align="center">复议简述</th>
					<th align="center" width="60">附件</th>
					<th width="180" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="FYApply">
			      <tr target="fyid" rel="${FYApply.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${FYApply.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="FYApply" property="fyApplyName"/>
					</td>
					<td align="center" >
						<bean:write name="FYApply" property="fyTime"/>
					</td>
					<td align="center" >
						<input type="hidden" id="${FYApply.id}" name="test" value="${FYApply.shortInfo }"/>
						<bean:write name="FYApply" property="shortInfo"/>
					</td>
					<td align="center" >
						<logic:notEqual value="" name="FYApply" property="attachPath">
							<a href="${FYApply.attachPath }">下载</a>
						</logic:notEqual>
					</td>
					<td align="center">
						<a href="#">&nbsp;</a>
						<a href="javascript:editFYApply('${FYApply.id }', '${FYApply.fyApplyName }','${FYApply.fyTime }');" title="编辑复议申请信息">编辑</a>
						<a href="<%=path%>/fYApplyManageAction.do?method=delete&id={fyid}" target="ajaxTodo" title="确定要删除吗?">删除</a>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何复议申请
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
				<h1>复议申请信息</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>复议申请人姓名：</dt>
					<dd>
						<input id="fyApplyName" name="fyApplyName" type="text" size="30" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>复议申请时间：</dt>
					<dd>
						<input id="fyTime" type="text" name="fyTime" class="date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>复议简述：</dt>
					<dd>
						<textarea id="shortInfo" rows="15" cols="100" name="shortInfo"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：</dt>
					<dd>
						<input type="file" name="fyUpload" id="fyUpload" />
        					<a href="javascript:uploadFYApply('#fyUpload','fyApply')">开始上传</a>&nbsp;
        					<a href="javascript:jQuery('#fyUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			</div>
			</div>
			<div class="formBar">
			<ul>
				<li><div id="newButton" class="buttonActive" style="display:block;"><div class="buttonContent"><button type="submit">新增申请</button></div></div></li>
				<li><div id="editButton" class="buttonActive" style="display:none;"><div class="buttonContent"><button type="submit">编辑申请</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>