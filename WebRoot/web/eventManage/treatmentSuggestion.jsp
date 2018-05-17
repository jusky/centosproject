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
        $("#tsUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'tsUpload', //和以下input的name属性一致 
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
	function uploadTSAdvice(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<script type="text/javascript">
function editTSAdvice(id, time)
{
	showTSAdvicePanel();
	var content = document.getElementById(id).value;
	document.getElementById("tscontent").value=content;
	document.getElementById("tsid").value=id;
	document.getElementById("tsnewButton").style.display="none";
	document.getElementById("tseditButton").style.display="block";
}
function addTSAdvice()
{
	showTSAdvicePanel();
	document.getElementById("tscontent").value="";
	document.getElementById("tsid").value=id;
	
	document.getElementById("tsnewButton").style.display="block";
	document.getElementById("tseditButton").style.display="none";
}
function lookTSAdvice(id, time)
{
	showTSLookPanel();
	var content = document.getElementById(id).value;
	document.getElementById("tstime_look").value=time;
	document.getElementById("tscontent_look").value=content;
	document.getElementById("tsnewButton").style.display="none";
	document.getElementById("tseditButton").style.display="none";
}
function showTSAdvicePanel()
{
	document.getElementById("tsadvicePanel").style.display="block";
	document.getElementById("tslookPanel").style.display="none";
}
function showTSLookPanel()
{
	document.getElementById("tsadvicePanel").style.display="none";
	document.getElementById("tslookPanel").style.display="block";
}
</script>

<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/TreatmentSuggestAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" id="reportID" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="tsid" name="id" value=""/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		
		<div class="panelBar">
		<logic:notEqual name="RoleIDs" value="2"  scope="session">
			<ul class="toolBar">
			<li><a class="add" href="javascript:addTSAdvice();" title="新增处理建议"><span>添加处理建议</span></a></li>
			</ul>
			</logic:notEqual>
		</div>
		
		<table class="table" width="100%" layoutH="430">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="100" align="center">办公人员名字</th>
					<th width="100" align="center">反馈时间</th>
					<th align="center">处理建议</th>
					<th align="center" width="60">附件</th>
					<th width="180" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="TreatmentSuggestion">
			      <tr target="aiid" rel="${TreatmentSuggestion.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${TreatmentSuggestion.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="TreatmentSuggestion" property="workername"/>
					</td>
					<td align="center" >
						<bean:write name="TreatmentSuggestion" property="time"/>
					</td>
					<td align="center" >
						<input type="hidden" id="${TreatmentSuggestion.id}" name="test" value="${TreatmentSuggestion.content }"/>
						<bean:write name="TreatmentSuggestion" property="content"/>
					</td>
					<td align="center" >
						<logic:notEqual value="" name="TreatmentSuggestion" property="attachname">
							<a href="${TreatmentSuggestion.attachname }">下载</a>
						</logic:notEqual>
					</td>
					<td align="center">
						<a href="javascript:lookTSAdvice('${TreatmentSuggestion.id }','${TreatmentSuggestion.time }');" title="查看详情">查看</a>
						<a href="javascript:editTSAdvice('${TreatmentSuggestion.id }','${TreatmentSuggestion.time }');" title="编辑依托单位意见">编辑意见</a>
						<!-- <a href="<%=path%>/deptAdviceAction.do?method=delete&id=${DeptAdvice.id }" target="ajaxTodo" title="确定要删除吗?">删除</a>  -->
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何分析结论
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
			<div class="panel" id="tsadvicePanel" style="display:block;">
				<h1>分析结论</h1>
				<div style="background:#ffffff;">
				<!--  <dl class="nowrap">
					<dt>反馈时间：</dt>
					<dd>
						<input id="tstime" type="text" name="time" class="date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>-->
				<dl class="nowrap">
					<dt>处理建议：</dt>
					<dd>
						<textarea id="tscontent" rows="15" cols="100" name="content"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：
					<br/><font color="red">请将多个附件打包压缩后再一起上传，谢谢！</font>
					</dt>
					<dd>
						<input type="file" name="tsUpload" id="tsUpload" />
        					<a href="javascript:uploadTSAdvice('#tsUpload','event')">开始上传</a>&nbsp;
        					<a id="cfile" href="javascript:jQuery('#tsUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel" id="tslookPanel" style="display:none;">
				<h1>分析结论</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>反馈时间：</dt>
					<dd>
						<input id="tstime_look" type="text" name="time" size="20" readonly/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>处理建议：</dt>
					<dd>
						<textarea id="tscontent_look" rows="15" cols="100" name="content" readonly></textarea>
					</dd>
				</dl>
				
				</div>
			</div>
			</div>
			</div>
			<div class="formBar">
			<ul>
				<logic:notEqual name="RoleIDs" value="2"  scope="session">
				<li><div id="tsnewButton" class="button" style="display:block;"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				</logic:notEqual>
				<li><div id="tseditButton" class="button" style="display:none;"><div class="buttonContent"><button type="submit">编辑意见</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>