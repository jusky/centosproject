<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<div class="pageContent">
	<form method="post" action="/bmjjManageAction.do?method=save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<div class="pageFormContent" layoutH="57">
			<dl>
				<dt>标题：</dt>
				<dd><input class="required" name="total" type="text" size="30" /></dd>
			</dl>
			<dl class="nowrap">
			<dt>收信人:</dt>
			<dd>
				<input name="org3.id" value="" type="hidden">
				<input name="org3.orgName" type="text" size="60"/>
				<a class="btnLook" href="<%=request.getContextPath()%>/dwz/demo/database/dwzOrgLookup2.html" lookupGroup="org3">查找带回</a>
				<span class="info">查找</span>
			</dd>
			</dl>
			<dl class="nowrap">
				<dt>收信组织：</dt>
				<dd>
				<input name="org3.id" value="" type="hidden">
				<input name="org3.orgName" type="text" size="60"/>
				<a class="btnLook" href="<%=request.getContextPath()%>/dwz/demo/database/dwzOrgLookup2.html" lookupGroup="org3">查找带回</a>
				<span class="info">查找</span>
			</dd>
			</dl>
			<dl class="nowrap">
				<dt>需要回复：</dt>
				<dd>
					<input type="radio" name="r1" checked="checked"/>是
					<input type="radio" name="r1" />否
				</dd>
			</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>内容：</dt>
				<dd>	
				<div class="unit">
					<textarea class="editor" name="description" rows="15" cols="100">请输入内容</textarea>
				</div>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">发送</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>

