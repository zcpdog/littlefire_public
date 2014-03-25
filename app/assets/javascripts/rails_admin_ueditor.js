$(document).on('rails_admin.dom_ready', function(){
	if($("#deal_title").length>0){
		new UE.ui.Editor({ initialFrameHeight:100}).render("deal_title");
	}
	if($("#deal_content").length>0){
		new UE.ui.Editor().render("deal_content");
	}
	if($("#discovery_title").length>0){
		new UE.ui.Editor({ initialFrameHeight:100}).render("discovery_title");
	}
	if($("#discovery_content").length>0){
		new UE.ui.Editor().render("discovery_content");
	}
	if($("#article_title").length>0){
		new UE.ui.Editor({ initialFrameHeight:100}).render("article_title");
	}
	if($("#article_content").length>0){
		new UE.ui.Editor().render("article_content");
	}
	if($("#experience_title").length>0){
		new UE.ui.Editor({ initialFrameHeight:100}).render("experience_title");
	}
	if($("#experience_content").length>0){
		new UE.ui.Editor().render("experience_content");
	}
	$(document).on("keydown", function (e) {
	    if (e.which === 8 && !$(e.target).is("input, textarea")) {
	        e.preventDefault();
	    }
	});
})
