<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="pageContent">
	<form method="post" action="<%=path%>/eventManageAction.do?method=midCloseEvent" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="reportID" value="<%=request.getAttribute("ReportID") %>"/>
		<div class="pageFormContent" layoutH="56">
			<fieldset>
					<legend>举报内容</legend>
					<dl class="nowrap">
						<dt>事件简述：</dt>
						<dd><textarea rows="8" cols="60" readonly><%=request.getAttribute("ReportInfo") %></textarea></dd>
					</dl>
			</fieldset>
			<fieldset>
					<legend>结束内容</legend>
					<dl class="nowrap">
						<dt>调查结果：</dt>
						<dd>
							<textarea name="surveyResult" cols="70" rows="12" class="required"></textarea>
						</dd>
					</dl>
			</fieldset>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定结束</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>