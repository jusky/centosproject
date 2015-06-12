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
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/configInstituteAction.do?method=save&operation=new">
		<div class="pageFormContent" layoutH="57">
			<dl class="nowrap">
				<dt>代码：</dt>
				<dd><input class="required" maxlength="13" minlength="13" name="code" type="text" size="20"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>性质：</dt>
				<dd><select name="category">
							<option value="0">请选择</option>
							<option value="1">高等院校</option>
							<option value="2">研究机构</option>
							<option value="0">其他</option>
					</select></dd>
			</dl>
			<dl class="nowrap">
				<dt>名称：</dt>
				<dd><input class="required" name="name" type="text" size="50" /></dd>
			</dl>					
			<dl class="nowrap">
				<dt>联系电话：</dt>
				<dd>
					<input minlength="6" maxlength="30" name="phone" type="text" size="25" />
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>通讯地址：</dt>
				<dd>
					<textarea class="address" name="address" cols="50" rows="4" ></textarea>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
