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
        $("#expertUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'expertUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 1,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
             'fileDesc': "请选择office/pdf/压缩包文件",
    		'fileExt': '*.doc;*.docx;*.xls;*.xlsx;*.pdf;*.rar;*.zip', 
            'buttonText' : 'BROWSE'
        });
        $("#emailUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=email',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue1',//与下面的id对应
            'fileDataName'   : 'emailUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 5,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
             'fileDesc': "请选择office/pdf/压缩包文件",
    		'fileExt': '*.doc;*.docx;*.xls;*.xlsx;*.pdf;*.rar;*.zip', 
            'buttonText' : 'BROWSE'
        });
    });
</script>
<script type="text/javascript">
function editAdvice(id, expertName, time, conclusion)
{
	showAdvicePanel();
	
	var advice = document.getElementById(id).value;
	var temp = "conclu" + id;
	var conclusion = document.getElementById(temp).value;
	document.getElementById("expertName").value=expertName;
	document.getElementById("time").value=time;
	document.getElementById("conclusion").value=conclusion;
	document.getElementById("advice").value=advice;
	document.getElementById("adviceid").value=id;
	
	document.getElementById("sendButton").style.display="none";
	document.getElementById("newButton").style.display="none";
	document.getElementById("editButton").style.display="block";
}
function addAdvice()
{
	showAdvicePanel();

	document.getElementById("expertName").value="";
	document.getElementById("time").value="";
	document.getElementById("conclusion").value="";
	document.getElementById("advice").value="";
	document.getElementById("adviceid").value="";
	document.getElementById("sendButton").style.display="none";
	document.getElementById("newButton").style.display="block";
	document.getElementById("editButton").style.display="none";
	//document.getElementById("newButton").className="buttonActive";
	//document.getElementById("editButton").className="buttonDisabled";
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
	document.getElementById("operatorFlag").value="sendEmail";
	document.getElementById("emailPanel").style.display="block";
	document.getElementById("advicePanel").style.display="none";
}
function showAdvicePanel()
{
	document.getElementById("operatorFlag").value="newAdvice";
	document.getElementById("emailPanel").style.display="none";
	document.getElementById("advicePanel").style.display="block";
}
function showCreatePanel()
{
	var reportID = document.getElementById("reportID").value;
	var url = "<%=path%>/expertAdviceAction.do?method=editJDH&id=" + reportID;
	openMaxWin(url);
}
function showIdentifyPanel()
{
	var reportID = document.getElementById("reportID").value;
	var url = "<%=path%>/expertAdviceAction.do?method=editJDYJS&id=" + reportID;
	openMaxWin(url);
}
function showEmail(id)
{

}
function createAccount()
{
	var loginName = generateMixed(6);
	var password = generateMixed(8);
	document.getElementById("loginName").value = loginName;
	document.getElementById("password").value = password;
}
//js生成随机数    n表示生成几位的随机数
var jschars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function generateMixed(n) {
    var res = "";
    for(var i = 0; i < n ; i ++) {
        var id = Math.ceil(Math.random()*35);
        res += jschars[id];
    }
    return res;
}
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	function uploadExpert(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<div class="pageContent">
	<form method="post" id="form1" action="<%=path%>/expertAdviceAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
	<input type="hidden" id="reportID" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" id="adviceid" name="id" value=""/>
	<input type="hidden" id="operatorFlag" name="operatorFlag" value="sendEmail"/>
	<div class="pageFormContent" layoutH="56">
	<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
		<div class="panelBar">
			<ul class="toolBar">
				<li><a class="add" mask="true" href="<%=path %>/expertAdviceAction.do?method=createExpertJDH" target="dialog" rel="createJDH" width="900" height="600"  title="专家鉴定函"><span>专家鉴定函</span></a></li>
				<!-- 
				<li><a class="add" href="javascript:showIdentifyPanel();" title="编辑鉴定意见书"><span>编辑鉴定意见书</span></a></li>
				 -->
				 <li><a class="add" mask="true" href="<%=path %>/expertAdviceAction.do?method=createJDYJS" target="dialog" rel="createJDYJS" width="800" height="450"  title="鉴定意见书"><span>鉴定意见书</span></a></li>
				<li><a class="add" href="javascript:sendEmail();" title="向专家发送邮件"><span>发送邮件</span></a></li>
				<li><a class="add" href="javascript:addAdvice();" title="新增专家鉴定意见"><span>人工录入</span></a></li>
			</ul>
		</div>
		<table class="table" width="100%" layoutH="400">
			<thead>
				<tr>
					<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
					<th width="100" align="center">专家姓名</th>
					<th width="100" align="center">鉴定时间</th>
					<th width="150" align="center">鉴定结论</th>
					<th align="center">鉴定意见</th>
					<th align="center" width="60">是否反馈</th>
					<th align="center" width="60">附件</th>
					<th width="150" align="center">管理</th>
				</tr>
			</thead>
			<tbody>
			<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
			   <logic:notEmpty name="eventManageForm" property="recordList">
			     <logic:iterate name="eventManageForm" property="recordList" id="ExpertAdvice">
			      <tr target="expertid" rel="${ExpertAdvice.id}">
			      	<td align="center">
			      		<input type="checkbox" name="ids" value="${ExpertAdvice.id}" />
			      	</td>
			      	<td align="center" >
						<bean:write name="ExpertAdvice" property="expertName"/>
					</td>
					<td align="center" >
						<bean:write name="ExpertAdvice" property="time"/>
					</td>
					<td align="center" >
						<input type="hidden" id="conclu${ExpertAdvice.id}" name="test" value="${ExpertAdvice.conclusion }"/>
						<bean:write name="ExpertAdvice" property="conclusion"/>
					</td>
					<td align="center" >
						<input type="hidden" id="${ExpertAdvice.id}" name="test" value="${ExpertAdvice.advice }"/>
						<bean:write name="ExpertAdvice" property="advice"/>
					</td>
					<td align="center" >
						<logic:equal value="1" name="ExpertAdvice" property="isFK">是</logic:equal>
						<logic:equal value="0" name="ExpertAdvice" property="isFK">否</logic:equal>
					</td>
					<td align="center" >
						<logic:notEqual value="" name="ExpertAdvice" property="attachName">
							<a href="${ExpertAdvice.attachName }">下载</a>
						</logic:notEqual>
					</td>
					<td align="center">
						<a href="#">&nbsp;</a>
						<logic:equal value="1" name="ExpertAdvice" property="isEmail">
							<a href="<%=path %>/expertAdviceAction.do?method=showEmail&id=${ExpertAdvice.id}" mask="true" rel="showEmail" target="dialog" width="1000" height="600" title="查看邮件信息">查看邮件</a>
						</logic:equal>
						<a href="javascript:editAdvice('${ExpertAdvice.id }', '${ExpertAdvice.expertName }','${ExpertAdvice.time }','${ExpertAdvice.conclusion }');" title="编辑专家鉴定意见">编辑意见</a>
						<a href="<%=path%>/expertAdviceAction.do?method=delete&id=${ExpertAdvice.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:equal value="true" name="eventManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何专家鉴定意见
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
			<div class="panel" id="advicePanel" style="display:none;">
				<h1>专家鉴定意见</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>专家姓名：</dt>
					<dd>
						<input id="expertName" name="expertName" type="text" size="60" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定时间：</dt>
					<dd>
						<input id="time" type="text" name="time" class="date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定结论：</dt>
					<dd>
						<textarea id="conclusion" rows="4" cols="100" name="conclusion"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定意见：</dt>
					<dd>
						<textarea id="advice" rows="13" cols="100" name="advice"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：</dt>
					<dd>
						<input type="file" name="expertUpload" id="expertUpload" />
        					<a href="javascript:uploadExpert('#expertUpload','event')">开始上传</a>&nbsp;
        					<a href="javascript:jQuery('#expertUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel" id="emailPanel" style="display:block;">
				<h1>发送电子邮件</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>专家姓名：</dt>
					<dd>
						<input id="org9.expertID" name="org9.expertID" type="hidden"/>
						<input id="org9.expertName" name="org9.expertName" type="text" size="60" readonly/>
						<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=expert" lookupGroup="org9">选择鉴定专家</a>
						<span class="info">选择</span>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>邮箱地址：</dt>
					<dd>
						<input name="org9.email" type="text" size="90" readonly/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>标题：</dt>
					<dd>
						<input name="title" type="text" size="90" value="关于商请鉴定XXX的函"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：</dt>
					<dd>
						<input type="file" name="emailUpload" id="emailUpload" />
        					<a href="javascript:uploadExpert('#emailUpload','email')">开始上传</a>&nbsp;
        					<a href="javascript:jQuery('#emailUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue1"></div>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>登陆账号：</dt>
					<dd>
						账号：<input id="loginName" name="loginName" type="text" size="20" value="" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						密码：<input id="password" name="password" type="text" size="15" value=""/>
						<div class="button"><div class="buttonContent" onclick="createAccount();"><button>生成账号</button></div></div>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>邮件正文：</dt>
					<dd>
						<textarea id="emailContent" class="editor" rows="16" cols="100" name="content">
						<p>
							&nbsp;您好：
						</p>
						<blockquote style="MARGIN-RIGHT: 0px" dir="ltr">
							<p>
								我是XXX，
							</p>
							<p>
								请您协助鉴定！专家鉴定函和鉴定意见书见附件！
							</p>
							<p>
								鉴定结果请使用<span style="color:#ff0000;">IE浏览器</span>登陆   http://localhost/KXJJBDXW/login.jsp（如果不能直接点击，请复制到浏览器的地址栏中访问！）
							</p>
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
							国家自然科学基金委员会监督委员会
						</p>
						<p dir="ltr" align="right">
							XXXX年XX月XX日
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
				<li><div id="sendButton" class="buttonActive"  style="display:block;"><div class="buttonContent"><button type="submit">发送邮件</button></div></div></li>
				<li><div id="newButton" class="buttonActive" style="display:none;"><div class="buttonContent"><button type="submit">新增意见</button></div></div></li>
				<li><div id="editButton" class="buttonActive" style="display:none;"><div class="buttonContent"><button type="submit">编辑意见</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>