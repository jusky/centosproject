<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>
<script type="text/javascript">

</script>
<h2 class="contentTitle">单位调查，共有<font color="red"><%=request.getAttribute("totalRows") %></font>个案件</h2>
<div class="pageContent">
<div class="pageFormContent"  layoutH="56">
<logic:notEqual value="true" name="deptFKManageForm" property="recordNotFind">
 <logic:notEmpty name="deptFKManageForm" property="recordList">
  <logic:iterate name="deptFKManageForm" property="recordList" id="DeptDCBean">
	<div class="panel">
		<h1>案件<bean:write name="DeptDCBean" property="serialNum"/>
			<logic:equal value="1" name="DeptDCBean" property="isSubmit"><font color="blue">已提交</font></logic:equal>
			<logic:equal value="0" name="DeptDCBean" property="isSubmit"><font color="blue">未提交</font></logic:equal>
		</h1>
		<div>
			<dl class="nowrap">
				<dt>标题：</dt>
				<dd>
					${DeptDCBean.title }
				</dd>
			</dl>
			<div class="divider">divider</div>
			<dl class="nowrap">
				<dt>问题简述：</dt>
				<dd>
					${DeptDCBean.shortInfo }
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>反馈日期：</dt>
				<dd>
					${DeptDCBean.fkTime }
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>调查内容：</dt>
				<dd>
					<textarea name="surveyContnet" cols="90" rows="10" readonly>${DeptDCBean.surveyContent }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>调查函：</dt>
				<dd>
					<logic:notEqual value="" name="DeptDCBean" property="filePath">
						<a href="${DeptDCBean.filePath }" title="下载调查函">下载调查函</a>
					</logic:notEqual>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>其他附件：</dt>
				<dd>
					
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>操作：</dt>
				<dd>
				<logic:equal value="" name="DeptDCBean" property="status"><font color="blue">该案件的调查已经完成，不能在线提交！</font></logic:equal>
				<logic:notEqual value="" name="DeptDCBean" property="status">
					<logic:equal value="1" name="DeptDCBean" property="isSubmit">						
						<a href="<%=path%>/deptFKManageAction.do?method=onlineSubmit&id=${DeptDCBean.id }&reportID=${DeptDCBean.reportID }&adviceID=${DeptDCBean.adviceID }" target="navTab" rel="onlineSubmit"><font color="red">查看已提交调查结果</font></a>
					</logic:equal>
					<logic:equal value="0" name="DeptDCBean" property="isSubmit">
						<a href="<%=path%>/deptFKManageAction.do?method=onlineSubmit&id=${DeptDCBean.id }&reportID=${DeptDCBean.reportID }&adviceID=${DeptDCBean.adviceID }" target="navTab" rel="onlineSubmit"><font color="red">在线提交调查结果</font></a>		
					</logic:equal>
				</logic:notEqual>
				</dd>
			</dl>
		</div>
	</div>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="deptFKManageForm" property="recordNotFind">
	</logic:equal>
</div>
</div>