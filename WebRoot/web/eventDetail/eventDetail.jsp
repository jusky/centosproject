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
	var XMLHttpReq=false;
   //创建一个XMLHttpRequest对象
   
   function createXMLHttpRequest(){
     if(window.XMLHttpRequest){ //Mozilla 
       XMLHttpReq=new XMLHttpRequest();
     }else if(window.ActiveXObject){
		  try{
         XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");
 	  }catch(e){
  	    try{
           XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
         }catch(e){}
       }
     }
   }
   
   //发送提交的请求函数
   function send(url){
     createXMLHttpRequest();
     XMLHttpReq.open("post",url,true);
     XMLHttpReq.onreadystatechange=proce;   //指定响应的函数
     XMLHttpReq.send(null);  //发送请求
   }
   function proce(){        	 
	if(XMLHttpReq.readyState==4){ //对象状态,收到完整的服务器响应
	 		  if(XMLHttpReq.status==200){//信息已成功返回，HTTP服务器响应的值为OK   
	         		var root=XMLHttpReq.responseText;
	         		alert(root);
	         	}
	       		else{
	         		window.alert("所请求的页面有异常");
	       		}
	     	}
	   }
	function checkIdentity()
	{
		if(window.confirm('该实名举报者的身份是否真实？')){
	        send('<%=path%>/servlet/CheckIdentityServlet?type=real');
	     }else{
	        send('<%=path%>/servlet/CheckIdentityServlet?type=noreal');
	    }
	}
	function confirm(str)   
	 {   
	     execScript("n = (msgbox('"+str+"',vbYesNo,'核实身份')=vbYes)","vbscript");   
	     return(n);   
	 } 
	 //向举报者发送邮件
	 function sendMail()
	 {
	 	//先控制页面跳转到发送邮件页面
	 	$("#sendEmailID").click();
	 	//然后关闭当前对话框
	 	$.pdialog.closeCurrent();
	 }
	 
	 function printEvent()
	 {
	 	var url = "<%=path%>/eventDetailAction.do?method=print";
		openMaxWin(url);
	 }

</script>
<div class="pageContent">
	<div class="tabs" currentIndex="0" eventType="click">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:;"><span>举报信息</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=approveInfo" class="j-ajax"><span>审核信息</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=deptAdvice" class="j-ajax"><span>依托单位意见</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=expertAdvice" class="j-ajax"><span>专家鉴定意见</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=litigantState" class="j-ajax"><span>当事人陈述</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=facultyAdvice" class="j-ajax"><span>学部意见</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=handleDecide" class="j-ajax"><span>处理决定</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=eventDetail&type=handleFlow" class="j-ajax"><span>处理流程</span></a></li>
					<li><a href="<%=path %>/eventDetailAction.do?method=attachment" class="j-ajax"><span>附件列表</span></a></li>
				</ul>
			</div>
		</div>
		<div class="tabsContent">
		<div>
			<div class="pageFormContent" layoutH="95">
			<form method="post" action="<%=path%>/eventDetailAction.do?method=print" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<logic:notEqual value="true" name="eventManageForm" property="recordNotFind">
		<logic:notEmpty name="eventManageForm" property="recordList">
     		<logic:iterate name="eventManageForm" property="recordList" id="EventBean">
				<fieldset>
					<legend>举报人信息</legend>
					<logic:equal value="1" name="EventBean" property="isNI">
						<dl>
							<dt>姓名：</dt>
							<dd><input readonly="true" type="text" size="20" value='${EventBean.reportName}' style="color:#ff0000;"/></dd>
						</dl>
						<dl>
							<dt>举报方式：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.reportType}'/></dd>
						</dl>
						<dl>
							<dt>收件编号：</dt>
							<dd><input readonly="true" type="text" size="20" value='${EventBean.serialNum}'/></dd>
						</dl>
						<dl>
							<dt>系统编号：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.reportID}'/></dd>
						</dl>
					</logic:equal>
					<logic:notEqual value="1" name="EventBean" property="isNI">
						<dl class="nowrap">
							<dt>姓名：</dt>
							<dd>
								<input readonly="true" type="text" size="20" value='${EventBean.reportName}' style="color:#ff0000;"/>
								<logic:equal value="0" name="EventBean" property="isNI">
									<div class="button"><div class="buttonContent"><button onclick="javascript:checkIdentity()">核实身份</button></div></div>
								</logic:equal>
								<logic:equal value="2" name="EventBean" property="isNI">
									<font color="#ff0000">身份已核实</font>
								</logic:equal>
							</dd>
						</dl>
						<dl class="nowrap">
							<dt>工作单位：</dt>
							<dd><input readonly="true" type="text" size="60" value='${EventBean.dept}'/></dd>
						</dl>
						<dl class="nowrap">
							<dt>邮箱地址：</dt>
							<dd>
								<input readonly="true" type="text" size="30" value='${EventBean.mailAddress}'/>
								<logic:notEqual value="" name="EventBean" property="mailAddress">
									<a id="sendEmailID" href="<%=path%>/newMailAction.do?method=init&address=${EventBean.mailAddress}" target="navTab" rel="newEmail" style="display:none;">发送邮件</a>
									<a href="#" onclick="javascript:sendMail()"><font color="blue">发送邮件</font></a>
								</logic:notEqual>
							</dd>
						</dl>
						<dl>
							<dt>固定电话：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.gdPhone}'/></dd>
						</dl>
						<dl>
							<dt>手机号码：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.telPhone}' style="color:#ff0000;"/></dd>
						</dl>
						<dl>
							<dt>举报时间：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.reportTime}'/></dd>
						</dl>
						<dl>
							<dt>举报方式：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.reportType}'/></dd>
						</dl>
						<dl>
							<dt>收件编号：</dt>
							<dd><input readonly="true" type="text" size="20" value='${EventBean.serialNum}' style="color:#ff0000;"/></dd>
						</dl>
						<dl>
							<dt>系统编号：</dt>
							<dd><input readonly="true" type="text" size="30" value='${EventBean.reportID}'/></dd>
						</dl>
					</logic:notEqual>
				</fieldset>
				<fieldset>
					<legend>被举报人信息</legend>
					<logic:iterate name="EventBean" property="beReportList" id="BeReportBean">
						<dl class="nowrap">
							<dt>被举报人姓名：</dt>
							<dd><input readonly="true" type="text" size="30" value='${BeReportBean.beName}' style="color:#ff0000;"/></dd>
						</dl>
						<dl class="nowrap">
							<dt>所属单位：</dt>
							<dd><input readonly="true" type="text" size="60" value='${BeReportBean.beDept}'/></dd>
						</dl>
						<dl>
							<dt>职称：</dt>
							<dd><input readonly="true" type="text" size="30" value='${BeReportBean.bePosition}'/></dd>
						</dl>
						<dl>
							<dt>联系方式：</dt>
							<dd><input readonly="true" type="text" size="30" value='${BeReportBean.beTelPhone}'/></dd>
						</dl>
						<div class="divider"></div>
					</logic:iterate>
				</fieldset>
				<fieldset>
					<legend>举报内容</legend>
					<dl class="nowrap">
						<dt>所属学部：</dt>
						<dd><input readonly="true" type="text" size="50" value='${EventBean.faculty}' style="color:#ff0000;"/></dd>
					</dl>
					<dl class="nowrap">
						<dt>举报事由：</dt>
						<dd><textarea rows="3" cols="80" readonly="true">${EventBean.reportReason}</textarea></dd>
					</dl>
					<dl class="nowrap">
						<dt>内容详情：</dt>
						<dd>
							<textarea rows="15" cols="80" readonly="true">${EventBean.reportContent}</textarea>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>备注：</dt>
						<dd>
							<textarea rows="8" cols="80" readonly="true">${EventBean.bz}</textarea>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>附件：</dt>
						<dd>
							<logic:notEqual value="" name="EventBean" property="accessory">
								<a href="${EventBean.accessory }" >下载附件</a>
							</logic:notEqual>
						</dd>
					</dl>
				</fieldset>
				</logic:iterate>
				</logic:notEmpty>
				</logic:notEqual>
				<logic:notEqual value="false" name="eventManageForm" property="recordNotFind">
				出错了！！！
				</logic:notEqual>
				</form>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="printEvent()">打印</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
			
			</div>
			<div>
			
			</div>
			<div>
			
			</div>
			<div>
			
			</div>
			<div>
			
			</div>
			<div>
			
			</div>
			<div>
			
			</div>
			<div>
			
			</div>
		</div>

		<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
		</div>
	</div>
</div>
