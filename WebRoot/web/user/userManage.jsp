<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<form id="pagerForm" method="post" action='<%=path%>/userManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/userManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					姓名：<input type="text" name="userName"/>
				</td>
				<!-- 
				<td>
					创建时间：
					 <input type="text" class="date" readonly name="createBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="createEndTime"/>
				</td>
				 -->
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				<li><a class="button" href="<%=path %>/web/user/gjSearch.jsp" rel="gjSearch" target="dialog" mask="true" width="600" height="310" title="查询框"><span>高级检索</span></a></li>
			</ul>
		</div>
	</div>
	</html:form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="<%=path%>/web/user/addUser.jsp" mask="true" target="dialog" rel="addUser" width="750" height="590" title="添加用户"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/userManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="100" align="center">账号</th>
				<th width="150" align="center">用户姓名</th>
				<th  align="center">部门</th>
				<th  align="center" width="60">是否领导</th>
				<th width="120" align="center">办公电话</th>
				<th width="150" align="center">手机号码</th>
				<th width="160" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="userManageForm" property="recordNotFind">
   <logic:notEmpty name="userManageForm" property="recordList">
     <logic:iterate name="userManageForm" property="recordList" id="UserBean">
      <tr target="slt_uid" rel="${UserBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${UserBean.id}" />
      	</td>
		<td align="center">
			<bean:write name="UserBean" property="loginName"/>
		</td>
		<td align="center" >
			<bean:write name="UserBean" property="userName"/>
		</td>
		<td align="center" >
			<bean:write name="UserBean" property="zzName"/>
		</td>
		<td align="center" >
			<logic:equal value="1" name="UserBean" property="isHead">是</logic:equal>
			<logic:equal value="0" name="UserBean" property="isHead">否</logic:equal>
		</td>
		<td  align="center">
			<bean:write name="UserBean" property="bgPhone"/>
		</td>
		<td align="center" >
			<bean:write name="UserBean" property="telPhone"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href = "<%=path%>/userManageAction.do?method=detail&uid=${UserBean.id}" target="dialog" mask="true" rel="detail" width="750" height="590" title="查看用户详情">查看</a>
		<a href = "<%=path%>/userManageAction.do?method=initPWD&uid=${UserBean.id}" target="ajaxTodo" title="确定要将该用户的密码恢复为初始值吗?">密码重置</a>
		<a href = "<%=path%>/configUserAction.do?method=edit&uid=${UserBean.id}" target="dialog" mask="true" rel="editUser" width="750" height="590" title="编辑用户信息">编辑</a>
		<a href = "<%=path%>/userManageAction.do?method=delete&uid=${UserBean.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="userManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何用户
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
