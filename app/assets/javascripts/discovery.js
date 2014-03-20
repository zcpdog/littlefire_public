$(function(){
	$('.image-loaded').waitForImages(function() {
		$('#discovery-container').masonry({
		  itemSelector: '.masonryBrick'
		})
	})
})