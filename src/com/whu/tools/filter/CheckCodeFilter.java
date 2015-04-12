package com.whu.tools.filter;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public class CheckCodeFilter implements Filter {
	
	protected FilterConfig filterConfig;
	private String[] checkActions = new String[]{"/newJBAction.do", "/fkSearchAction.do", "/sendEmailAction.do", "/newAdviceAction.do"};
	private String[] checkTypes = new String[]{"input", "search", "email", "advice"};
	
	public void init( FilterConfig filterConfig) {
		this.filterConfig = filterConfig;
	}
	
	public void doFilter( ServletRequest request, ServletResponse response, FilterChain chain) 
		throws IOException, ServletException {
		
		HttpServletRequest req= (HttpServletRequest)request;
		String requestUrl = req.getRequestURI();
		
		String pageType = requestUrl.substring(requestUrl.lastIndexOf("/"));
		for(int i = 0; i < checkActions.length; i++) {
			if(pageType.equals(checkActions[i])) {
				Boolean checked = (Boolean)req.getSession().getAttribute(checkTypes[i] + "randChecked");
				if(checked == null || !checked.equals(true)) {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/wsjb/online/wsjb_" + checkTypes[i] + ".jsp");
					dispatcher.forward(request, response);
					return;
				} else {
					req.getSession().setAttribute(checkTypes[i] + "randChecked", false);
					chain.doFilter(request, response);
					return;
				}
			}
		}
		chain.doFilter(request, response);
	}
	
	
	public void destroy() {
		
	}
}
