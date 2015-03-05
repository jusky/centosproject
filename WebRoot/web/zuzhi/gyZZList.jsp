<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=sszz'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=sszz" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>组织名称:</label>
				<input type="text" name="zzName" value=""/>
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th align="center" width="100">组织编号</th>
				<th align="center" width="150">组织名称</th>
				<th align="center" >组织简介</th>
				<th align="center" width="60">选择</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="ZZBean">
      					<tr>
      					<td align="center">
								<bean:write name="ZZBean" property="zzID"/>
							</td>
							<td align="center">
								<bean:write name="ZZBean" property="zzName"/>
							</td>
							<td align="center">
								<bean:write name="ZZBean" property="zzDescribe"/>
							</td>
							<td align="center">
								<a href="#">&nbsp;</a>
								<a class="btnSelect" href="javascript:$.bringBack({zzID:'${ZZBean.zzID }', zzName:'${ZZBean.zzName }'})" title="组织选择">选择</a>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
			<tr>
				<td align="center" colspan="5">
					没有查询到任何组织
				</td>
			</tr>
			</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页10  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="10" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>