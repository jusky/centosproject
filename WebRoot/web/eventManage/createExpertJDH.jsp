<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function makeExpertJDH()
{
	var jdhID = document.getElementById("jdhID").value;
	if(jdhID == "")
	{
		alert("请编辑内容并保存成功后再生成鉴定函！");
	}
	else
	{
		var url = "<%=path%>/expertAdviceAction.do?method=makeExpertJDH";
		openMaxWin(url);
	}
}
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/expertAdviceAction.do?method=saveExpertJDH" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<logic:notEmpty name="expertAdviceForm" property="recordList">
     		<logic:iterate name="expertAdviceForm" property="recordList" id="ExpertJDH">
     		<input type="hidden" id="jdhID" name="jdhID" value="${ExpertJDH.id }"/>
     		<input type="hidden" name="reportID" value="${ExpertJDH.reportID }"/>
			<dl class="nowrap">
					<dt>标题：</dt>
					<dd>
						<input type="text" id="letterTitle" name="title" size="100" value="${ExpertJDH.title }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>问题简述：</dt>
					<dd>
						<textarea id="shortInfo1" rows="4" cols="100" name="shortInfo">${ExpertJDH.shortInfo }</textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>反馈日期：</dt>
					<dd>
						<input id="time1" type="text" name="fkTime" class="date" size="20" readonly="true" value="${ExpertJDH.fkTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定目标：</dt>
					<dd>
						<textarea rows="3" cols="100" id="target" name="target">${ExpertJDH.target }</textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定内容：</dt>
					<dd>
						<textarea rows="15" cols="100" id="jdContent" name="jdContent">${ExpertJDH.jdContent }</textarea>
					</dd>
				</dl>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="makeExpertJDH()">生成专家鉴定函</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		