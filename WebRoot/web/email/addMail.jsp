<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<div class="pageContent">
	<form method="post" action="<%=path%>/mailConfigAction.do?method=save&type=new" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>账号名称：</label>
				<input class="required" name="accountName" type="text" size="30"/>
			</p>
			<p>
				<label>邮箱类型：</label>
				<select class="combox" name="mailBoxType">
						<option value="pop3">pop3类型</option>
				</select>
			</p>
			<p>
				<label>邮箱地址：</label>
				<input type="text" name="mailBoxAddress" class="required email" alt="请输入您的电子邮件" size="40"/>
			</p>
			<p>
				<label>邮箱密码：</label>
				<input id="w_validation_pwd" type="password" name="mailBoxPwd" class="required alphanumeric" minlength="6" maxlength="20" alt="字母、数字、下划线 6-20位"/>
			</p>
			<p>
				<label>smtp主机：</label>
				<input class="required" name="smtpPC" type="text" size="40" />
			</p>
			<p>
				<label>smtp端口：</label>
				<input class="required" name="smtpPort" type="text" size="20" />
			</p>
			<p>
				<label>pop主机：</label>
				<input class="required" name="popPC" type="text" size="40" />
			</p>
			<p>
				<label>pop端口：</label>
				<input class="required" name="popPort" type="text" size="20" />
			</p>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		