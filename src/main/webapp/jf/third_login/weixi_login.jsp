<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>微信登录</title>
<meta charset="utf-8">
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>

<link rel="stylesheet"
	href="https://res.wx.qq.com/connect/zh_CN/htmledition/style/impowerApp29579a.css">
<link
	href="https://res.wx.qq.com/connect/zh_CN/htmledition/images/favicon16cb56.ico" rel="Shortcut Icon">
<script src="https://res.wx.qq.com/connect/zh_CN/htmledition/js/jquery.min29f55f.js"></script>
</head>
<body>
	<div class="main impowerBox">
		<div class="loginPanel normalPanel">
			<div class="title">微信登录</div>
			<div class="waiting panelContent">
				<div class="wrp_code">
					<img class="qrcode lightBorder"
						src="<%=basePath %>app/login/images/weixin.jpg" />
				</div>
				<div class="info">
					<div class="status status_browser js_status" id="wx_default_tip">
						<p>请使用微信扫描二维码登录</p>
						<p>“红酒窝后台管理”</p>
					</div>
					<div class="status status_succ js_status" style="display: none"
						id="wx_after_scan">
						<i class="status_icon icon38_msg succ"></i>
						<div class="status_txt">
							<h4>扫描成功</h4>
							<p>请在微信中点击确认，就可以转到目的页面</p>
						</div>
					</div>
					<div class="status status_fail js_status" style="display: none"
						id="wx_after_cancel">
						<i class="status_icon icon38_msg warn"></i>
						<div class="status_txt">
							<h4>您已取消此次登录</h4>
							<p>您可再次扫描登录，或关闭窗口</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		function AQ_SECAPI_ESCAPE(a, b) {
			for (var c = new Array, d = 0; d < a.length; d++)
				if ("&" == a.charAt(d)) {
					var e = [ 3, 4, 5, 9 ], f = 0;
					for ( var g in e) {
						var h = e[g];
						if (d + h <= a.length) {
							var i = a.substr(d, h).toLowerCase();
							if (b[i]) {
								c.push(b[i]), d = d + h - 1, f = 1;
								break
							}
						}
					}
					0 == f && c.push(a.charAt(d))
				} else
					c.push(a.charAt(d));
			return c.join("")
		}
		function AQ_SECAPI_CheckXss() {
			for (var a = new Object, b = "'\"<>`script:daex/hml;bs64,", c = 0; c < b.length; c++) {
				for (var d = b.charAt(c), e = d.charCodeAt(), f = e, g = e.toString(16), h = 0; h < 7 - e.toString().length; h++)
					f = "0" + f;
					a["&#" + e + ";"] = d, a["&#" + f] = d, a["&#x" + g] = d
			}
			a["&lt"] = "<",a["&gt"]=">", a["&quot"] = '"';
			var i = location.href, j = document.referrer;
			i = decodeURIComponent(AQ_SECAPI_ESCAPE(i, a)),
					j = decodeURIComponent(AQ_SECAPI_ESCAPE(j, a));
			var k = new RegExp("['\"<>`]|script:|data:text/html;base64,");
			if (k.test(i) || k.test(j)) {
				var l = "1.3", m = "http://zyjc.sec.qq.com/dom", n = new Image;
				n.src = m + "?v=" + l + "&u=" + encodeURIComponent(i) + "&r="
						+ encodeURIComponent(j), i = i.replace(
						/['\"<>`]|script:/gi, ""),
						i = i.replace(/data:text\/html;base64,/gi,
								"data:text/plain;base64,"), location.href = i
			}
		}
		AQ_SECAPI_CheckXss();
	</script>
	<script>
		!function() {
			function a(c) {
				jQuery
						.ajax({
							type : "GET",
							url : "https://long.open.weixin.qq.com/connect/l/qrconnect?uuid=0316vOB1CdY8t0qa"
									+ (c ? "&last=" + c : ""),
							dataType : "script",
							/*https://open.weixin.qq.com/connect/qrconnect?appid=wxadfc3188c82ef252
									&redirect_uri=http%3A%2F%2Fpassport.jikexueyuan.com%2Fconnect%2Fsuccess%3Ft%3Dweixin
									&response_type=code
									&scope=snsapi_login
									&t=weixin&state=weixin#wechat_redirect 
							view-source:https://open.weixin.qq.com/connect/qrconnect?appid=wxadfc3188c82ef252
									&redirect_uri=http%3A%2F%2Fpassport.jikexueyuan.com%2Fconnect%2Fsuccess%3Ft%3Dweixin
									&response_type=code
									&scope=snsapi_login
									&t=weixin&state=weixin#wechat_redirect*/
							cache : !1,
							timeout : 6e4,
							success : function(c, d, e) {
								var f = window.wx_errcode;
								switch (f) {
								case 405:
									var g = "http://passport.jikexueyuan.com/connect/success?t=weixin";
									if (g = g.replace(/&amp;/g, "&"), g += (g
											.indexOf("?") > -1 ? "&" : "?")
											+ "code="
											+ wx_code
											+ "&state=weixin", b)
										try {
											document.domain = "qq.com";
											var h = window.top.location.host
													.toLowerCase();
											h && (window.location = g)
										} catch (i) {
											window.top.location = g
										}
									else
										window.location = g;
									break;
								case 404:
									jQuery(".js_status").hide(), jQuery(
											"#wx_after_scan").show(),
											setTimeout(a, 2e3, f);
									break;
								case 403:
									jQuery(".js_status").hide(), jQuery(
											"#wx_after_cancel").show(),
											setTimeout(a, 2e3, f);
									break;
								case 402:
								case 500:
									window.location.reload();
									break;
								case 408:
									setTimeout(a, 2e3)
								}
							},
							error : function(b, c, d) {
								var e = window.wx_errcode;
								408 == e ? setTimeout(a, 5e3) : setTimeout(a,
										5e3, e)
							}
						})
			}
			var b = window.top != window;
			if (b) {
				var c = "";
				"white" != c && (document.body.style.color = "#373737")
			} else {
						document.getElementsByClassName
								|| (document.getElementsByClassName = function(
										a) {
									for (var b = [], c = new RegExp("(^| )" + a
											+ "( |$)"), d = document
											.getElementsByTagName("*"), e = 0, f = d.length; f > e; e++)
										c.test(d[e].className) && b.push(d[e]);
									return b
								}),
						document.body.style.backgroundColor = "#333333",
						document.body.style.padding = "50px";
				for (var d = document.getElementsByClassName("status"), e = 0, f = d.length; f > e; ++e) {
					var g = d[e];
					g.className = g.className + " normal"
				}
			}
			var h = "";
			if (h) {
				var i = document.createElement("link");
				i.rel = "stylesheet", i.href = h, document
						.getElementsByTagName("head")[0].appendChild(i)
			}
			setTimeout(a, 2e3)
		}();
	</script>
</body>
</html>
