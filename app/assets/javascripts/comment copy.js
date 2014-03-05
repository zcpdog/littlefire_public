/*! loethen 2014-01-26 */ ! function (a) {
    a.fn.okComment = function (b) {
        var c = this,
            d = [],
            e = {
                commentList: a("ul#s-cmts"),
                targetInput: a("#sc-input"),
                targetForm: a("#cmtfm"),
                emotion: a("#emotion"),
                getcomment: a("#getcomment")
            }, f = a.extend({}, e, b),
            g = {
                get: function (a) {
                    var b = {
                        text: "",
                        start: 0,
                        end: 0
                    };
                    if (a.setSelectionRange) a.focus(), b.start = a.selectionStart, b.end = a.selectionEnd, b.text = b.start != b.end ? a.value.substring(b.start, b.end) : "";
                    else if (document.selection) {
                        a.focus();
                        var c, d = document.selection.createRange(),
                            e = document.body.createTextRange();
                        for (e.moveToElementText(a), b.text = d.text, b.bookmark = d.getBookmark(), c = 0; e.compareEndPoints("StartToStart", d) < 0 && 0 !== d.moveStart("character", -1); c++) "\r" == a.value.charAt(c) && c++;
                        b.start = c, b.end = b.text.length + b.start
                    }
                    return b
                }
            }, h = function (a, b) {
                var c = f.targetInput[0],
                    d = c.value.length < 1,
                    e = c.value;
                if (c.createTextRange) {
                    var h = g.get(c);
                    c.value = b ? d ? a : e + a : d ? a : e.slice(0, h.start) + a + e.slice(h.end)
                } else {
                    var i = c.selectionStart,
                        j = c.selectionEnd;
                    c.value = b ? d ? a : e + a : d ? a : e.slice(0, i) + a + e.slice(j), c.setSelectionRange(i === j ? i + a.length : i, i + a.length)
                }
                c.focus()
            }, i = function (a) {
                a.scrollHeight > a.clientHeight && (a.style.height = a.scrollHeight + "px")
            }, j = function (b, c) {
                return "-1" == a.inArray(b, c) ? !1 : !0
            }, k = function (a) {
                if (!a.avatar) {
                    var b = function (a) {
                        function b(a, b) {
                            return a << b | a >>> 32 - b
                        }

                        function c(a, b) {
                            var c, d, e, f, g;
                            return e = 2147483648 & a, f = 2147483648 & b, c = 1073741824 & a, d = 1073741824 & b, g = (1073741823 & a) + (1073741823 & b), c & d ? 2147483648 ^ g ^ e ^ f : c | d ? 1073741824 & g ? 3221225472 ^ g ^ e ^ f : 1073741824 ^ g ^ e ^ f : g ^ e ^ f
                        }

                        function d(a, b, c) {
                            return a & b | ~a & c
                        }

                        function e(a, b, c) {
                            return a & c | b & ~c
                        }

                        function f(a, b, c) {
                            return a ^ b ^ c
                        }

                        function g(a, b, c) {
                            return b ^ (a | ~c)
                        }

                        function h(a, e, f, g, h, i, j) {
                            return a = c(a, c(c(d(e, f, g), h), j)), c(b(a, i), e)
                        }

                        function i(a, d, f, g, h, i, j) {
                            return a = c(a, c(c(e(d, f, g), h), j)), c(b(a, i), d)
                        }

                        function j(a, d, e, g, h, i, j) {
                            return a = c(a, c(c(f(d, e, g), h), j)), c(b(a, i), d)
                        }

                        function k(a, d, e, f, h, i, j) {
                            return a = c(a, c(c(g(d, e, f), h), j)), c(b(a, i), d)
                        }

                        function l(a) {
                            for (var b, c = a.length, d = c + 8, e = (d - d % 64) / 64, f = 16 * (e + 1), g = Array(f - 1), h = 0, i = 0; c > i;) b = (i - i % 4) / 4, h = 8 * (i % 4), g[b] = g[b] | a.charCodeAt(i) << h, i++;
                            return b = (i - i % 4) / 4, h = 8 * (i % 4), g[b] = g[b] | 128 << h, g[f - 2] = c << 3, g[f - 1] = c >>> 29, g
                        }

                        function m(a) {
                            var b, c, d = "",
                                e = "";
                            for (c = 0; 3 >= c; c++) b = 255 & a >>> 8 * c, e = "0" + b.toString(16), d += e.substr(e.length - 2, 2);
                            return d
                        }

                        function n(a) {
                            a = a.replace(/\r\n/g, "\n");
                            for (var b = "", c = 0; c < a.length; c++) {
                                var d = a.charCodeAt(c);
                                128 > d ? b += String.fromCharCode(d) : d > 127 && 2048 > d ? (b += String.fromCharCode(192 | d >> 6), b += String.fromCharCode(128 | 63 & d)) : (b += String.fromCharCode(224 | d >> 12), b += String.fromCharCode(128 | 63 & d >> 6), b += String.fromCharCode(128 | 63 & d))
                            }
                            return b
                        }
                        var o, p, q, r, s, t, u, v, w, x = Array(),
                            y = 7,
                            z = 12,
                            A = 17,
                            B = 22,
                            C = 5,
                            D = 9,
                            E = 14,
                            F = 20,
                            G = 4,
                            H = 11,
                            I = 16,
                            J = 23,
                            K = 6,
                            L = 10,
                            M = 15,
                            N = 21;
                        for (a = n(a), x = l(a), t = 1732584193, u = 4023233417, v = 2562383102, w = 271733878, o = 0; o < x.length; o += 16) p = t, q = u, r = v, s = w, t = h(t, u, v, w, x[o + 0], y, 3614090360), w = h(w, t, u, v, x[o + 1], z, 3905402710), v = h(v, w, t, u, x[o + 2], A, 606105819), u = h(u, v, w, t, x[o + 3], B, 3250441966), t = h(t, u, v, w, x[o + 4], y, 4118548399), w = h(w, t, u, v, x[o + 5], z, 1200080426), v = h(v, w, t, u, x[o + 6], A, 2821735955), u = h(u, v, w, t, x[o + 7], B, 4249261313), t = h(t, u, v, w, x[o + 8], y, 1770035416), w = h(w, t, u, v, x[o + 9], z, 2336552879), v = h(v, w, t, u, x[o + 10], A, 4294925233), u = h(u, v, w, t, x[o + 11], B, 2304563134), t = h(t, u, v, w, x[o + 12], y, 1804603682), w = h(w, t, u, v, x[o + 13], z, 4254626195), v = h(v, w, t, u, x[o + 14], A, 2792965006), u = h(u, v, w, t, x[o + 15], B, 1236535329), t = i(t, u, v, w, x[o + 1], C, 4129170786), w = i(w, t, u, v, x[o + 6], D, 3225465664), v = i(v, w, t, u, x[o + 11], E, 643717713), u = i(u, v, w, t, x[o + 0], F, 3921069994), t = i(t, u, v, w, x[o + 5], C, 3593408605), w = i(w, t, u, v, x[o + 10], D, 38016083), v = i(v, w, t, u, x[o + 15], E, 3634488961), u = i(u, v, w, t, x[o + 4], F, 3889429448), t = i(t, u, v, w, x[o + 9], C, 568446438), w = i(w, t, u, v, x[o + 14], D, 3275163606), v = i(v, w, t, u, x[o + 3], E, 4107603335), u = i(u, v, w, t, x[o + 8], F, 1163531501), t = i(t, u, v, w, x[o + 13], C, 2850285829), w = i(w, t, u, v, x[o + 2], D, 4243563512), v = i(v, w, t, u, x[o + 7], E, 1735328473), u = i(u, v, w, t, x[o + 12], F, 2368359562), t = j(t, u, v, w, x[o + 5], G, 4294588738), w = j(w, t, u, v, x[o + 8], H, 2272392833), v = j(v, w, t, u, x[o + 11], I, 1839030562), u = j(u, v, w, t, x[o + 14], J, 4259657740), t = j(t, u, v, w, x[o + 1], G, 2763975236), w = j(w, t, u, v, x[o + 4], H, 1272893353), v = j(v, w, t, u, x[o + 7], I, 4139469664), u = j(u, v, w, t, x[o + 10], J, 3200236656), t = j(t, u, v, w, x[o + 13], G, 681279174), w = j(w, t, u, v, x[o + 0], H, 3936430074), v = j(v, w, t, u, x[o + 3], I, 3572445317), u = j(u, v, w, t, x[o + 6], J, 76029189), t = j(t, u, v, w, x[o + 9], G, 3654602809), w = j(w, t, u, v, x[o + 12], H, 3873151461), v = j(v, w, t, u, x[o + 15], I, 530742520), u = j(u, v, w, t, x[o + 2], J, 3299628645), t = k(t, u, v, w, x[o + 0], K, 4096336452), w = k(w, t, u, v, x[o + 7], L, 1126891415), v = k(v, w, t, u, x[o + 14], M, 2878612391), u = k(u, v, w, t, x[o + 5], N, 4237533241), t = k(t, u, v, w, x[o + 12], K, 1700485571), w = k(w, t, u, v, x[o + 3], L, 2399980690), v = k(v, w, t, u, x[o + 10], M, 4293915773), u = k(u, v, w, t, x[o + 1], N, 2240044497), t = k(t, u, v, w, x[o + 8], K, 1873313359), w = k(w, t, u, v, x[o + 15], L, 4264355552), v = k(v, w, t, u, x[o + 6], M, 2734768916), u = k(u, v, w, t, x[o + 13], N, 1309151649), t = k(t, u, v, w, x[o + 4], K, 4149444226), w = k(w, t, u, v, x[o + 11], L, 3174756917), v = k(v, w, t, u, x[o + 2], M, 718787259), u = k(u, v, w, t, x[o + 9], N, 3951481745), t = c(t, p), u = c(u, q), v = c(v, r), w = c(w, s);
                        var O = m(t) + m(u) + m(v) + m(w);
                        return O.toLowerCase()
                    }, c = 48;
                    a.avatar = "http://www.gravatar.com/avatar/" + b(a.email) + ".jpg?d=retro&s=" + c
                }
                var d = '<li><div class="w28-img"><img src="' + a.avatar + '"></div>' + '<div class="cmtcnt yui3-u-1">' + '<div class="eR">' + '<div class="cmtune">' + '<a href="/user/' + a.nickname + '" target="_blank">' + a.nickname + "</a>" + "<span>" + a.commentTime + "</span>" + "</div>" + '<div class="HA"><a href="javascript:;" class="dR report" data-commentid="' + a.comment_id + '"" title="\u4e3e\u62a5\u5783\u573e\u8bc4\u8bba">\u4e3e\u62a5</a><a href="#commentPs" class="d-s Kv dR" data-target="@' + a.nickname + '">\u56de\u590d</a></div>' + "</div>" + '<div class="Ct"><p>' + a.commentContent + "</p></div>";
                return d
            };
        f.commentList.on("click", ".d-s", function () {
            var b = a(this).data("target") + "  ";
            return "" == f.targetInput[0].value && (d = []), j(b, d) ? !1 : (d.push(b), h(b, !0), f.targetInput.trigger("keyup"), void 0)
        }), f.commentList.on("mouseover", "li", function () {
            a(this).find(".report").show()
        }).on("mouseleave", "li", function () {
            a(this).find(".report").hide()
        }).on("click", ".report", function () {
            var b, c = {}, d = a(this).closest(".cmtcnt").find(".Ct");
            return c.comment_id = a(this).data("commentid"), d.next(".alert").length > 0 ? (alert("\u4e0d\u8981\u91cd\u590d\u4e3e\u62a5"), !1) : (a.getJSON("/comment/report_to_admin", c, function (c) {
                c.status && (b = a('<p class="alert">\u4f60\u5df2\u7ecf\u6210\u529f\u4e3e\u62a5\u6b64\u8bc4\u8bba\uff0c\u6b63\u5728\u7b49\u5f85\u963f\u8fbe\u660e\u5ba1\u6838</p>'), d.after(b), b.delay(1e3).fadeOut(1e3))
            }), void 0)
        }).on("click", ".delCmt", function () {
            var b = {
                comment_id: a(this).data("commentid")
            }, c = a(this);
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
        }), f.targetInput.on("keyup", function () {
            i(this)
        }).on("keydown", function (a) {
            a.ctrlKey && 13 == a.keyCode && f.targetForm.submit()
        }), f.emotion.on("click", "img", function () {
            var b = a(this),
                c = "[" + b.attr("title") + "]";
            h(c, !1), f.targetInput.trigger("keyup")
        }), f.targetForm.submit(function () {
            if ("" == a.trim(f.targetInput.val())) return alert("\u4ec0\u4e48\u90fd\u4e0d\u5199\u5c31\u60f3\u53d1\u8868\uff0c\u8fd9\u662f\u65e0\u58f0\u7684\u8d5e\u7f8e\u4e48\uff1f"), f.targetInput.val(""), !1;
            var b = {
                postid: a(c).data("postid"),
                title: a("h1.title").text(),
                content: f.targetInput[0].value,
                board_type: a(c).data("boardtype")
            };
            return a.post(a(this).attr("action"), b, function (b) {
                if ("0" == b.status) alert("\u4e0d\u7ba1\u4f60\u4fe1\u4e0d\u4fe1\uff0c\u53cd\u6b63\u8bc4\u8bba\u5931\u8d25\u4e86\u3002\u3002\u91cd\u8bd5\u4e00\u4e0b\u5427");
                else if ("-1" == b.status) alert("\u4f60\u8bc4\u8bba\u592a\u9891\u7e41\u4e86\uff0c\u4f11\u606f\u4e00\u4e0b\u5427\uff0c30\u79d2\u540e\u518d\u6765");
                else {
                    var c = a(k(b));
                    c.hide(), f.commentList.prepend(c), c.slideDown(), f.targetInput.val(""), d = []
                }
            }), !1
        });
        var l = {
            board_id: a(c).data("postid"),
            board_type: a(c).data("boardtype")
        };
        return f.getcomment.on("click", function () {
            var b = "",
                c = a(this);
            a.getJSON("/get_more_comments_by_board_id/", l, function (d) {
                return d.items.length < 1 ? (c.addClass("disabled").html("\u6ca1\u6709\u66f4\u591a\u4e86..."), !1) : (l.page = d.next, a.each(d.items, function (c, d) {
                    var e = a.extend({}, d, d.user_info);
                    b += k(e)
                }), f.commentList.append(b), void 0)
            })
        }), this
    }
}(window.jQuery);