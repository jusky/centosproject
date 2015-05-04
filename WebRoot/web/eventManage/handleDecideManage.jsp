<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#decideUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'decideUpload', //和以下input的name属性一致 
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
	function uploadHandleDecide(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<script type="text/javascript">
function editAdvice(id, handleName, deptName, shortInfo, handleTime, conference)
{
	var decideContent = document.getElementById(id).value;
	document.getElementById("handleName").value=handleName;
	document.getElementById("deptName").value=deptName;
	document.getElementById("shortInfo").value=shortInfo;
	document.getElementById("handleTime").value=handleTime;
	document.getElementById("conference").value=conference;
	document.getElementById("decideContent").value=decideContent;
	document.getElementById("HandleDecideAdviceId").value=id;
	
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="block";
}
function addAdvice()
{
	document.getElementById("handleName").value="";
	document.getElementById("deptName").value="";
	document.getElementById("shortInfo").value="";
	document.getElementById("handleTime").value="";
	document.getElementById("conference").value="";
	document.getElementById("decideContent").value="";
	document.getElementById("HandleDecideAdviceId").value="";

	document.getElementById("editButton").style.display="none";
	document.getElementById("newButton").style.display="block";
}
function newHandleDecide()
{
	var reportID = document.getElementById("reportID").value;
	var id = document.getElementById("HandleDecideAdviceId").value;
	var handleName = document.getElementById("handleName").value;
	var handleTime = document.getElementById("handleTime").value;
	var conference = document.getElementById("conference").value;
	var decideContent = document.getElementById("decideContent").value;
	var url = "<%=path%>/handleDecideAction.do?method=save&reportID=" + reportID + "&id=" + id + "&n=" + handleName + "&t=" + handleTime + "&c=" + conference + "&d=" + decideContent;
	$.pdialog.closeCurrent();
	openMaxWin(url);
}

function NewHandleDecideDoc(id)
{
	var url = "<%=path%>/handleDecideAction.do?method=newHDD&id=" + id;
	openMaxWin(url);
}
</script>

<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/handleDecideAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" id="" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="HandleDecideAdviceId" name="id" value=""/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" href="javascript:addAdvice();" title="新增处理决定"><span>新增</span></a></li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="430">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="60" align="center">编号</th>
					<th width="150" align="center">处理人姓名</th>
					<th width="200" align="center">会议名称</th>
					<th width="100" align="center">处理时间</th>
					<th align="center">处理决定</th>
					<th width="60" align="center">附件</th>
					<th width="150" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="HandleDecide">
			      <tr target="decideid" rel="${HandleDecide.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${HandleDecide.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="HandleDecide" property="serialNum"/>
					</td>
			      	<td align="center" >
						<bean:write name="HandleDecide" property="handleName"/>
					</td>
					<td align="center" >
						<bean:write name="HandleDecide" property="conference"/>
					</td>
					<td align="center" >
						<bean:write name="HandleDecide" property="handleTime"/>
					</td>
					<td align="center" >
						<input type="hidden" id="${HandleDecide.id}" name="test" value="${HandleDecide.decideContent }"/>
						<bean:write name="HandleDecide" property="decideContent"/>
					</td>
					<td align="center" >
						<logic:notEqual value="" name="HandleDecide" property="attachName">
							<a href="${HandleDecide.attachName }">下载</a>
						</logic:notEqual>
					</td>
					<td align="center">
						<a href="javascript:editAdvice('${HandleDecide.id }', '${HandleDecide.handleName }','${HandleDecide.deptName }','${HandleDecide.shortInfo }','${HandleDecide.handleTime }','${HandleDecide.conference }');" title="编辑内容">编辑内容</a>
						<a href="javascript:NewHandleDecideDoc('${HandleDecide.id }');" title="编辑文档">编辑文档</a>
						<a href="<%=path%>/handleDecideAction.do?method=delete&id={decideid}" rel="addHandleDecide" target="ajaxTodo" title="确定要删除吗?">删除</a>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何处理决定
					</td>
				</tr>
				</logic:equal>
					</tbody>
				</table>
				<div class="panelBar">
					<div class="pages">
						<span>共 <%=request.getAttribute("totalRows") %> 条处理决定</span>
					</div>
				</div>
			</div>
			<div class="pageContent">
			<div class="panel">
				<h1>处理决定</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>处理人姓名：</dt>
					<dd>
						<input id="handleName" name="handleName" type="text" size="40" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>所在单位：</dt>
					<dd>
						<input id="deptName" name="deptName" type="text" size="60" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>问题简述：</dt>
					<dd>
						<textarea id="shortInfo" rows="3" cols="100" name="shortInfo"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>会议名称：</dt>
					<dd>
						<input id="conference" name="org5.conference" type="text" size="60" readonly value=""/>
						<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=hymc" lookupGroup="org5">选择会议</a>
						<span class="info">选择会议</span>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>处理时间：</dt>
					<dd>
						<input id="handleTime" type="text" name="handleTime" class="date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>处理决定：</dt>
					<dd>
						<textarea id="decideContent" rows="5" cols="100" name="orgd.decideContent"></textarea>
						<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=cljdlook" lookupGroup="orgd">选择处理决定</a>
						<span class="info">选择处理决定</span>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：</dt>
					<dd>
						<input type="file" name="decideUpload" id="decideUpload" />
        					<a href="javascript:uploadHandleDecide('#decideUpload','event')">开始上传</a>&nbsp;
        					<a href="javascript:jQuery('#decideUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			</div>
			</div>
			<div class="formBar">
			<ul>
				<li><div id="newButton" class="buttonActive" style="display:block;"><div class="buttonContent"><button type="submit">新增决定</button></div></div></li>
				<li><div id="editButton" class="buttonActive" style="display:none;"><div class="buttonContent"><button type="submit">编辑决定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" id="closeButton" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>