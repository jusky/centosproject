<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
</script>
<form id="pagerForm" method="post" action='<%=path%>/punishManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}"/>
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this)" action="/punishManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>名称：<input type="text" name="caption"/>
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
			<li><a class="add" href="<%=path%>/web/credit/addPunish.jsp" mask="true" target="dialog" rel="addPunish" width="550" height="400" title="添加处理决定信息"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/punishManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			<li class="line">line</li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="150" align="center">代码标识</th>
				<th width="100" align="center">代码编码</th>
				<th width="100" align="center">恢复时间/年</th>
				<th width="100" align="center">恢复上限*100%</th>
				<th width="150" align="center">代码显示名称</th>
				<th align="center">说明</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
				<logic:notEqual value="true" name="punishManageForm" property="recordNotFind">
   						<logic:notEmpty name="punishManageForm" property="recordList">
     							<logic:iterate name="punishManageForm" property="recordList" id="PunishBean">
							      <tr target="punish_id" rel="${PunishBean.id}">
							      	<td align="center">
							      		<input type="checkbox" name="ids" value="${PunishBean.id}" />
							      	</td>
									<td align="center">
										<bean:write name="PunishBean" property="codename"/>
									</td>
									<td align="center" >
										<bean:write name="PunishBean" property="code"/>
									</td>
									<td align="center" >
										<bean:write name="PunishBean" property="year"/>
									</td>
									<td align="center">
										<bean:write name="PunishBean" property="rate"/>
									</td>
									<td  align="center">
										<bean:write name="PunishBean" property="caption"/>
									</td>
									<td align="center" >
										<bean:write name="PunishBean" property="remark"/>
									</td>
									<td align="center" >
										<a href = "<%=request.getContextPath()%>/configPunishAction.do?method=edit&uid=${PunishBean.id}" mask="true" target="dialog" rel="editPunish" width="550" height="400">编辑</a>
										<a href = "<%=request.getContextPath()%>/punishManageAction.do?method=delete&uid=${PunishBean.id}"  target="ajaxTodo" title="确定要删除吗?">删除</a>
									</td>
								</tr>
								</logic:iterate>
								</logic:notEmpty>
								</logic:notEqual>
								<logic:equal value="true" name="punishManageForm" property="recordNotFind">
								<tr>
									<td align="center" colspan="7">
										没有配置任何字典信息
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
