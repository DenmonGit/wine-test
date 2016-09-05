<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
<title>公共easyui的js包</title>
<link href="${ctx }/js/easyui/themes/icon.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx }/js/easyui/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/js/easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="${ctx }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${ctx }/js/easyui/locale/easyui-lang-zh_CN.js"></script>

</head>
<body>

</body>
</html>
