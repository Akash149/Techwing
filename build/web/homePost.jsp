<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>

<div class="row">
<%
    
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    UserDao u = new UserDao(ConnectionProvider.getConnection());
    
    int cid=Integer.parseInt(request.getParameter("cid"));
    List<Post> posts = null;
    if(cid==0){
        posts = d.getAllPosts();
    } else {
        posts=d.getPostByCatId(cid);
    }
    if(posts.size()==0) {
        out.println("<h3 class='display-3 text-center'>NO posts in this category</h3>");
        return;
    }
    for (Post p: posts) {
               
%>

<div class="post-area">
    <div class="container">
            <div class="card-column">
                <div class="card">
                    <div class="img1">
                        <img src="blog_pics/<%= p.getPpic() %>" alt="">
                    </div>
                    <% 
                        int id = p.getUserid();
                        List<User> user = u.UserDetailsById(id); 
                        for (User us: user){
                    %>
                    
                    <div class="card-header bg-success text-black">
                        <div class="row">
                            <div class="col">
                                <div class="img2">
                                    <img src="pics/<%= us.getProfile() %>" <alt="">
                                </div>
                            </div>
                            <div class="col">
                                <div class="row">
                                    <p>Author</p>
                                </div>
                                <div class="row">
                                    <h2><%= us.getName() %></h2>
                                </div>
                                <div class="row">
                                    <p><%= us.getEmail() %></p>
                                </div>
                            </div>
                        </div>

                    </div>
  
                    <div class="main-text">
                        <b><%= p.getPtitle() %></b>
                        <p><%= p.getPcontent() %></p>
                        <p><%= p.getPcode() %></p>
                    </div>
                    <%
                        }
                    %>
                    
                    <div class="card-footer bg-light text-center">
                        <% 
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());         
                        %>
                        <a href="#!" onclick="message()" class="btn"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPOst(p.getPid())%></span> </a>
                        <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn">Read More</a>
                        <a href="#!" onclick="message()" class="btn"><i class="fa fa-commenting-o"></i><span>20</span> </a>
                    </div>
                </div>
            </div>
    </div>
</div>
<%        
    }
%>
</div>

<script>
    function message(){
        alert("Please login to do like and comment ont the post");
    }
    
</script>