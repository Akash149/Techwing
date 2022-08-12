
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<% 
   User user = (User) session.getAttribute("currentUser");
   if(user == null) {
       response.sendRedirect("login_page.jsp");
   }
%>



<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    
    Post p = d.getPostByPostId(postId);
    
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getPtitle() %> || </title>
         <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>AtechWings
            .banner-background {
                clip-path: polygon(52% 0, 100% 0, 100% 100%, 75% 97%, 55% 100%, 29% 97%, 0 100%, 0 50%, 0 0);
            }
            
            body{
                text-align: center;
                background-size: cover;
                background-attachment: fixed;
            }
            
            .post-title{
                font-weight: 100;
                font-size: 30px;
                
            }
            
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            
            .post-user-info{
                font-size: 20px;
                font-weight: 200;
            }
            
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;   
            }
            
            .img img{
                width:350px;
                height: 300px;
            }
            
/*            .cards{
                padding: 10px;
                width: 350px;
                margin-top: 10px;
                overflow: hidden;
                margin-bottom: 20px;
            }*/
        </style>
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v13.0&appId=198138004106787&autoLogAppEvents=1" nonce="E3bu3VgZ"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk">
                </span>AtechWings
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                            
                    <li class="nav-item">
                        <a class="nav-link" href="contactus.jsp"><span class="fa fa-address-book-o"></span> Contact Us</a>
                    </li> 
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span> Do Post</a>
                    </li>
                </ul>      
                        <ul class="navbar-nav mr-right">
                            <li class="nav-item">
                                <image src="pics/<%= user.getProfile() %>" class="img-fluid" style="border-radius:50%; max-width: 40px;">
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"></span><%= " " + user.getName() %></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="LogoutServlet">Logout <span class="fa-regular fa-arrow-right-from-bracket"></span></a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>             
        </nav>
<!--                            Main content of body-->
        <div clas="container">
            <div class="row my-4">
                <div class="col-md-6 offset-md-3">
                    <div class="cards">
                        <div class="card-header">
                            <h4 class="post-title"><%= p.getPtitle()%></h4>
                        </div>
                        <div class="car-body">
                            <div class="img">
                                <img src="blog_pics/<%= p.getPpic() %>" alt="">
                             </div>
                             <div class="row my-3 row-user">
                                 <div class="col-md-8">
                                     <% 
                                        UserDao u = new UserDao(ConnectionProvider.getConnection());
                                     %>
                                    <p class="post-user-info"><a href="user_profile.jsp?user_id=<%= p.getUserid()%>"><%= u.getUserByUserId(p.getUserid()).getName()%> </a>has posted</p> 
                                 </div>
                                 <div class="col-md-4">
                                     <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getPdate()) %></p>
                                 </div>
                             </div>
                                <p class="post-content"><%= p.getPcontent()%></p>
                            <br><!-- comment -->
                            <br>
                            <div class="post-code">
                                <pre> <%= p.getPcode()%></pre>
                            </div>
                            
                        </div>
                        <div class="card-footer">
                            <% 
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                            %>
                            <a href="#!" onclick="doLike(<%= p.getPid()%> ,<%= user.getId() %> )" class="btn btn-outline-primary btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPOst(p.getPid())%></span> </a>
                            <a href="#!" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>20</span> </a>
                        </div>
                            
                        <div class="card-footer">
                            <div class="fb-comments" data-href="http://localhost:8080/TechwingBlog/show_blog_page.jsp?post_id=<%=p.getPid()%>" data-width="" data-numposts="5"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                            <!--End of body-->

                            <!--Profile modal-->
                    
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header primary-background text-white text-center">
                    <h5 class="modal-title">AtechWings</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body primary-background text-white">
                    <div class="container text-center">
                        <image src="pics/<%= user.getProfile() %>" class="img-fluid" style="border-radius:50%; max-width: 150px;">
                        <br>
                        <p class="modal-title mt-3"><%= user.getName() %></p>
                        <br>
                        <div id="profile-details">
                            <table class="table">   
                                <tbody>
                                  <tr>
                                    <th scope="row">ID: </th>
                                    <td><%=user.getId()%></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Email: </th>
                                    <td><%= user.getEmail() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Gender: </th>
                                    <td><%= user.getGender().toUpperCase()%></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">About: </th>
                                    <td><%= user.getAbout()%></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Registered on: </th>
                                    <td><%= user.getTime().toString()%></td>
                                  </tr>
                                </tbody>
                            </table>
                        </div>
                                  
                        <!-- profile edit -->
                        
                        <div id="profile-edit" style="display: none;">
                            <h3 class="mt-2">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID: </td>
                                        <td><%= user.getId() %></td>
                                    </tr>
                                    <tr>
                                        <td>Gender: </td>
                                        <td><%= user.getGender().toUpperCase() %></td>
                                    </tr>
                                    <tr>
                                        <td>Name: </td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%= user.getName() %>"></td>
                                    </tr>
                                    <tr>
                                        <td>Email: </td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail() %>"></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>Password: </td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
                                    </tr>
                                    <tr>
                                        <td>About: </td>
                                        <td>
                                            <textarea rows="3" class="form-control" name="user_about">
                                                <%= user.getAbout() %>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> DP: </td>
                                        <td><input type="file" name="image" class="form-control"></td>
                                    </tr>
                                </table>
                                    <div class="container"> 
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                  <button type="button" id="edit-profile-btn" class="btn btn-primary">Edit</button>
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
        </div>

                                    <!-- java script -->               
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v13.0&appId=198138004106787&autoLogAppEvents=1" nonce="fwEYUB3t"></script>
        <script>
            function doLike(pid, uid) {
            console.log(pid + "," + uid);
            const d = {
                uid: uid,
                pid: pid,
                operation:'like'
            };

            $.ajax({
                url: "LikeServlet",
                data: d,
                success: function(data, textStatus, jqXHR) {
                    console.log(data);
                    if(data.trim()==='true') {
                        let c = $(".like-counter").html();
                        c++;
                        $('.like-counter').html(c);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(data);
                }
            });
            }
        </script>
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(document).ready(function(){
                
                let editStatus = false;
                
                $('#edit-profile-btn').click(function(){
                    
                    if(editStatus === false) {
                        $("#profile-details").hide();                 
                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back");
                    } else {
                        $("#profile-details").show();                
                        $("#profile-edit").hide();
                        editStatus = false;
                        $(this).text("Edit");
                    }
                });
            });
        </script>

        <script>
            $(document).ready(function (e) {
                $("#add-post-form").on("submit",function(event) {
                    //this code called when form get submitted....
                    event.preventDefault();
                    console.log("form submitted");
                    
                    let form = new FormData(this);
                    
                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function(data, textStatus, jqXHR) {
                            console.log(data);
                            if(data.trim() === 'done'){
                                swal("Good job!", "Save successfully", "success");
                            } else {
                                swal("Error!", "Something went wrong", "error");
                            }
                            
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            //error........
                            swal("Error!", "Something went wrong", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
    </body>
</html>
