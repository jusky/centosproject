<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function makeDCH()
{
	var dchID = document.getElementById("dchID").value;
	if(dchID == null || dchID == "")
	{
		alert("请先编辑内容并保存成功后，再生成调查函！");
	}
	else
	{
		var url = "<%=path%>/deptAdviceAction.do?method=makeDCH&dchID=" + dchID;
		openMaxWin(url);
	}
}
function createAccount()
{
	var loginName = generateMixed(6);
	var password = generateMixed(8);
	document.getElementById("loginName").value = loginName;
	document.getElementById("password").value = password;
}
var jschars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function generateMixed(n) {
    var res = "";
    for(var i = 0; i < n ; i ++) {
        var id = Math.ceil(Math.random()*35);
        res += jschars[id];
    }
    return res;
}
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/deptAdviceAction.do?method=saveDCH" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="deptAdviceForm" property="recordList">
     	<logic:iterate name="deptAdviceForm" property="recordList" id="DeptSurveyLetter">
		<div class="pageFormContent" layoutH="56">
     		<input type="hidden" name="isEdit" value="${DeptSurveyLetter.isEdit }"/>
     		<input type="hidden" id="dchID" name="dchID" value="${DeptSurveyLetter.id }"/>
			<input type="hidden" name="adviceID" value="${DeptSurveyLetter.adviceID }"/>
				<dl class="nowrap">
					<dt>标题：</dt>
					<dd>
						<input class="required" id="title" name="title" type="text" size="70" value="${DeptSurveyLetter.title }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>单位名称：</dt>
					<dd>
						<input class="required" id="deptName" name="deptName" type="text" size="40" value="${DeptSurveyLetter.deptName }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>问题简述：</dt>
					<dd>
						<textarea class="required" id="shortInfo1" rows="2" cols="70" name="shortInfo">${DeptSurveyLetter.shortInfo }</textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>反馈日期：</dt>
					<dd>
						<input class="required date" id="time1" type="text" name="fkTime" size="20" readonly="true" value="${DeptSurveyLetter.fkTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>登陆账号：</dt>
					<dd>
					<logic:equal value="0" name="DeptSurveyLetter" property="isEdit">
						账号：<input id="loginName" class="required" name="loginName" type="text" size="20" value="${DeptSurveyLetter.loginName }"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						密码：<input id="password" class="required" name="password" type="text" size="15" value="${DeptSurveyLetter.password }"/>
						<div class="button"><div class="buttonContent" onclick="createAccount();"><button>生成账号</button></div></div>
					</logic:equal>
					<logic:equal value="1" name="DeptSurveyLetter" property="isEdit">
						账号：${DeptSurveyLetter.loginName }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						密码：${DeptSurveyLetter.password }
					</logic:equal>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>调查内容：</dt>
					<dd>
						<textarea class="required" id="surveyContent" rows="15" cols="70" name="surveyContent">${DeptSurveyLetter.surveyContent }</textarea>
					</dd>
				</dl>
			
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="makeDCH()">生成调查函</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
			</logic:iterate>
			</logic:notEmpty>
	</form>
</div>
		