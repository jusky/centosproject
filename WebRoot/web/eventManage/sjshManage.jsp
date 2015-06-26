<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function setAnonymity(cb)
{
	var id="informer5";
	if(cb.checked==true)
	{	
		document.getElementById(id).value="";
		document.getElementById(id).disabled=true;
	}
	else
	{
		document.getElementById(id).value="";
		document.getElementById(id).disabled=false;
	}
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/eventManageAction.do?method=queryMsg&operation=changePage&jdid=4'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
	<input type="hidden" name="orderField" value="${param.orderField}" />
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/eventManageAction.do?method=queryMsg&operation=search&jdid=4" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					编号：<input type="text" name="serialNum"/>
				</td>
				<td>
					举报人：<input type="text" name="reportName" id="informer5"/>
					<input type="checkbox" name="isNi" value="匿名举报" onclick="setAnonymity(this)"/>匿名
				</td>
				<td>
					被举报人：<input type="text" name="beReportName"/>
				</td>
				<td>
					 举报时间：
					 <input type="text" class="date" readonly name="jbBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="jbEndTime"/>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
			</ul>
		</div>
	</div>
	</html:form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<!-- 
			<li><a class="delete" rel="ids" href="<%=path %>/eventManageAction.do?method=delete&type=noreal" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			 -->
			<li><a class="icon" href="<%=path%>/eventManageAction.do?method=export&id=4" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center">编号</th>
				<th width="100" align="center">状态</th>
				<th width="100" align="center">举报人姓名</th>
				<th width="100" align="center">被举报人姓名</th>
				<th align="center">举报事由</th>
				<th width="130" align="center">举报时间</th>
				<logic:equal name="IsHead" value="1" scope="session">
					<th width="100" align="center" orderField="a.OFFICER" <%if (request.getParameter("orderField")!=null && request.getParameter("orderField").equals("a.OFFICER")) { %> class="${param.orderDirection}" <%} %>>查办人员</th>
				</logic:equal>
				<th width="120" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
   <logic:notEmpty name="eventManageForm" property="recordList">
     <logic:iterate name="eventManageForm" property="recordList" id="EventBean">
      <tr target="eventid" rel="${EventBean.reportID}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${EventBean.reportID}" />
      	</td>
      	<td align="center" >
			<bean:write name="EventBean" property="serialNum"/>
		</td>
      	<td align="center" >
			<bean:write name="EventBean" property="status"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="reportName"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="beReportName"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="reportReason"/>
		</td>
		<td  align="center">
			<bean:write name="EventBean" property="reportTime"/>
		</td>
		<logic:equal name="IsHead" value="1" scope="session">
			<td align="center">
				<bean:write name="EventBean" property="officer"/>
				&nbsp;&nbsp;
				<a class="btnEdit" href='<%=path%>/dispatchEventAction.do?method=init&reportID=${EventBean.reportID}' clss="link edit" mask="true" target="dialog" rel="dispatchEvent" width="550" height="450" title="指派查办人员">重新指派</a>
			</td>
		</logic:equal>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a href="<%=path%>/eventManageAction.do?method=detail&id=${EventBean.reportID}" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看</a>
			<logic:equal value="已初步核实" name="EventBean" property="status">
				<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核">审核</a>
			</logic:equal>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="eventManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何需要审核的事件
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>
