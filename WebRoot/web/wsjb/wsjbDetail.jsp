<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/configWyAction.do?method=editContent" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="wsjbManageForm" property="recordList">
     	<logic:iterate name="wsjbManageForm" property="recordList" id="WsjbInfo">
		<div class="pageFormContent" layoutH="56">
				<fieldset>
					<legend>举报人信息</legend>
					<logic:equal value="1" name="WsjbInfo" property="isNi">
						<dl>
							<dt>姓名：</dt>
							<dd><font color="#ff0000">匿名举报</font></dd>
						</dl>
					</logic:equal>
					<logic:equal value="0" name="WsjbInfo" property="isNi">
						<dl class="nowrap">
							<dt>姓名：</dt>
							<dd><input readonly="true" type="text" size="30" value='${WsjbInfo.reportName}'/></dd>
						</dl>
						<dl>
							<dt>性别：</dt>
							<dd><input readonly="true" type="text" size="10" value='${WsjbInfo.sex}'/></dd>
						</dl>
						<dl>
							<dt>民族：</dt>
							<dd><input readonly="true" type="text" size="20" value='${WsjbInfo.nation}'/></dd>
						</dl>
						<dl class="nowrap">
							<dt>工作单位：</dt>
							<dd><input readonly="true" type="text" size="60" value='${WsjbInfo.dept}'/></dd>
						</dl>
						<dl class="nowrap">
							<dt>邮箱地址：</dt>
							<dd><input readonly="true" type="text" size="40" value='${WsjbInfo.mailAddres}'/></dd>
						</dl>
						<dl>
							<dt>固定电话：</dt>
							<dd><input readonly="true" type="text" size="30" value='${WsjbInfo.gdPhone}'/></dd>
						</dl>
						<dl>
							<dt>手机号码：</dt>
							<dd><input readonly="true" type="text" size="30" value='${WsjbInfo.telPhone}'/></dd>
						</dl>
					</logic:equal>
				</fieldset>
				<fieldset>
					<legend>被举报人信息</legend>
					<dl>
						<dt>姓名：</dt>
						<dd><input readonly="true" type="text" size="30" value='${WsjbInfo.beReportName}'/></dd>
					</dl>
					<dl>
						<dt>性别：</dt>
						<dd><input readonly="true" type="text" size="10" value='${WsjbInfo.beSex}'/></dd>
					</dl>
					<dl class="nowrap">
						<dt>工作单位：</dt>
						<dd><input readonly="true" type="text" size="60" value='${WsjbInfo.beDept}'/></dd>
					</dl>
					<dl class="nowrap">
						<dt>职称：</dt>
						<dd><input readonly="true" type="text" size="30" value='${WsjbInfo.bePosition}'/></dd>
					</dl>
					<dl class="nowrap">
						<dt>联系方式：</dt>
						<dd><input readonly="true" type="text" size="30" value='${WsjbInfo.bePhone}'/></dd>
					</dl>
				</fieldset>
				<fieldset>
					<legend>举报内容</legend>
					<dl class="nowrap">
						<dt>举报事由：</dt>
						<dd><textarea rows="3" cols="80" readonly="true">${WsjbInfo.jbsy2 }</textarea></dd>
					</dl>
					<dl class="nowrap">
						<dt>内容详情：</dt>
						<dd>
							<textarea rows="15" cols="80" readonly="true">${WsjbInfo.detail }</textarea>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>附件：</dt>
						<dd>
							<logic:equal value="无" name="WsjbInfo" property="attachPath">无附件</logic:equal>
							<logic:notEqual value="无" name="WsjbInfo" property="attachPath">
								<a href="${WsjbInfo.attachPath }" >下载附件</a>
							</logic:notEqual>
						</dd>
					</dl>
				</fieldset>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
