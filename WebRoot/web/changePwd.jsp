<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="pageContent">
	<form method="post" action="<%=path%>/changePwdAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>旧密码：</label>
				<input class="required" name="oldPwd" type="password" autocomplete="off" size="20"/>
			</p>
			<p>
				<label>新密码：</label>
				<input id="pwd" name="newPwd" type="password" size="20" class="required password" autocomplete="off" alt="字母、数字、!@#$%^&*()_+-= 6-20位"/>
			</p>
			<p>
				<label>确认新密码：</label>
				<input type="password" name="repassword" class="required" autocomplete="off" equalto="#pwd"/>
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