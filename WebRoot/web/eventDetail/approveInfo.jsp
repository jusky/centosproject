<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="pageFormContent" layoutH="75">
	<logic:notEqual value="true" name="eventDetailForm" property="recordNotFind">
		<logic:notEmpty name="eventDetailForm" property="recordList">
     		<logic:iterate name="eventDetailForm" property="recordList" id="ApproveInfo">
     			<fieldset>
					<legend>初核意见</legend>
						<dl>
							<dt>核实人：</dt>
							<dd>${ApproveInfo.nibanName}</dd>
						</dl>
						<dl>
							<dt>提交时间：</dt>
							<dd>${ApproveInfo.nibanTime}</dd>
						</dl>
						<dl class="nowrap">
							<dt>初步核实意见：</dt>
							<dd><textarea rows="10" cols="80" readonly>${ApproveInfo.nibanAdvice}</textarea></dd>
						</dl>
				</fieldset>
				<fieldset>
					<legend>领导批示</legend>
						<dl>
							<dt>批示领导：</dt>
							<dd>${ApproveInfo.headName}</dd>
						</dl>
						<dl>
							<dt>批示时间：</dt>
							<dd>${ApproveInfo.headTime}</dd>
						</dl>
						<dl class="nowrap">
							<dt>领导批示：</dt>
							<dd><textarea rows="12" cols="80" readonly>${ApproveInfo.headAdvice}</textarea></dd>
						</dl>
				</fieldset>
			</logic:iterate>
		</logic:notEmpty>
	</logic:notEqual>
</div>