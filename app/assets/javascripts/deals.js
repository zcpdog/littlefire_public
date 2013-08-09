$('.datepicker').datepicker({
startDate: 'today',
forceParse: true,
language: 'zh-CN',
format: 'yyyy-mm-dd'
});  
$("body").delegate( "a[data-remove]", "click", function() {
  	$(this).prev("input[type=hidden]").val("1");
	$(this).closest(".fields").hide();  
});

$("a[data-association]").click(function(){
	var association = $(this).data("association");
	var content = $(this).data("content");
  	var new_id = new Date().getTime();
  	var regexp = new RegExp("new_" + association, "g");
	$(this).parent().before(content.replace(regexp, new_id));
});