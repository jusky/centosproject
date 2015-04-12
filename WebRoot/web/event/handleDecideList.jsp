<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
<script type="text/javascript">
function editHandleDecide(id)
{
	var url = "<%=path%>/cljdManageAction.do?method=edit&id=" + id;
	openMaxWin(url);
}
function showDetail(id)
{
	paramers="dialogWidth:1000px; dialogHeight:700px; resizable=yes; status:no";
	url = "<%=path%>/cljdManageAction.do?method=detail&id=" + id;
	window.showModelessDialog(url, "", paramers);
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/cljdManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/cljdManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					处理编号：<input type="text" name="serialNum"/>
				</td>
				<td>
					处理人：<input type="text" name="handleName"/>
				</td>
				<td>
					会议：<input type="text" name="conference"/>
				</td>
				<td>
					 处理时间：
					 <input type="text" class="date" readonly name="handleBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="handleEndTime"/>
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
			<li><a class="delete" rel="ids" href="<%=path %>/cljdManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除这些处理决定吗?注意：删除后将无法恢复！"><span>批量删除</span></a></li>
			 -->
			<li><a class="icon" href="<%=path%>/cljdManageAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center">处理编号</th>
				<th width="100" align="center">处理人</th>
				<th width="150" align="center">所属单位</th>
				<th width="150" align="center">会议</th>
				<th width="130" align="center">处理时间</th>
				<th align="center">处理决定</th>
				<th width="180" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="cljdManageForm" property="recordNotFind">
   <logic:notEmpty name="cljdManageForm" property="recordList">
     <logic:iterate name="cljdManageForm" property="recordList" id="HandleDecide">
      <tr target="decideid" rel="${HandleDecide.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${HandleDecide.id}" />
      	</td>
      	<td align="center" >
			<bean:write name="HandleDecide" property="serialNum"/>
		</td>
      	<td align="center" >
			<bean:write name="HandleDecide" property="handleName"/>
		</td>
		<td align="center" >
			<bean:write name="HandleDecide" property="deptName"/>
		</td>
		<td align="center" >
			<bean:write name="HandleDecide" property="conference"/>
		</td>
		<td align="center" >
			<bean:write name="HandleDecide" property="handleTime"/>
		</td>
		<td align="center" >
			<bean:write name="HandleDecide" property="decideContent"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<!-- 
			<a href="javascript:showDetail('${HandleDecide.id}')" onclick="alertMsg.info('正在查询中，请稍后...')" title="查看处理决定详情">查看</a>
			 -->
			<a href="javascript:editHandleDecide('${HandleDecide.id}');">处理决定</a>
			<logic:notEqual name="HandleDecide" property="filePath" value="">
				<a href="${HandleDecide.filePath}">下载</a>
			</logic:notEqual>
			<logic:equal name="HandleDecide" property="filePath" value="">
				<a href="javascript:alert('没有查询到处理决定文件，请重新编辑！')">下载</a>
			</logic:equal>
			<a href = "<%=path%>/cljdManageAction.do?method=delete&id={decideid}" target="ajaxTodo" title="确定要删除该处理决定吗?注意：删除后将无法恢复！">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="cljdManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何处理决定
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
