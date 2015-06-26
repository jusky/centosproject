<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script src="<%=path%>/js/moreops.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
<script type="text/javascript">
function editSurveyReport(id)
{
	var url = "<%=path%>/dcbgManageAction.do?method=edit&id=" + id;
	openMaxWin(url);
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/dcbgManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/dcbgManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					编号：<input type="text" name="serialNum"/>
				</td>
				<td>
					举报人：<input type="text" name="reportName"/>
				</td>
				<td>
					被举报人：<input type="text" name="beReportName"/>
				</td>
				<td>
					 生成时间：
					 <input type="text" class="date" readonly name="createBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="createEndTime"/>
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
			<li><a class="add selectedTodoDw" rel="ids" href="<%=path %>/dcbgManageAction.do?method=combine" postType="string" target="_blank" title="确定要合并这些调查报告吗？"><span>合并调查报告</span></a></li>
			<li><a class="add" href="<%=path %>/dcbgManageAction.do?method=showCombine" mask="true" rel="combineReport" target="navTab" width="900" height="500" title="查看已合并调查报告"><span>已合并调查报告</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center">事件编号</th>
				<th width="100" align="center">举报人</th>
				<th width="200" align="center">被举报人</th>
				<th width="130" align="center">更新时间</th>
				<th align="center">调查报告路径</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="dcbgManageForm" property="recordNotFind">
   <logic:notEmpty name="dcbgManageForm" property="recordList">
     <logic:iterate name="dcbgManageForm" property="recordList" id="SurveyReportBean">
      <tr target="id" rel="${SurveyReportBean.reportID}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${SurveyReportBean.reportID}" />
      	</td>
      	<td align="center" >
			<bean:write name="SurveyReportBean" property="serialNum"/>
		</td>
      	<td align="center" >
			<bean:write name="SurveyReportBean" property="reportName"/>
		</td>
		<td align="center" >
			<bean:write name="SurveyReportBean" property="beReportName"/>
		</td>
		<td align="center" >
			<bean:write name="SurveyReportBean" property="createTime"/>
		</td>
		<td align="center" >
			<bean:write name="SurveyReportBean" property="filePath"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a href="javascript:editSurveyReport('${SurveyReportBean.reportID}');">编辑调查报告</a>
			<a href="${SurveyReportBean.filePath}">下载</a>
			<!-- 
			<a href = "<%=path%>/dcbgManageAction.do?method=delete&id={decideid}" target="ajaxTodo" title="确定要删除该处理决定吗?注意：删除后将无法恢复！">删除</a>
			 -->
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="dcbgManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何调查报告
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
