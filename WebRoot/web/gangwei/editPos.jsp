<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<div class="pageContent">
	<form method="post" action="<%=path %>/posConfigAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="57">
		<logic:notEmpty name="posConfigForm" property="recordList">
     		<logic:iterate name="posConfigForm" property="recordList" id="PosBean">
     			<input type="hidden" name="id" value="${PosBean.id}">
				<p>
					<label>岗位名称：</label>
					<input class="required" name="posName" type="text" size="30" value="${PosBean.posName}"/>
				</p>
				<p>
					<label>岗位简介：</label>
					<textarea name="posDescribe" cols="30" rows="5">${PosBean.posDescribe}</textarea>
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

