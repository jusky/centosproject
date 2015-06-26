<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<form id="pagerForm" method="post" action='<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=jbsy'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=jbsy" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>投诉对象:</label>
				<select class="combox" name="jbObject">
						<option value="">--请选择--</option>
						<option value="38">申请者</option>
						<option value="39">承担者</option>
						<option value="40">评议、评审者</option>
						<option value="41">依托单位</option>
				</select>
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="jbrId" warn="请选择举报事由">选择</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th align="center" width="40"><input type="checkbox" class="checkboxCtrl" group="jbrId"/></th>
				<th align="center" width="100">编号</th>
				<th align="center">举报事由</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="JBReasonBean">
      					<tr>
      						<td align="center">
      							<input type="checkbox" name="jbrId" value="{reasonID:'${JBReasonBean.reasonID}', jbReason:'${JBReasonBean.jbReason}'}"/>
      						</td>
      						<td align="center">
								<bean:write name="JBReasonBean" property="reasonID"/>
							</td>
      						<td align="center">
								<bean:write name="JBReasonBean" property="jbReason"/>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
	<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有查询到任何举报事由！
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页10  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="10" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>