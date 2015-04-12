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
	var id="informer";
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
function selectLine(cb)
{
	var id=cb;
	if(document.getElementById(id).checked==false)
	{
		alert("请选择信息！");
		return false;
	}
	return true;
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/wsjbManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/wsjbManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					举报人：<input type="text" name="reportName" id="informer"/>
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
			<!-- 暂不提供批量接收功能，如果需要，另行开发
			<li><a class="add" href="<%=path%>/wsjbManageAction.do?method=recv&id={wsjbid}"><span>接收举报</span></a></li>
			-->
			<!-- 
			<li><a class="add" href="<%=path %>/wsjbManageAction.do?method=recv&id={wsjbid}" target="ajaxTodo" title="确定要接收该举报事件吗?"><span>接收录入</span></a></li>
			 
			<li><a class="delete" rel="ids" href="<%=path %>/wsjbManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			-->
			<li><a class="icon" href="<%=path%>/wsjbManageAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="40" align="center">序号</th>
				<th width="100" align="center">举报人姓名</th>
				<th width="100" align="center">被举报人姓名</th>
				<th width="200" align="center">被举报人单位</th>
				<th align="center">举报事由</th>
				<th width="130" align="center">举报时间</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="wsjbManageForm" property="recordNotFind">
   <logic:notEmpty name="wsjbManageForm" property="recordList">
     <logic:iterate name="wsjbManageForm" property="recordList" id="WsjbInfo">
      <tr target="wsjbid" rel="${WsjbInfo.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${WsjbInfo.id}"/>
      	</td>
      	<td align="center" >
			<bean:write name="WsjbInfo" property="serialNum"/>
		</td>
		<td align="center" >
			<bean:write name="WsjbInfo" property="reportName"/>
		</td>
		<td align="center" >
			<bean:write name="WsjbInfo" property="beReportName"/>
		</td>
		<td  align="center">
			<bean:write name="WsjbInfo" property="beDept"/>
		</td>
		<td align="center" >
			<bean:write name="WsjbInfo" property="jbsy2"/>
		</td>
		<td  align="center">
			<bean:write name="WsjbInfo" property="time"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a href="<%=path%>/wsjbManageAction.do?method=detail&id=${WsjbInfo.id}" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看</a>
			<a href="<%=path %>/wsjbManageAction.do?method=recv&id=${WsjbInfo.id}" target="ajaxTodo" title="确定要受理该举报案件吗?">受理</a>
			<a href="<%=path%>/wsjbManageAction.do?method=unrecv&id=${WsjbInfo.id}" target="ajaxTodo" title="确定不受理该举报案件吗?">不受理</a>
			<!-- 
			<a href="<%=path%>/wsjbManageAction.do?method=recv&id={wsjbid}" target="ajaxTodo" title="确定要接收该举报事件吗?">接收录入</a>
			 -->
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="wsjbManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何网上举报内容
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>
