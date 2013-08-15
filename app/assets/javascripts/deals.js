	$("body").delegate(".file-upload-btn","click",function(){
		$(this).closest("div.file-upload").children(".real-file").click();
	});
	$(".real-file").change(function(){
		$('.file-display-field').val($(".real-file").val());
		$(this).next("div").find(".file-display-field").val($(this).val().replace(/^.*[\\\/]/, ''));
	});
	
	$('.datepicker').datepicker({
		startDate: 'today',
		forceParse: true,
		language: 'zh-CN',
		format: 'yyyy-mm-dd'
	});  
	$("body").delegate( "a[data-remove]", "click", function() {
	  	$(this).prev("input[type=hidden]").val("1");
		$(this).closest(".fields").hide();  
	});

	$("a[data-association]").click(function(){
		var association = $(this).data("association");
		var content = $(this).data("content");
	  	var new_id = new Date().getTime();
	  	var regexp = new RegExp("new_" + association, "g");
		$(this).parent().before(content.replace(regexp, new_id));
	});
	
	$(".deal-toolbar-link").bind("ajax:error", function(evt, data, status, xhr){
		if(data.status==401){
			$('#please-login').modal({
				remote: "/users/sign_in"
			})
		}else if (data.status == 500){
			alert("something wrong");
		}
	});

	$(".comment-field-cancel").click(function(){
		$(this).closest(".comment-field").hide();
	});
	
	$('.comment-form').validate({
	    rules: {
	      "comment[content]": {
	        minlength: 10,
			maxlength: 140,
	        required: true
	      }
	    },
		highlight: function(element,errorClass, validClass) {
			$(element).closest('.control-group').addClass('warning');
		},
		unhighlight: function(element,errorClass, validClass){
			$(element).closest('.control-group').removeClass('warning');
		},
		errorLabelContainer: ".help-inline",
		errorElement: "span"
	 });
	 
	 $('.deal-form').validate({
 	    rules: {
			"deal[title]": {
				minlength: 15,
				maxlength: 80,
				required: true
			},
			"deal[body]":{
				minlength: 50,
				maxlength: 500,
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
	 
	 $("body").delegate(".deal-body-toggle","click",function(){
		 $(this).closest("div[id^='deal']").find(".deal-body-extra").toggle();
	 });


