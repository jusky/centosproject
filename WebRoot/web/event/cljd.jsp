<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<div class="pageContent">
	<form method="post" action="<%=path%>/lookUpGroupAction.do?method=savecljd" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<dl class="nowrap">
				<dt>撤销项目（基金号）：</dt>
				<dd>
					<input class="" name="fundNum" type="text" size="100" value=''/><span class="inputInfo" style='color:red'>基金号之间请用逗号隔开!!!</span>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>取消申请资格年限：</dt>
				<dd>
					<input class="" name="applicantQualificationsYear" type="text" size="50" value=''/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt></dt>
				<dd>
					<input type="radio" name="choose" value="0" />通报批评
					<input type="radio" name="choose" value="1" />内部通报批评
					<input type="radio" name="choose" value="2" />书面警告
					<input type="radio" name="choose" value="3" />谈话提醒
				</dd>
			</dl>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		