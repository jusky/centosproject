<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 


<div class="pageHeader">	
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="icon" href="<%=path%>/miscountManageAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>		
				<th width="100" align="center">记录编号</th>
				<th width="100" align="center">标题</th>
				<th width="200" align="center">当事人</th>
				<th width="100" align="center">当事单位</th>
				<th width="150" align="center">不端类型</th>	
				<th width="150" align="center">处罚措施</th>		
				<th width="100" align="center">生效时间</th>	
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="miscountManageForm" property="recordNotFind">
   <logic:notEmpty name="miscountManageForm" property="recordList">
     <logic:iterate name="miscountManageForm" property="recordList" id="MiscountInfo">
      <tr target="slt_uid" rel="${MiscountInfo.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${MiscountInfo.id}" />
      	</td>      
      		
      	<td align="center">
			<bean:write name="MiscountInfo" property="miscountId"/>
		</td>
		<td align="center">
			<bean:write name="MiscountInfo" property="title"/>
		</td>
		<td align="center" >
			<bean:write name="MiscountInfo" property="individual"/>
		</td>
		<td>
			<bean:write name="MiscountInfo" property="institute"/>
		</td>
		<td align="center">
			<bean:write name="MiscountInfo" property="mistype"/>
		</td>
		<td  align="center">
			<bean:write name="MiscountInfo" property="punish"/>
		</td>
		<td align="center">
			<bean:write name="MiscountInfo" property="time" />
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href = "<%=path%>/miscountManageAction.do?method=detail&uid=${MiscountInfo.id}" target="dialog" mask="true" rel="miscountDetail" width="750" height="550" title="不端行为详细信息">查看</a>
		<a href = "<%=path%>/configMiscountAction.do?method=edit&uid=${MiscountInfo.id}" target="dialog" mask="true" rel="editMiscount" width="750" height="400" title="编辑不端行为信息">编辑</a>
		<a href = "<%=path%>/miscountManageAction.do?method=delete&uid=${MiscountInfo.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="miscountManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何不端行为信息
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
