<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<form id="pagerForm" method="post" action='<%=path%>/wyManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/wyManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					委员姓名：<input type="text" name="wyName"/>
				</td>
				<td>
					所在单位：<input type="text" name="dept"/>
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
			<li><a class="add" href="<%=path%>/wyManageAction.do?method=configWY&type=new" mask="true" target="dialog" rel="addExpert" width="750" height="350" title="添加委员信息"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/wyManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=path%>/wyManageAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="30" align="center">序号</th>
				<th width="100" align="center">委员姓名</th>
				<th width="70" align="center">性别</th>
				<th width="100" align="center">单位</th>
				<th width="100" align="center">职务/职称</th>
				<th align="center">通讯地址</th>
				<th width="120" align="center">邮箱地址</th>
				<th width="100" align="center">联系方式</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="wyManageForm" property="recordNotFind">
   <logic:notEmpty name="wyManageForm" property="recordList">
     <logic:iterate name="wyManageForm" property="recordList" id="WYBean">
      <tr target="slt_uid" rel="${WYBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${WYBean.id}" />
      	</td>
      	<td align="center">
			<bean:write name="WYBean" property="serialNum"/>
		</td>
		<td align="center">
			<bean:write name="WYBean" property="name"/>
		</td>
		<td align="center" >
			<logic:equal value="1" name="WYBean" property="sex">男</logic:equal>
			<logic:equal value="0" name="WYBean" property="sex">女</logic:equal>
		</td>
		<td align="center" >
			<bean:write name="WYBean" property="dept"/>
		</td>
		<td  align="center">
			<bean:write name="WYBean" property="title"/>
		</td>
		<td align="center" >
			<bean:write name="WYBean" property="txAddress"/>
		</td>
		<td align="center" >
			<bean:write name="WYBean" property="email"/>
		</td>
		<td align="center" >
			<bean:write name="WYBean" property="phone"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href = "<%=path%>/wyManageAction.do?method=detail&uid=${WYBean.id}" target="dialog" mask="true" rel="detail" width="750" height="350" title="查看委员详情">查看</a>
		<a href = "<%=path%>/wyManageAction.do?method=configWY&type=edit&uid=${WYBean.id}" target="dialog" mask="true" rel="editExpert" width="750" height="350" title="编辑委员信息">编辑</a>
		<a href = "<%=path%>/wyManageAction.do?method=delete&uid=${WYBean.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="wyManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何委员信息
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
