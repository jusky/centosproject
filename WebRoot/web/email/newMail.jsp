<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
    $(document).ready(function() {
        $("#emailAttach").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=email',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'emailAttach', //和以下input的name属性一致 
            'queueSizeLimit' : 5,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'buttonText' : 'BROWSE'
        });
    });
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	//上传附件前先删除临时文件夹中的文件
	function uploadNewEvent(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/newMailAction.do?method=sendEmail" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<div class="pageFormContent" layoutH="57">
			<dl>
				<dt>发件人：</dt>
				<dd>
				<select class="combox" name="sendName">
					<logic:notEqual value="true" name="newMailForm" property="recordNotFind">
   						<logic:notEmpty name="newMailForm" property="sendNameList">
	     					<logic:iterate name="newMailForm" property="sendNameList" id="EmailBean">
								<option value="${EmailBean.ID}"><bean:write name="EmailBean" property="accountName"/></option>
							</logic:iterate>
						</logic:notEmpty>
					</logic:notEqual>
				</select>
				</dd>
			</dl>
			<dl class="nowrap">
			<dt>收件人：</dt>
			<dd>
				<input name="org3.conName" type="text" size="60" value="<%=(String)request.getAttribute("MailAddress") %>"/>
				<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=contact" lookupGroup="org3">查找带回</a>
				<span class="info">查找</span>
			</dd>
			</dl>
			<dl class="nowrap">
				<dt>抄送人：</dt>
				<dd>
				<input name="org2.conName" type="text" size="60"/>
				<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=contact" lookupGroup="org2">查找带回</a>
				<span class="info">查找</span>
			</dd>
			</dl>
			<dl class="nowrap">
				<dt>主题：</dt>
				<dd>
					<input class="required" name="title" type="text" size="80" />
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>附件：</dt>
				<dd>
    				<input type="file" name="emailAttach" id="emailAttach" />
        			<a href="javascript:uploadNewEvent('#emailAttach','email')"">开始上传</a>&nbsp;
        			<a href="javascript:jQuery('#emailAttach').uploadifyClearQueue()">取消所有上传</a>
    				<div id="fileQueue"></div>
				</dd>
			</dl>
			<div class="divider"></div>
				<div class="unit">
					<textarea class="editor" rows="15" cols="100" name="content"></textarea>
				</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">发送</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>

