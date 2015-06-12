<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<div class="pageContent">
	<form method="post" action="<%=path%>/mailConfigAction.do?method=save&type=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
		<logic:notEmpty name="mailConfigForm" property="recordList">
     		<logic:iterate name="mailConfigForm" property="recordList" id="EmailBean">
     		<input type="hidden" name="id" value="${EmailBean.ID}">
			<p>
				<label>账号名称：</label>
				<input class="required" name="accountName" type="text" size="30" value='${EmailBean.accountName}'/>
			</p>
			<p>
				<label>邮箱类型：</label>
				<select class="combox" name="mailBoxType">
						<option value="pop3">pop3类型</option>
				</select>
			</p>
			<p>
				<label>邮箱地址：</label>
				<input type="text" name="mailBoxAddress" class="required email" alt="请输入您的电子邮件" size="40" value='${EmailBean.mailBoxAddress}'/>
			</p>
			<p>
				<label>邮箱密码：</label>
				<input id="w_validation_pwd" type="password" name="mailBoxPwd" value='${EmailBean.mailBoxPwd}' class="required password" alt="字母、数字、!@#$%^&*()_+-= 6-20位"/>
			</p>
			<p>
				<label>smtp主机：</label>
				<input class="required" name="smtpPC" type="text" size="40" value='${EmailBean.smtpPC}'/>
			</p>
			<p>
				<label>smtp端口：</label>
				<input class="required" name="smtpPort" type="text" size="20" value='${EmailBean.smtpPort}'/>
			</p>
			<p>
				<label>pop主机：</label>
				<input class="required" name="popPC" type="text" size="40" value='${EmailBean.popPC}'/>
			</p>
			<p>
				<label>pop端口：</label>
				<input class="required" name="popPort" type="text" size="20" value='${EmailBean.popPort}'/>
			</p>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		