//ueditor custom config
(function () {
    window.CUSTOM_CONFIG = {
	  imageUrl: "/ueditor_images"
	  ,imagePath: ""
	  ,elementPathEnabled: false
	  ,wordCount:0 
	  ,maximumWords:5000
	  ,savePath: ['upload']
	  ,pasteplain:true
	  ,initialFrameHeight:300
      ,toolbars: [
	   	  ['Bold','UnderLine','ForeColor','FontSize','|','JustifyLeft',
	       'JustifyCenter','JustifyRight','JustifyJustify','|',
		   'insertorderedlist', 'insertunorderedlist','|',
		   'InsertImage', 'Link','InsertTable','|',
		   'RemoveFormat','FormatMatch','SearchReplace','source',
	       'FullScreen' ]
      ]
    };
    jQuery.extend(window.UEDITOR_CONFIG, window.CUSTOM_CONFIG);
})();
