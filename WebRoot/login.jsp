<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>科学基金科研诚信管理平台</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link href="<%=path %>/styles/login.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
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
            XMLHttpReq.open("post",encodeURI(url),true);
            XMLHttpReq.onreadystatechange=proce;   //指定响应的函数
            XMLHttpReq.send(null);  //发送请求
          }
          function proce(){        	 
   	 		if(XMLHttpReq.readyState==4){ //对象状态,收到完整的服务器响应
        		  if(XMLHttpReq.status==200){//信息已成功返回，HTTP服务器响应的值为OK   
                		var root=XMLHttpReq.responseText;
                		document.getElementById("msg").innerHTML=root;
                		if(("登录成功，即将转向管理页面！" == root)||("登录成功，即将转向管理页面！\n注意，你没有拥有任何权限!" == root)) {
                			window.location.href = "<%=path%>/loginAction.do?method=login";
                		}
                		else{
                		window.location.href = loadimage();
                		}
              		}
              		else{
                		window.alert("所请求的页面有异常");
              		}
            	}
          }
    function loadimage() {
    	//alert("aaa");
		document.getElementById("randImageId").src = "<%=path%>/web/image.jsp?page=input&"+Math.random();
		$("#checkCode").html("");
  }

    function login(){
   		var username = document.getElementById("usename").value;
   		var password = document.getElementById("password").value;
   		var temp = document.getElementById("randNum").value;
   		send('<%=path%>/servlet/LoginServlet?username=' + username + '&password=' + password+ '&page=input&code=' + temp);
    }
    document.onkeydown = function() {
    	if(window.event.keyCode=='13') login();
    }
    function func(){
    window.location.href = loadimage();
    }
    
</script>

</head>

<body class="conatrainer" onload="func()">
<div class="main">
  <div class="header">
  	<img src="<%=path %>/images/top_logo.jpg" alt="科学基金科研不端行为管理平台" width="573" height="62" />
  </div><!--// header-->
  <div class="content">
    <div class="earth"><img src="<%=path %>/images/logo_gp.jpg" alt="地球" width="564" height="240" /></div>
    <div class="login">
	    <form id="form-login" action="" method="post">
	      <div class="formarea">
	        <ul>
		        <li class="user"><p>用户名</p><input type="text" id="usename" name="usename"/></li>
		        <li class="pass"><p>密&nbsp;&nbsp;&nbsp;&nbsp;码</p><input type="password" id="password" name="password" autocomplete="off" value="NSFC123456"/></li>
	        	  <li class="prove"><p>验证码</p><input type="text" name="rand" id="randNum" autocomplete="off" size="10"/>&nbsp;<img alt="code..." name="randImage" id="randImageId" src="<%=path%>/web/image.jsp?page=input" width="75" height="22" border="1" onclick="loadimage();" style="cursor:pointer; vertical-align:middle"/></li>
	        	  <span id="checkCode"></span>
	        </ul>
	      </div>
	    </form>
	    <div class="buttonActive" align="center">
	      <input type="image" name="submit" src="<%=path %>/images/loginbuttonbg.png" onclick="login();" />
	    </div>
    	 <span class="error" id="msg"></span>
    </div><!--login结束 -->
     <div class="footer"><p>Copyright 国家自然科学基金委员会 All Rights Reserved</p></div>
  </div><!--content结束 -->
 
</div><!--main结束 -->
</body>
</html>