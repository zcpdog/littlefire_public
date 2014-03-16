$(function(){
	$("ul#s-cmts").on("click", ".d-s", function () {
	            $(".sc-input").val($('.sc-input').val()+$(this).data("target") + "  ")
	        }).on("mouseover", "li", function () {
	            $(this).find(".report").show()
	        }).on("mouseleave", "li", function () {
	            $(this).find(".report").hide()
	        }).on("click", ".report", function () {
	            var b, c = {}, d = $(this).closest(".cmtcnt").find(".Ct");
	            return c.comment_id = $(this).data("commentid"), d.next(".alert").length > 0 ? (alert("\u4e0d\u8981\u91cd\u590d\u4e3e\u62a5"), !1) : (a.getJSON("/comment/report_to_admin", c, function (c) {
	                c.status && (b = a('<p class="alert">\u4f60\u5df2\u7ecf\u6210\u529f\u4e3e\u62a5\u6b64\u8bc4\u8bba\uff0c\u6b63\u5728\u7b49\u5f85\u963f\u8fbe\u660e\u5ba1\u6838</p>'), d.after(b), b.delay(1e3).fadeOut(1e3))
	            }), void 0)
	        }).on("click", ".delCmt", function () {
	            var b = {
	                comment_id: a(this).data("commentid")
	            }, c = $(this);
	            a.getJSON("/comment/delete_com", b, function (a) {
	                console.log(a), a.status ? c.closest("li").slideUp() : alert("\u5220\u9664\u5931\u8d25")
	            })
	        }).on("click", ".recovery", function () {
	            var b = {
	                comment_id: a(this).data("commentid")
	            };
	            a(this), a.getJSON("/comment/restore_com", b, function (a) {
	                a.status ? alert("\u6062\u590d\u6210\u529f\uff0c\u8bf7\u5237\u65b0") : alert("\u5220\u9664\u6210\u529f")
	            })
	        })
			
	$("#emotion").on("click", "img", function () {
	            var b = $(this),
	                c = "[" + b.attr("title") + "]";
	            $(".sc-input").val($('.sc-input').val()+c);
	        })
	$("#cmtfm").submit(function () {
		if ("" == $(".sc-input").val().trim()) {
			alert("\u4ec0\u4e48\u90fd\u4e0d\u5199\u5c31\u60f3\u53d1\u8868\uff0c\u8fd9\u662f\u65e0\u58f0\u7684\u8d5e\u7f8e\u4e48\uff1f");
	    }else{
	    	$.ajax({
	    		type: "POST",
				url: $(this).attr("action"),
				data: $(this).serialize(),
				dataType: 'html',
				success: (function(cmt){
					$(".sc-input").val("");
					$(cmt).hide().prependTo("ul#s-cmts").slideDown();
					num = parseInt($(".comments-size").text().replace( /\D+/g, ''))+1;
					$(".comments-size").text("评论("+num+")")
				})
	    	});
	    }
		return false;
	});
});