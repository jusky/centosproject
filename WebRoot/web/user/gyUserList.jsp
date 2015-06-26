<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/queryUserAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/queryUserAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					姓名：<input type="text" name="userName"/>
				</td>
				<td>
					<select class="combox" name="isOverdue">
						<option value="">--所属组织--</option>
						<option value="yes">监督委员会办公室</option>
					</select>
				</td>
				<td>
					<div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div>
				</td>
			</tr>
		</table>
	</div>
	</html:form>
</div>
<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
<div class="panelBar">
	<ul class="toolBar">
		<li><a class="add" rel="ids" href="<%=request.getContextPath()%>/posUserAction.do?method=addUser" postType="string" target="ajaxTodo" title="确定要添加这些用户吗?"><span>批量添加</span></a></li>
	</ul>
</div>
<table class="table" width="100%" layoutH="95">
	<thead>
		<tr>
			<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
			<th width="150" align="center">姓名</th>
			<th align="center">组织</th>
			<th width="100" align="center">管理</th>
		</tr>
	</thead>
<tbody>
<logic:notEqual value="true" name="gyUserListForm" property="recordNotFind">
   <logic:notEmpty name="gyUserListForm" property="recordList">
     <logic:iterate name="gyUserListForm" property="recordList" id="UserBean">
      <tr target="slt_uid" rel="${UserBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${UserBean.id}" />
      	</td>
		<td align="center">
			<bean:write name="UserBean" property="userName"/>
		</td>
		<td align="center" >
			<bean:write name="UserBean" property="userID"/>
		</td>
		<td  align="center" >
			<a href = "<%=request.getContextPath()%>/posUserAction.do?method=addUser&uid={slt_uid}" target="ajaxTodo" title="确定要选择该用户吗?">选择</a>					
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="gyUserListForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			目前系统没有添加任何用户
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
