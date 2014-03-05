/*! loethen 2014-01-26 */ ! function () {
    yepnope([{
        load: ["/static/build/js/vendor/util.js", "/static/build/js/vendor/comment.js"],
        complete: function () {
            $(".addlike a").click(function () {
                var a = $(this).data("id");
                return util.like("/like/", this, !0, {
                    post_id: a
                }), !1
            }), $("#commentWrap").okComment().show(), $(".cmtload").hide()
        }
    }])
}();