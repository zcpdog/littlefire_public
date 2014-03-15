//ueditor custom config
(function () {
    window.CUSTOM_CONFIG = {
      // Insert your config code
      // toolbars: [
//            ['Source','Undo','Redo','Cleardoc','SearchReplace','InsertImage','WordImage','Bold','ForeColor','JustifyLeft',
//            'JustifyCenter','JustifyRight','JustifyJustify']
//       ]
	  	imageUrl: "/ueditor_images"
		,imagePath: ""
		,maxImageSideLength: 600
		,elementPathEnabled: false
		,wordCount:0          //是否开启字数统计
		,maximumWords:5000       //允许的最大字符数
		,savePath: ['upload']
      // toolbars: [
      //      ['Source','Undo','Redo','Cleardoc','SearchReplace','InsertImage','WordImage','Bold','ForeColor','JustifyLeft',
      //      'JustifyCenter','JustifyRight','JustifyJustify','RemoveFormat','FormatMatch','AutoTypeSet','PastePlain',
      //      'FontSize','Preview','Link','FullScreen', 'PageBreak', 'InsertTable','Attachment','InsertVideo']
      // ]
    };
    jQuery.extend(window.UEDITOR_CONFIG, window.CUSTOM_CONFIG);
})();
