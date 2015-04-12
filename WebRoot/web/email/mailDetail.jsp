<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/mailConfigAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="mailManageForm" property="recordList">
     		<logic:iterate name="mailManageForm" property="recordList" id="EmailBean">
			<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${EmailBean.ID}">
			<p>
				<label>账号名称：</label>
				<input readonly name="accountName" type="text" size="30" value='${EmailBean.accountName}'/>
			</p>
			<p>
				<label>邮箱类型：</label>
				<input readonly name="accountName" type="text" size="20" value='${EmailBean.mailBoxType}'/>
			</p>
			<p>
				<label>邮箱地址：</label>
				<input type="text" name="mailBoxAddress" readonly size="40" value='${EmailBean.mailBoxAddress}'/>
			</p>
			<p>
				<label>smtp主机：</label>
				<input readonly name="smtpPC" type="text" size="40" value='${EmailBean.smtpPC}'/>
			</p>
			<p>
				<label>smtp端口：</label>
				<input readonly name="smtpPort" type="text" size="20" value='${EmailBean.smtpPort}'/>
			</p>
			<p>
				<label>pop主机：</label>
				<input readonly name="popPC" type="text" size="40" value='${EmailBean.popPC}'/>
			</p>
			<p>
				<label>pop端口：</label>
				<input readonly name="popPort" type="text" size="20" value='${EmailBean.popPort}'/>
			</p>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
			</logic:iterate>
		</logic:notEmpty>
	</form>
</div>
		