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
<div class="pageContent" style="overflow:auto">
	<form method="post" action="<%=path%>/facultyFKAction.do?method=saveAdvice" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="facultyFKForm" property="recordList">
     	<logic:iterate name="facultyFKForm" property="recordList" id="FacultyAdviceBean">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${FacultyAdviceBean.id}">
			<dl class="nowrap">
				<dt>编号:</dt>
				<dd><input class="required" readonly name="serialNum" type="text" size="20" value="${FacultyAdviceBean.serialNum }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>被举报人：</dt>
				<dd><input class="required" readonly name="beReportName" type="text" size="20" value="${FacultyAdviceBean.beReportName }"/></dd>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>学部意见：</dt>
				<dd>
					<textarea id="facultyAdviceContent" class="required" minlength="5" maxlength="600" <logic:equal name="FacultyAdviceBean" property="isfk" value="1">readonly</logic:equal> rows="15" cols="75" name="advice">${FacultyAdviceBean.advice}</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>调查报告：</dt>
				<dd>
					<a target="_blank" href="${FacultyAdviceBean.filePath}">下载调查报告</a>
				</dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<logic:equal name="FacultyAdviceBean" property="isfk" value="0">
				<li><div class="button"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				</logic:equal> 
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>