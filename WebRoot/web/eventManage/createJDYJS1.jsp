<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function makeJDYJS()
{
	var yjsID = document.getElementById("yjsID").value;
	if(yjsID == "")
	{
		alert("请编辑内容并保存成功后再生成鉴定意见书！");
	}
	else
	{
		var url = "<%=path%>/expertAdviceAction.do?method=makeJDYJS";
		openMaxWin(url);
	}
}
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/expertAdviceAction.do?method=saveJDYJS" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<logic:notEmpty name="expertAdviceForm" property="recordList">
     		<logic:iterate name="expertAdviceForm" property="recordList" id="JDYJSBean">
     		<input type="hidden" id="yjsID" value="${JDYJSBean.id }" />
     		<input type="hidden" name="reportID" value="${JDYJSBean.reportID }" />
			<dl class="nowrap">
				<dt>案由：</dt>
				<dd>
					<textarea class="requird" rows="2" cols="70" name="eventReason">${JDYJSBean.eventReason }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>鉴定内容及目的：</dt>
				<dd>
					<textarea class="requird" rows="3" cols="70" name="identifyContent">${JDYJSBean.identifyContent }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>委托机构：</dt>
				<dd>
					<input class="requird" name="wtDept" type="text" size="50" value='${JDYJSBean.wtDept }'/>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>鉴定结论：</dt>
				<dd>
					<textarea class="requird" rows="8" cols="70" name="jdConclusion">${JDYJSBean.jdConclusion }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt></dt>
				<dd>
					每输入一个鉴定结论选项，请回车！例如：<br/>
					1、请选择XXX的第一组论文是否存在重复发表<br/>
					2、请选择XXX的第一组论文是否存在造假
				</dd>
			</dl>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="makeJDYJS()">生成鉴定意见书</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		