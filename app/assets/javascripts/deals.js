$(function(){
	if ($(".purchase_redirect").length>0) { 
		setTimeout( function() {window.location.href = $(".purchase_redirect_url").attr("href");}, 1000);
	}
})