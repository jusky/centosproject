<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<div class="pageContent">
	<form method="post" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path %>/meetManageAction.do?method=saveclose">
		<div class="pageFormContent" layoutH="57">	
			<dl>
				<dt>会议名称：</dt>
				<dd><input class="required" name="meetName" type="text" size="30" value=""/></dd>
			</dl>
			<dl class="nowrap">
				<dt>召开时间：</dt>
				<dd><input type="text" name="time" class="required date" size="20" readonly="true"/><a class="inputDateButton" href="javascript:;">选择</a></dd>
			</dl>
			<dl class="nowrap">
				<dt>召开地点：</dt>
				<dd>
					<input class="required" name="location" type="text" size="60" value=""/>
    			</dd>
			</dl>
			<dl class="nowrap">
				<dt>参会委员：</dt>
				<dd>
					<textarea id="wyNames" rows="10" cols="80" name="orgw.wyName"></textarea>
					<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=wylook" lookupGroup="orgw">选择委员</a>
					<span class="info">选择委员</span>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存后关闭</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>