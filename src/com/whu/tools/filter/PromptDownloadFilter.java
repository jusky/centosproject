package com.whu.tools.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class PromptDownloadFilter implements Filter {

	protected FilterConfig filterConfig;
	
	public void destroy() {
				
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {		
		
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		
		String fileName = httpRequest.getRequestURI().substring(httpRequest.getRequestURI().lastIndexOf("/") + 1);
		httpResponse.setHeader("Content-Type", "application/octet-stream");
		httpResponse.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}
	

}
