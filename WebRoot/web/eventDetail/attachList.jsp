<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
<script type="text/javascript">
function showattach(filename,extname)
{
	if(isDocument(extname))
	{
		//paramers="dialogWidth:1000px; dialogHeight:700px; resizable=yes; status:no";
		//url = "<%=path%>/web/documentView.jsp?filename=" + filename;
		//var url = "<%=path%>/eventDetailAction.do?method=showDoc&filename=" + filename;
		var url = "<%=path%>/web/dsoframer/showAttachDoc.jsp?filename=" + filename;
		openMaxWin(url);
	}
	else if(isPicture(extname))
	{
		paramers="dialogWidth:1000px; dialogHeight:700px; resizable=yes; status:no";
		//filename+="." + extname;
		url = "<%=path%>/web/pictureView.jsp?filename=" + filename;
		url = encodeURI(url);
		window.showModelessDialog(url, "", paramers);
	}
	else
	{
		alert("该附件无法在线预览，如果需要查看，请下载到本地！");
		return;
	}
	
}
function isPicture(extname)
{
	if(extname=="png" || extname=="jpg" || extname=="jpeg" || extname=="gif")
	{
		return true;
	}
	else
	{
		return false;
	}
}
function isDocument(extname)
{
	if(extname=="doc" || extname=="docx")
	{
		return true;
	}
	else
	{
		return false;
	}
}
</script>
<div class="pageContent" layoutH="56" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="50" align="center">序号</th>
				<th width="200" align="center">文件名</th>
				<th width="70" align="center">扩展名</th>
				<th align="center">路径</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
	<logic:notEqual value="true" name="eventDetailForm" property="recordNotFind">
		<logic:notEmpty name="eventDetailForm" property="recordList">
     		<logic:iterate name="eventDetailForm" property="recordList" id="AttachmentBean">
     			<tr target="file" rel="${AttachmentBean.fileName}">
     			<td align="center" >
					<bean:write name="AttachmentBean" property="serialNum"/>
				</td>
     			<td align="center" >
					<bean:write name="AttachmentBean" property="fileName"/>
				</td>
				<td align="center" >
					<bean:write name="AttachmentBean" property="extName"/>
				</td>
				<td align="center" >
					<bean:write name="AttachmentBean" property="filePath"/>
				</td>
				<td align="center" >
					<a href="#">&nbsp;</a>
					<a href="#" onclick="showattach('${AttachmentBean.fileName}','${AttachmentBean.extName}')" >预览</a>
					<a href="${AttachmentBean.filePath }">下载</a>
				</td>
			</tr>
			</logic:iterate>
		</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="eventDetailForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有上传任何附件
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
</div>