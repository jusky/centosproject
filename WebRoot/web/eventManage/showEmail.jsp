<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<div class="pageContent">
	<form method="post" action="<%=path%>/mailConfigAction.do?method=save&type=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
		<logic:notEmpty name="expertAdviceForm" property="recordList">
     		<logic:iterate name="expertAdviceForm" property="recordList" id="EmailInfo">
			<dl class="nowrap">
				<dt>专家姓名：</dt>
				<dd>
					<input name="accountName" type="text" size="40" value='${EmailInfo.sendName}'/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd>
					<input name="accountName" type="text" size="60" value='${EmailInfo.recvName}'/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>标题：</dt>
				<dd>
					<input name="accountName" type="text" size="100" value='${EmailInfo.title}'/>
				</dd>
			</dl>
			<dl class="nowrap">
					<dt>登陆账号：</dt>
					<dd>
						账号：${EmailInfo.loginName }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						密码：${EmailInfo.password }
					</dd>
			</dl>
			<dl class="nowrap">
				<dt>附件列表：</dt>
				<dd>
					<logic:notEmpty name="EmailInfo" property="attachList">
  						<logic:iterate name="EmailInfo" property="attachList" id="UrlAndName">
  							${UrlAndName.name }&nbsp;&nbsp;&nbsp;&nbsp;<a href="${UrlAndName.url }" title="下载"><font color="red">下载</font></a><br/>
  						</logic:iterate>
  					</logic:notEmpty>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>邮件正文：</dt>
				<dd>
					<textarea class="editor" rows="15" cols="100" name="content">${EmailInfo.content }</textarea>
				</dd>
			</dl>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		