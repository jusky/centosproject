<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
function editSurveyReport(filePath)
{
	var url = "<%=path%>/dcbgManageAction.do?method=editCombineReport&path=" + filePath;
	openMaxWin(url);
}
function selectID(comid)
{
	var temp = "id" + comid;
	var selectItem = document.getElementById(temp).value;
	var obj = document.getElementById("selectReportHref");
	obj.href="<%=path%>/eventManageAction.do?method=detail&id=" + selectItem;
	obj.click();
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/dcbgManageAction.do?method=showCombine&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageContent">
	<div class="panelBar">
			<ul class="toolBar">
				
			</ul>
	</div>
	<table class="table" layoutH="80" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th width="40" align="center" ><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="150" align="center" >事件编号</th>
				<th align="center">文件路径</th>
				<th width="100" align="center">创建时间</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="dcbgManageForm" property="recordNotFind">
   				<logic:notEmpty name="dcbgManageForm" property="recordList">
     				<logic:iterate name="dcbgManageForm" property="recordList" id="CombineReport">
      					<tr target="sid" rel="${CombineReport.id}">
					      	<td align="center">
					      		<input type="checkbox" name="ids" value="${CombineReport.id}" />
					      	</td>
      						<td align="center">
      							<select class="combox" id="id${CombineReport.id}" name="reportList" onchange="selectID('${CombineReport.id}');">
      							<logic:iterate id="EventBean" name="CombineReport" property="reportIDList">
      								<option value="${EventBean.reportID}">      									
      									<bean:write name="EventBean" property="reportID"/>
      								</option>
      							</logic:iterate>
      							</select>
      							<a id="selectReportHref" href="" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情"></a>
							</td>
							<td align="center">
								<bean:write name="CombineReport" property="filePath"/>
							</td>
							<td align="center">
								<bean:write name="CombineReport" property="createTime"/>
							</td>
							<td align="center">
								<a href="javascript:editSurveyReport('${CombineReport.fileName}');">编辑</a>
								<a href="${CombineReport.filePath}">下载</a>
								<a href="<%=path%>/dcbgManageAction.do?method=deleteCombine&id=${CombineReport.id}&name=${CombineReport.fileName }" target="ajaxTodo" title="确定要删除吗?">删除</a>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
		<logic:equal value="true" name="dcbgManageForm" property="recordNotFind">
		<tr>
			<td align="center" colspan="5">
				没有查询到任何合并的调查报告
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