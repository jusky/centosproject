package com.whu.tools.filter;

import java.io.IOException;

import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptAndExpertFilter implements Filter {
	
   protected Pattern allow = null;
   protected Pattern intranet = null;
   protected int dennyStatus = HttpServletResponse.SC_FORBIDDEN;
	 
   public void init( FilterConfig filterConfig) {
	   
	   setAllow(filterConfig.getInitParameter("allow"));
	   setIntranet(filterConfig.getInitParameter("intranet"));
    }
   
	public void destroy() {
		
	}
  
	/**
	 *  
	 */
   public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) 
		   throws IOException, ServletException {
	   
	   HttpServletRequest req = (HttpServletRequest)request;
	   
	   if (isAllowed(request.getRemoteAddr(), req.getRequestURI().substring(req.getContextPath().length()))) {
		   chain.doFilter(request, response);
	   } else {
		   ((HttpServletResponse)response).sendError(dennyStatus);
	   	}
    }
    
   private boolean isAllowed(String ip, String uri) {
	    
	   if (intranet == null || intranet.matcher(ip).matches()) {
	    	return true;
	    }
	   
	   if (allow != null && allow.matcher(uri).matches()) {
		   return true;
	   }
	   
	   return false;
   	}
   
     
   private void setAllow(String allow) {
	   
	   if (allow == null || allow.length() == 0) {
		   this.allow = null;
	   } else {
		   this.allow = Pattern.compile(allow);
	   }
   	}
  
   private void setIntranet(String intranet) {
	   if(intranet == null || intranet.length() == 0) {
		   this.intranet = null;
	   } else {
		   this.intranet = Pattern.compile(intranet);
	   }
   }
}