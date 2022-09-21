<%@page import="com.tech.blog.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>

<header>
    <style>
        .navbar{
            color: white;
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
        
        #drop{
            color: black;
        }
    </style>
</header>

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
                          <a class="dropdown-item" onlclick="getPosts(0,this)">All blogs</a>
                        <% 
                            PostDao postd = new PostDao(ConnectionProvider.getConnection());
                            ArrayList<Category> list=postd.getAllCategories();
                            for(Category c:list) {
                        %>
                            <a class="dropdown-item" id="drop" onclick="getPosts(<%= c.getCid()%>,this)"><%= c.getName() %></a>
                        <%
                            }
                        %>
                        
                      </div>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="login_page.jsp"><span class="fa fa-user"></span> Login</a>
                      
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-plus"></span> Sign up</a>
                      
                    </li>
              </ul>
                
                <form class="form-inline my-2 my-lg-0">
                  <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                  <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
</nav>
                        
                        <!--        loading post using ajax-->
        <script>
            function getPosts(catId,temp) {
                $("#loader").show();
                $("#post-container").hide();
                $(".dropdown-item").removeClass('active');
                $.ajax({
                    url: "load_post.jsp",
                    data:{cid: catId},
                    success: function(data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $('#post-container').html(data);
                        $(temp).addClass('active');
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        swal("Error!", "Something went wrong", "error");
                    },
                });
            }
            $(document).ready(function(e) {
                let allPostRef = $('.dropdown-item') [0]
                getPosts(0,allPostRef);
                
            });
//        </script>
                            
                            
                        
       
