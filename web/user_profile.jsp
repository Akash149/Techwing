 <%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<% 
    UserDao u = new UserDao(ConnectionProvider.getConnection());
    int userId = Integer.parseInt(request.getParameter("user_id"));
    User user = (User) u.getUserByUserId(userId);
 %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <ink href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
             rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" 
             crossorigin="anonymous">
        <link rel="stylesheet" href="bootstrap/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/userprofile.css" rel="stylesheet" type="text/css"/>
        <title><%= user.getName()%></title>
    </head>
    <body>
        <div class="card-container">
            <div class="upper-container">
                <div class="image-container">
                    <img src="pics/<%= user.getProfile() %>"/>
                </div>
            </div>               
            <div class="lower-container">
                <h2><%= user.getName() %></h2>
                <h4><%= user.getAbout() %></h4>
                <h4><%= user.getEmail() %></h4>
                <div class="container text-center">
                    <a href="index.jsp" style="border-radius: 50%" class="btn"><i class="fa-light fa-house-chimney"></i> Home</a>
                </div>
            </div>
        </div>
    </body>
</html>
