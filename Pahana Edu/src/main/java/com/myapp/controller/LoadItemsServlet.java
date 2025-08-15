package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import com.myapp.dao.ItemDAO;
import com.myapp.model.ItemBean;


@WebServlet("/LoadItemsServlet")
public class LoadItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public LoadItemsServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	ItemDAO itemDAO = new ItemDAO();
        List<ItemBean> items = itemDAO.getAllItems(); // Fetch all items

        request.setAttribute("itemsList", items); // Set as request attribute
        request.getRequestDispatcher("ManageItems.jsp").forward(request, response);
        
	}

}
