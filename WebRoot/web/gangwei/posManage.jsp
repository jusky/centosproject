<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<form id="pagerForm" method="post" action='<%=path%>/posManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/posManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					岗位名称：<input type="text" name="posName"/>
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
			<li><a class="add" href="<%=path%>/web/gangwei/addPos.jsp" mask="true" target="dialog" rel="addGW" width="600" height="300" title="添加岗位"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/posManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center">序号</th>
				<th width="250" align="center">岗位名称</th>
				<th align="center">岗位描述</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="posManageForm" property="recordNotFind">
   <logic:notEmpty name="posManageForm" property="recordList">
     <logic:iterate name="posManageForm" property="recordList" id="PosBean">
      <tr target="slt_uid" rel="${PosBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${PosBean.id}" />
      	</td>
      	<td align="center">
			<bean:write name="PosBean" property="serialNum"/>
		</td>
		<td align="center">
			<bean:write name="PosBean" property="posName"/>
		</td>
		<td align="center" >
			<bean:write name="PosBean" property="posDescribe"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href = "<%=path%>/posManageAction.do?method=detail&uid=${PosBean.id}" class="btnLook" target="dialog" mask="true" rel="detail" width="600" height="300" title="查看岗位详情">查看</a>
		<a href = "<%=path%>/posConfigAction.do?method=edit&uid=${PosBean.id}" class="btnInfo" target="dialog" mask="true" rel="editUser" width="600" height="300" title="编辑岗位信息">编辑</a>
		<a href = "<%=path%>/posManageAction.do?method=delete&uid=${PosBean.id}" class="btnDel"  target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="posManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何岗位信息
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
