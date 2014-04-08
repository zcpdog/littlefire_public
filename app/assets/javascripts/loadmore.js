$(function(){
	$("#stance.loadmore").on('inview', function(){
		$(".loadmore img").show();
		$.ajax({
			type: "GET",
			dataType: "SCRIPT",
			url: "/user/"+$("#msd-timeline").data("klass")+ 
				"?user_id="+ $("#msd-timeline").data("name")+"&date=" +$("#msd-timeline").data("next")
		});
	});
	
	$("#stance.kaminari-resources").on('inview', function(){
		$(this).removeClass("kaminari-resources");
		var url = $("ul.pure-paginator").find("li a[rel=next]").attr("href");
		if(url && url.match(/\/\w+\/page\/\d+/)){
			$("#stance img").show();
			$.ajax({
				type: "GET",
				dataType: "SCRIPT",
				url: url
			});
		}
	});
		
})