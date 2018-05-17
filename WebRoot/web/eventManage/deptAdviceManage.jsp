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
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){if(response == "1"){alert(file.name +"上传成功！");}else{alert(file.name +"上传失败！");document.getElementById("cfile").click();}}
        });
        $("#demailUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=email',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue1',//与下面的id对应
            'fileDataName'   : 'demailUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 5,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'fileDesc': "请选择office/pdf/压缩包文件",
    		   'fileExt': '*.doc;*.docx;*.xls;*.xlsx;*.pdf;*.rar;*.zip', 
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){if(response == "1"){alert(file.name +"上传成功！");}else{alert(file.name +"上传失败！");document.getElementById("dfile").click();}}
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
	document.getElementById("sendButton").style.display="none";
}
function lookDeptAdvice(id, dept, time)
{
	showLookPanel();
	var advice = document.getElementById(id).value;
	var temp = "expert" + id;
	var expertAdvice = document.getElementById(temp).value;
	document.getElementById("dept_look").value=dept;
	document.getElementById("time_look").value=time;
	document.getElementById("advice_look").value=advice;
	//document.getElementById("adviceid").value=id;
	document.getElementById("expertAdvice_look").value=expertAdvice;
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="none";
	document.getElementById("sendButton").style.display="none";
}
function showAdvicePanel()
{
	document.getElementById("advicePanel").style.display="block";
	document.getElementById("lookPanel").style.display="none";
	document.getElementById("demailPanel").style.display="none";
	document.getElementById("operatorFlag").value="newAdvice";
}
function showLookPanel()
{
	document.getElementById("advicePanel").style.display="none";
	document.getElementById("lookPanel").style.display="block";
	document.getElementById("demailPanel").style.display="none";
}
function sendEmail()
{
	document.getElementById("sendButton").style.display="block";
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="none";
	showEmailPanel();
}
function showEmailPanel()
{
	document.getElementById("demailPanel").style.display="block";
	document.getElementById("advicePanel").style.display="none";
	document.getElementById("lookPanel").style.display="none";
	document.getElementById("operatorFlag").value="sendEmail";
}
</script>

<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/deptAdviceAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" id="reportID" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="adviceid" name="id" value=""/>
	<input type="hidden" id="operatorFlag" name="operatorFlag" value="newAdvice"/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		
		<div class="panelBar">
		<logic:notEqual name="RoleIDs" value="2"  scope="session">
			<ul class="toolBar">
				<li><a class="add" mask="true" href="<%=path %>/deptAdviceAction.do?method=createDCH&type=new" target="dialog" rel="createDCH" width="800" height="600"  title="调查函内容"><span>新建调查函</span></a></li>
				<li><a class="add" href="javascript:sendEmail();" title="向单位发送邮件"><span>发送邮件</span></a></li>
				<li><a class="add" href="javascript:addDeptAdvice();" title="新增依托单位意见"><span>人工录入</span></a></li>
			</ul>
			</logic:notEqual>
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
						<a href="javascript:lookDeptAdvice('${DeptAdvice.id }', '${DeptAdvice.dept }','${DeptAdvice.time }');" title="查看详情">查看</a>
						<logic:notEqual name="RoleIDs" value="2"  scope="session">
						<logic:notEqual value="1" name="DeptAdvice" property="isLetter">
						<a href="javascript:editDeptAdvice('${DeptAdvice.id }', '${DeptAdvice.dept }','${DeptAdvice.time }');" title="编辑依托单位意见">编辑意见</a>
						</logic:notEqual>
						<logic:equal value="1" name="DeptAdvice" property="isLetter">
							<a mask="true" href="<%=path %>/deptAdviceAction.do?method=createDCH&type=edit&id=${DeptAdvice.id }" target="dialog" rel="createDCH" width="800" height="600"  title="编辑调查函">编辑调查函</a>
						</logic:equal>
						</logic:notEqual>
						<!-- <a href="<%=path%>/deptAdviceAction.do?method=delete&id=${DeptAdvice.id }" target="ajaxTodo" title="确定要删除吗?">删除</a>  -->
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
					<dt>上传附件：
					<br/><font color="red">请将多个附件打包压缩后再一起上传，谢谢！</font>
					</dt>
					<dd>
						<input type="file" name="deptUpload" id="deptUpload" />
        					<a href="javascript:uploadDeptAdvice('#deptUpload','event')">开始上传</a>&nbsp;
        					<a id="cfile" href="javascript:jQuery('#deptUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel" id="lookPanel" style="display:none;">
				<h1>依托单位意见</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>依托单位名称：</dt>
					<dd>
						<input id="dept_look" name="dept" type="text" size="60" value="" readonly/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>反馈时间：</dt>
					<dd>
						<input id="time_look" type="text" name="time" class="date" size="20" readonly/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>依托单位意见：</dt>
					<dd>
						<textarea id="advice_look" rows="15" cols="100" name="advice" readonly></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>专家意见：</dt>
					<dd>
						<textarea id="expertAdvice_look" rows="10" cols="100" name="expertAdvice" readonly></textarea>
					</dd>
				</dl>
				
				</div>
			</div>
			<div class="panel" id="demailPanel" style="display:none;">
				<h1>发送电子邮件</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>依托单位名称：</dt>
					<dd>
						<input id="deptID" name="deptID" type="hidden"/>
						<input id="deptName" name="deptName" type="text" size="60"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>邮箱地址：</dt>
					<dd>
						<input id="deptemail" name="deptemail" type="text" size="90"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>标题：</dt>
					<dd>
						<input name="depttitle" type="text" size="90" value="关于商请鉴定XXX的函"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：
					<br/><font color="red">请将多个附件打包压缩后再一起上传，谢谢！</font>
					</dt>
					<dd>
						<input type="file" name="demailUpload" id="demailUpload"/>
        					<a href="javascript:uploadDeptAdvice('#demailUpload','email')">开始上传</a>&nbsp;
        					<a id="dfile" href="javascript:jQuery('#demailUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue1"></div>
					</dd>
				</dl>
				
				<!--  <dl class="nowrap">
					<dt>登陆账号：</dt>
					<dd>
						账号：<input id="loginName" name="loginName" type="text" size="20" value="" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						密码：<input id="password" name="password" type="text" size="15" value=""/>
						<div class="button"><div class="buttonContent" onclick="createAccount();"><button>生成账号</button></div></div>
					</dd>
				</dl>-->
				<dl class="nowrap">
					<dt>邮件正文：</dt>
					<dd>
						<textarea id="emailContent" class="editor" rows="16" cols="100" name="deptcontent">
						<p>
							&nbsp;您好：
						</p>
						<blockquote style="MARGIN-RIGHT: 0px" dir="ltr">
							<p>
								登陆账号：
							</p>
							<p>
								密码：
							</p>
							<p>
								&nbsp;
							</p>
							<p dir="ltr">
								此致
							</p>
						</blockquote>
						<p dir="ltr">
							敬礼
						</p>
						<p dir="ltr" align="right">
							科学基金科研诚信管理平台
						</p>
						<p dir="ltr" align="right">
							<%=request.getAttribute("year") %>年<%=request.getAttribute("month") %>月<%=request.getAttribute("day") %>日
						</p>
						</textarea>
					</dd>
				</dl>
				</div>
			</div>
			</div>
			</div>
			<div class="formBar">
			<ul>
				<logic:notEqual name="RoleIDs" value="2"  scope="session">
				<li><div id="newButton" class="button" style="display:block;"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				</logic:notEqual>
				<li><div id="sendButton" class="buttonActive"  style="display:none;"><div class="buttonContent"><button type="submit">发送邮件</button></div></div></li>
				<li><div id="editButton" class="button" style="display:none;"><div class="buttonContent"><button type="submit">编辑意见</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>