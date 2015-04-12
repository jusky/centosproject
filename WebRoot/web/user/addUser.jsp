<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/configUserAction.do?method=save&operation=new">
		<div class="pageFormContent" layoutH="57">
			<dl class="nowrap">
				<dt>登陆账号：</dt>
				<dd><input class="required" minlength="5" maxlength="20" name="loginName" type="text" size="30"/><span class="info">字母、数字、下划线 5-20位</span></dd>
			</dl>
			<dl class="nowrap">
				<dt>姓名：</dt>
				<dd><input class="required" minlength="2" maxlength="40" name="userName" type="text" size="25" /><span class="info">请输入您的真实姓名</span></dd>
			</dl>
			<dl>
				<dt>性别：</dt>
				<dd><select name="sex">
							<option value="1">请选择</option>
							<option value="1">男</option>
							<option value="0">女</option>
					</select></dd>
			</dl>
			<dl>
				<dt>是否领导：</dt>
				<dd><select name="isHead">
							<option value="0">请选择</option>
							<option value="1">是</option>
							<option value="0">否</option>
					</select></dd>
			</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>所属组织：</dt>
				<dd>
					<input name="org6.zzID" value="" type="hidden">
					<input id="zuzhi" name="org6.zzName" type="text" size="40" readonly value=""/>
					<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=sszz" lookupGroup="org6">选择组织</a>
					<span class="info">选择</span>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>组织编号：</dt>
					<dd>
						<input readonly name="org6.zzID" readonly="readonly" type="text"/>
					</dd>
				</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>担任职务：</dt>
				<dd>
					<input name="org8.posID" value="" type="hidden">
					<input id="pos" name="org8.posName" type="text" size="40" readonly value=""/>
					<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=pos" lookupGroup="org8">选择角色</a>
					<span class="info">选择</span>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>职务编号：</dt>
					<dd>
						<input readonly name="org8.posID" readonly="readonly" type="text"/>
					</dd>
				</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>角色分配：</dt>
				<dd>
					<input id="role" name="org7.roleName" type="text" size="40" readonly value=""/>
					<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=role" lookupGroup="org7">选择角色</a>
					<span class="info">选择</span>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>角色编号：</dt>
					<dd>
						<input readonly name="org7.roleID" readonly="readonly" type="text"/>
					</dd>
				</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>办公电话：</dt>
				<dd><input minlength="4" maxlength="25" name="bgPhone" type="text" size="25" /></dd>
			</dl>
			<dl class="nowrap">
				<dt>办公室号：</dt>
				<dd><input minlength="4" maxlength="25" name="bgsNum" type="text" size="25" /></dd>
			</dl>
			<dl class="nowrap">
				<dt>手机号码：</dt>
				<dd><input class="phone" minlength="11" maxlength="30" name="telPhone" type="text" size="30" /></dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd><input class="email" minlength="5" maxlength="30" name="mailAddress" type="text" size="50" /></dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
