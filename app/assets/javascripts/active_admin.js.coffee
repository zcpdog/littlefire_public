#= require active_admin/base
#= require tinymce
#= require cascading-drop-box
$(document).ready ->
  tinyMCE.init({
     mode: 'textareas',
     theme : 'modern',
	 selector: '.tinymce'
   });