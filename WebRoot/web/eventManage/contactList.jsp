<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<form id="pagerForm" onsubmit="return divSearch(this, 'zzUserDiv');" method="post" action='<%=path%>/createGroupAction.do?method=queryGroup&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader" style="border:1px #B8D0D6 solid">
	<html:form onsubmit="return divSearch(this, 'contactBox');" action="/createGroupAction.do?method=queryGroup&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
		<tr>
			<td>
				<input type="text" value="" size="40" name="expertName">
			</td>
			<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
		</tr>
		</table>
	</div>
	</html:form>
</div>
<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="380" rel="contactBox">
		<thead>
			<tr>
				<th width="30" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="100" align="center">姓名</th>
				<th width="200" align="center">所属单位</th>
				<th width="100" align="center">联系方式</th>
				<th align="center">研究方向</th>
				<th width="70" align="center">选择</th>
			</tr>
		</thead>
		<tbody>
			<logic:notEqual value="true" name="createGroupForm" property="recordNotFind">
				<logic:notEmpty name="createGroupForm" property="recordList">
					<logic:iterate name="createGroupForm" property="recordList" id="GroupBean">
				      <tr target="dic_id" rel="${GroupBean.id}">
				      	<td align="center">
				      		<input type="checkbox" name="ids" value="${GroupBean.id}" />
				      	</td>
						<td align="center">
							<bean:write name="GroupBean" property="name"/>
						</td>
						<td align="center" >
							<bean:write name="GroupBean" property="unit"/>
						</td>
						<td  align="center">
							<bean:write name="GroupBean" property="telPhone"/>
						</td>
						<td align="center" >
							<bean:write name="GroupBean" property="workContent"/>
						</td>
						<td align="center" >
							<a href="#">&nbsp;</a>
							<a href="javascript:insertRow('${GroupBean.id }', '${GroupBean.name}', '${GroupBean.unit }');" class="btnSelect" title="选择">选择</a>
						</td>
					</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:equal value="true" name="createGroupForm" property="recordNotFind">
			<tr>
				<td align="center" colspan="7">
					没有找到人员！
				</td>
			</tr>
			</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" rel="contactBox" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
	</div>
</div>	