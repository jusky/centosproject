<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@ page import="com.whu.web.user.ModuleBean" %>
<%
ModuleBean mb = (ModuleBean)request.getSession().getAttribute("ModuleBean");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=7" />
		<title>科学基金不端行为管理系统</title>
<style>
.box_content {clear:both; overflow:hidden;}
.box_content a:link{text-decoration:none;}
.r_comments{position:relative; height:300px;}
.r_comments ul{list-style:none outside none; margin-left:0px;}
.r_comments ul li{padding:5px 10px; line-height:20px; border-bottom:1px dashed #66CCCC;}
.r_comments li img{background:#FFF; border:1px solid#999; height:32px; float:left; padding:1px; margin:4px 4px 0 0;}
</style>

<link href="<%=path%>/dwz/themes/default/style.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%=path%>/dwz/themes/css/core.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%=path%>/dwz/themes/css/print.css" rel="stylesheet" type="text/css" media="print"/>
<link href="<%=path%>/dwz/uploadify/css/uploadify.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/styles/ops.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/styles/cs.css" rel="stylesheet" type="text/css">

<link href="<%=path%>/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
<!--[if IE]>
<link href="<%=path%>/dwz/themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
<![endif]-->

<!--[if lte IE 9]>
<script src="<%=path%>/dwz/js/speedup.js" type="text/javascript"></script>
<![endif]-->

<script src="<%=path%>/dwz/js/jquery-1.7.2.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/jquery.cookie.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/jquery.validate.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/jquery.bgiframe.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/xheditor/xheditor-1.2.1.min.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/xheditor/xheditor_lang/zh-cn.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/uploadify/scripts/jquery.uploadify.v2.1.4.min.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/uploadify/scripts/swfobject.js" type="text/javascript"></script>

<!-- svg图表  supports Firefox 3.0+, Safari 3.0+, Chrome 5.0+, Opera 9.5+ and Internet Explorer 6.0+ 
<script type="text/javascript" src="<%=path%>/dwz/chart/raphael.js"></script>
<script type="text/javascript" src="<%=path%>/dwz/chart/g.raphael.js"></script>
<script type="text/javascript" src="<%=path%>/dwz/chart/g.bar.js"></script>
<script type="text/javascript" src="<%=path%>/dwz/chart/g.line.js"></script>
<script type="text/javascript" src="<%=path%>/dwz/chart/g.pie.js"></script>
<script type="text/javascript" src="<%=path%>/dwz/chart/g.dot.js"></script>   -->

<script src="<%=path%>/dwz/js/dwz.core.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.util.date.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.validate.method.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.regional.zh.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.barDrag.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.drag.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.tree.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.accordion.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.ui.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.theme.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.switchEnv.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.alertMsg.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.contextmenu.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.navTab.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.tab.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.resize.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.dialog.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.dialogDrag.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.sortDrag.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.cssTable.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.stable.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.taskBar.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.ajax.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.pagination.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.database.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.datepicker.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.effects.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.panel.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.checkbox.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.history.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.combox.js" type="text/javascript"></script>
<script src="<%=path%>/dwz/js/dwz.print.js" type="text/javascript"></script>

<script src="<%=path%>/ztree/js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="<%=path%>/ztree/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>

<!--
<script src="<%=path%>/dwz/bin/dwz.min.js" type="text/javascript"></script>
-->
<script src="<%=path%>/dwz/js/dwz.regional.zh.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/scripts/jquery.noty.js"></script>
<script type="text/javascript" src="<%=path%>/scripts/bottomRight.js"></script>
<script type="text/javascript" src="<%=path%>/scripts/default.js"></script>


<logic:equal value="1" name="Identity" scope="session">
<script src="<%=path%>/Charts/FusionCharts.js" type="text/javascript"></script> 
<script type="text/javascript">
  function generate(str) {
  	var n = noty({
  		text: str,
  		type: 'alert',
        dismissQueue: true,
  		layout: 'bottomRight',
  		theme: 'defaultTheme'
  	});
  }
  
  $(document).ready(function() {
	checkNormal();
  });
	var XMLHttpReq=false;
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
	function check(typeStr) 
	{
		var myurl="<%=path%>/servlet/TimerServlet?type=" + typeStr; 
		createXMLHttpRequest();
        XMLHttpReq.open("post",myurl,true);
        XMLHttpReq.onreadystatechange=ValidateCallBack;   //指定响应的函数
        XMLHttpReq.send(null);  //发送请求
	} 
	function checkNormal() 
	{ 
	  check('normal');
	  window.setTimeout("checkNormal()",60000); 
	} 
	function ValidateCallBack() 
	{ 
	    if (XMLHttpReq.readyState == 4) 
		{ 
	      if (XMLHttpReq.status == 200) 
	      { 
		  		var result=XMLHttpReq.responseText;  
		        if(result.indexOf("提醒:")==0) 
		        { 
		            generate(result);
		        } 
			} 
		  else 
		  { 
		  
		  } 
	    }
	}
	
	function myJDJS(id)
	{
		var obj = document.getElementById("jdtjURL");
		obj.innerHTML=getJDName(id);
		obj.href="<%=path%>/eventManageAction.do?method=init&jdid="+id;
		obj.click();
	}
	function getJDName(status)
	{
		var result="";
		if(status == "1")
		{
			result = "受理阶段";
		}
		else if(status == "2")
		{
			result = "立案调查阶段";
		}
		else if(status == "3")
		{
			result = "处理阶段";
		}
		return result;
	}
</script> 
<script type="text/javascript">
$(function(a) {
    a(function() {
        var b;
        a("#rcslider").hover(function() {
            clearInterval(b)
        },
        function() {
            b = setInterval(function() {
                var b = a("#rcslider"),
                c = b.find("li:last").height();
                b.animate({
                    marginTop: c + 3 + "px"
                },
                1e3,
                function() {
                    b.find("li:last").prependTo(b),
                    b.find("li:first").hide(),
                    b.css({
                        marginTop: 0
                    }),
                    b.find("li:first").fadeIn(1e3)
                })
            },
            3e3)
        }).trigger("mouseleave")
    }),
    a(document).ready(function() {
        a("#rcslider li").css({
            opacity: ".6"
        }),
        a("#rcslider li").hover(function() {
            a(this).stop().fadeTo(300, 1)
        },
        function() {
            a(this).stop().fadeTo(300, .6)
        })
    })
});
</script>
</logic:equal>
<script type="text/javascript">
$(function(){
	DWZ.init("<%=path%>/dwz/dwz.frag.xml", {
		loginUrl:"login_dialog.jsp", loginTitle:"登录",	// 弹出登录对话框
		pageInfo:{pageNum:"currentPage", numPerPage:"pageSize", orderField:"orderField", orderDirection:"orderDirection"}, //【可选】
		debug:false,	// 调试模式 【true|false】
		callback:function(){
			initEnv();
			$("#themeList").theme({themeBase:"<%=path%>/dwz/themes"}); // themeBase 相对于index页面的主题base路径
		}
	});
});
</script>
</head>
<body scroll="no">
	<div id="layout">
		<div id="header">
			<div class="headerNav">
				<a class="logo" href="#">标志</a>
				<ul class="nav">
					<li><a href = "#"><%=request.getSession().getAttribute("UserName") %></a></li>
					<li><a href="<%=path%>/web/changePwd.jsp" target="dialog" width="450" height="230" title="修改密码">修改密码</a></li>
					<!-- <li><a href="<%=path%>/login.jsp">退出</a></li>  -->
					<li><a href="<%=path%>/servlet/LogoutServlet">退出</a></li>
				</ul>
				<ul class="themeList" id="themeList">
					<li theme="default"><div class="selected">蓝色</div></li>
					<li theme="green"><div>绿色</div></li>
					<!--<li theme="red"><div>红色</div></li>-->
					<li theme="purple"><div>紫色</div></li>
					<li theme="silver"><div>银色</div></li>
					<li theme="azure"><div>天蓝</div></li>
				</ul>
			</div>

			<!-- navMenu -->
			
		</div>

		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse"><div></div></div>
				</div>
			</div>
			<div id="sidebar">
				<logic:notEmpty name="loginForm" property="recordList">
     		<logic:iterate name="loginForm" property="recordList" id="ModuleBean">
				<div class="toggleCollapse"><h2>主菜单</h2><div>收缩</div></div>
				<div class="accordion" fillSpace="sidebar">
				<logic:notEqual value="0" name="ModuleBean" property="grbg">
					<div class="accordionHeader">
						<h2><span>Folder</span>个人办公</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<logic:notEqual value="0" name="ModuleBean" property="wsjb">
							<li><a href="<%=path%>/wsjbManageAction.do?method=init" target="navTab" rel="wsjb">网上举报</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="sjlr">
							<li><a href="<%=path%>/newEventAction.do?method=init" target="navTab" rel="newEvent">事件录入</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="sjsp">
							<li><a href="<%=path%>/eventManageAction.do?method=init&jdid=4" target="navTab" rel="myDealEvent">事件审批</a></li>
							</logic:notEqual>
							<!-- 
							<li><a href="<%=path%>/myStartEventAction.do?method=init" target="navTab" rel="myEvent">我参与的事件</a></li>
							 -->
							<!-- 
							<li><a href="<%=path%>/web/date/myDate.jsp" target="navTab" rel="myDate">我的日程</a></li>
							-->
							
							
							<logic:notEqual value="0" name="ModuleBean" property="sjgl">
							<li><a>事件管理</a>
								<ul>
									<logic:notEqual value="0" name="ModuleBean" property="sljd">
									<li><a href="<%=path%>/eventManageAction.do?method=init&jdid=1" target="navTab" rel="sljd">受理阶段</a></li>
									</logic:notEqual>
									<logic:notEqual value="0" name="ModuleBean" property="ladcjd">
									<li><a href="<%=path%>/eventManageAction.do?method=init&jdid=2" target="navTab" rel="ladcjd">调查阶段</a></li>
									</logic:notEqual>
									<logic:notEqual value="0" name="ModuleBean" property="cljd">
									<li><a href="<%=path%>/eventManageAction.do?method=init&jdid=3" target="navTab" rel="cljd">处理阶段</a></li>
									</logic:notEqual>
									<logic:notEqual value="0" name="ModuleBean" property="qbsj">
									<li><a href="<%=path%>/eventManageAction.do?method=init&jdid=9" target="navTab" rel="allEvent">全部事件</a></li>
									</logic:notEqual>
									<!-- 
									<logic:notEqual value="0" name="ModuleBean" property="yscsj">
									<li><a href="<%=path%>/eventManageAction.do?method=init&jdid=8" target="navTab" rel="deleteEvent">已删除事件</a></li>
									</logic:notEqual>
									 -->
								</ul>
							</li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="hygl">
							<li><a href="<%=path%>/meetManageAction.do?method=init" target="navTab" rel="hygl">会议管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="sjtj">
							<li><a href="<%=path%>/tjManageAction.do?method=init" target="navTab" rel="tjInfo">事件统计</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="yjgl">
							<li><a>邮件管理</a>
								<ul>
									<logic:notEqual value="0" name="ModuleBean" property="fsyj">
									<li><a href="<%=path%>/newMailAction.do?method=init" target="navTab" rel="newEmail">发送邮件</a></li>
									</logic:notEqual>
									<!-- 
									<li><a href="<%=path%>/mailManageAction.do?method=init" target="navTab" rel="outEmail">外部邮件</a></li>
									 -->
									 <logic:notEqual value="0" name="ModuleBean" property="yxpzgl">
									<li><a href="<%=path%>/mailManageAction.do?method=init" target="navTab" rel="emailConfig">邮件配置管理</a></li>
									</logic:notEqual>
									<logic:notEqual value="0" name="ModuleBean" property="txl">
									<li><a href="<%=path%>/addressBookAction.do?method=init" target="navTab" rel="addressBook">通讯录</a></li>
									</logic:notEqual>
								</ul>
							</li>
							</logic:notEqual>
							<!-- 
							<li><a>内部消息</a>
								<ul>
									<li><a href="<%=path%>/msgListAction.do?method=init" target="navTab" rel="recvMsg">收到的消息</a></li>
									<li><a href="<%=path%>/web/message/sendMsg.jsp" target="navTab" rel="sendMsg">发送消息</a></li>
									<li><a href="<%=path%>/sendMsgListAction.do?method=init" target="navTab" rel="sendMsgList">已发送消息</a></li>
								</ul>
							</li>
							 -->
						</ul>
					</div>
					</logic:notEqual>
				
					<logic:notEqual value="0" name="ModuleBean" property="credit">
					<div class="accordionHeader">
						<h2><span>Folder</span>科研诚信管理</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<logic:notEqual value="0" name="ModuleBean" property="miscount">
							<li><a href="<%=path%>/miscountManageAction.do?method=init" target="navTab" rel="miscountManage">不端行为记录管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="institute">
							<li><a href="<%=path%>/instituteManageAction.do?method=init" target="navTab" rel="instituteManage">科研机构管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="reasearcher">
							<li><a href="<%=path%>/individualManageAction.do?method=init" target="navTab" rel="individualManage">科研人员管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="mistype">
							<li><a href="<%=path%>/mistypeManageAction.do?method=init" target="navTab" rel="mistypeManage">诚信影响因素管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="punish">
							<li><a href="<%=path%>/punishManageAction.do?method=init" target="navTab" rel="punishManage">处理措施管理</a></li>
							</logic:notEqual>
						</ul>
					</div>
					</logic:notEqual>
					
					
					<logic:notEqual value="0" name="ModuleBean" property="yhzzgl">
					<div class="accordionHeader">
						<h2><span>Folder</span>用户组织管理</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<logic:notEqual value="0" name="ModuleBean" property="zzgl">
							<li><a href="<%=path%>/zzManageAction.do?method=init" target="navTab" rel="zzManage">组织管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="gwgl">
							<li><a href="<%=path%>/posManageAction.do?method=init" target="navTab" rel="gwManage">岗位管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="yhgl">
							<li><a href="<%=path%>/userManageAction.do?method=init" target="navTab" rel="userManage">用户管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="jsgl">
							<li><a href="<%=path%>/roleManageAction.do?method=init" target="navTab" rel="roleManage">角色管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="zjgl">
							<li><a href="<%=path%>/expertManageAction.do?method=init" target="navTab" rel="expertManage">专家管理</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="wygl">
							<li><a href="<%=path%>/wyManageAction.do?method=init" target="navTab" rel="wyManage">委员管理</a></li>
							</logic:notEqual>
						</ul>
					</div>
					</logic:notEqual>
					<logic:notEqual value="0" name="ModuleBean" property="xtgl">
					<div class="accordionHeader">
						<h2><span>Folder</span>系统管理</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<!-- 
							<li><a href="<%=path%>/logManageAction.do?method=init" target="navTab" rel="zyManage">资源管理</a></li>
							 -->
							 <logic:notEqual value="0" name="ModuleBean" property="sjzd">
							<li><a href="<%=path%>/dicManageAction.do?method=init" target="navTab" rel="dataDic">数据字典</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="xtfj">
							<li><a href="<%=path%>/attachManageAction.do?method=init" target="navTab" rel="sysAcc">系统附件</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="xtrz">
							<li><a href="<%=path%>/logManageAction.do?method=init" target="navTab" rel="sysLog">系统日志</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="mygl">
							<li><a href="<%=path%>/keyManageAction.do?method=init" target="navTab" rel="secret">密钥管理</a></li>
							</logic:notEqual>
						</ul>
					</div>
					</logic:notEqual>
					<logic:notEqual value="0" name="ModuleBean" property="jdzj">
					<div class="accordionHeader">
						<h2><span>Folder</span>鉴定专家</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<logic:notEqual value="0" name="ModuleBean" property="zjxx">
								<li><a href="<%=path%>/expertFKManageAction.do?method=expertInfo" target="navTab" rel="zjxx">专家信息</a></li>
							</logic:notEqual>
							<logic:notEqual value="0" name="ModuleBean" property="ajjd">
								<li><a href="<%=path%>/expertFKManageAction.do?method=eventList" target="navTab" rel="ajjd">案件鉴定</a></li>
							</logic:notEqual>
						</ul>
					</div>
					</logic:notEqual>
					<logic:notEqual value="0" name="ModuleBean" property="ytdw">
					<div class="accordionHeader">
						<h2><span>Folder</span>依托单位</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<logic:notEqual value="0" name="ModuleBean" property="ajdc">
								<li><a href="<%=path%>/deptFKManageAction.do?method=eventList" target="navTab" rel="ajdc">案件调查</a></li>
							</logic:notEqual>
						</ul>
					</div>
					</logic:notEqual>
					
					
					<logic:notEqual value="0" name="ModuleBean" property="faculty">
					<div class="accordionHeader">
						<h2><span>Folder</span>学部</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<logic:notEqual value="0" name="ModuleBean" property="xbyj">
								<li><a href="<%=path%>/facultyFKAction.do?method=init" target="navTab" rel="xbyj" title="学部意见">学部意见</a></li>
							</logic:notEqual>
						</ul>
					</div>
					</logic:notEqual>
					
				</div>
				</logic:iterate>
				</logic:notEmpty>
			</div>
		</div>
		<div id="container">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent"><!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
							<li tabid="main" class="main"><a href="javascript:;"><span><span class="home_icon">我的主页</span></span></a></li>
						</ul>
					</div>
					<div class="tabsLeft">left</div><!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
					<div class="tabsRight">right</div><!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
					<div class="tabsMore">more</div>
				</div>
				<ul class="tabsMoreList">
					<li><a href="javascript:;">我的主页</a></li>
				</ul>
				<div class="navTab-panel tabsPageContent layoutBox">
					<div class="pageContent">
						<div class="pageFormContent" layoutH="20">
						<logic:notEmpty name="loginForm" property="recordList">
     					<logic:iterate name="loginForm" property="recordList" id="ModuleBean">
     						<logic:equal value="0" name="ModuleBean" property="userType">
     						<a id="jdtjURL" href="" style="display:none;" target="navTab" rel="jdtj">状态统计</a>
							 <div style="float:left; display:block; overflow:auto; width:480px; line-height:21px;">
								<div class="panel" defH="300">
									<h1>网上举报</h1>
									<div class="box_content r_comments">
										<ul style="margin-top: 0px;" id="rcslider">
										<logic:notEmpty name="loginForm" property="wsjbList">
     										<logic:iterate name="loginForm" property="wsjbList" id="WsjbInfo">
     											 <li style="opacity: 0.6;">
											      	<bean:write name="WsjbInfo" property="time"/>&nbsp;&nbsp;&nbsp;&nbsp;举报者：<bean:write name="WsjbInfo" property="reportName"/><br/>
											 		<a href="<%=path%>/wsjbManageAction.do?method=detail&id=${WsjbInfo.id }" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">被举报人：<bean:write name="WsjbInfo" property="beReportName"/></a>
											      </li>
     										</logic:iterate>
     									</logic:notEmpty>		      
									    </ul>
									</div>
								</div>
							</div>
							
							<div style="float:left; display:block; overflow:auto; width:480px; line-height:21px;">
								<div class="panel" defH="300">
									<h1>阶段统计</h1>
									<div>
										<div id="jdChartXml" style="display:none;"><%=request.getAttribute("jdChartXml") %></div>
										<div id="jdChartContainer" align="center">
											<script type="text/javascript">	
												var myChart = new FusionCharts( "<%=path%>/Charts/Column3D.swf", 
												"jdChartId", "440", "300", "0" ); 
												var chartXMLObj = document.getElementById("jdChartXml");
												
												var chartXML = chartXMLObj.innerHTML;
												 myChart.setDataXML(chartXML);
												 myChart.render("jdChartContainer");
											</script>
										</div>
									</div>
								</div>
							</div>
							
							<div style="float:left; display:block; overflow:auto; width:480px; line-height:21px;">
								<div class="panel" defH="300">
									<h1>待办事项</h1>
									<div class="box_content r_comments">
										<ul style="margin-top: 0px;">
										<logic:notEmpty name="loginForm" property="dbsxList">
     										<logic:iterate name="loginForm" property="dbsxList" id="MsgNotifyBean">
     											 <li style="opacity: 0.6;">
     											 	<a href="<%=path%>/eventManageAction.do?method=gyMethod&type=approve&id=${MsgNotifyBean.reportID }" mask="true" target="dialog" rel="approveEvent" width="850" height="540" title="审核"><img alt="审核事件" src="<%=path %>/images/approve.jpg" class="avatar avatar-32 photo" height="32" width="32"></a>
											      	<bean:write name="MsgNotifyBean" property="sendTime"/>&nbsp;&nbsp;&nbsp;&nbsp;发起者：<bean:write name="MsgNotifyBean" property="sendName"/><br/>
											 		待办内容：<bean:write name="MsgNotifyBean" property="type"/>
											      </li>
     										</logic:iterate>
     									</logic:notEmpty>		      
									    </ul>
									</div>
								</div>
							</div>
							
							<div style="float:left; display:block; overflow:auto; width:480px; line-height:21px;">
								<div class="panel" defH="300">
									<h1>最新反馈事件&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=path%>/eventFKAction.do?method=init" target="navTab" rel="eventFK" title="反馈事件">更多>></a></h1>
									<div class="box_content r_comments">
										<ul style="margin-top: 0px;">
										<logic:notEmpty name="loginForm" property="replyList">
     										<logic:iterate name="loginForm" property="replyList" id="ReplyInfo">
     											 <li style="opacity: 0.6;">
											      	<bean:write name="ReplyInfo" property="time"/>&nbsp;&nbsp;&nbsp;&nbsp;反馈者：<bean:write name="ReplyInfo" property="fkName"/><br/>
											 		<a href="<%=path%>/eventManageAction.do?method=detail&id=${ReplyInfo.reportID }" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">反馈类型：<bean:write name="ReplyInfo" property="type"/></a>
											      </li>
     										</logic:iterate>
     									</logic:notEmpty>		      
									    </ul>
									</div>
								</div>
							</div>
     						</logic:equal>
     						<logic:equal value="1" name="ModuleBean" property="userType">
     							<iframe src="<%=path%>/web/date/time.jsp" width="100%" frameborder="0" height="100%" name="show"></iframe>
     						</logic:equal>
     						<logic:equal value="2" name="ModuleBean" property="userType">
     							<iframe src="<%=path%>/web/date/time.jsp" width="100%" frameborder="0" height="100%" name="show"></iframe>
     						</logic:equal>
     						<logic:equal value="3" name="ModuleBean" property="userType">
     							<div style="float:left; display:block; overflow:auto; width:600px; line-height:21px;">
								<div class="panel" defH="480">
									<h1>待办事项<a style="margin-left:460px; color:#aaccff" href="<%=path%>/facultyFKAction.do?method=queryMsg&operation=search&isfk=0"  target="navTab" rel="xbyj" title="学部意见">更多 >></a></h1>
									<div class="box_content r_comments">
										<ul style="margin-top: 0px;">
										<logic:notEmpty name="loginForm" property="dbsxList">
     										<logic:iterate name="loginForm" property="dbsxList" id="MsgNotifyBean">
     											 <li style="opacity: 0.6;">
     											 	<a  class="btnEdit" href="<%=path%>/facultyFKAction.do?method=editFacultyAdvice&reportId=${MsgNotifyBean.reportID }" mask="true" target="dialog" rel="facultyFK" width="850" height="540" title="学部意见"></a>
											      	<bean:write name="MsgNotifyBean" property="sendTime"/>&nbsp;&nbsp;&nbsp;&nbsp;发起者：<bean:write name="MsgNotifyBean" property="sendName"/><br/>
											 		待办内容：<bean:write name="MsgNotifyBean" property="type"/>
											      </li>
     										</logic:iterate>
     									</logic:notEmpty>	
     									<logic:empty name="loginForm" property="dbsxList">
     										<li style="opacity: 0.6">无待办事项</li>
     									</logic:empty>	      
									    </ul>
									</div>
								</div>
								</div>
     						</logic:equal>
     					</logic:iterate>
     					</logic:notEmpty>
						
						</div>
					</div>
				</div>
		</div>
	</div>
	</div>

	<div id="footer">Copyright &copy; 2013 <a href="/NSFCOSC/index.html" target="_blank">国家自然科学基金委员会监督委员会</a></div>
</body>
</html>