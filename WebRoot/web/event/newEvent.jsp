<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
function setRealName(cb)
{
	if(cb.checked==true)
	{
		document.getElementById("niDiv").style.display="block";
		document.getElementById("jbName").value="";
		document.getElementById("jbName").readOnly=false;
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";	
		deleteDefault();
	}
	
}
function setName(cb)
{
	if(cb.checked==true)
	{
		document.getElementById("niDiv").style.display="none";
		document.getElementById("jbName").value="匿名举报";
		document.getElementById("jbName").readOnly=true;
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";
		//将必填的数据填充为默认值，提交表单后可以不验证这些信息
		setDefault();
	}
	else
	{
		document.getElementById("niDiv").style.display="block";
		document.getElementById("jbName").value="";
		document.getElementById("jbName").readOnly=false;
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";
		deleteDefault();
	}
}
function setFaculty(cb)
{
	if(cb.checked==true)
	{
		document.getElementById("nimingID").readOnly = true;
		document.getElementById("niDiv").style.display="none";
		document.getElementById("jbName").value="科学部转";
		document.getElementById("jbName").readOnly=true;
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";
		//将必填的数据填充为默认值，提交表单后可以不验证这些信息
		setDefault();
		
	}
	else
	{
		document.getElementById("niDiv").style.display="block";
		document.getElementById("jbName").value="";
		document.getElementById("jbName").readOnly=false;
		
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";
		
		deleteDefault();
	}
}
function setSimilar(cb)
{
	if(cb.checked==true)
	{
		document.getElementById("nimingID").readOnly = true;
		document.getElementById("niDiv").style.display="none";
		document.getElementById("jbName").value="信息中心";
		document.getElementById("jbName").readOnly=true;
		document.getElementById("reportReason").value = "申请项目高相似度";
		document.getElementById("reportContent").value = "整体相似度：%，摘要：%，立项依据：%，研究内容：%，研究方案：%，特色创新：%";
		//将必填的数据填充为默认值，提交表单后可以不验证这些信息
		setDefault();
		
	}
	else
	{
		document.getElementById("niDiv").style.display="block";
		document.getElementById("jbName").value="";
		document.getElementById("jbName").readOnly=false;
		
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";
		
		deleteDefault();
	}
}
function setDept(cb)
{
	if(cb.checked==true)
	{
		document.getElementById("nimingID").readOnly = true;
		document.getElementById("niDiv").style.display="none";
		document.getElementById("jbName").value="其他部门转";
	//	document.getElementById("jbName").readOnly=true;
		document.getElementById("reportReason").value = "";
		document.getElementById("reportContent").value = "";
		setDefault();
		
	}
	else
	{
		document.getElementById("niDiv").style.display="block";
		document.getElementById("jbName").value="";
	//	document.getElementById("jbName").readOnly=false;
		deleteDefault();
	}
}
function setDefault()
{
	document.getElementById("dept").value="无单位";
	document.getElementById("telPhone").value="12345678901";
	document.getElementById("mailAddress").value="no@no.com";
}
function deleteDefault()
{
	document.getElementById("dept").value="";
	document.getElementById("telPhone").value="";
	document.getElementById("mailAddress").value="";
}
function commit()
{
    document.forms[0].action = "<%=path%>/newEventAction.do?method=commit";
    document.forms[0].submit();
}
function showreason()
{
	paramers="dialogWidth:320px; dialogHeight:400px; resizable:yes; overflow:auto; status:no";
	url = "<%=path%>/web/event/reportReason.jsp";
	var value1 = window.showModalDialog(url, "", paramers);
	if(value1.names !== null)
	{	
		document.getElementById("reportReason").value=value1.names;
	}
}
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#eventUpload").uploadify({
            'uploader' : '<%=path%>/dwz/uploadify/scripts/uploadify.swf',
            'script' : '<%=path%>/servlet/UploadServlet?type=event',//后台处理的请求
            'cancelImg' : '<%=path%>/dwz/uploadify/img/cancel.png',
            'folder' : 'uploads',//您想将文件保存到的路径
            'queueID' : 'fileQueue',//与下面的id对应
            'fileDataName'   : 'eventUpload', //和以下input的name属性一致 
            'queueSizeLimit' : 1,//上传队列大小
            'auto' : false,
            'multi' : true,
            'simUploadLimit' : 2,//同时可上传的文件实例数
            'buttonText' : 'BROWSE',
            'removeCompleted':false ,
            'onComplete' :function(event,queueId,file,response,data){alert(file.name +"上传成功！");}
		       
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
	
	//向举报者发送邮件
	 function sendMail()
	 {
	 	var address = document.getElementById("mailAddress").value;
	 	if(address != null && address != "")
	 	{
	 		$("#NEsendEmailID").attr("href",'<%=path%>/newMailAction.do?method=init&address=' + address); 
	 		//先控制页面跳转到发送邮件页面
	 		$("#NEsendEmailID").click();
	 		//然后关闭当前对话框
	 		$.pdialog.closeCurrent();
	 	}else
	 	{
	 		alert("请填写邮箱地址!");
	 	}
	 	
	 }
</script>
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);" action="<%=path%>/newEventAction.do?method=save">
		<div class="pageFormContent" layoutH="56">
			<div class="panel">
				<h1>举报人信息（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>举报人姓名：</dt>
					<dd>
						<input id="jbName" name="reportName" minlength="2" maxlength="15" class="required" type="text" size="20" value=""/>
						<input type="radio" name="choose" value="0" checked onclick="setRealName(this)"/>实名举报
						<input type="radio" id="nimingID" name="choose" value="1" onclick="setName(this);"/>匿名举报
						<input type="radio" name="choose" value="2" onclick="setSimilar(this);"/>高相似度
						<input type="radio" name="choose" value="3" onclick="setDept(this);"/>其他部门转
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>编号：</dt>
					<dd>
						<input id="serialNum" name="serialNum" minlength="5" maxlength="8" class="required" type="text" size="10" value="<%=request.getAttribute("SerialNum") %>"/>
					</dd>
				</dl>
				<div id="niDiv">
				<dl class="nowrap">
					<dt>所属单位：</dt>
					<dd>
						<input id="dept" name="dept" minlength="3" maxlength="30" class="required" type="text" size="70" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>办公电话：</dt>
					<dd>
						<input id="gdPhone" minlength="4" maxlength="15" name="gdPhone" type="text" size="30" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>手机号码：</dt>
					<dd>
						<input id="telPhone" name="telPhone" minlength="5" maxlength="15" class="phone required"  type="text" size="30" value=""/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>邮箱地址：</dt>
					<dd>
						<input id="mailAddress" name="mailAddress" class="email required" type="text" size="50" value=""/>
						<a id="NEsendEmailID" href="<%=path%>/newMailAction.do?method=init&address=2516265600@qq.com" target="navTab" rel="newEmail" style="display:none;">发送邮件</a>
						<a href="#" onclick="javascript:sendMail()"><font color="blue">发送邮件</font></a>
					</dd>
				</dl>
				</div>
				<dl class="nowrap">
					<dt>举报时间：</dt>
					<dd>
						<input id="reportTime" type="text" name="reportTime" class="required date" size="20" readonly/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dd>
						<input type="hidden" name="reportType" value="手工录入">
					</dd>
				</dl>
				</div>
			</div>

			<div class="panel">
				<h1>被举报人信息（注意：标有<font color="#ff0000">*</font>的必须填写，只接受前五个被举报人）</h1>
				<div style="background:#ffffff;">
					<table class="list nowrap itemDetail" addButton="新建被举报人" width="100%">
						<thead>
							<tr>
								<th align="center" type="text" name="items.name[#index#]" size="15" fieldClass="required">姓名</th>
								<th align="center" type="text" name="items.position[#index#]" size="25">职称</th>
								<th align="center" type="text" name="items.phone[#index#]" size="20" fieldClass="digits">联系方式</th>
								<th align="center" type="text" name="items.dept[#index#]" fieldClass="required"  size="60">所属单位</th>
								<th align="center" type="del" width="30">删除</th>
							</tr>
						</thead>
						<tbody>
							<tr class="unitBox" style="background-color:#fff;border-color:#fff; ">
    							<td><input type="text" name="items.name[0]" value size="15" class="required textInput"></td>
    							<td><input type="text" name="items.position[0]" value size="25" class="textInput"></td>
    							<td><input type="text" name="items.phone[0]" value size="20" class="digits textInput"></td>
    							<td><input type="text" name="items.dept[0]" value size="60" class="required textInput"></td>
    							<td></td>
							</tr>
						</tbody>
					</table>
				</div>
				
			</div>
			<div class="panel">
				<h1>举报内容（注意：标有<font color="#ff0000">*</font>的必须填写）</h1>
				<div style="background:#ffffff;">
				<dl class="nowrap">
					<dt>举报事由：</dt>
					<dd>
						<textarea class="required" id="reportReason" rows="4" cols="60" name="org4.jbReason" ></textarea>
						<a class="btnLook" href="javascript:showreason()">选择举报事由</a>
						<span class="info"></span>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>举报详情：</dt>
					<dd>
						<textarea id="reportContent" class="required" rows="15" cols="100" minlength="10" name="reportContent"></textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>上传附件：
					<br/><font color="red">请将多个附件打包压缩后再一起上传，谢谢！</font>
					</dt>
					<dd>
						<input type="file" name="eventUpload" id="eventUpload" />
        					<a href="javascript:uploadNewEvent('#eventUpload','event')">开始上传</a>&nbsp;
        					<a href="javascript:jQuery('#eventUpload').uploadifyClearQueue()">取消所有上传</a>
    					<div id="fileQueue"></div>
					</dd>
				</dl>
				<dl id="imglist"></dl>
				</div>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<!-- 
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="commit();">提交</button></div></div></li>
				 -->
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>