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
		<logic:notEmpty name="roleManageForm" property="recordList">
     	<logic:iterate name="roleManageForm" property="recordList" id="RoleBean">
		<div class="pageFormContent" layoutH="56">
			<p>
					<label>角色名称：</label>
					<input class="readonly" name="roleName" type="text" size="30" value="${RoleBean.roleName}"/>
				</p>
				<p>
					<label>是否启用：</label>
					<logic:equal value="1" name="RoleBean" property="isUse">
					 	<input name="userName" class="readonly" type="text" size="10" value="是"/>
					</logic:equal>
					<logic:equal value="0" name="RoleBean" property="isUse">
					 	<input name="userName" class="readonly" type="text" size="10" value="否"/>
					</logic:equal>
				</p>
				<p>
					<label>角色简介：</label>
					<textarea class="readonly" cols="30" rows="5">${RoleBean.roleDescribe}</textarea>
				</p>
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
