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
function showattach(filename,reportID)
{
	var temp = filename.split("/");
	var test = temp[temp.length-1];
	alert(test);
	var url = "<%=path%>/web/dsoframer/showAttachDoc.jsp?filename=" + test + "&reportID=" + reportID;
	openMaxWin(url);
}

</script>
<h2 class="contentTitle">专家鉴定，共有<font color="red"><%=request.getAttribute("totalRows") %></font>个案件</h2>
<div class="pageContent">
<div class="pageFormContent"  layoutH="56">
<logic:notEqual value="true" name="expertFKForm" property="recordNotFind">
 <logic:notEmpty name="expertFKForm" property="recordList">
  <logic:iterate name="expertFKForm" property="recordList" id="ExpertIdentityBean">
	<div class="panel">
		<h1>案件<bean:write name="ExpertIdentityBean" property="serialNum"/>
			<logic:equal value="1" name="ExpertIdentityBean" property="isSubmit"><font color="blue">已提交</font></logic:equal>
			<logic:equal value="0" name="ExpertIdentityBean" property="isSubmit"><font color="blue">未提交</font></logic:equal>
		</h1>
		<div>
			<dl class="nowrap">
				<dt>鉴定函标题：</dt>
				<dd>
					${ExpertIdentityBean.eventTitle }
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>案由：</dt>
				<dd>
					${ExpertIdentityBean.eventReason }
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>鉴定内容及目的：</dt>
				<dd>
					${ExpertIdentityBean.jdContent }
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>委托机构：</dt>
				<dd>
					${ExpertIdentityBean.wtDept }
				</dd>
			</dl>
			<div class="divider">divider</div>
			<dl class="nowrap">
				<dt>专家鉴定函：</dt>
				<dd>
					<logic:notEqual value="" name="ExpertIdentityBean" property="letterPath">
						<!-- 
						<a href="#" onclick="showattach('${ExpertIdentityBean.letterPath }','${ExpertIdentityBean.reportID }')" title="查看专家鉴定函">查看</a>
						 -->
						<a href="${ExpertIdentityBean.letterPath }" title="下载专家鉴定函">下载专家鉴定函</a>
					</logic:notEqual>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>鉴定意见书：</dt>
				<dd>
					<logic:notEqual value="" name="ExpertIdentityBean" property="adviceLetterPath">
						<!-- 
						<a href="#" onclick="showattach('${ExpertIdentityBean.adviceLetterPath }','${ExpertIdentityBean.reportID }')" title="查看鉴定意见书">查看</a>
						 -->
						<a href="${ExpertIdentityBean.adviceLetterPath }" title="下载鉴定意见书">下载鉴定意见书</a>
					</logic:notEqual>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>其他附件：</dt>
				<dd>
					<logic:notEmpty name="ExpertIdentityBean" property="attachList">
  						<logic:iterate name="ExpertIdentityBean" property="attachList" id="UrlAndName">
  							${UrlAndName.name }&nbsp;&nbsp;&nbsp;&nbsp;<a href="${UrlAndName.url }" title="下载"><font color="red">下载</font></a><br/><br/>
  						</logic:iterate>
  					</logic:notEmpty>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>操作：</dt>
				<dd>
				<logic:equal value="" name="ExpertIdentityBean" property="status"><font color="blue">该案件的调查已经完成，不能在线提交！</font></logic:equal>
				<logic:notEqual value="" name="ExpertIdentityBean" property="status">				
					<logic:equal value="1" name="ExpertIdentityBean" property="isSubmit">
					<a href="<%=path%>/expertFKAction.do?method=onlineSubmit&id=${ExpertIdentityBean.id }&reportID=${ExpertIdentityBean.reportID }&adviceID=${ExpertIdentityBean.adviceID }" target="navTab" rel="onlineSubmit"><font color="red">查看已提交鉴定结果</font></a>					
					</logic:equal>
					<logic:equal value="0" name="ExpertIdentityBean" property="isSubmit">
						<a href="<%=path%>/expertFKAction.do?method=onlineSubmit&id=${ExpertIdentityBean.id }&reportID=${ExpertIdentityBean.reportID }&adviceID=${ExpertIdentityBean.adviceID }" target="navTab" rel="onlineSubmit"><font color="red">在线提交鉴定结果</font></a>
					</logic:equal>
				</logic:notEqual>
				</dd>
			</dl>
		</div>
		
	</div>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="expertFKForm" property="recordNotFind">
	
	</logic:equal>
</div>
</div>