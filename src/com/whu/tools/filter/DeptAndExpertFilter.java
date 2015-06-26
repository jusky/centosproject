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
import javax.servlet.http.HttpSession;

public class DeptAndExpertFilter implements Filter {
	
   protected Pattern allow = null;
   protected Pattern intranet = null;
   protected Pattern special = null;
   protected int dennyStatus = HttpServletResponse.SC_FORBIDDEN;
	 
   public void init( FilterConfig filterConfig) {
	   
	   setAllow(filterConfig.getInitParameter("allow"));
	   setIntranet(filterConfig.getInitParameter("intranet"));
	   setSpecial(filterConfig.getInitParameter("special"));
    }
   
	public void destroy() {
		
	}
  
	/**
	 *  
	 */
   public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) 
		   throws IOException, ServletException {
	   
	   HttpServletRequest req = (HttpServletRequest)request;
	   
	   if (isAllowed(request.getRemoteAddr(), req.getRequestURI().substring(req.getContextPath().length()), ((HttpServletRequest)request).getSession(true))) {
		   chain.doFilter(request, response);
	   } else {
		   ((HttpServletResponse)response).sendError(dennyStatus);
	   	}
    }
    
   private boolean isAllowed(String ip, String uri, HttpSession session) {
	    
	   if (intranet == null || intranet.matcher(ip).matches()) {
	    	return true;
	    }
	   
	   if (allow != null && allow.matcher(uri).matches()) {
		   return true;
	   }
	   
	   if (special != null && special.matcher(uri).matches() ) {
		   session.setAttribute("warnout", "1");
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
  
   private void setSpecial(String special) {
	   if(special == null || special.length() == 0) {
		   this.special = null;
	   } else {
		   this.special = Pattern.compile(special);
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