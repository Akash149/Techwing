
<script>
    $(document).ready(function () {
        console.log("loaded.....");
        $("#loader").hide();
        $('#reg-form').on('submit', function (event) {
            event.preventDefault();
            let form = new FormData(this);
            $("#sumbit-btn").hide();
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
                        swal("Registration Successfull")
                                .then((value) => {
                                    window.location = "login_page.jsp";
                                });
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

        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous">
        </script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/capp.js"></script>