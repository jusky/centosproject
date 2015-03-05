package com.whu.web.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.Action;

public class BaseAction extends Action {
	private String encoding = "UTF-8";  
    private String contentType = "application/json";  
      
    /** 
     * to make JSON object that will be returned to the front-end and send it 
     *  
     * @param response response 
     * @param objName jsonObjectName 
     * @param obj object that is used to make jsonObject 
     * @throws IOException 
     */  
    protected void makeJSONObject(HttpServletResponse response, String objName, Object obj) throws IOException {  
  
        this.contentType = contentType + ";charset=" + encoding;  
          
        JSONObject jsonObj = new JSONObject();  
        jsonObj.put(objName, obj);
          
        response.setContentType(contentType);  
        response.setCharacterEncoding(encoding);  
        PrintWriter pw = response.getWriter();   
        pw.write(jsonObj.toString());  
        pw.flush();  
    }  
}
