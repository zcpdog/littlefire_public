$(function() {
    function a(a) {
        var b = $(a),
            c = b.data("submenuId"),
            d = $("#" + c),
            e = g.outerHeight(),
            f = g.outerWidth();
        d.css({
            display: "block",
            top: -1,
            left: f - 2,
            height: e - 3
        }), b.find("a").addClass("maintainHover")
    }

    function b(a) {
        var b = $(a),
            c = b.data("submenuId"),
            d = $("#" + c);
        d.hide(), b.find("a").remove("maintainHover")
    }
    var c, d, e = $("#categroy-menu"),
        f = $("#categroy"),
        g = e.find(".dropdown-menu"),
        h = 200,
        i = e.width();
    e.css("left", -i), f.hover(function () {
        clearTimeout(d), c = setTimeout(function () {
            j()
        }, h)
    }, function () {
        clearTimeout(c)
    }), e.on("mouseleave", function () {
        k()
    });
    var j = function () {
        e.show().animate({
            left: 0
        }, 200)
    }, k = function () {
            e.animate({
                left: -i
            }, 200, function () {
                e.hide()
            }), $(".popover").css("display", "none"), $("a.maintainHover").removeClass("maintainHover")
        };
    g.menuAim({
        activate: a,
        deactivate: b,
        exitMenu: function () {
            return !0
        }
    }), $("#categroy-menu > .dropdown-menu li a").click(function () {});
	var window_height = $(window).height();
	$(document).on("scroll", function () {
	    $(this).scrollTop() > window_height ? $(".back-to-top").show() : $(".back-to-top").hide();
	});
	
	$('.nav-content').affix({
		offset: {
	      top: 98
	    , bottom: function () {
	        return (this.bottom = $('.footer').outerHeight(true))
	      }
	    }
	});
	if($(".best-choice").length>0 && $(".nav-content").length>0){
		$('.best-choice').affix({
			offset: { top: $('.nav-content').offset().top }
		});
	}
	
	$(".items").on("mouseenter", ".item", function () {
        $(this).find(".more").css("visibility", "visible")
    }).on("mouseleave", ".item", function () {
        $(this).find(".more").css("visibility", "hidden")
    });
	
	$(".items").on("click", ".more", function () {
        var a = $(this).closest(".entry-share").siblings(".post-wrap"),
            b = $(this).closest(".item"),
            c = b.offset(),
            d = $(window).scrollTop();
        if (a.toggleClass("post-hide"), a.hasClass("post-hide")) {
            if ($(this).find("a").html("\u5168\u6587 \u2193"), d > c.top) {
                $("html, body").animate({
                    scrollTop: c.top - 40
                }), b.css({
                    backgroundColor: "rgb(255,255,160)"
                });
                var e = 160,
                    f = setInterval(function () {
                        e++, b.css("backgroundColor", "rgb(255,255," + e + ")"), e >= 255 && (clearInterval(f), b.removeAttr("style"))
                    }, 10)
            }
        } else $(this).find("a").html("\u6536\u8d77 \u2191");
        return !1
    });
});
