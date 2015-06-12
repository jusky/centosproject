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
	<form method="post" action="<%=path%>/configInstituteAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="configInstituteForm" property="recordList">
     	<logic:iterate name="configInstituteForm" property="recordList" id="InstituteInfo">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${InstituteInfo.id}">
			<dl class="nowrap">
				<dt>代码:</dt>
				<dd><input class="required" maxlength="13" minlength="13" name="code" type="text" size="20" value="${InstituteInfo.code }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>性质：</dt>
				<dd><select name="category" id="category">
						<logic:equal name="InstituteInfo" property="category" value="0" >
							<option value="1">高等院校</option>
							<option value="2">研究机构</option>
							<option value="0" selected>其他</option>
						</logic:equal>
						<logic:equal name="InstituteInfo" property="category" value="1" >
							<option value="1" selected>高等院校</option>
							<option value="2">研究机构</option>
							<option value="0">其他</option>
						</logic:equal>
						<logic:equal name="InstituteInfo" property="category" value="2" >
							<option value="1">高等院校</option>
							<option value="2" selected=>研究机构</option>
							<option value="0">其他</option>
						</logic:equal>
					</select></dd>
			</dl>
			<dl class="nowrap">
				<dt>名称：</dt>
				<dd><input class="required" minlength="2" maxlength="50" name="name" type="text" size="55" value="${InstituteInfo.name }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>联系电话：</dt>
				<dd>
					<input minlength="6" maxlength="30" name="phone" type="text" size="25" value="${InstituteInfo.phone}"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>通讯地址：</dt>
				<dd>
					<textarea class="email" name="address" cols="50" rows="4">${InstituteInfo.address}</textarea>
				</dd>
			</dl>
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