$(document).ready(function(){
	$(".category").change(function(){
		$(this).attr("name","");
		$(this).parent().append("hello");
	});
})