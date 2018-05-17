<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
function showreason(id)
{
	document.getElementById("id").value=id;
	paramers="dialogWidth:320px; dialogHeight:400px; resizable:yes; overflow:auto; status:no";
	url = "<%=path%>/web/event/reportReason.jsp";
	var value1 = window.showModalDialog(url, "", paramers);
	if(value1.names !== null)
	{	
		document.getElementById("wsjbreportReason").value=value1.names;
		document.getElementById("wsjbeditButton").style.display="block";
	}
}
//向举报者发送邮件
	 function sendMail()
	 {
	 	//先控制页面跳转到发送邮件页面
	 	$("#sendEmailID").click();
	 	//然后关闭当前对话框
	 	$.pdialog.closeCurrent();
	 }
	 
	 //print reportInfo
	 function printEvent_recv()
	 {
	 	var id = document.getElementById("id").value;
	 	if(id != "" && id != null){
	 		var url = "<%=path%>/wsjbManageAction.do?method=print&id=" + id;
			//openMaxWin(url);
			window.open(url);
	 	}
	 }
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/wsjbManageAction.do?method=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="wsjbManageForm" property="recordList">
     	<logic:iterate name="wsjbManageForm" property="recordList" id="WsjbInfo">
     	<input type="hidden" id="id" name="id" value='${WsjbInfo.id}'/>
		<div class="pageFormContent" layoutH="56">
				<fieldset>
					<legend>举报人信息</legend>
					<logic:equal value="1" name="WsjbInfo" property="isNi">
						<dl>
							<dt>姓名：</dt>
							<dd><font color="#ff0000">匿名举报</font></dd>
						</dl>
						<dl>
							<dt>举报人IP：</dt>
							<dd><input readonly type="text" size="30" value='${WsjbInfo.reportIP}'/></dd>
						</dl>
					</logic:equal>
					<logic:equal value="0" name="WsjbInfo" property="isNi">
						<dl class="nowrap">
							<dt>姓名：</dt>
							<dd><input readonly type="text" size="30" value='${WsjbInfo.reportName}'/></dd>
						</dl>
						<dl>
							<dt>性别：</dt>
							<dd><input readonly type="text" size="10" value='${WsjbInfo.sex}'/></dd>
						</dl>
						<!-- <dl>
							<dt>民族：</dt>
							<dd><input readonly type="text" size="20" value='${WsjbInfo.nation}'/></dd>
						</dl> -->
						<dl class="nowrap">
							<dt>工作单位：</dt>
							<dd><input readonly type="text" size="60" value='${WsjbInfo.dept}'/></dd>
						</dl>
						<dl class="nowrap">
							<dt>邮箱地址：</dt>
							<dd>
								<input readonly type="text" size="40" value='${WsjbInfo.mailAddres}'/>
								<logic:notEqual value="" name="WsjbInfo" property="mailAddres">
								<logic:notEqual value="无" name="WsjbInfo" property="mailAddres">
									<a id="sendEmailID" href="<%=path%>/newMailAction.do?method=init&address=${WsjbInfo.mailAddres}" target="navTab" rel="newEmail" style="display:none;">发送邮件</a>
									<a href="#" onclick="javascript:sendMail()"><font color="blue">发送邮件</font></a>
								</logic:notEqual>
								</logic:notEqual>
							</dd>
						</dl>
						<dl>
							<dt>固定电话：</dt>
							<dd><input readonly type="text" size="30" value='${WsjbInfo.gdPhone}'/></dd>
						</dl>
						<dl>
							<dt>手机号码：</dt>
							<dd><input readonly type="text" size="30" value='${WsjbInfo.telPhone}'/></dd>
						</dl>
						<dl>
							<dt>举报人IP：</dt>
							<dd><input readonly type="text" size="30" value='${WsjbInfo.reportIP}'/></dd>
						</dl>
						
					</logic:equal>
				</fieldset>
				<fieldset>
					<legend>被举报人信息</legend>
					<logic:notEmpty name="WsjbInfo" property="beReportList">
					<logic:iterate name="WsjbInfo" property="beReportList" id="BeReportBean">
						<dl class="nowrap">
							<dt>被举报人姓名：</dt>
							<dd><input readonly type="text" size="30" value='${BeReportBean.beName}' style="color:#ff0000;"/></dd>
						</dl>
						<dl class="nowrap">
							<dt>所属单位：</dt>
							<dd><input readonly type="text" size="60" value='${BeReportBean.beDept}'/></dd>
						</dl>
						<dl>
							<dt>职称：</dt>
							<dd><input readonly type="text" size="30" value='${BeReportBean.bePosition}'/></dd>
						</dl>
						<dl>
							<dt>联系方式：</dt>
							<dd><input readonly type="text" size="30" value='${BeReportBean.beTelPhone}'/></dd>
						</dl>
						<div class="divider"></div>
					</logic:iterate>
					</logic:notEmpty>
					<!-- <dl>
						<dt>姓名：</dt>
						<dd><input readonly type="text" size="30" value='${WsjbInfo.beReportName}'/></dd>
					</dl>
					<dl>
						<dt>性别：</dt>
						<dd><input readonly type="text" size="10" value='${WsjbInfo.beSex}'/></dd>
					</dl>
					<dl class="nowrap">
						<dt>工作单位：</dt>
						<dd><input readonly type="text" size="60" value='${WsjbInfo.beDept}'/></dd>
					</dl>
					<dl class="nowrap">
						<dt>职称：</dt>
						<dd><input readonly type="text" size="30" value='${WsjbInfo.bePosition}'/></dd>
					</dl>
					<dl class="nowrap">
						<dt>联系方式：</dt>
						<dd><input readonly type="text" size="30" value='${WsjbInfo.bePhone}'/></dd>
					</dl> -->
				</fieldset>
				<fieldset>
					<legend>举报内容</legend>
					<dl class="nowrap">
						<dt>举报确认标号：</dt>
						<dd><textarea readonly rows="3" cols="80">${WsjbInfo.notice}</textarea></dd>
					</dl>
					<dl class="nowrap">
						<dt>举报不端类型：</dt>
						<dd>
							<textarea id="wsjbreportReason" name="wsjbreportReason" rows="3" cols="70" readonly>${WsjbInfo.jbsy2 }</textarea>
							<a class="btnLook" href="javascript:showreason(${WsjbInfo.id})">选择举报事由</a>
							<span class="info"></span>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>内容详情：</dt>
						<dd>
							<textarea rows="15" cols="80" readonly>${WsjbInfo.detail }</textarea>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>附件：</dt>
						<dd>
							<logic:equal value="无" name="WsjbInfo" property="attachPath">无附件</logic:equal>
							<logic:notEqual value="无" name="WsjbInfo" property="attachPath">
								<a href="${WsjbInfo.attachPath }" >下载附件</a>
							</logic:notEqual>
						</dd>
					</dl>
					<dl>
						<dt>举报查询码：</dt>
						<dd><input readonly type="text" size="30" value='${WsjbInfo.searchID}'/></dd>
					</dl>
				</fieldset>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div id="wsjbeditButton" class="button" style="display:none;"><div class="buttonContent"><button type="submit">编辑</button></div></div></li>
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="printEvent_recv()">打印</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
