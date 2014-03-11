$(function(){
	// $(".my_info").click(function(){
// 		$(".my_info.current").removeClass("current");
// 		$(this).addClass("current");
// 		$("#msd-timeline").html("");
// 		$("#msd-timeline").data("klass",$(this).attr("id"));
// 	});
	$(".edit_profile").submit(function(){
		$.ajax({
			type: "POST",
			url: $(this).attr("action"),
			data: $(this).serialize(),
			dataType: 'script'
		});
		return false;
	});
	
})