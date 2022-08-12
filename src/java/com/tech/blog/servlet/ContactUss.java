
package com.tech.blog.servlet;

import com.tech.blog.dao.Contactdao;
import com.tech.blog.entities.Contact;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class ContactUss extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String query = request.getParameter("query");
            
            Contact contact = new Contact(name, email, phone, query);
            
           //create Contactdao object.....
                Contactdao condao = new Contactdao(ConnectionProvider.getConnection());
                if(condao.saveContactDetails(contact)) {
                    out.println("Done");
                } else if(condao.saveContactDetails(contact) == false) {
                    out.println("Something went wrong");
                }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
