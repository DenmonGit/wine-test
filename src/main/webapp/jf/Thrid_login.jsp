<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>红酒窝后台第三方登录</title>
	<link rel="icon" href="/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" type="text/css" href="http://sp1.jikexueyuan.com/static/v2.0/css/passport.min.css"/>
	<script src="http://sp1.jikexueyuan.com/static/v2.0/scripts/jquery.min.js"></script>
	<script src="http://sp1.jikexueyuan.com/static/v2.0/scripts/verify.js"></script>
	<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
    <script>
        var _hmt = _hmt || [];
        (function() {
          var hm = document.createElement("script");
          hm.src = "//hm.baidu.com/hm.js?d4d9ee1e5ed6885f44337f5bb337f67f";
          var s = document.getElementsByTagName("script")[0]; 
          s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script type="text/javascript">
    var _Sjkxy = [];
        _Sjkxy['jPro'] = 'passport';
        _Sjkxy['params'] = {posId:91000};
</script>	<!--feg-box end-->
	    <script src="http://wirrorcdn.jikexueyuan.com/stat/JKanalysis.js"></script>

<script type="text/javascript">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-50413628-16', 'auto');
    ga('send', 'pageview');
</script>
<script type='text/javascript'>
  // growingio埋点
  var _vds = _vds || [];
  window._vds = _vds;
  (function() {
      _vds.push(['setAccountId', 'aacd01fff9535e79']);

      var jkuid = new RegExp("(^| )uid=([^;]*)(;|$)");
      if (document.cookie.match(jkuid) && document.cookie.match(jkuid)[2]) {
        var uidVal = document.cookie.match(jkuid)[2];
          _vds.push(['setCS1', 'uid', uidVal]);
      }

      (function() {
          var vds = document.createElement('script');
          vds.type = 'text/javascript';
          vds.async = true;
          vds.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'dn-growing.qbox.me/vds.js';
          var s = document.getElementsByTagName('script')[0];
          s.parentNode.insertBefore(vds, s);
      })();
  })();
</script>
</head>

<body>
<div class="passport-wrapper">
<script src="http://sp1.jikexueyuan.com/static/v2.0/scripts/sign.js"></script>
<script src="http://sp1.jikexueyuan.com/static/scripts/setcookie.js"></script>
    <div class="passport-sign" align="center">       
        <div class="aside">
            <div class="sendgift"></div>
            <div class="passport-third" align="center">
                <header class="hd">
                    <div class="layout-inner">
                        <h1>第三方登录</h1>
                    </div>
                </header>
                <div class="links">
                    <a href="/connect/qq" jktag="0001|0.1|91061"><i class="passport-icon icon-tencent" ></i></a>
                    <a href="/connect/weibo" jktag="0001|0.1|91058"><i class="passport-icon icon-weibo"></i></a>
                    <a href="<%=basePath%>/jf/third_login/weixi_login.jsp" jktag="0001|0.1|91059"><i class="passport-icon icon-weixin"></i></a>
                    <a href="/connect/eoe" jktag="0001|0.1|91060"><i class="passport-icon icon-eoe"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>