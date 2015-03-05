<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxBox');" action="<%=request.getContextPath()%>/mailManageAction.do?method=queryMsg&operation=changePage" method="post">
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
	
<div class="pageHeader" style="border:1px #B8D0D6 solid">
	<html:form onsubmit="return divSearch(this, 'jbsxBox');" action="/mailManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td class="dateRange">
					主题:
					<input type="text" value="" name="title">
				</td>
				<td class="dateRange">
					日期从:
					<input type="text" class="date" readonly="true" name="recvBeginTime"/>
					至：
					<input type="text" class="date" readonly="true" name="recvEndTime"/>
				</td>
				<td class="dateRange">
					<select class="combox" name="isRead">
						<option value="">--是否已读--</option>
						<option value="all">全部</option>
						<option value="yes">是</option>
						<option value="no">否</option>
					</select>
				</td>
				<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
			</tr>
		</table>
	</div>
	</html:form>
</div>

<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="<%=request.getContextPath()%>/mailManageAction.do?method=syncMail" target="ajax" rel="jbsxBox"><span>同步邮件</span></a></li>
			<li><a class="delete" href="demo/pagination/ajaxDone3.html?uid={sid_obj}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
			<li><a class="edit" href="demo/pagination/dialog2.html?uid={sid_obj}" target="dialog" mask="true"><span>修改</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="99%" layoutH="170" rel="jbsxBox">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th align="center"  width="220">发件人</th>
				<th align="center" width="120">主题</th>
				<th align="center">接收日期</th>
				<th align="center" width="120">是否已读</th>
				<th align="center" width="100">管理</th>
			</tr>
		</thead>
		<tbody>
			<logic:notEqual value="true" name="mailManageForm" property="recordNotFind">
   				<logic:notEmpty name="mailManageForm" property="recordList">
     				<logic:iterate name="mailManageForm" property="recordList" id="RecvMailInfo">
      					<tr target="recv_uid" rel="${RecvMailInfo.id}">
      						<td align="center">
      							<input type="checkbox" name="ids" value="${RecvMailInfo.id}" />
      						</td>
      						<td align="center">
								<bean:write name="RecvMailInfo" property="sendName"/>
							</td>
							<td align="center">
								<bean:write name="RecvMailInfo" property="title"/>
							</td>
							<td align="center" >
								<bean:write name="RecvMailInfo" property="recvTime"/>
							</td>
							<td  align="center">
								<logic:equal value="1" name="RecvMailInfo" property="isRead">已读</logic:equal>
								<logic:equal value="0" name="RecvMailInfo" property="isRead">未读</logic:equal>
							</td>
							<td  align="center" >
								<a href = "<%=request.getContextPath()%>/mailListAction.do?method=delete&id={mail_uid}" target="ajaxTodo" title="确定要删除吗?">删除</a>
								<a href = "<%=request.getContextPath()%>/mailConfigAction.do?method=edit&id={mail_uid}" target="dialog" rel="editMail" width="645" height="370">编辑</a>
								<a href = "<%=request.getContextPath()%>/mailConfigAction.do?method=detail&id={mail_uid}" target="dialog" rel="editMail" width="645" height="370">明细</a>
								<a href = "<%=request.getContextPath()%>/mailListAction.do?method=test&id={mail_uid}" target="dialog" rel="test" onclick="alertMsg.info('正在测试连接，请耐心等待...')" width="513" height="150">测试</a>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:equal value="true" name="mailManageForm" property="recordNotFind">
			<tr>
				<td align="center" colspan="5">
					没有接收到任何邮件，请选择“同步邮件”
				</td>
			</tr>
			</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" rel="jbsxBox" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
	</div>
</div>
