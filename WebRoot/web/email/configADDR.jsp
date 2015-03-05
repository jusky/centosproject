<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/addressBookAction.do?method=saveADDR">
		<input type="hidden" name="addrID" value="<%=request.getAttribute("addrID") %>"/>
		<logic:notEmpty name="addressBookForm" property="recordList">
  		<logic:iterate name="addressBookForm" property="recordList" id="ContactBean">
		<div class="pageFormContent" layoutH="57">
			<dl class="nowrap">
				<dt>姓名：</dt>
				<dd><input class="required" minlength="2" maxlength="40" name="addrName" type="text" size="25" value="${ContactBean.contactName }"/></dd>
			</dl>
			
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd><input class="required" minlength="2" maxlength="40" name="emailAddr" type="text" size="50" value="${ContactBean.contactAddr }"/></dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
