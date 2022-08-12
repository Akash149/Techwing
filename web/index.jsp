

<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background {
                clip-path: polygon(52% 0, 100% 0, 100% 100%, 75% 97%, 55% 100%, 29% 97%, 0 100%, 0 50%, 0 0);
            }
        </style>
    </head>
    <body>

        <%@include file="normal_navbar.jsp" %>

        <!<!-- //banner -->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white">
                <div class="container">
                    <h3 class="display-3">Welcome to Atech-Wings </h3>
                    <p>
                        programming language is any set of rules that converts strings,
                        or graphical program elements in the case of visual programming 
                        languages, to various kinds of machine code output. Programming 
                        languages are one kind of computer language, and are used in computer 
                        programming to implement algorithms.
                    </p>

                    <button class="btns"><span class="fa fa-user-plus"></span> Start ! its free</button>
                    <a href="login_page.jsp" class="btns"><span class="fa fa-user-circle fa fa-spin"></span> Login</a>
                </div>
            </div> 
        </div>

        <div class="container">
            <div class="container text-center" id="loader">
                <i class="fa fa-refresh fa-3x fa-spin"></i>
                <h3 class="mt-2"> Loading...</h3>
            </div> 
            <div class="container-fluid" id="post-container">


            </div>
        </div>


        <!-- java script -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <!--        loading post using ajax-->
        <script>
                function getPosts(catId, temp) {
                    $("#loader").show();
                    $("#post-container").hide();
                    $(".dropdown-item").removeClass('active');
                    $.ajax({
                        url: "homePost.jsp",
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
                    let allPostRef = $('.dropdown-item') [0];
                    getPosts(0, allPostRef);

                });
        </script>
    </body>
</html>
