#= require active_admin/base
#= require tinymce
#= require cascading-drop-box
$(document).ready ->
  tinyMCE.init({
     mode: 'textareas',
     theme : 'modern',
	 selector: '.tinymce',
	 plugins: "link textcolor image wordcount media preview",
	 toolbar1: "styleselect | outdent indent | bold italic | link | forecolor | image media | preview",
	 language: "zh_CN"
   });