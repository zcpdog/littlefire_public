$(function(){
	$(".my_info").click(function(){
		$(".my_info.current").removeClass("current");
		$(this).addClass("current");
		$("#msd-timeline").html("");
		$("#msd-timeline").data("klass",$(this).attr("id"));
	});
})