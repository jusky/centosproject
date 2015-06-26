<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=bsld'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=bsld" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>姓名:</label>
				<input type="text" name="userName" value=""/>
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="userId" warn="请选择人员">选择</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th align="center" width="40"><input type="checkbox" class="checkboxCtrl" group="userId"/></th>
				<th align="center" orderfield="userName">姓名</th>
				<th align="center" width="200">所属组织</th>
				<th align="center" width="200">办公电话</th>
				<th align="center" width="150">办公室号</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="UserBean">
      					<tr>
      						<td align="center">
      							<input type="checkbox" name="userId" value="{id:'${UserBean.id}', loginName:'${UserBean.loginName }', userName:'${UserBean.userName}'}"/>
							</td>
							<td align="center">
								<bean:write name="UserBean" property="userName"/>
							</td>
							<td align="center">
								<bean:write name="UserBean" property="zzName"/>
							</td>
      						<td align="center">
								<bean:write name="UserBean" property="bgPhone"/>
							</td>
							<td align="center">
								<bean:write name="UserBean" property="bgsNum"/>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
	<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有查询到任何用户
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页10  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="10" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>