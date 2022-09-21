
<%@page import="com.tech.blog.entities.SendLoginEmail"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User" %>
<%@page errorPage="error_page.jsp" %>
<%

    User user = (User) session.getAttribute("currentUser");
//SendLoginEmail email = new SendLoginEmail();
//String uemail = user.getEmail();
//String msg = "Hello, + user.getName() + you have just logged in";
//email.setTo(uemail);
//email.setMessage(msg);
//email.SendEmail();
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background {
                clip-path: polygon(52% 0, 100% 0, 100% 100%, 75% 97%, 55% 100%, 29% 97%, 0 100%, 0 50%, 0 0);
            }

            body{
                background-color: #4c4177;
                background-image: linear-gradient(315deg, #4c4177 0%, #2a5470 74%);
                background-size: cover;
                background-attachment: fixed;
            }

            .navbar{
                font-weight: 500;
                background-color: rgba(0, 0, 0, 0.515);
                backdrop-filter: blur(8px);
                box-shadow:0px 0px 0px  #00A1A6;
            }

            .navbar a{
                color: white;
            }
            .navbar .nav-item a{
                color: white;
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg fixed-top">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk">
                </span> AtechWings
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
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" onclick="getPosts(0, this)">All blogs</a>
                            <%                                PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list = postd.getAllCategories();
                                for (Category c : list) {
                            %>
                            <a class="dropdown-item" onclick="getPosts(<%= c.getCid()%>, this)" href="#"><%= c.getName()%></a>
                            <%
                                }
                            %>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span> Do Post</a>
                    </li>
                </ul>      
                <!--                        ......................User_profile......................-->
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <image src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%; max-width: 40px;">
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><%= " " + user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Logout <span class="fa-regular fa-arrow-right-from-bracket"></span></a>
                    </li>
                </ul>
                </li>
                </ul>
            </div>             
        </nav>

        <!--  Alert Message  -->

        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert alert-primary text-center <%= m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>

        <%
                session.removeAttribute("msg");
            }
        %>

        <!--        Main body of the page.-->
        <main>
            <div class="container">
                <div class="row">
                    <!--Second column..-->
                    <div class="col-md-12">
                        <div class="card-columns">
                            <!--.........posts..........-->
                            <div class="container text-center" id="loader">
                                <i class="fa fa-refresh fa-4x fa-spin"></i>
                                <h3 class="mt-2">Loading...</h3>
                            </div>

                            <div class="container-fluid" id="post-container"></div>   
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!--            Profile modal-->

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
                            <image src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%; max-width: 150px;">
                            <br>
                            <p class="modal-title mt-3"><%= user.getName()%></p>
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
                                            <td><%= user.getEmail()%></td>
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
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Gender: </td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>Name: </td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Email: </td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>

                                        <tr>
                                            <td>Password: </td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>About: </td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about">
                                                    <%= user.getAbout()%>
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


        <!-- Add post Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post">
                            <div class="form-group">   
                                <select class="form-control" name="cid">
                                    <option select="disabled"> Select category</option>
                                    <%
                                        //PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        // ArrayList<Category> list=postd.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <textarea  name="pContent" placeholder="Enter your content" style="height: 200px;" class="form-control"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea name="pCode" placeholder="Enter your code (if availiable)" style="height: 200px;" class="form-control"></textarea>
                            </div>
                            <div class="form-group">
                                <lable>Select your Image</lable><br>
                                <input type="file" name="pic">
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>  



        <!-- end post Modal -->


        <!-- java script -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
                                $(document).ready(function () {

                                    let editStatus = false;

                                    $('#edit-profile-btn').click(function () {

                                        if (editStatus === false) {
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

        <!--now add post js-->

        <script>
            $(document).ready(function (e) {
                $("#add-post-form").on("submit", function (event) {
                    //this code called when form get submitted....
                    event.preventDefault();
                    console.log("form submitted");

                    let form = new FormData(this);

                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() === 'done') {
                                swal("Good job!", "Save successfully", "success");
                            } else {
                                swal("Error!", "Something went wrong", "error");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error........
                            swal("Error!", "Something went wrong", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

        <!--        loading post using ajax-->
        <script>
            function getPosts(catId, temp) {
                $("#loader").show();
                $("#post-container").hide();
                $(".dropdown-item").removeClass('active');
                $.ajax({
                    url: "load_post.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $('#post-container').html(data);
                        $(temp).addClass('active');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        swal("Error!", "Something went wrong", "error");
                    },
                });
            }
            $(document).ready(function (e) {
                let allPostRef = $('.dropdown-item') [0]
                getPosts(0, allPostRef);

            });
        </script>
    </body>
</html>
