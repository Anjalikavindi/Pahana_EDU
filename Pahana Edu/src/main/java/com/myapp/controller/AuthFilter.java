//package com.myapp.controller;
//
//import javax.servlet.*;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.*;
//import java.io.IOException;
//
//@WebFilter("/Views/*")
//public class AuthFilter implements Filter {
//	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest request = (HttpServletRequest) req;
//        HttpServletResponse response = (HttpServletResponse) res;
//
//        HttpSession session = request.getSession(false);
//        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);
//        String loginURI = request.getContextPath() + "/Views/Login.jsp";
//
//        if (loggedIn || request.getRequestURI().equals(loginURI) || request.getRequestURI().contains("/LoginServlet")) {
//            chain.doFilter(request, response);
//        } else {
//            response.sendRedirect(loginURI);
//        }
//    }
//}