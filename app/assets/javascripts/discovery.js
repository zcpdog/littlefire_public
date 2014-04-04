var discovery_container;
$(function(){
	$('.image-loaded').waitForImages(function() {
		discovery_container = $('#discovery-container');
		discovery_container.masonry({
		  itemSelector: '.masonryBrick'
		})
	})
})