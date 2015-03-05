<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<div class="pageContent">
	<div class="tabs" currentIndex="0" eventType="click">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:;"><span>组织简介</span></a></li>
					<li><a href="<%=path %>/zzDetailAction.do?method=zzuser" class="j-ajax" rel="zzUserInfo"><span>组织人员</span></a></li>
				</ul>
			</div>
		</div>
		<div class="tabsContent">
			<div>
			<div class="pageFormContent" layoutH="75">
			<logic:notEqual value="true" name="zzDetailForm" property="recordNotFind">
				<logic:notEmpty name="zzDetailForm" property="recordList">
				   	<logic:iterate name="zzDetailForm" property="recordList" id="ZZBean">
						<dl class="nowrap">
							<dt>组织编号：</dt>
							<dd><input name="zzID" type="text" size="60" value='${ZZBean.zzID}'/></dd>
						</dl>
						<dl class="nowrap">
							<dt>组织名称：</dt>
							<dd><input name="zzName" type="text" size="60" value='${ZZBean.zzName}'/></dd>
						</dl>
						<dl class="nowrap">
							<dt>组织简介：</dt>
							<dd><textarea name="zzDescribe" rows="3" cols="60">${ZZBean.zzDescribe }</textarea></dd>
						</dl>
						<dl class="nowrap">
							<dt>上级组织：</dt>
							<dd><input name="pzzID" type="text" size="60" value='${ZZBean.pzzName}'/></dd>
						</dl>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:notEqual value="false" name="zzDetailForm" property="recordNotFind">
				没有查询到详情，系统出现错误！
			</logic:notEqual>
			</div>
			</div>
			<div id="zzUserDiv">
			
			</div>
		</div>

		<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
		</div>
	</div>
</div>
