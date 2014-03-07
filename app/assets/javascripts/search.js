$(function(){
	$(".search_form").submit(function(){
		if($("#q").val().trim() == "") return false;
	});
})