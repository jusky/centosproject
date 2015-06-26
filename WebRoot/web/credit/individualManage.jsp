<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<% 
	String path = request.getContextPath();	
	String basePath = request.getScheme() + "://"
						+ request.getServerName() + ":" + request.getServerPort() 
						+ path + "/";
%>
<script type="text/javascript">
function changeExportNum() {
	var total=document.getElementById("indicount").totalCount;
	var num=document.getElementById("indiexportnum").value;
	var exportattr=document.getElementById("indidwzExport").href;
   if(/^\d*$/.test(num) && num > 0){
		var index = exportattr.indexOf("&exportnum=");
		exportattr = exportattr.slice(0, index).concat("&exportnum=", num);
   	document.getElementById("indidwzExport").href = exportattr ;
   } else {
   	alert("请输入正整数");
   	document.getElementById("indiexportnum").value = total;
   }
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/individualManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/individualManageAction.do?method=queryMsg&operation=search" method="post">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>姓名：<input type="text" name="name" maxlength="20"/></td>
					<td>所在单位：<input type="text" name="institute" maxlength="50"/></td>
					<td>身份证：<input type="text" name="pid" maxlength="16"/></td>
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
			<li><a class="add" href="<%=path%>/web/credit/addIndividual.jsp" mask="true" target="dialog" rel="addIndividual" width="750" height="500" title="添加科研人员信息"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path%>/individualManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=path%>/individualManageAction.do?method=export&exportnum=<%=request.getAttribute("totalRows")%>" id="indidwzExport" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
			<li><input id="indiexportnum" type="text" class="number" size="4" onchange="changeExportNum();" value="<%=request.getAttribute("totalRows")%>"/></li><span >条</span>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="100" align="center">姓名</th>
				<th width="200" align="center">身份证</th>
				<th width="150" align="center">所在单位</th>
				<th width="100" align="center">是否专家</th>
				<th width="100" align="center">诚信值</th>
				<th width="150" align="center">联系方式</th>
				<th width="150" align="center">通讯地址</th>
				<th width="200" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
			<logic:notEqual value="true" name="individualManageForm" property="recordNotFind">
				<logic:notEmpty name="individualManageForm" property="recordList">
				  <logic:iterate name="individualManageForm" property="recordList" id="IndividualInfo">
					<tr target="slt_uid" rel="${IndividualInfo.id }">
						<td align="center">
							<input type="checkbox" name="ids" value="${IndividualInfo.id}" />
						</td>
						<td align="center"><bean:write name="IndividualInfo" property="name"/></td>
						<td align="center"><bean:write name="IndividualInfo" property="pid" /></td>
						<td align="center"><bean:write name="IndividualInfo" property="institute"/></td>
						<td align="center">
						<logic:equal name="IndividualInfo" property="isExpert" value="1">是</logic:equal>
						<logic:equal name="IndividualInfo" property="isExpert" value="0">否</logic:equal>
						</td>
						<td align="center"><bean:write  name="IndividualInfo" property="credit"/></td>
						<td align="center"><bean:write name="IndividualInfo" property="phone"/></td>
						<td align="center"><bean:write name="IndividualInfo" property="address"/></td>
						<td align="center">
							<a href="<%=path%>/configIndividualAction.do?method=edit&uid=${IndividualInfo.id}" target="dialog" mask="true" rel="editIndividual" width="750" height="550" title="编辑科研人员信息">编辑</a>							
							<a href="<%=path%>/miscountManageAction.do?method=queryMsg&operation=search&pid=${IndividualInfo.pid}" target="dialog" mask="true" rel="creditDetail" width="900" height="600" title="查看详细信息">查看不端记录</a>
							<a href="<%=path%>/individualManageAction.do?method=delete&uid=${IndividualInfo.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
						</td>
					</tr>
				  </logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:equal value="true" name="individualManageForm" property="recordNotFind">
				<tr>
					<td align="center" colspan="7">
						没有查询到任何科研人员信息
					</td>
				</tr>
			</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
		</div>
		<div class="pagination" target="navTab" id="indicount" totalCount="<%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum")%>"></div>
	</div>
</div>