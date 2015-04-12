<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/configUserAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="userManageForm" property="recordList">
     	<logic:iterate name="userManageForm" property="recordList" id="UserBean">
		<div class="pageFormContent" layoutH="56">
			<dl class="nowrap">
				<dt>登陆账号：</dt>
				<dd><input name="loginName" readonly type="text" size="30" value="${UserBean.loginName }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>姓名：</dt>
				<dd><input name="userName" readonly type="text" size="25" value="${UserBean.userName }"/></dd>
			</dl>
			<dl>
				<dt>性别：</dt>
				<dd>
				<logic:equal value="1" name="UserBean" property="sex">
				 	<input name="userName" readonly type="text" size="10" value="男"/>
				</logic:equal>
				<logic:equal value="0" name="UserBean" property="sex">
				 	<input name="userName" readonly type="text" size="10" value="女"/>
				</logic:equal>
				</dd>
			</dl>
			<dl>
				<dt>是否领导：</dt>
				<dd>
				<logic:equal value="1" name="UserBean" property="isHead">
				 	<input name="userName" readonly type="text" size="10" value="是"/>
				</logic:equal>
				<logic:equal value="0" name="UserBean" property="isHead">
				 	<input name="userName" readonly type="text" size="10" value="否"/>
				</logic:equal>
				</dd>
			</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>所属组织：</dt>
				<dd>
					<input name="zzName" type="text" size="40" readonly value="${UserBean.zzName }"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>组织编号：</dt>
					<dd>
						<input readonly name="org6.zzID" value="${UserBean.zzID }" type="text"/>
					</dd>
				</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>担任职务：</dt>
				<dd>
					<input name="posName" type="text" size="40" readonly value="${UserBean.posNames }"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>职务编号：</dt>
					<dd>
						<input readonly name="org6.zzID" value="${UserBean.posIDs }" type="text"/>
					</dd>
				</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>角色分配：</dt>
				<dd>
					<input name="org7.roleName" type="text" size="40" readonly value="${UserBean.roleNames }"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>角色编号：</dt>
					<dd>
						<input readonly name="org7.roleID" value="${UserBean.roleIDs }" type="text"/>
					</dd>
				</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>办公电话：</dt>
				<dd><input readonly name="bgPhone" type="text" size="25" value="${UserBean.bgPhone }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>办公室号：</dt>
				<dd><input readonly name="bgsNum" type="text" size="25" value="${UserBean.bgsNum }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>手机号码：</dt>
				<dd><input readonly name="telPhone" type="text" size="30" value="${UserBean.telPhone }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd><input readonly name="mailAddress" type="text" size="50" value="${UserBean.mailAddress }"/></dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
