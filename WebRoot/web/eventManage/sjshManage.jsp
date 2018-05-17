<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script src="<%=path%>/js/moreops.js" type="text/javascript"></script>
<script type="text/javascript">
var boxID = "sjsh_box";
function showSjshDiv(aID)
 {
 document.getElementById("sjshReportID").value = aID;
 	  var opsID = "more" + aID;
 	  var opsObject = document.getElementById(opsID);
 	  var r = getAbsolutePos(opsObject);
 	  var newDiv = document.getElementById("sjsh_box"); 
	  //让新层的zIndex属性要足够大，才会在最上面显示  	  
	  //newDiv.style.zIndex = "9999";  
	  newDiv.style.top= r.y - 65 + "px";  
	 // newDiv.style.left= r.x - 400 + "px";
	  newDiv.style.display="block";
 } 
	 document.getElementById("sjsh_box").onclick = function(e){
	     e = e || window.event;
	     if(window.event){    //阻止事件冒泡
	         e.cancelBubble = true;
	     } else {
	         e.stopPropagation();
	     }
	 }
function setAnonymity(cb)
{
	var id="informer5";
	if(cb.checked==true)
	{	
		document.getElementById(id).value="";
		document.getElementById(id).disabled=true;
	}
	else
	{
		document.getElementById(id).value="";
		document.getElementById(id).disabled=false;
	}
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/eventManageAction.do?method=queryMsg&operation=changePage&jdid=4'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
	<input type="hidden" name="orderField" value="${param.orderField}" />
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />
</form>
<div id="sjsh_box" class="ops_box ops_itemDiv">
	<ul style="width:255px;">
		<!-- <li class="ops_li">
			<a class="link edit ops_more" href="<%=path%>/approveEventAction.do?method=dispatch&id={eventid}" mask="true" target="dialog" rel="dispatchAgent" width="550" height="450" title="授权审核">授权审核</a>
		</li> -->
		<li class="ops_li">
			<a class="link edit ops_more" href="<%=path%>/approveEventAction.do?method=survey&reportID={eventid}" target="ajaxTodo"  title="确定对该案件进行调查吗？">调查</a>
		</li>
		<li class="ops_li">
			<a class="link edit ops_more" href="<%=path%>/approveEventAction.do?method=unsurvey&reportID={eventid}" target="ajaxTodo"  title="确定不对该案件进行调查吗？">不调查</a>
		</li>
		<li class="ops_li">
			<a class="link edit ops_more" href="<%=path%>/eventManageAction.do?method=revocation&id={eventid}" target="ajaxTodo"  title="确定对该案件进行撤回吗？">撤回</a>
		</li>
		<li class="ops_li">
			<a class="link edit ops_more" href="<%=path%>/approveEventAction.do?method=rollOut&reportID={eventid}" target="ajaxTodo"  title="确定转出该案件吗？">转出</a>
		</li>
	</ul>
</div>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/eventManageAction.do?method=queryMsg&operation=search&jdid=4" method="post">
	<input type="hidden" id="sjshReportID" value=""/>
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					编号：<input type="text" name="serialNum"/>
				</td>
				<td>
					举报人：<input type="text" name="reportName" id="informer5"/>
					<input type="checkbox" name="isNi" value="匿名举报" onclick="setAnonymity(this)"/>匿名
				</td>
				<td>
					被举报人：<input type="text" name="beReportName"/>
				</td>
				<td>
					 举报时间：
					 <input type="text" class="date" readonly name="jbBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="jbEndTime"/>
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
			<!-- 
			<li><a class="delete" rel="ids" href="<%=path %>/eventManageAction.do?method=delete&type=noreal" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			 -->
			<li><a class="icon" href="<%=path%>/eventManageAction.do?method=export&id=4" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center">编号</th>
				<th width="100" align="center">状态</th>
				<th width="100" align="center">举报人姓名</th>
				<th width="100" align="center">被举报人姓名</th>
				<th align="center">举报事由</th>
				<th width="130" align="center" orderField="a.REPORTTIME" <%if (request.getParameter("orderField")!=null && request.getParameter("orderField").equals("a.REPORTTIME")) { %> class="${param.orderDirection}" <%} %>>举报时间</th>
				<th width="100" align="center" orderField="a.OFFICER" <%if (request.getParameter("orderField")!=null && request.getParameter("orderField").equals("a.OFFICER")) { %> class="${param.orderDirection}" <%} %>>查办人员</th>			
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
   <logic:notEmpty name="eventManageForm" property="recordList">
     <logic:iterate name="eventManageForm" property="recordList" id="EventBean">
      <tr target="eventid" rel="${EventBean.reportID}">
      <td align="center">
      	<input type="checkbox" name="ids" value="${EventBean.reportID}" />
      </td>
      <td align="center" >
			<bean:write name="EventBean" property="serialNum"/>
		</td>
      	<td align="center" >
			<bean:write name="EventBean" property="status"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="reportName"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="beReportName"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="reportReason"/>
		</td>
		<td  align="center">
			<bean:write name="EventBean" property="reportTime"/>
		</td>
		<td align="center">
		<bean:write name="EventBean" property="officer"/>
		<!--<logic:equal name="RoleIDs" value="3" scope="session">
				&nbsp;&nbsp;
				<a class="btnEdit" href='<%=path%>/dispatchEventAction.do?method=init&reportID=${EventBean.reportID}' clss="link edit" mask="true" target="dialog" rel="dispatchEvent" width="550" height="450" title="指派查办人员">重新指派</a>
		</logic:equal>-->
		</td>
		<td align="center">
			<a href="<%=path%>/eventManageAction.do?method=detail&id=${EventBean.reportID}" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看</a>
			<logic:equal name="RoleIDs" value="1"  scope="session">
				<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核">审核</a>
			</logic:equal>
			<logic:equal name="RoleIDs" value="3"  scope="session">
				<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核">审核</a>
			</logic:equal>
			<logic:equal name="RoleIDs" value="9"  scope="session">
				<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核">审核</a>
			</logic:equal>
			<logic:equal name="RoleIDs" value="8"  scope="session">
				<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=finalApprove&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="主任审核">主任审核</a>
			</logic:equal>
			<logic:notEqual name="RoleIDs" value="2"  scope="session">
				<a id="more${EventBean.reportID}" style="cursor: pointer;text-decoration: underline;" href="javascript:showSjshDiv('${EventBean.reportID}');" title="更多操作">更多操作</a>
			</logic:notEqual>
			<!-- <a href="<%=path%>/eventManageAction.do?method=detail&id=${EventBean.reportID}" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看</a>
			<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核">审核</a>
			<logic:equal name="IsHead" value="1" scope="session">
			<a href="<%=path%>/approveEventAction.do?method=dispatch&id=${EventBean.reportID}" clss="link edit" mask="true" target="dialog" rel="dispatchAgent" width="550" height="450" title="代理审批人员">代理审核</a>
			<bean:write name="EventBean" property="agentOfficer"/>
			<a href="<%=path%>/approveEventAction.do?method=survey&reportID=${EventBean.reportID}" target="ajaxTodo"  title="确定调查该举报案件吗？">调查</a>
			<a href="<%=path%>/approveEventAction.do?method=unsurvey&reportID=${EventBean.reportID}" target="ajaxTodo"  title="确定不调查该举报案件吗？">不调查</a>
			</logic:equal>
			<logic:equal name="IsHead" value="0" scope="session">
			<logic:equal value="已审核" name="EventBean" property="status">
				<a href="<%=path%>/approveEventAction.do?method=survey&reportID=${EventBean.reportID}" target="ajaxTodo"  title="确定调查该举报案件吗？">调查</a>
				<a href="<%=path%>/approveEventAction.do?method=unsurvey&reportID=${EventBean.reportID}" target="ajaxTodo"  title="确定不调查该举报案件吗？">不调查</a>
			</logic:equal>-->
			<!--<logic:equal value="已初步核实" name="EventBean" property="status">
			<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${EventBean.reportID}" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核">审核</a>
			</logic:equal>
			</logic:equal>-->
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="eventManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何需要审核的事件
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
