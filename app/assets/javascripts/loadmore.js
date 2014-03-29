$(function(){
	$("#stance.loadmore").on('inview', function(){
		$(".loadmore img").show();
		$.ajax({
			type: "GET",
			dataType: "SCRIPT",
			url: "/user/"+$("#msd-timeline").data("klass")+ 
				"?user_id="+ $("#msd-timeline").data("name")+"&date=" +$("#msd-timeline").data("next")
		});
	})
})