$(document).ready(function(){
	$(".login-form").validate({
 	    rules: {
			"user[email]": {
				email: true,
				required: true
			},
			"user[password]":{
				minlength: 6,
				maxlength: 20,
				required: true
			}
 	    }
	 });
	 
	 $(".signup-form").validate({
 	    rules: {
			"user[email]": {
				email: true,
				required: true
			},
			"user[username]":{
				minlength: 3,
				maxlength: 10,
				required: true
			},
			"user[password]":{
				minlength: 6,
				maxlength: 20,
				required: true
			},
			"user[password_confirmation]":{
				minlength: 6,
				maxlength: 20,
				required: true,
				equalTo : "#user_password"
			}
 	    }
	 });
});