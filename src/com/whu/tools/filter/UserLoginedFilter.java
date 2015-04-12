package com.whu.tools.filter;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterConfig;
import javax.servlet.FilterChain;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLoginedFilter implements Filter {
	
	protected Pattern allow = null; // always allowed URIs
	protected Pattern protect = null; // uris only logined user access, null means all protected
	
	public void init(FilterConfig filterConfig) throws ServletException {
		
		setAllow(filterConfig.getInitParameter("allow"));
		setProtect(filterConfig.getInitParameter("protect"));
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		
		if (isAllowed(req.getRequestURI().substring(req.getContextPath().length()), (String)req.getSession().getAttribute("LoginName"))) {
			chain.doFilter(request, response);
		} else {
			((HttpServletResponse)response).sendRedirect(req.getContextPath() + "/login.jsp");
		}
	}
	
	
	private boolean isAllowed(String uri, String user) {
		if (user != null) {
			return true;
		}
		
		if (allow != null && allow.matcher(uri).matches()) {
			return true;
		}
		
		if (protect != null && !protect.matcher(uri).matches()) {
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
	
	private void setProtect(String protect) {
		if (protect == null || protect.length() == 0) {
			this.protect = null;
		} else {
			this.protect = Pattern.compile(protect);
		}
	}
	
	
	public void destroy() {
		
	}
	
}
