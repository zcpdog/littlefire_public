$(function(){
	if ($(".purchase_redirect").length>0) { 
		setTimeout( function() {window.location.href = $(".purchase_redirect_url").attr("href");}, 1000);
	}
	
	$(".deal-toolbar-link").bind("ajax:error", function(event, jqXHR, ajaxSettings, thrownError){
		if(jqXHR.status == 401){
			$(".top-tip").slideDown();
			setTimeout(function(){$(".top-tip").slideUp();}, 3000);
		}
	});
})