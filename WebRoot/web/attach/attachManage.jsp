<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
	function copy_clip(txt) {
        if (window.clipboardData) {
                window.clipboardData.clearData();
                window.clipboardData.setData("Text", txt);
        } else if (navigator.userAgent.indexOf("Opera") != -1) {
                window.location = txt;
        } else if (window.netscape) {
          try {
                  netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
          } catch (e) {
                  alert("您的firefox安全限制限制您进行剪贴板操作，请在新窗口的地址栏里输入'about:config'然后找到'signed.applets.codebase_principal_support'设置为true'");
                  return false;
          }
          var clip = Components.classes["@mozilla.org/widget/clipboard;1"].createInstance(Components.interfaces.nsIClipboard);
          if (!clip)
                  return;
          var trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
          if (!trans)
                  return;
          trans.addDataFlavor('text/unicode');
          var str = new Object();
          var len = new Object();
          var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
          var copytext = txt;
          str.data = copytext;
          trans.setTransferData("text/unicode", str, copytext.length * 2);
          var clipid = Components.interfaces.nsIClipboard;
          if (!clip)
                  return false;
          clip.setData(trans, null, clipid.kGlobalClipboard);
        }
	}
</script>
<form id="pagerForm" method="post" action='<%=path%>/attachManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/attachManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					文件名：<input type="text" name="fileName" />
				</td>
				<td>
					上传者：<input type="text" name="uploadName"/>
				</td>
				<td>
					 创建时间从：
					 <input type="text" class="date" readonly="true" name="createBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly="true" name="createEndTime"/>
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
			<li><a class="add" href="<%=path %>/web/attach/uploadAttach.jsp" mask="true" target="dialog" rel="addXtfj" width="530" height="200" title="添加系统附件"><span>上传附件</span></a></li>
			<!-- 
			<li><a class="delete" rel="ids" href="<%=path %>/attachManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			 -->
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="40" align="center">编号</th>
				<th width="300" align="center">文件名</th>
				<th width="150" align="center">创建时间</th>
				<th width="100" align="center">上传者</th>
				<th align="center">文件路径</th>
				<th width="200" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="attachManageForm" property="recordNotFind">
   <logic:notEmpty name="attachManageForm" property="recordList">
     <logic:iterate name="attachManageForm" property="recordList" id="AttachBean">
     <tr target="attachid" rel="${AttachBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${AttachBean.id}" />
      	</td>
      	<td align="center">
			<bean:write name="AttachBean" property="serialNum"/>
		</td>
		<td align="center">
			<bean:write name="AttachBean" property="fileName"/>
		</td>
		<td align="center" >
			<bean:write name="AttachBean" property="createTime"/>
		</td>
		<td align="center" >
			<bean:write name="AttachBean" property="uploadName"/>
		</td>
		<td  align="center">
			<bean:write name="AttachBean" property="filePath"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a href="${AttachBean.filePath }">下载</a>
			<!-- 
			<a href = "#" onclick="copy_clip('${AttachBean.filePath}');alert('附件路径已经复制到剪切板！');">复制路径</a>
			 -->
			<a href="<%=path%>/attachManageAction.do?method=delete&id=${AttachBean.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="attachManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何附件
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
