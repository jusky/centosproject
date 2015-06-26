<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<form id="pagerForm" method="post" action='<%=path%>/expertManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/expertManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					专家姓名：<input type="text" name="expertName"/>
				</td>
				<td>
					所在单位：<input type="text" name="dept"/>
				</td>
				<td>
					所属学部：<input type="text" name="faculty"/>
				</td>
				<td>
					研究方向：<input type="text" name="research"/>
				</td>
				<!-- 
				<td>
					创建时间：
					 <input type="text" class="date" readonly name="createBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="createEndTime"/>
				</td>
				 -->
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
			<li><a class="add" href="<%=path%>/web/expert/addExpert.jsp" mask="true" target="dialog" rel="addExpert" width="750" height="550" title="添加专家信息"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/expertManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=path%>/expertManageAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="30" align="center">序号</th>
				<th width="100" align="center">专家姓名</th>
				<th width="70" align="center">职称</th>
				<th  align="center">单位</th>
				<th width="100" align="center">专业</th>
				<th width="120" align="center">研究方向</th>
				<th width="100" align="center">联系方式</th>
				<th width="100" align="center">所属学部</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="expertManageForm" property="recordNotFind">
   <logic:notEmpty name="expertManageForm" property="recordList">
     <logic:iterate name="expertManageForm" property="recordList" id="ExpertInfo">
      <tr target="slt_uid" rel="${ExpertInfo.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${ExpertInfo.id}" />
      	</td>
      	<td align="center">
			<bean:write name="ExpertInfo" property="serialNum"/>
		</td>
		<td align="center">
			<bean:write name="ExpertInfo" property="name"/>
		</td>
		<td align="center" >
			<bean:write name="ExpertInfo" property="title"/>
		</td>
		<td align="center" >
			<bean:write name="ExpertInfo" property="dept"/>
		</td>
		<td  align="center">
			<bean:write name="ExpertInfo" property="specialty"/>
		</td>
		<td align="center" >
			<bean:write name="ExpertInfo" property="research"/>
		</td>
		<td align="center" >
			<bean:write name="ExpertInfo" property="phone"/>
		</td>
		<td align="center" >
			<bean:write name="ExpertInfo" property="faculty"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href = "<%=path%>/expertManageAction.do?method=detail&uid=${ExpertInfo.id}" class="btnLook" target="dialog" mask="true" rel="detail" width="750" height="550" title="查看专家详情">查看</a>
		<a href = "<%=path%>/configExpertAction.do?method=edit&uid=${ExpertInfo.id}" class="btnInfo" target="dialog" mask="true" rel="editExpert" width="750" height="550" title="编辑专家信息">编辑</a>
		<a href = "<%=path%>/expertManageAction.do?method=delete&uid=${ExpertInfo.id}" class="btnDel"  target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="expertManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何专家信息
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
