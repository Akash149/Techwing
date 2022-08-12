
package com.tech.blog.servlet;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.SendLoginEmail;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String userEmail = request.getParameter("email");
            String userPassword = request.getParameter("password"); 
            
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            User u = dao.getUserByEmailandPassword(userEmail, userPassword);
            
            SendLoginEmail sendloginemail = new SendLoginEmail();
            
            if(u==null) {
                //out.println("Invalid details... try again");
                Message msg = new Message("Invalid details ! ", "error", "alert-danger");
                HttpSession s = request.getSession();
                s.setAttribute("msg", msg);
                response.sendRedirect("login_page.jsp");
                
            } else {
                HttpSession s = request.getSession();
                s.setAttribute("currentUser", u);
//                User user=(User)s.getAttribute("currentUser");
//                sendloginemail.setTo(user.getEmail());
//                sendloginemail.setSubject("Login alert!");
//                sendloginemail.setFrom("mr.iotdeveloper@gmail.com");
//                sendloginemail.setMessage("Hi, " + user.getName() + "\n" + "your are loggedIn\n");
//                sendloginemail.SendEmail();
                response.sendRedirect("profile.jsp");
                
            }  
            out.println("</body>");
            out.println("</html>");
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
