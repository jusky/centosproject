<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
	 function sendMail()
	 {
	 	//先控制页面跳转到发送邮件页面
	 	$("#sendEmailID").click();
	 	//然后关闭当前对话框
	 	$.pdialog.closeCurrent();
	 }
</script>
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/wyManageAction.do?method=saveWY">
		<logic:notEmpty name="wyManageForm" property="recordList">
  		<logic:iterate name="wyManageForm" property="recordList" id="WYBean">
		<div class="pageFormContent" layoutH="57">
			<dl>
				<dt><font color="blue">姓名：</font></dt>
				<dd><bean:write name="WYBean" property="name"/></dd>
			</dl>
			<dl>
				<dt><font color="blue">性别：</font></dt>
				<dd><logic:equal value="1" name="WYBean" property="sex">男</logic:equal>
					<logic:equal value="0" name="WYBean" property="sex">女</logic:equal>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt><font color="blue">单位：</font></dt>
				<dd><bean:write name="WYBean" property="dept"/></dd>
			</dl>
			<dl class="nowrap">
				<dt><font color="blue">职务/职称：</font></dt>
				<dd><bean:write name="WYBean" property="title"/></dd>
			</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt><font color="blue">通讯地址：</font></dt>
				<dd><bean:write name="WYBean" property="txAddress"/></dd>
			</dl>
			<dl class="nowrap">
				<dt><font color="blue">邮箱地址：</font></dt>
				<dd>
					<bean:write name="WYBean" property="email"/>
					<logic:notEqual value="" name="WYBean" property="email">
						<a id="sendEmailID" href="<%=path%>/newMailAction.do?method=init&address=${WYBean.email}" target="navTab" rel="newEmail" style="display:none;">发送邮件</a>
						<a href="#" onclick="javascript:sendMail()"><font color="red">发送邮件</font></a>
					</logic:notEqual>	
				</dd>
			</dl>
			<dl class="nowrap">
				<dt><font color="blue">联系方式：</font></dt>
				<dd><bean:write name="WYBean" property="phone"/></dd>
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
