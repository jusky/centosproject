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
		<logic:notEmpty name="zzManageForm" property="recordList">
     	<logic:iterate name="zzManageForm" property="recordList" id="ZZBean">
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>组织编号：</label>
				<input readonly name="zzID" type="text" size="30" value="${ZZBean.zzID }"/>
			</p>
			<p>
				<label>组织名称：</label>
				<input readonly name="zzName" type="text" size="30" value="${ZZBean.zzName }"/>
			</p>
			<p>
				<label>上级组织：</label>
				<input readonly readonly name="pzzName" value="${ZZBean.pzzName }" type="text" size="30" />
			</p>
			<p>
				<label>组织简介：</label>
				<textarea name="zzDescribe" cols="30" readonly rows="7">${ZZBean.zzDescribe }</textarea>
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
