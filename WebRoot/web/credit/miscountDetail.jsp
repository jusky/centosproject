<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
</script> 
<div class="pageContent">
	<form method="post" action="<%=path%>/configMiscountAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="configMiscountForm" property="recordList">
     	<logic:iterate name="configMiscountForm" property="recordList" id="MiscountInfo">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${MiscountInfo.id}">
			<dl class="nowrap">
				<dt>标题：</dt>
				<dd><input readonly minlength="2" maxlength="30" name="code" type="text" size="35" value="${MiscountInfo.title}"/></dd>
			</dl>			
			<dl class="nowrap">
				<dt>当事人：</dt>
				<dd><input name="individual" type="text" size="20" value="${MiscountInfo.individual}"/></dd>
			</dl>					
			<dl class="nowrap">
				<dt>当事单位：</dt>
				<dd>
					<input name="institute" readonly type="text" size="25" value="${MiscountInfo.institute}"/>
				</dd>
			</dl>				
			<dl class="nowrap">
				<dt>不端类型：</dt>
				<dd><textarea name="mistype" readonly cols="40" rows="3">${MiscountInfo.mistype}</textarea></dd>
			</dl>					
			<dl class="nowrap">
				<dt>处罚措施：</dt>
				<dd><textarea name="punish" readonly cols="40" rows="3" >${MiscountInfo.punish}</textarea></dd>
			</dl>					
			<dl class="nowrap">
				<dt>生效时间：</dt>
				<dd><input name="time" readonly type="text" size="20" value="${MiscountInfo.time}"/></dd>
			</dl>		
			<dl class="nowrap">
				<dt>举报编号：</dt>
				<dd><input  readonly name="reportId" type="text" size="20" value="${MiscountInfo.reportId }"/></dd>
			</dl>			
			<dl class="nowrap">
				<dt>详细内容的文件地址：</dt>
				<dd>${MiscountInfo.detail }</dd>
			</dl>				
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>