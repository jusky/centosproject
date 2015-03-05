<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%>
<link href="<%=path %>/styles/jquery-ui.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/js/jquery-ui.min.js"></script>
<script>
	  $(function() {
	  	$("#rate").spinner({
		  min: 0.00,
		  max: 1.00,
		  step: 0.01,
		  numberFormat: "n"
		}); 
	})
</script>
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath()%>/configPunishAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="configPunishForm" property="recordList">
     	<logic:iterate name="configPunishForm" property="recordList" id="PunishBean">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${PunishBean.id}">
			<p>
				<label>代码标识：</label>
				<input class="required" name="codename" type="text" size="20" value='${PunishBean.codename}'/>
			</p>
			<p>
				<label>代码编码：</label>
				<input class="required" name="code" type="text" size="10" value='${PunishBean.code}'/>
			</p>
			<p>
				<label>代码显示名称：</label>
				<input class="required" name="caption" type="text" size="30" value='${PunishBean.caption}'/>
			</p>
			<p>
				<label>恢复时间/年：</label>
				<input class="required" name="year" type="number" size="10" value="${PunishBean.year}"/>
			</p>
			<p>
				<label>恢复上限：</label>
				<input id="rate" class="required" name="rate" size="10" value="${PunishBean.rate}"/>
			</p>
			<p>
				<label>说明：</label>
				<textarea name="remark" cols="30" rows="5">${PunishBean.remark}</textarea>
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
