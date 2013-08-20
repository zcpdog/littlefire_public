function goback(event_element){
	$('html, body').animate({
        scrollTop: event_element.closest("div[id^='deal']").position().top - 50
    });
}
$(document).on("click",".file-upload-btn", function(){
	$(this).closest("div.file-upload").children(".real-file").click();
});

$(document).on("change",".real-file", function(){
	$('.file-display-field').val($(".real-file").val());
	$(this).next("div").find(".file-display-field").val($(this).val().replace(/^.*[\\\/]/, ''));
});

$(document).on("click","a[data-remove]",function(){
  	$(this).prev("input[type=hidden]").val("1");
	$(this).closest(".fields").hide();  
});

$(document).on("ajax:error",".deal-toolbar-link",function(evt, data, status, xhr){
	if(data.status==401){
		$('#please-login').modal();
	}else if (data.status == 500){
		alert("something wrong");
	}
});

$(document).on("click",".comment-field-cancel",function(){
	$(this).closest(".comment-field").hide();
	goback($(this));
});

$(document).on("click",".deal-body-toggle",function(){
	var deal_body_extra=$(this).closest("div[id^='deal']").find(".deal-body-extra")
	if(deal_body_extra.is(":visible")){
		deal_body_extra.hide();
		$(this).html("展开全文<i class='icon-sort-down'></i>");
		goback($(this));
	}else{
		deal_body_extra.show();
		$(this).html("向上收起<i class='icon-sort-up'></i>");
	}
});

$(document).on("click",".deal-show-comment-toggle",function(){
	$(this).closest("div[id^='deal']").find(".comment-field").toggle();
});


$(document).ready(function(){
	
	$('.datepicker').datepicker({
		startDate: 'today',
		forceParse: true,
		language: 'zh-CN',
		format: 'yyyy-mm-dd'
	});  	
	
	$("a[data-association]").click(function(){
		var association = $(this).data("association");
		var content = $(this).data("content");
	  	var new_id = new Date().getTime();
	  	var regexp = new RegExp("new_" + association, "g");
		$(this).parent().before(content.replace(regexp, new_id));
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
	
})


