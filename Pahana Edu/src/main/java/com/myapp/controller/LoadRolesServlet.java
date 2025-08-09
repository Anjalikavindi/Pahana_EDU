package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.util.List;

import com.myapp.dao.RoleDAO;


@WebServlet("/LoadRolesServlet")
public class LoadRolesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RoleDAO roleDAO;
    
    public LoadRolesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    @Override
    public void init() {
        roleDAO = new RoleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<String> roleList = roleDAO.getAllRoleNames();
        request.setAttribute("roleList", roleList);

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Views/AddEmployee.jsp");
        dispatcher.forward(request, response);
    }

}
