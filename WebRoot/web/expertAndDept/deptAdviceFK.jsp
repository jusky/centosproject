<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#eventUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=adviceFK',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'eventUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 1,
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,
            'fileDesc': "请选择office/pdf/压缩包文件",
    		'fileExt': '*.doc;*.docx;*.xls;*.xlsx;*.pdf;*.rar;*.zip', 
            'buttonText' : 'BROWSE'
        });
    });
    
    var isSubmit = <%=request.getAttribute("isSubmit")%>;
    if (isSubmit == "1") {
    	 $(function(){
			$("textarea input").attr("class", "readonly");   
			$("#submitHide").hide();
    	})
    }
</script>
<script type="text/javascript" src="<%=path%>/js/uploadAjax.js"></script>
<script type="text/javascript">
	function uploadNewEvent(obj,type)
	{
		var url="<%=path%>/servlet/DeleteUploadServlet?type=" + type;
		sendAjax(url);
		jQuery(obj).uploadifyUpload();
	}
	function countRemind(id)
	{
		var text = document.getElementById(id).value;
		var len;
		if(text.length >= 2500)
		{
			document.getElementById(id).value=text.substr(0, 2500);
			len = 0;
		}
		else
		{
			len = 2500 - text.length;
		}
		document.getElementById(id + "Label").innerText = "还可以输入" + len + "字！";
	}
</script>
<div class="pageContent">
	<form method="post" action="<%=path %>/deptFKAction.do?method=submitAdvice" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);" enctype="multipart/form-data">
	<input type="hidden" name="dcID" value="<%=request.getAttribute("dcID") %>"/>
	<input type="hidden" name="reportID" value="<%=request.getAttribute("reportID") %>"/>
	<input type="hidden" name="adviceID" value="<%=request.getAttribute("adviceID") %>"/>
		<div class="pageFormContent" layoutH="56">
		<logic:notEmpty name="deptFKForm" property="recordList">
     		<logic:iterate name="deptFKForm" property="recordList" id="DeptAdviceBean">
			<div class="panel">
				<h1>调查结果（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>事实和贵单位意见：</dt>
					<dd>
						<textarea id="deptAdvice" cols="100" name="deptAdvice" rows="15" onKeyUp="countRemind('deptAdvice')" onblur="countRemind('deptAdvice')">${DeptAdviceBean.deptAdvice }</textarea>
						<br/>
						<label id="deptAdviceLabel">还可以输入2500字！</label>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel">
				<h1>当事人情况（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>当事人姓名：</dt>
					<dd>
						<input type="text" name="litigantName" size="50" value="${DeptAdviceBean.litigantName }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>当事人陈述：</dt>
					<dd>
						<textarea id="attitude" cols="100" name="attitude" rows="10" onKeyUp="countRemind('attitude')" onblur="countRemind('attitude')">${DeptAdviceBean.attitude }</textarea>
				    	<br/>
						<label id="attitudeLabel">还可以输入2500字！</label>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>面谈时间：</dt>
					<dd>
						<input id="litigantTime" type="text" name="litigantTime" class="date" size="20" readonly="true" value="${DeptAdviceBean.litigantTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel">
				<h1>其他情况（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>专家意见：</dt>
					<dd>
						<textarea id="expertAdvice" cols="100" name="expertAdvice" rows="10" onKeyUp="countRemind('expertAdvice')" onblur="countRemind('expertAdvice')">${DeptAdviceBean.expertAdvice }</textarea>
						<br/>
						<label id="expertAdviceLabel">还可以输入2500字！</label>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：
						<br/>
			    		<font color="red">添加附件后请点击“开始上传”！</font>
			    	</dt>
					<dd>
						<input type="file" name="eventUpload" id="eventUpload" />
        					<a href="javascript:uploadNewEvent('#eventUpload','event')">开始上传</a>&nbsp;
	    				<div id="fileQueue"></div>
						如果需要上传多个附件，请一起打包压缩后再上传，谢谢！
					</dd>
				</dl>
				</div>
			</div>
			</logic:iterate>
			</logic:notEmpty>
		</div>
		<div class="formBar">
			<ul>
				<li><div id="submitHide" class="button"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>