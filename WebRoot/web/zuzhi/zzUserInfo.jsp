<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<form id="pagerForm" onsubmit="return divSearch(this, 'zzUserDiv');" method="post" action='<%=path%>/zzDetailAction.do?method=queryZZuser&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader" style="border:1px #B8D0D6 solid">
	<html:form onsubmit="return divSearch(this, 'zzUserDiv');" action="/zzDetailAction.do?method=queryZZuser&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
		<tr>
			<td class="dateRange">
				用户姓名:
				<input type="text" value="" name="userName">
			</td>
			<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
		</tr>
		</table>
	</div>
	</html:form>
</div>
<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="<%=path%>/web/zuzhi/addZZUser.jsp" target="dialog" rel="addZZUser" width="600" height="400" title="添加人员"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/zzDetailAction.do?method=removeuser" postType="string" target="selectedTodo" title="确定要移除这些用户吗?"><span>批量移除</span></a></li>
			<li><a class="icon" href="<%=path%>/myStartEventAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="99%" layoutH="160">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="150" align="center">用户姓名</th>
				<th width="70" align="center">性别</th>
				<th align="center">单位</th>
				<th width="150" align="center">联系方式</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
			<logic:notEqual value="true" name="zzDetailForm" property="recordNotFind">
				<logic:notEmpty name="zzDetailForm" property="recordList">
		     		<logic:iterate name="zzDetailForm" property="recordList" id="UserBean">
		     			<tr target="userid" rel="${UserBean.id}">
		     			<td align="center">
					      		<input type="checkbox" name="ids" value="${UserBean.id}" />
					    </td>
		     			<td align="center" >
							<bean:write name="UserBean" property="userName"/>
						</td>
						<td align="center" >
							<logic:equal value="1" name="UserBean" property="sex">男</logic:equal>
							<logic:equal value="0" name="UserBean" property="sex">女</logic:equal>
						</td>
						<td align="center" >
							<bean:write name="UserBean" property="dept"/>
						</td>
						<td align="center" >
							<bean:write name="UserBean" property="telPhone"/>
						</td>
						<td align="center" >
							<a href="#">&nbsp;</a>
							<a href="<%=path%>/zzDetailAction.do?method=removeuser&id={userid}" class="btnDel" target="ajaxTodo" title="确定要移除该用户吗?">移除</a>
						</td>
					</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:equal value="true" name="zzDetailForm" property="recordNotFind">
			<tr>
				<td align="center" colspan="7">
					没有添加任何人员信息
				</td>
			</tr>
			</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" rel="zzUserDiv" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
	</div>
</div>