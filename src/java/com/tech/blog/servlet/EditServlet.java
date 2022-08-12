
package com.tech.blog.servlet;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String userEmail=request.getParameter("user_email");
            String userName=request.getParameter("user_name");
            String userPassword=request.getParameter("user_password");
            String userAbout=request.getParameter("user_about");
            
            Part part = request.getPart("image");
            String imageName=part.getSubmittedFileName();
            
            //get the user form the session...............
            
            HttpSession s=request.getSession();
            User user = (User)s.getAttribute("currentUser");
            
            user.setName(userName);
            user.setEmail(userEmail);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile=user.getProfile();
            user.setProfile(imageName);
            
            //Update database.....................
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            
            boolean ans=userDao.updateUser(user);
            if(ans) {
                
                String path = request.getRealPath("/")+"pics"+File.separator+user.getProfile();
                
                String pathOldFile = request.getRealPath("/")+"pics"+File.separator+user.getProfile();
                if(!oldFile.equals("default.png")) {
                    Helper.deleteFile(pathOldFile);
                }               
                    if(Helper.saveFile(part.getInputStream(), path)) {
                        Message msg = new Message("Profile details updated ", "error", "alert-success");
                        s.setAttribute("msg", msg);
                    } else {
                        Message msg = new Message("something went wrong ", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                    }
            } else {
                out.println("Not updated");
                Message msg = new Message("Invalid details ! ", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }
            
            response.sendRedirect("profile.jsp");
            
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
