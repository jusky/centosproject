<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<h2 class="contentTitle">您的信息</h2>
<div class="pageContent">
	
	<form method="post" action="demo/common/ajaxDone.html" class="pageForm required-validate" onsubmit="return validateCallback(this)">
		<div class="pageFormContent">
		<logic:notEmpty name="expertFKForm" property="recordList">
     	<logic:iterate name="expertFKForm" property="recordList" id="ExpertInfo">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${ExpertInfo.id}">
			<dl class="nowrap">
				<dt>专家姓名：</dt>
				<dd><input class="readonly" name="name" type="text" size="30" value="${ExpertInfo.name }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>性别：</dt>
				<dd>
					<logic:equal value="1" name="ExpertInfo" property="sex">
						<input class="readonly" name="title" type="text" size="10" value="男"/>
					</logic:equal>
					<logic:equal value="0" name="ExpertInfo" property="sex">
						<input class="readonly" name="title" type="text" size="10" value="女"/>
					</logic:equal>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>年龄：</dt>
				<dd><input class="readonly" name="age" type="text" size="7" value="${ExpertInfo.age }"/></dd>
			</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>职称：</dt>
				<dd>
					<input class="readonly" name="title" type="text" size="25" value="${ExpertInfo.title }"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>是否博导：</dt>
					<dd>
						<logic:equal value="1" name="ExpertInfo" property="isPHD">
							<input class="readonly" name="title" type="text" size="10" value="是"/>
						</logic:equal>
						<logic:equal value="0" name="ExpertInfo" property="isPHD">
							<input class="readonly" name="title" type="text" size="10" value="否"/>
						</logic:equal>
					</dd>
			</dl>
			<dl class="nowrap">
				<dt>单位：</dt>
				<dd><input class="readonly" name="dept" type="text" size="50" value="${ExpertInfo.dept }"/></dd>
			</dl>
			<dl class="nowrap">
				<dt>专业：</dt>
				<dd>
					<input class="readonly" name="specialty" type="text" size="40" value="${ExpertInfo.specialty }"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>研究方向：</dt>
					<dd>
						<input class="readonly" name="research" type="text" size="40" value="${ExpertInfo.research }"/>
					</dd>
			</dl>
			<dl class="nowrap">
				<dt>所属学部：</dt>
				<dd>
					<input class="readonly" name="faculty" type="text" size="25" value="${ExpertInfo.faculty }"/>
				</dd>
			</dl>
			<div class="divider"></div>
			<dl class="nowrap">
				<dt>联系电话：</dt>
				<dd>
					<input class="readonly" name="phone" type="text" size="25" value="${ExpertInfo.phone }"/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>邮箱地址：</dt>
					<dd>
						<input class="readonly" name="email" size="40" type="text" value="${ExpertInfo.email }"/>
					</dd>
			</dl>
			<dl class="nowrap">
				<dt>通讯地址：</dt>
				<dd>
					<input class="readonly" name="address" type="text" size="60" value="${ExpertInfo.address }"/>
				</dd>
			</dl>
		</div>
		</logic:iterate>
		</logic:notEmpty>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
	
</div>