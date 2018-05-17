<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#attachUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=attach',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'attachUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 5,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){alert(file.name +"上传成功！");}
        });
    });
</script>
<div class="pageContent">
	<form method="post" action="<%=path %>/attachManageAction.do?method=upload" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="58">
		<dl>
			<dt>上传附件：
			<br/><font color="red">请将多个附件打包压缩后再一起上传，谢谢！</font>
			</dt>
			<dd>
				<input type="file" name="attachUpload" id="attachUpload" />
      				<a href="javascript:jQuery('#attachUpload').uploadifyUpload()">开始上传</a>&nbsp;
  					<a href="javascript:jQuery('#attachUpload').uploadifyClearQueue()">取消</a>
  					<div id="fileQueue"></div>
			</dd>
		</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>