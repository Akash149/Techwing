<%@page import="com.tech.blog.entities.Message"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width", initial-scale="1.0" />
        <title>CONTACT_US</title>
        <link rel="stylesheet" href="css/cstyle.css" />
        <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <%
        Message m = (Message) session.getAttribute("msg");
        if (m != null) {

    %>

    <div class="alert-primary text-center <%= m.getCssClass()%>" role="alert">
        <%= m.getContent()%>
    </div>

    <%
        }
    %>

    <body>
        <div class="container">
            <span class="big-circle"></span>
            <img src="img/shape.png" class="square" alt="" />

            <div class="form" >
                <div class="contact-info">
                    <h3 class="title">Let's get in touch</h3>
                    <p class="text">
                        This is a platform where we can post and read technical blog
                    </p>

                    <div class="info">
                        <div class="information">
                            <img src="img/location.png" class="icon" alt=""/>
                            <p>Hinjewadi Phase-1, Pune </p>
                        </div>

                        <div class="information">
                            <img src="img/email.png" class="icon" alt=""/>
                            <p>araushan11@gmail.com </p>
                        </div>

                        <div class="information">
                            <img src="img/phone.png" class="icon" alt=""/>
                            <p>+91 8709394895 </p>
                        </div>
                    </div>

                    <div class="social-media">
                        <p> Connect with us: </p>
                        <div class="social-icons">
                            <a href="#">
                                <i class="fab fa-facebook-f"></i>
                            </a>

                            <a href="#">
                                <i class="fab fa-twitter"></i>
                            </a>

                            <a href="#">
                                <i class="fab fa-instagram"></i>
                            </a>

                            <a href="#">
                                <i class="fab fa-linked-in"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="contact-form">
                    <span class="circle one"></span>
                    <span class="circle two"></span>

                    <form action="ContactUss" method="post" id="contactform" autocomplete="off">
                        <h3 class="title"> Contact us </h3>
                        <div class="input-container">
                            <input type="text" required="true" name="name" class="input" />
                            <label for="">Username</label>
                            <span>Username</span>
                        </div>

                        <div class="input-container">
                            <input type="email" required="true" name="email" class="input" />
                            <label for="">Email</label>
                            <span>Email</span>
                        </div>
                        <div class="input-container">
                            <input type="tel" required="true" name="phone" class="input" required pattern="[6-9]{1}[0-9]{9}"/>
                            <label for="">Phone</label>
                            <span>Phone</span>
                        </div>

                        <div class="input-container">
                            <textarea name="query" required="true" class="input"></textarea>
                            <label for="">Message</label>
                            <span>Message</span>
                        </div>
                        <input type="submit"  value="send" class="btn"/>
                        <a class="btn" style="margin: 80px;" href="index.jsp">Home</a>
                    </form>
                </div>
            </div>
        </div>
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous">
        </script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/capp.js"></script>
        <!--    <script src="js/cappfun.js"></script>-->
        <script>
                $(document).ready(function () {
                    $('#contactform').on('submit', function (event) {
                        event.preventDefault();
                        let form = new FormData(this);

                        //send contact data.....
                        $.ajax({
                            url: "ContactUss",
                            type: 'POST',
                            data: form,
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                if (data.trim() === "Done") {
                                    swal("Thank you", "Sent successfully", "success");
                                    document.getElementById("contactform").reset();
                                } else {
                                    swal("Error!", "Sorry", "error");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(jqXHR);
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