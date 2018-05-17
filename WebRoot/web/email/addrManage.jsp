 <%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 

<form id="pagerForm" method="post" action='<%=path%>/addressBookAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/addressBookAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					姓名：<input type="text" name="addrName" />
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
			<li><a class="add" href="<%=path%>/addressBookAction.do?method=configADDR&type=new" mask="true" target="dialog" rel="addAddress" width="750" height="200" title="添加联系人"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path%>/addressBookAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除这些联系人吗?"><span>批量删除</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=path%>/addressBookAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="150" align="center">姓名</th>
				<th align="center">邮箱地址</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="addressBookForm" property="recordNotFind">
   <logic:notEmpty name="addressBookForm" property="recordList">
     <logic:iterate name="addressBookForm" property="recordList" id="ContactBean">
      <tr target="addrid" rel="${ContactBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${ContactBean.id}"/>
      	</td>
      	<td align="center" >
			<bean:write name="ContactBean" property="contactName"/>
		</td>
		<td align="center" >
			<bean:write name="ContactBean" property="contactAddr"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a href="<%=path%>/addressBookAction.do?method=configADDR&type=edit&uid=${ContactBean.id}" target="dialog" mask="true" rel="editAddress" width="750" height="200" title="编辑联系人">编辑</a>
			<a href="<%=path %>/addressBookAction.do?method=delete&uid=${ContactBean.id}" target="ajaxTodo" title="确定要删除该联系人吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="addressBookForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何联系人
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
