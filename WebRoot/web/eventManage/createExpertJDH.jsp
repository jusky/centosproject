<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whu.web.eventbean.ExpertJDH" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function makeExpertJDH()
{
	var jdhID = document.getElementById("jdhID").value;
	
	if(jdhID == "")
	{
		alert("请编辑内容并保存成功后再生成鉴定函！");
	}
	else
	{
		var url = "<%=path%>/expertAdviceAction.do?method=makeExpertJDH";
		openMaxWin(url);
	}
}
</script>

<script type="text/javascript">
	brContent = document.getElementById("shortInfo1").value;
	document.getElementById("shortInfo1").value=brContent.replace(/<br>/g, "\n");
	brContent = document.getElementById("target").value;
	document.getElementById("target").value=brContent.replace(/<br>/g, "\n");
	brContent = document.getElementById("jdContent").value;
	document.getElementById("jdContent").value=brContent.replace(/<br>/g, "\n");
	function chooseJDH(){
   	var objS = document.getElementById("JDHlist");
      var jdhid = objS.options[objS.selectedIndex].value;
      <% 
      	ArrayList jdhlist = (ArrayList)request.getAttribute("JDHlist");
      	for(int i = 0;i < jdhlist.size();i++){
      %>
      if(jdhid == '<%=((ExpertJDH)jdhlist.get(i)).getId() %>'){
      	document.getElementById("jdhID").value='<%=((ExpertJDH)jdhlist.get(i)).getId() %>';
      	document.getElementById("letterTitle").value='<%=((ExpertJDH)jdhlist.get(i)).getTitle() %>';
   		document.getElementById("shortInfo1").value='<%=((ExpertJDH)jdhlist.get(i)).getShortInfo() %>'.replace(/<br>/g, "\n");
   		document.getElementById("time1").value='<%=((ExpertJDH)jdhlist.get(i)).getFkTime() %>';
   		document.getElementById("target").value='<%=((ExpertJDH)jdhlist.get(i)).getTarget() %>'.replace(/<br>/g, "\n");
   		document.getElementById("jdContent").value='<%=((ExpertJDH)jdhlist.get(i)).getJdContent() %>'.replace(/<br>/g, "\n");
      }
      
      <%}%>
    }
   function newJDH(){
   	document.getElementById("jdhID").value="";
   	document.getElementById("letterTitle").value="关于商请鉴定XXX的函";
   	document.getElementById("shortInfo1").value="";
   	document.getElementById("time1").value="";
   	document.getElementById("target").value="";
   	document.getElementById("jdContent").value="";
   	}
</script>

<div id ="localjiazai" class="pageContent" >
	<form method="post" action="<%=path%>/expertAdviceAction.do?method=saveExpertJDH" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="56">
				<dl>
				<dt>选择查看的鉴定函：</dt>
				<dd>
					<select id="JDHlist" onchange="chooseJDH()">
						<logic:notEmpty name="expertAdviceForm" property="recordList">
     					<logic:iterate name="expertAdviceForm" property="recordList" id="ExpertJDH">
							<option value="${ExpertJDH.id }">${ExpertJDH.title}</option>
						</logic:iterate>
						</logic:notEmpty>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</dd>
			</dl>
			<logic:notEmpty name="expertAdviceForm" property="recordList">
     		<logic:iterate name="expertAdviceForm" property="recordList" id="ExpertJDH"  length="1" offset="0">
     		<input type="hidden" id="jdhID" name="jdhID" value="${ExpertJDH.id }"/>
     		<input type="hidden" name="reportID" value="${ExpertJDH.reportID }"/>
			<dl class="nowrap">
					<dt>标题：</dt>
					<dd>
						<input type="text" id="letterTitle" name="title" size="100" value="${ExpertJDH.title }"/>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>问题简述：</dt>
					<dd>
						<textarea id="shortInfo1" rows="4" cols="100" name="shortInfo">${ExpertJDH.shortInfo }</textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>反馈日期：</dt>
					<dd>
						<input id="time1" type="text" name="fkTime" class="date" size="20" readonly value="${ExpertJDH.fkTime }"/><a class="inputDateButton" href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定目标：</dt>
					<dd>
						<textarea rows="3" cols="100" id="target" name="target">${ExpertJDH.target }</textarea>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>鉴定内容：</dt>
					<dd>
						<textarea rows="15" cols="100" id="jdContent" name="jdContent">${ExpertJDH.jdContent }</textarea>
					</dd>
				</dl>
			</logic:iterate>
			</logic:notEmpty>
			</div>
			<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="makeExpertJDH()">生成专家鉴定函</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="newJDH()">新建鉴定函</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
			</div>
	</form>
</div>
		