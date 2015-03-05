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
	var url = encodeURI("<%=path%>/instituteManageAction.do?method=getcode&name=" + $("#addIName").val());
	$.post(url)
	.done(function(data){
		var code = JSON.parse(data);
		if(typeof code.code == "undefined"){
			alert("该单位不存在!");
			$("#addIName").val("");
		} else {
			$("#addICode").val(code.code);}
	})
	.fail(function(){
		alert("网络连接错误!");
		$("#addIName").val("");
	});
}
</script>
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path %>/configIndividualAction.do?method=save&operation=new">
		<div class="pageFormContent" layoutH="57">
			<dl class="nowrap">
				<dt>姓名：</dt>
				<dd><input class="required" minlength="2" maxlength="20" name="name" type="text" size="20" /></dd>
			</dl>
			<dl class="nowrap">
				<dt>性别：</dt>
				<dd><select name="sex">
					<option value="1">请选择</option>
					<option value="1">男</option>
					<option value="0">女</option>
				</select>
			</dl>
			<dl class="nowrap">
				<dt>身份证：</dt>
				<dd>
					<input class="required" minlength="16" maxlength="16" name="pid" type="text" size="25"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>职称：</dt>
				<dd>
					<input class="required" minlength="1" maxlength="20" name="title" type="text" size="25" />
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>是否专家：</dt>
				<dd><select name="isExpert">
					<option value="0">请选择</option>
					<option value="0">否</option>
					<option value="1">是</option>
				</select></dd>
			</dl>
			<dl class="nowrap">
				<dt>单位：</dt>
				<dd><input id="addICode" name="institute" type="hidden" />
					<input class="required" id="addIName" type="text" size="50" alt="请输入单位名称" onchange="selectInst();"/>
			</dl>
			<dl class="nowrap">
				<dt>专业：</dt>
				<dd>
					<input name="specialty" type="text" minlength="2" maxlength="30" size="40"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>联系电话：</dt>
				<dd>
					<input minlength="6" maxlength="20" name="phone" type="text" size="25"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd>
					<input class="email" name="email" minlength="5" maxlength="40" size="50" type="text"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>通讯地址：</dt>
				<dd>
					<textarea name="address" cols="40" rows="4"></textarea>
				</dd>
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