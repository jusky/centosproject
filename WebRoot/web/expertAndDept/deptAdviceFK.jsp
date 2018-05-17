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
    		   'fileExt': '*.doc;*.docx;*.xls;*.xlsx;*.pdf;*.jpg;*.jpeg;*.png;*.tiff;*.rar;*.zip', 
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){if(response == "1"){alert(file.name +"上传成功！");}else{alert(file.name +"上传失败！");}}
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
		if(text.length >= 5000)
		{
			document.getElementById(id).value=text.substr(0, 5000);
			len = 0;
		}
		else
		{
			len = 5000 - text.length;
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
		<logic:notEmpty name="deptFKManageForm" property="recordList">
     		<logic:iterate name="deptFKManageForm" property="recordList" id="DeptAdviceBean">
     		<logic:equal name="isSubmit" scope="request" value="1">
     			<div class="panel">
     			<h1>涉案人员信息（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
     			<logic:notEmpty name="DeptAdviceBean" property="beReportList">
				<logic:iterate name="DeptAdviceBean" property="beReportList" id="BeReportBean" indexId="number">
				<input type="hidden" name="beReportedList[${number}].ID" value="BeReportBean.ID"/>
				<dl class="nowrap">
					<dt>当事人姓名：</dt>
					<dd><input class="required" name="beReportedList[${number}].beName" type="text" size="30" value='${BeReportBean.beName}' style="color:#ff0000;"/></dd>
				</dl>
				<dl class="nowrap">
					<dt>身份证号：</dt>
					<dd><input class="required" name="beReportedList[${number}].beidNumber" type="text" size="30" value='${BeReportBean.idNumber}' style="color:#ff0000;"/></dd>
				</dl>
				<dl class="nowrap">
					<dt>出生年月：</dt>
					<dd>
						<input id="beReportedList[${number}].birth" type="text" name="beReportedList[${number}].birth" class="date required" size="20"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				</logic:iterate>
				</logic:notEmpty>
     			</div>
     			</div>
     			
     			<div class="panel">
				<h1>调查结果（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>调查情况和单位意见：<font color="#ff0000">*</font></dt>
					<dd>
						<textarea readonly id="deptAdvice" cols="100" name="deptAdvice" rows="15" onKeyUp="countRemind('deptAdvice')" onblur="countRemind('deptAdvice')">${DeptAdviceBean.deptAdvice }</textarea>
						<br/>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel">
				<h1>当事人情况（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>当事人姓名：<font color="#ff0000">*</font></dt>
					<dd>
						<input readonly type="text" name="litigantName" size="50" value="${DeptAdviceBean.litigantName }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>当事人陈述：<font color="#ff0000">*</font></dt>
					<dd>
						<textarea readonly id="attitude" cols="100" name="attitude" rows="10" onKeyUp="countRemind('attitude')" onblur="countRemind('attitude')">${DeptAdviceBean.attitude }</textarea>
				    	<br/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>面谈时间：<font color="#ff0000">*</font></dt>
					<dd>
						<input readonly id="litigantTime" type="text" name="litigantTime" class="date" size="20" readonly value="${DeptAdviceBean.litigantTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel">
				<h1>其他情况（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>贵单位专家意见：</dt>
					<dd>
						<textarea readonly id="expertAdvice" cols="100" name="expertAdvice" rows="10" onKeyUp="countRemind('expertAdvice')" onblur="countRemind('expertAdvice')">${DeptAdviceBean.expertAdvice }</textarea>
						<br/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：
						<br/>
			    	</dt>
					<dd><a href="${DeptAdviceBean.filePath }"><font color="blue">下载</font></a>
					</dd>
				</dl>
				</div>
			</div>
     		</logic:equal>
			<logic:equal name="isSubmit" scope="request" value="0">
			<div class="panel">
				<h1>涉案人员信息（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
     			<logic:notEmpty name="DeptAdviceBean" property="beReportList">
				<logic:iterate name="DeptAdviceBean" property="beReportList" id="BeReportBean" indexId="number">
				<input type="hidden" name="beReportedList[${number}].ID" value="${BeReportBean.ID}"/>
				<dl class="nowrap">
					<dt>当事人姓名：</dt>
					<dd><input class="required" name="beReportedList[${number}].beName" type="text" size="30" value='${BeReportBean.beName}' style="color:#ff0000;"/></dd>
				</dl>
				<dl class="nowrap">
					<dt>身份证号：</dt>
					<dd><input class="required" name="beReportedList[${number}].beidNumber" type="text" size="30" value='${BeReportBean.idNumber}' style="color:#ff0000;"/></dd>
				</dl>
				<dl class="nowrap">
					<dt>出生年月：</dt>
					<dd>
						<input id="beReportedList[${number}].birth" type="text" name="beReportedList[${number}].birth" class="date required" size="20"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				</logic:iterate>
				</logic:notEmpty>
     			</div>
     			</div>
			<div class="panel">
				<h1>调查结果（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>调查情况和单位意见：<font color="#ff0000">*</font></dt>
					<dd>
						<textarea id="deptAdvice" cols="100" name="deptAdvice" rows="15" onKeyUp="countRemind('deptAdvice')" onblur="countRemind('deptAdvice')">${DeptAdviceBean.deptAdvice }</textarea>
						<br/>
						<label id="deptAdviceLabel">还可以输入5000字！</label>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel">
				<h1>当事人情况（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>当事人姓名：<font color="#ff0000">*</font></dt>
					<dd>
						<input type="text" name="litigantName" size="50" value="${DeptAdviceBean.litigantName }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>当事人陈述：<font color="#ff0000">*</font></dt>
					<dd>
						<textarea id="attitude" cols="100" name="attitude" rows="10" onKeyUp="countRemind('attitude')" onblur="countRemind('attitude')">${DeptAdviceBean.attitude }</textarea>
				    	<br/>
						<label id="attitudeLabel">还可以输入2500字！</label>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>面谈时间：<font color="#ff0000">*</font></dt>
					<dd>
						<input id="litigantTime" type="text" name="litigantTime" class="date" size="20" readonly value="${DeptAdviceBean.litigantTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				</div>
			</div>
			<div class="panel">
				<h1>其他情况（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>贵单位专家意见：</dt>
					<dd>
						<textarea id="expertAdvice" cols="100" name="expertAdvice" rows="10" onKeyUp="countRemind('expertAdvice')" onblur="countRemind('expertAdvice')">${DeptAdviceBean.expertAdvice }</textarea>
						<br/>
						<label id="expertAdviceLabel">还可以输入5000字！</label>
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
			</logic:equal>
			</logic:iterate>
			</logic:notEmpty>
		</div>
		<div class="formBar">
			<ul>
				<logic:equal name="isSubmit" value="0" scope="request"><li><div class="button"><div class="buttonContent"><button type="submit">提交</button></div></div></li></logic:equal>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>