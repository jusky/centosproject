<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
    $(document).ready(function() {
        $("#editUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'editUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 1,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){if(response == "1"){alert(file.name +"上传成功！");}else{alert(file.name +"上传失败！");document.getElementById("cfile").click();}}
        });
    });
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	function uploadNewEvent(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
</script>
<div class="pageContent">
	<form method="post" action="<%=path%>/eventManageAction.do?method=editEvent" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
			<logic:notEmpty name="eventManageForm" property="recordList">
     		<logic:iterate name="eventManageForm" property="recordList" id="EventBean">
     		<input type="hidden" name="reportID" id="reportID" value="${EventBean.reportID }"/>
			<dl class="nowrap">
				<dt>举报事由：</dt>
				<dd>
					<textarea class="requird " readonly rows="5" cols="100" name="reportReason">${EventBean.reportReason }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
				<dt>举报内容：</dt>
				<dd>
					<textarea class="requird" readonly rows="20" cols="100" name="reportContent">${EventBean.reportContent }</textarea>
				</dd>
			</dl>
			<dl class="nowrap">
					<dt>上传附件：
					<br/><font color="red">请将多个附件打包压缩后再一起上传，谢谢！</font>
					</dt>
					<dd>
						<input type="file" name="editUpload" id="editUpload" />
        					<a href="javascript:uploadNewEvent('#editUpload','event')">开始上传</a>&nbsp;
        					<a id="cfile" href="javascript:jQuery('#editUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
			</dl>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		