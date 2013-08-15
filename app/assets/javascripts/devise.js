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
 	    },
		highlight: function(element,errorClass, validClass) {
			$(element).closest('.control-group').addClass('warning');
		},
		unhighlight: function(element,errorClass, validClass){
			$(element).closest('.control-group').removeClass('warning');
		}
	 });
	 
	 $(".register-form").validate({
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
			
 	    },
		highlight: function(element,errorClass, validClass) {
			$(element).closest('.control-group').addClass('warning');
		},
		unhighlight: function(element,errorClass, validClass){
			$(element).closest('.control-group').removeClass('warning');
		}
	 });
});