<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<div class="pageContent" style="padding:5px">
	<div class="tabs">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:;"><span>字典列表</span></a></li>
				</ul>
			</div>
		</div>
		<div class="tabsContent">
			<div>
				<div layoutH="50" style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
				    <ul class="tree treeFolder">
						<li><a href="javascript">字典目录</a>
							<ul>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_SJZT" target="ajax" rel="jbsxDic">事件状态</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_JBFS" target="ajax" rel="jbsxDic">投诉方式</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_DCFS" target="ajax" rel="jbsxDic">调查方式</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_CLGZ" target="ajax" rel="jbsxDic">处理规则</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_GRCLZL" target="ajax" rel="jbsxDic">个人处理种类</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_DWCLZL" target="ajax" rel="jbsxDic">单位处理种类</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_BDXWZT" target="ajax" rel="jbsxDic">不端行为主体</a></li>
								<li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_QJYZCD" target="ajax" rel="jbsxDic">情节严重程度</a></li>
								<!-- move ZDBZ_CLJD to credit management as credit recover factor -->
								<!-- <li><a href="<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=select&id=ZDBZ_CLJD" target="ajax" rel="jbsxDic" >处理决定</a></li>	-->							
							</ul>
						</li>
				     </ul>
				</div>
				<div id="jbsxDic" class="unitBox" style="margin-left:246px;">
					<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxDic');" method="post" action='<%=request.getContextPath()%>/dicManageAction.do?method=queryMsg&operation=changePage'>
						<input type="hidden" name="pageNum" value="${pageNum}" />
						<input type="hidden" name="pageSize" value="${pageSize}" />
					</form>
					<div class="pageHeader" style="border:1px #B8D0D6 solid">
						<html:form onsubmit="return divSearch(this, 'jbsxDic');" action="/dicManageAction.do?method=queryMsg&operation=search" method="post">
						<div class="searchBar">
							<table class="searchContent">
							<tr>
								<td class="dateRange">
									代码标识:
									<input type="text" value="" name="codeName">
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
								<li><a class="add" href="<%=request.getContextPath()%>/web/dic/addDic.jsp" target="dialog" rel="addDic" width="470" height="300" title="添加字典"><span>添加</span></a></li>
								<li><a class="delete" rel="ids" href="<%=request.getContextPath()%>/dicManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>								
							</ul>
						</div>
						<table class="table" width="99%" layoutH="170" rel="jbsxDic">
							<thead>
								<tr>
									<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
									<th width="150" align="center">代码标识</th>
									<th width="100" align="center">代码编码</th>
									<th width="150" align="center">代码显示名称</th>
									<th align="center">说明</th>
									<th width="150" align="center">管理</th>
								</tr>
							</thead>
							<tbody>
								<logic:notEqual value="true" name="dicManageForm" property="recordNotFind">
   								<logic:notEmpty name="dicManageForm" property="recordList">
     							<logic:iterate name="dicManageForm" property="recordList" id="DicBean">
							      <tr target="dic_id" rel="${DicBean.id}">
							      	<td align="center">
							      		<input type="checkbox" name="ids" value="${DicBean.id}" />
							      	</td>
									<td align="center">
										<bean:write name="DicBean" property="codeName"/>
									</td>
									<td align="center" >
										<bean:write name="DicBean" property="code"/>
									</td>
									<td  align="center">
										<bean:write name="DicBean" property="caption"/>
									</td>
									<td align="center" >
										<bean:write name="DicBean" property="remark"/>
									</td>
									<td align="center" >
										<a href = "<%=request.getContextPath()%>/dicConfigAction.do?method=edit&id=${DicBean.id}" mask="true" target="dialog" rel="editDic" width="470" height="300">编辑</a>
										<a href = "<%=request.getContextPath()%>/dicManageAction.do?method=delete&id=${DicBean.id}"  target="ajaxTodo" title="确定要删除吗?">删除</a>
									</td>
								</tr>
								</logic:iterate>
								</logic:notEmpty>
								</logic:notEqual>
								<logic:equal value="true" name="dicManageForm" property="recordNotFind">
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
							<div class="pagination" rel="jbsxDic" totalCount="<%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
		</div>
	</div>
</div>