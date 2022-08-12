//$(document).ready(function(e){
//    $('#contactform').on('submit',function(e) {
//        e.preventDefault();
//
//        console.log("form submitted");
//        
//        let form = new FormData(this);
//        
//        //now requesting to server
//        $.ajax({
//            url: "contactus",
//            type: 'POST',
//            data: form,
//            success: function(data, textStatus, jqXHR) {
//                console.log(data);
//                if(data.trim() === 'Done') {
//                    swal("Thank you", "Sent successfully", "success");
//                } else {
//                    swal("Error", "Sorry", "error");
//                }
//            },
//            error: function(jqXHR, textStatus, errorThrown) {
//                //error......
//                swal("Error!","Something went wrong", "error");
//            },
//            processData: false,
//            contentType: false
//        });
//    });
//
//
////jQuery('#contactform').on('submit',function(e){
////                alert(result);
////                e.perventDefault();
////                jQuery.ajax({
////                    url:'contactus',
////                    type:'post',
////                    data:jQuery('#contactform').serialize(),
////                    success: function(result){
////                        console.log(result);
////                        if(data.trim() === 'Done'){
////                            swal("Thank you", "Sent successfully", "success");
////                        } else {
////                            swal("Error", "Something went wrong", "error");
////                        }
////                        alert(result);
////                    },
////                    error: function(result){
////                        swal("Error",result, "error");
////                    },
////                    processData: false,
////                    contentType: false
////                });
//
//$('#contactform').on('submit',function(e){
//                e.preventDefault();
//                console.log("form submitted");
//                let form = new FormData(this);
//        
//                //now requesting to server
//                $.ajax({
//                    url: "ContactUss",
//                    type: 'POST',
//                    data: form,
//                    success: function(data, textStatus, jqXHR) {
//                        console.log(data);
//                        if(data.trim() === 'Done') {
//                            swal("Thank you", "Sent successfully", "success");
//                        } else {
//                            swal("Error",data, "error");
//                        }
//                    },
//                    error: function(jqXHR, textStatus, errorThrown) {
//                        //error......
//                        swal("Error!","Something went wrong", "error");
//                    },
//                    processData: false,
//                    contentType: false
//                });
//            });