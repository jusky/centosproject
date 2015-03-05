<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/dicConfigAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="dicConfigForm" property="recordList">
     	<logic:iterate name="dicConfigForm" property="recordList" id="DicBean">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${DicBean.id}">
			<p>
				<label>代码标识：</label>
				<input class="required" name="codeName" type="text" size="20" value='${DicBean.codeName}'/>
			</p>
			<p>
				<label>代码编码：</label>
				<input class="required" name="code" type="text" size="10" value='${DicBean.code}'/>
			</p>
			<p>
				<label>代码显示名称：</label>
				<input class="required" name="caption" type="text" size="30" value='${DicBean.caption}'/>
			</p>
			<p>
				<label>说明：</label>
				<textarea name="remark" cols="30" rows="5">${DicBean.remark}</textarea>
			</p>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
