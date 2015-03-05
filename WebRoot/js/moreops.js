 	function getAbsolutePos(el)  
    {  
        var SL = 0, ST = 0;  
        var is_div = /^div$/i.test(el.tagName);  
        if (is_div && el.scrollLeft)  
            SL = el.scrollLeft;  
        if (is_div && el.scrollTop)  
            ST = el.scrollTop;  
        var r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };  
        if (el.offsetParent)  
        {  
            var tmp = this.getAbsolutePos(el.offsetParent);   
            r.x += tmp.x;  
            r.y += tmp.y;  
        }  
        return r;  
    }
 	
document.body.onclick = function(e){
     e = e || window.event;
      var target = e.target || e.srcElement;
     if(target.id == "ladcjd_box" || target.id == "cljd_box"  || target.id == "sljd_box"  || target.id == "meet_box" || target.id == "mail_box"|| target.id == "all_box") {
         return;
     } else {
    	 var obj = document.getElementById("ladcjd_box");
    	 if(obj != null)
    	 {
    		 obj.style.display = "none";
    	 }
    	 obj = document.getElementById("cljd_box");
    	 if(obj != null)
    	 {
    		 obj.style.display = "none";
    	 }
    	 obj = document.getElementById("sljd_box");
    	 if(obj != null)
    	 {
    		 obj.style.display = "none";
    	 }
    	 obj = document.getElementById("meet_box");
    	 if(obj != null)
    	 {
    		 obj.style.display = "none";
    	 }
    	 obj = document.getElementById("mail_box");
    	 if(obj != null)
    	 {
    		 obj.style.display = "none";
    	 }
    	 obj = document.getElementById("all_box");
    	 if(obj != null)
    	 {
    		 obj.style.display = "none";
    	 }
     }
}