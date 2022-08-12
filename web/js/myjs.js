function doLike(pid, uid) {
    console.log(pid + "," + uid)
    const d = {
        uid: uid,
        pid: pid,
        operation:'like'
    }
    
    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function(data, textStatus, jqXHR) {
            console.log(data);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    })
}


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


            $(document).ready(function() {
                
                console.log("loaded.....")
                
                $('#reg-form').on('submit',function(event) {
                    event.preventDefault();
                    
                    
                    
                    let form = new FormData(this);
                    $("#sumbit-btn").hide();
                    $("#loader").show();
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function(data, textStatus, jqXHR) {
                            console.log(data)
                            
                            $("#sumbit-btn").show();
                            $("#loader").hide();
                            
                            if(data.trim() === 'done') {
                                swal("Registration Successfull")
                                    .then((value) => {
                                        window.location = "login_page.jsp"
                                    });
                            } else {
                                swal(data);
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            
                            $("#sumbit-btn").show();
                            $("#loader").hide();
                            
                            swal("Something went wrong...try again");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
            
            