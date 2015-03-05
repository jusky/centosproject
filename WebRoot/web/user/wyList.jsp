<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<form id="pagerForm" method="post" action='<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=wylook'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=wylook" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>委员姓名:</label>
				<input type="text" name="wyName"/>
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="wyId" warn="请选择委员">选择</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th align="center" width="40"><input type="checkbox" class="checkboxCtrl" group="wyId"/></th>
				<th align="center" width="40">序号</th>
				<th align="center" width="150">委员姓名</th>
				<th align="center">单位</th>
				<th align="center" width="150">职务/职称</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="WYBean">
      					<tr>
      						<td align="center">
      							<input type="checkbox" name="wyId" value="{wyID:'${WYBean.id}', wyName:'${WYBean.name}'}"/>
      						</td>
      						<td align="center">
								<bean:write name="WYBean" property="serialNum"/>
							</td>
      						<td align="center">
								<bean:write name="WYBean" property="name"/>
							</td>
							<td align="center">
								<bean:write name="WYBean" property="dept"/>
							</td>
							<td align="center">
								<bean:write name="WYBean" property="title"/>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
	<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有查询到任何委员信息！
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页50  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="10" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>