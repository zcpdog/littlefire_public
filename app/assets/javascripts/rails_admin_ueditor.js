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
})
