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
   function sendAjax(url){
     createXMLHttpRequest();
     XMLHttpReq.open("post",url,true);
     XMLHttpReq.onreadystatechange=proce;   //指定响应的函数
     XMLHttpReq.send(null);  //发送请求
   }
   function proce(){        	 
 		if(XMLHttpReq.readyState==4){ //对象状态,收到完整的服务器响应
 		  if(XMLHttpReq.status==200){//信息已成功返回，HTTP服务器响应的值为OK   
         		var root=XMLHttpReq.responseText;
         		if(root == "删除成功")
         		{
         			//jQuery('#attachUpload').uploadifyUpload();
         		}
         	}
       		else{
         		window.alert("所请求的页面有异常");
       		}
     	}
   }