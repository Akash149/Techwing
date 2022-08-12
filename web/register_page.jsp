

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
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
        <main class="primary-background p-5 banner-background" style="padding-bottom: 80px;">
            <diva class="container">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-header primary-background text-center text-white">
                            <span class="fa fa-user-plus fa-3x"></span>
                            <br>
                            Register here
                        </div>
                        <div class="card-body">
                            <form action="RegisterServlet" id="reg-form" method="post">
                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input type="text" class="form-control" required="true" name="u_name" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">

                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" name="u_email" required="true" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">

                                </div>

                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" name="password" required="true" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>

                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <input type="radio" name="gender" value="male"> Male
                                    <input type="radio" name="gender" value="female"> Female
                                </div>

                                <div class="form-group">
                                    <textarea name="about" class="form-control" rows="4" placeholder="Write something about yorself">
                                    </textarea>
                                </div>

                                <div class="form-check">
                                    <input type="checkbox" name="check" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and condition</label>
                                </div>

                                <br>
                                <div class="container text-center" id="loader" style="display: none;">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait...</h4>
                                </div>
                                <button type="submit" id="submit-btn" class="btn">Submit</button>
                            </form>
                        </div>

                    </div>
            </diva>
        </main>

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
                    console.log("loaded.....");
                    $("#loader").hide();
                    $('#reg-form').on('submit', function (event) {
                        event.preventDefault();
                        let form = new FormData(this);
                        $("#submit-btn").hide();
                        $("#loader").show();
                        $.ajax({
                            url: "RegisterServlet",
                            type: 'POST',
                            data: form,
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                $("#sumbit-btn").show();
                                $("#loader").hide();

                                if (data.trim() === 'done') {
                                    swal("Thank you","Registration Successfull", "success")
                                            .then((value => {
                                                window.location = "login_page.jsp";
                                            }));
                                } else {
                                    swal(data);
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                                $("#sumbit-btn").show();
                                $("#loader").hide();

                                swal("Something went wrong...try again");
                            },
                            processData: false,
                            contentType: false
                        });
                    });
                });
        </script> 
    </body>
</html>
