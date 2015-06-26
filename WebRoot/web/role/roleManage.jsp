<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<form id="pagerForm" method="post" action='<%=path%>/roleManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/roleManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					角色名：<input type="text" name="roleName"/>
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
			<li><a class="add" href="<%=path%>/web/role/addRole.jsp" mask="true" target="dialog" rel="addRole" width="500" height="300" title="添加角色"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/roleManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="50" align="center">编号</th>
				<th width="200" align="center">角色名</th>
				<th  align="center">角色简介</th>
				<th width="60" align="center">是否启用</th>
				<th width="250" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="roleManageForm" property="recordNotFind">
   <logic:notEmpty name="roleManageForm" property="recordList">
     <logic:iterate name="roleManageForm" property="recordList" id="RoleBean">
      <tr target="slt_uid" rel="${RoleBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${RoleBean.id}" />
      	</td>
		<td align="center">
			<bean:write name="RoleBean" property="serialNum"/>
		</td>
		<td align="center" >
			<bean:write name="RoleBean" property="roleName"/>
		</td>
		<td align="center" >
			<bean:write name="RoleBean" property="roleDescribe"/>
		</td>
		<td align="center">
			<logic:equal value="1" name="RoleBean" property="isUse">是</logic:equal>
			<logic:equal value="0" name="RoleBean" property="isUse">否</logic:equal>
		</td>
		<td  align="center" >
			<a href="#">&nbsp;</a>
			<a href = "<%=path%>/roleManageAction.do?method=detail&id=${RoleBean.id}" target="dialog" mask="true" rel="detail" width="500" height="300" title="查看角色详情">查看</a>
			<a href = "<%=path%>/configRoleAction.do?method=edit&id=${RoleBean.id}" target="dialog" mask="true" rel="editRole" width="500" height="300" title="编辑角色信息">编辑</a>
			<!-- 
			<a href = "<%=path%>/roleManageAction.do?method=copyRole&id={slt_uid}" target="dialog" mask="true" rel="copyRole" width="900" height="600" title="复制角色">复制角色</a>
			 -->
			<a href = "<%=path%>/roleManageAction.do?method=resAllocation&id=${RoleBean.id}" target="dialog" mask="true" rel="resAllocation" width="350" height="530" title="分配角色资源">资源分配</a>
			<a href = "<%=path%>/roleManageAction.do?method=delete&uid=${RoleBean.id}"  target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="roleManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何角色
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
