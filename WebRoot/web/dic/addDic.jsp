<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/dicConfigAction.do?method=save&operation=new" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<p>
				<label>代码标识：</label>
				<input class="required" name="codeName" type="text" size="20"/>
			</p>
			<p>
				<label>代码编码：</label>
				<input class="required" name="code" type="text" size="10"/>
			</p>
			<p>
				<label>代码显示名称：</label>
				<input class="required" name="caption" type="text" size="30"/>
			</p>
			<p>
				<label>说明：</label>
				<textarea name="remark" cols="30" rows="5"></textarea>
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
