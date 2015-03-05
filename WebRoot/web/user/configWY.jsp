<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/wyManageAction.do?method=saveWY">
		<input type="hidden" name="wyID" value="<%=request.getAttribute("wyID") %>"/>
		<input type="hidden" name="addrID" value="<%=request.getAttribute("addrID") %>"/>
		<logic:notEmpty name="wyManageForm" property="recordList">
  		<logic:iterate name="wyManageForm" property="recordList" id="WYBean">
		<div class="pageFormContent" layoutH="57">
			<dl class="nowrap">
				<dt>姓名：</dt>
				<dd><input class="required" minlength="2" maxlength="40" name="wyName" type="text" size="25" value="${WYBean.name }"/></dd>
			</dl>
			<dl>
				<dt>性别：</dt>
				<dd><select name="sex">
				<% 
					if(request.getAttribute("wySex").equals(""))
					{
				%>
							<option value="2" selected="true">请选择</option>
							<option value="1">男</option>
							<option value="0">女</option>
				<%  } else if(request.getAttribute("wySex").equals("1")){%>
							<option value="2" >请选择</option>
							<option value="1" selected="true">男</option>
							<option value="0">女</option>
				<%} else {%>
							<option value="2">请选择</option>
							<option value="1">男</option>
							<option value="0" selected="true">女</option>
				<% }%>
					</select></dd>
			</dl>
			<dl class="nowrap">
				<dt>单位：</dt>
				<dd><input class="required" minlength="2" maxlength="40" name="dept" type="text" size="50" value="${WYBean.dept }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>职务/职称：</dt>
				<dd><input class="required" minlength="1" maxlength="25" name="title" type="text" size="30" value="${WYBean.title }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>通讯地址：</dt>
				<dd><input minlength="4" maxlength="50" name="txAddress" type="text" size="60" value="${WYBean.txAddress }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
				<dd><input class="required email" minlength="5" maxlength="30" name="email" type="text" size="40" value="${WYBean.email }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>联系方式：</dt>
				<dd><input class="phone" minlength="5" maxlength="30" name="phone" type="text" size="40" value="${WYBean.phone }"/></dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
