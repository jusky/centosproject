<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#stateUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'stateUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 1,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){if(response == "1"){alert(file.name +"上传成功！");}else{alert(file.name +"上传失败！");document.getElementById("cfile").click();}}
        });
    });
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	function uploadState(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<script type="text/javascript">
function detailAdvice(id, litigantName, litigantTime)
{	
	var litigantContent = document.getElementById(id).value;
	var temp = "talk" + id;
	var talkRecorder = document.getElementById(temp).value;
	document.getElementById("litigantName").value=litigantName;
	document.getElementById("litigantTime").value=litigantTime;
	document.getElementById("litigantContent").value=litigantContent;
	document.getElementById("adviceid").value=id;
	document.getElementById("talkRecorder").value=talkRecorder;
	
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="none";
}
function editAdvice(id, litigantName, litigantTime)
{	
	var litigantContent = document.getElementById(id).value;
	var temp = "talk" + id;
	var talkRecorder = document.getElementById(temp).value;
	document.getElementById("litigantName").value=litigantName;
	document.getElementById("litigantTime").value=litigantTime;
	document.getElementById("litigantContent").value=litigantContent;
	document.getElementById("adviceid").value=id;
	document.getElementById("talkRecorder").value=talkRecorder;
	
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="block";
}
function addAdvice()
{
	document.getElementById("litigantName").value="";
	document.getElementById("litigantTime").value="";
	document.getElementById("litigantContent").value="";
	document.getElementById("adviceid").value="";
	document.getElementById("talkRecorder").value="";
	
	document.getElementById("newButton").style.display="block";
	document.getElementById("editButton").style.display="none";
}
</script>
<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/litigantStateAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="adviceid" name="id" value=""/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		<div class="panelBar">
		<logic:notEqual name="RoleIDs" value="2"  scope="session">
			<ul class="toolBar">
				<li><a class="add" href="javascript:addAdvice();" title="新增当事人陈述"><span>新增</span></a></li>
			</ul>
			</logic:notEqual>
		</div>
		<table class="table" width="100%" layoutH="430">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="150" align="center">当事人姓名</th>
					<th width="100" align="center">陈述时间</th>
					<th align="center">内容</th>
					<th align="center" width="200">面谈记录</th>
					<th align="center" width="60">附件</th>
					<th width="100" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="LitigantState">
			      <tr target="litigantid" rel="${LitigantState.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${LitigantState.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="LitigantState" property="litigantName"/>
					</td>
					<td align="center" >
						<bean:write name="LitigantState" property="litigantTime"/>
					</td>
					<td align="center" >
						<input type="hidden" id="${LitigantState.id}" name="test" value="${LitigantState.litigantContent }"/>
						<bean:write name="LitigantState" property="litigantContent"/>
					</td>
					<td align="center" >
						<input type="hidden" id="talk${LitigantState.id}" name="test" value="${LitigantState.talkRecorder }"/>
						<bean:write name="LitigantState" property="talkRecorder"/>
					</td>
					<td align="center" >
						<logic:notEqual value="" name="LitigantState" property="filePath">
							<a href="${LitigantState.filePath }">下载</a>
						</logic:notEqual>
					</td>
					<td align="center">
						<a href="javascript:detailAdvice('${LitigantState.id }', '${LitigantState.litigantName }','${LitigantState.litigantTime }');" title="查看当事人陈述">查看</a>					
						<logic:notEqual name="RoleIDs" value="2"  scope="session">
							<a href="#">&nbsp;</a>
							<a href="javascript:editAdvice('${LitigantState.id }', '${LitigantState.litigantName }','${LitigantState.litigantTime }');" title="编辑当事人陈述">编辑</a>
							<a href="<%=path%>/litigantStateAction.do?method=delete&id=${LitigantState.id }" target="ajaxTodo" title="确定要删除吗?">删除</a>
						</logic:notEqual>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何当事人陈述
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
				<h1>当事人陈述</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>当事人姓名：</dt>
					<dd>
						<input id="litigantName" class="required" name="litigantName" type="text" size="60" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>陈述时间：</dt>
					<dd>
						<input id="litigantTime" type="text" name="litigantTime" class="date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>陈述内容：</dt>
					<dd>
						<textarea id="litigantContent" class="required" rows="15" cols="100" name="litigantContent"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>面谈记录：</dt>
					<dd>
						<textarea id="talkRecorder" rows="10" cols="100" name="talkRecorder"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：</dt>
					<dd>
						<input type="file" name="stateUpload" id="stateUpload" />
        					<a href="javascript:uploadState('#stateUpload','event')">开始上传</a>&nbsp;
        					<a id="cfile" href="javascript:jQuery('#stateUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			</div>
			</div>
			<div class="formBar">
			<ul>
			<logic:notEqual name="RoleIDs" value="2"  scope="session">
				<li><div id="newButton" class="buttonActive" style="display:block;"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				</logic:notEqual>
				<li><div id="editButton" class="buttonActive" style="display:none;"><div class="buttonContent"><button type="submit">编辑陈述</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>