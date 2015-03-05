<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<style type="text/css">
	ul.rightTools {float:right; display:block;}
	ul.rightTools li{float:left; display:block; margin-left:5px}
</style>
<div class="pageContent" style="padding:5px">
<div class="tabs">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:;"><span>邮箱</span></a></li>
				</ul>
			</div>
		</div>
		<html:form onsubmit="return navTabSearch(this);" action="/mailListAction.do?method=queryMsg&operation=search" method="post">
		<div class="tabsContent">
			<div>
				<div layoutH="50" style="float:left; display:block; overflow:auto; width:240px; border:solid 1px #CCC; line-height:21px; background:#fff">
				    <ul class="tree treeFolder">
				    <logic:notEqual value="true" name="mailManageForm" property="recordNotFind">
   						<logic:notEmpty name="mailManageForm" property="recordList">
     					<logic:iterate name="mailManageForm" property="recordList" id="EmailBean">
						<li><a href="javascript"><bean:write name="EmailBean" property="accountName"/></a>
							<ul>
								<li><a href="<%=request.getContextPath()%>/mailManageAction.do?method=recvMail&id=${EmailBean.ID}" target="ajax" rel="jbsxBox">收件箱(0)</a></li>
								<li><a href="<%=request.getContextPath()%>/web/gangwei/gwList.jsp" target="ajax" rel="jbsxBox">发件箱(0)</a></li>
								<li><a href="<%=request.getContextPath()%>/web/gangwei/gwList.jsp" target="ajax" rel="jbsxBox">草稿箱(0)</a></li>
								<li><a href="<%=request.getContextPath()%>/web/gangwei/gwList.jsp" target="ajax" rel="jbsxBox">垃圾箱(0)</a></li>
							</ul>
						</li>
						</logic:iterate>
						</logic:notEmpty>
					</logic:notEqual>
				     </ul>
				</div>
				
				<div id="jbsxBox" class="unitBox" style="margin-left:246px;">
					
				</div>
			</div>
			</div>
			</html:form>
			<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
			</div>
	</div>
</div>

