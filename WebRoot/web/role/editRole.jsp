<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<div class="pageContent">
	<form method="post" action="<%=path %>/configRoleAction.do?method=save&operation=editRole" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="57">
		<logic:notEmpty name="configRoleForm" property="recordList">
     		<logic:iterate name="configRoleForm" property="recordList" id="RoleBean">
     			<input type="hidden" name="id" value="${RoleBean.id}">
				<p>
					<label>角色名称：</label>
					<input class="required" name="roleName" type="text" size="30" value="${RoleBean.roleName}"/>
				</p>
				<p>
					<label>是否启用：</label>
					<select name="isUse">
						<option value="1">是</option>
						<option value="0">否</option>
					</select>
				</p>
				<p>
					<label>角色简介：</label>
					<textarea name="roleDescribe" cols="30" rows="5">${RoleBean.roleDescribe}</textarea>
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

