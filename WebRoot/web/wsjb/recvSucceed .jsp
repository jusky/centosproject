<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function makeSJYBD()
{
	var ybdId = document.getElementById("ybdID").value;
	if(ybdId == null || ybdId == "")
	{
		alert("请先编辑内容并保存成功后，再生成收件阅办单！");
	}
	else
	{
		var reportID = document.getElementById("reportID").value;
		var url = "<%=path%>/sjybdManageAction.do?method=makeSJYBD&reportID=" + reportID;
		openMaxWin(url);
	}
}

</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/sjybdManageAction.do?method=saveSJYBD" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<logic:notEmpty name="wsjbManageForm" property="recordList">
     		<logic:iterate name="wsjbManageForm" property="recordList" id="SjybdBean">
     		<input type="hidden" name="reportID" id="reportID" value="${SjybdBean.reportID }"/>
     		<input type="hidden" name="ybdID" id="ybdID" value="${SjybdBean.id }"/>
			<dl class="nowrap">
				<dt>编号：</dt>
				<dd>
					<input class="requird" name="serialNum" type="text" size="20" value='${SjybdBean.serialNum }'/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>来件单位：</dt>
				<dd>
					<input class="requird" name="comeName" type="text" size="50" value='${SjybdBean.comeName }'/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>收件日期：</dt>
				<dd>
					<input type="text" name="recvTime" class="required date" size="20" readonly value="${SjybdBean.recvTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>来件标题：</dt>
				<dd>
					<textarea class="requird" rows="5" cols="60" name="title">${SjybdBean.title }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>拟办意见：</dt>
				<dd>
					<textarea class="requird" rows="5" cols="60" name="proposedOpinion">${SjybdBean.proposedOpinion }</textarea>
				</dd>
			</dl>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="makeSJYBD()">生成收件阅办单</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		