<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/commons/taglibs.jsp" %>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
				+ request.getServerName() + ":" + request.getServerPort()
				+ path + "/";
%>
<script type="text/javascript">
var selectInst = function() {
	var url = encodeURI("<%=path%>/instituteManageAction.do?method=getcode&name=" + $("#editIName").val());
	$.post(url)
	.done(function(data){
		var code = JSON.parse(data);
		if(typeof code.code == "undefined"){
			alert("该单位不存在!");
			$("#editIName").val("");
		} else {
			$("#editICode").val(code.code);}
	})
	.fail(function(){
		alert("网络连接错误!");
		$("#editIName").val("");
	});
}
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/configIndividualAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="configIndividualForm" property="recordList">
     	<logic:iterate name="configIndividualForm" property="recordList" id="IndividualInfo">
		<div class="pageFormContent" layoutH="57">
			<input type="hidden" name="id" value="${IndividualInfo.id}"/>
			<dl class="nowrap">
				<dt>姓名：</dt>
				<dd><input class="required" minlength="2" maxlength="20" name="name" type="text" size="20" value="${IndividualInfo.name}"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>性别：</dt>
				<dd><select name="sex">
					<logic:equal value="1" name="IndividualInfo" property="sex">
					<option value="1" selected="true">男</option>
					<option value="0">女</option>
					</logic:equal>
					<logic:equal value="0" name="IndividualInfo" property="sex">
					<option value="1">男</option>
					<option value="0" selected="true">女</option>
					</logic:equal>
				</select>
			</dl>
			<dl class="nowrap">
				<dt>身份证：</dt>
				<dd>
					<input class="required" minlength="16" maxlength="16" name="pid" type="text" size="25" value="${IndividualInfo.pid}"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>职称：</dt>
				<dd>
					<input class="required" minlength="1" maxlength="20" name="title" type="text" size="25" value="${IndividualInfo.title}"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>是否专家：</dt>
				<dd><select name="isExpert">
					<logic:equal value="1" name="IndividualInfo" property="isExpert">
					<option value="1" selected="true">是</option>
					<option value="0">否</option>
					</logic:equal>
					<logic:equal value="0" name="IndividualInfo" property="isExpert">
					<option value="1">是</option>
					<option value="0" selected="true">否</option>
					</logic:equal>
				</select></dd>
			</dl>
			<dl class="nowrap">
				<dt>单位：</dt>
				<dd><input id="editICode" name="institute" type="hidden" value="${IndividualInfo.instCode}"/>
					<input class="required" id="editIName" type="text" size="50" value="${IndividualInfo.institute}" onchange="selectInst();"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>专业：</dt>
				<dd>
					<input name="specialty" type="text" minlength="2" maxlength="30" size="40" value="${IndividualInfo.specialty}"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>联系电话：</dt>
				<dd>
					<input minlength="6" maxlength="20" name="phone" type="text" size="25" value="${IndividualInfo.phone}"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd>
					<input class="email" name="email" minlength="5" maxlength="40" size="50" type="text" value="${IndividualInfo.email}"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>通讯地址：</dt>
				<dd>
					<textarea name="address" cols="40" rows="4" value="${IndividualInfo.address}"></textarea>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
		</logic:iterate>
		</logic:notEmpty>
	</form>
</div>