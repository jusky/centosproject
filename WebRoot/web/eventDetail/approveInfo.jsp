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
						<logic:notEmpty name="ApproveInfo" property="checkList">
							<logic:iterate name="ApproveInfo" property="checkList" id="CheckBean">
							<dl>
								<dt>核实人：</dt>
								<dd>${CheckBean.nibanName}</dd>
							</dl>
							<dl>
								<dt>提交时间：</dt>
								<dd>${CheckBean.nibanTime}</dd>
							</dl>
							<dl class="nowrap">
								<dt>初核意见：</dt>
								<dd><textarea rows="10" cols="80" readonly>${CheckBean.nibanAdvice}</textarea></dd>
							</dl>
						</logic:iterate>
					</logic:notEmpty>
				</fieldset>
				<fieldset>
					<legend>领导审批</legend>
					<logic:notEmpty name="ApproveInfo" property="approveList">
					<logic:iterate name="ApproveInfo" property="approveList" id="ApproveBean">
						<dl>
							<dt>审核人：</dt>
							<dd>${ApproveBean.headName}</dd>
						</dl>
						<dl>
							<dt>批示时间：</dt>
							<dd>${ApproveBean.approveTime}</dd>
						</dl>
						<logic:notEmpty name="ApproveBean" property="isXY">
						<dl>
							<dt>调查所需：</dt>
							<dd>${ApproveBean.isXY}</dd>
						</dl>
						</logic:notEmpty>
						<dl class="nowrap">
							<dt>领导批示：</dt>
							<dd><textarea rows="12" cols="80" readonly>${ApproveBean.headAdvice}</textarea></dd>
						</dl>
						<div class="divider"></div>
					</logic:iterate>
					</logic:notEmpty>
				</fieldset>
			</logic:iterate>
		</logic:notEmpty>
	</logic:notEqual>
</div>