$(function(){
	$("#stance.loadmore").on('inview', function(){
		$(".loadmore img").show();
		$.ajax({
			type: "GET",
			dataType: "SCRIPT",
			url: "/user/" + $("#msd-timeline").data("name")+ "/" +$("#msd-timeline").data("klass")+ "?date=" +$("#msd-timeline").data("next")
		});
	})
})