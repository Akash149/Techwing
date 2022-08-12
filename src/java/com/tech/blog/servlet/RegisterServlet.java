
package com.tech.blog.servlet;

import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String check = request.getParameter("check");
            if(check==null) {
                out.println("box not checked");
                 
            } else {
                String name = request.getParameter("u_name");
                String email = request.getParameter("u_email");
                String pass = request.getParameter("password");
                String gender = request.getParameter("gender");
                String about = request.getParameter("about");
                
                User user = new User(name,email,pass,gender,about);
                
                //create a useDao object
                UserDao dao = new UserDao(ConnectionProvider.getConnection());
                if(dao.saveUser(user) == true) {
                    out.println("done");
                    return;
                } 
                else {
                    out.println("User already registered! please login or try with another email");
                }
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
