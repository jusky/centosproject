<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<form id="pagerForm" method="post" action='<%=path%>/keyManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
	<input type="hidden" name="orderField" value="${param.orderField}" />
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/keyManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					使用时间从：
					 <input type="text" class="date" readonly="true" name="keyBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly="true" name="keyEndTime"/>
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
			<li><a class="add" href="<%=path %>/keyManageAction.do?method=newKey" target="ajaxTodo" title="确定要生成新密钥文件吗?"><span>生成密钥</span></a></li>
			<li><a class="add" href="<%=path %>/web/key/importKey.jsp" mask="true" target="dialog" rel="importKey" width="530" height="200" title="导入密钥文件"><span>导入密钥</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" rel="ids" href="<%=path %>/keyManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="30" align="center">编号</th>
				<th width="150" align="center">文件名</th>
				<th width="120" align="center">起始时间</th>
				<th width="120" align="center">截止时间</th>
				<th align="center">密钥文件路径</th>
				<th width="80" align="center">是否启用</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="keyManageForm" property="recordNotFind">
   <logic:notEmpty name="keyManageForm" property="recordList">
     <logic:iterate name="keyManageForm" property="recordList" id="KeyBean">
     <tr target="keyid" rel="${KeyBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${KeyBean.id}" />
      	</td>
		<td align="center">
			<bean:write name="KeyBean" property="id"/>
		</td>
		<td  align="center">
			<bean:write name="KeyBean" property="keyName"/>
		</td>
		<td  align="center">
			<bean:write name="KeyBean" property="startTime"/>
		</td>
		<td align="center" >
			<bean:write name="KeyBean" property="endTime"/>
		</td>
		<td align="center" >
			<bean:write name="KeyBean" property="path"/>
		</td>
		<td align="center" >
			<logic:equal value="0" name="KeyBean" property="isUse">未启用</logic:equal>
			<logic:equal value="1" name="KeyBean" property="isUse">启用</logic:equal>
		</td>
		<td  align="center" >
			<a href="#">&nbsp;</a>
			<logic:equal value="0" name="KeyBean" property="isUse">
				<a href="<%=path%>/keyManageAction.do?method=enableKey&id=${KeyBean.id}&path=${KeyBean.localPath }" target="ajaxTodo" title="确定要启用该密钥吗?请妥善保管历史密钥，启用成功后，已经录入的事件信息只能由原密钥进行解密！！">启用</a>
			</logic:equal>
			<a href="${KeyBean.path }">下载</a>
			<a href="<%=path%>/keyManageAction.do?method=delete&id=${KeyBean.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="keyManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何密钥信息
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
