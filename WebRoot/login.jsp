<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>国家自然科学基金委员会监督委员会</title>
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
              		}
              		else{
                		window.alert("所请求的页面有异常");
              		}
            	}
          }
    function login(){
   		var username = document.getElementById("usename").value;
   		var password = document.getElementById("password").value;
   		send('<%=path%>/servlet/LoginServlet?username=' + username + '&password=' + password);
    }
    document.onkeydown = function() {
    	if(window.event.keyCode=='13') login();
    }
</script>
	
</head>

<body class="conatrainer">
<div class="main">
  <div class="header">
  	<a href="#"><img src="<%=path %>/images/top_logo.jpg" alt="监督委员会科研不端行为管理平台" width="573" height="62" /></a>
  </div><!--// header-->
  <div class="content">
    <div class="earth"><img src="<%=path %>/images/logo_gp.jpg" alt="地球" width="564" height="240" /></div>
    <div class="login">
    <form id="form-login" action="" method="post">
      <div class="formarea">
        <ul>
	        <li class="user"><p>用户名</p><input type="text" id="usename" name="usename" value=""/></li>
	        <li class="pass"><p>密&nbsp;&nbsp;&nbsp;&nbsp;码</p><input type="password" id="password" name="password" value=""/></li>
        </ul>
      </div>
    </form>
    <div class="buttonActive">
      <input type="image" name="submit" src="<%=path %>/images/loginbuttonbg.png" onclick="login();" />
    </div>
    <span class="error" id="msg"></span>
    </div><!--login结束 -->
     <div class="footer"><p>Copyright 国家自然科学基金委员会 All Rights Reserved</p></div>
  </div><!--content结束 -->
 
</div><!--main结束 -->
</body>
</html>