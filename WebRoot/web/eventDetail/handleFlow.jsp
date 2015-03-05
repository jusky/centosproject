<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function showFlowGraph()
{
	var width = screen.availWidth;
	var height = screen.availHeight;
	var Ttop = screen.availHeight / 2 - height / 2;
	var Tlef = screen.availWidth / 2 - width / 2;
	url = "<%=path%>/eventDetailAction.do?method=flowGraph";
	var feather = "width=" + width + ", height=" + height + ", fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1, top=" + Ttop + ",left=" + Tlef;
	window.open(url, "_blank", feather);
}
</script>
<div class="pageContent" layoutH="56" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="javascript:showFlowGraph();"><span>流程图</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="50" align="center">序号</th>
				<th width="150" align="center">操作人姓名</th>
				<th width="100" align="center">操作时间</th>
				<th align="center">操作类型</th>
				<th width="150" align="center">事件状态</th>
			</tr>
		</thead>
		<tbody>
	<logic:notEqual value="true" name="eventDetailForm" property="recordNotFind">
		<logic:notEmpty name="eventDetailForm" property="recordList">
     		<logic:iterate name="eventDetailForm" property="recordList" id="HandleFlow">
     			<tr target="id" rel="${HandleFlow.id}">
     			<td align="center" >
					<bean:write name="HandleFlow" property="serialNum"/>
				</td>
				<td align="center" >
					<bean:write name="HandleFlow" property="name"/>
				</td>
				<td align="center" >
					<bean:write name="HandleFlow" property="time"/>
				</td>
				<td align="center" >
					<bean:write name="HandleFlow" property="type"/>
				</td>
				<td align="center" >
					<bean:write name="HandleFlow" property="status"/>
				</td>
			</tr>
			</logic:iterate>
		</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="eventDetailForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有记录任何信息
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
</div>