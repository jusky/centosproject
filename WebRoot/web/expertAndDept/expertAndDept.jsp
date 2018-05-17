<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<form id="pagerForm" method="post" action='<%=path%>/deptAndExpertAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/deptAndExpertAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					账号：<input type="text" name="loginName"/>
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
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="30" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="60" align="center">账号</th>
				<th width="80" align="center">密码</th>
				<th width="120" align="center">创建时间</th>
				<th width="120" align="center">登录时间</th>
				<th width="120" align="center">截止时间</th>
				<th width="50" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="deptAndExpertForm" property="recordNotFind">
   <logic:notEmpty name="deptAndExpertForm" property="recordList">
     <logic:iterate name="deptAndExpertForm" property="recordList" id="DeptAndExpertBean">
      <tr target="slt_uid" rel="${DeptAndExpertBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${DeptAndExpertBean.id}" />
      	</td>
		<td align="center">
			<bean:write name="DeptAndExpertBean" property="loginName"/>
		</td>
		<td align="center" >
			<bean:write name="DeptAndExpertBean" property="password"/>
		</td>
		<td  align="center">
			<bean:write name="DeptAndExpertBean" property="createTime"/>
		</td>
		<td  align="center">
			<bean:write name="DeptAndExpertBean" property="loginTime"/>
		</td>
		<td  align="center">
			<bean:write name="DeptAndExpertBean" property="endTime"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href="<%=path %>/deptAndExpertAction.do?method=delayTime&id=${DeptAndExpertBean.id}" target="dialog" mask="true" rel="editAddress" width="700" height="150"  title="延长账户登录时间"><span>延时</span></a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="deptAndExpertForm" property="recordNotFind">
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
