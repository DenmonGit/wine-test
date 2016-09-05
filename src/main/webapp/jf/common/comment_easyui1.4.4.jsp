<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link href="<%=basePath %>css/style.css" rel="stylesheet"
	type="text/css" />

<link href="<%=basePath %>js/easyui_1_4_4/themes/icon.css"
	rel="stylesheet" type="text/css" />
<link href="<%=basePath %>js/easyui_1_4_4/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<%=basePath %>js/easyui_1_4_4/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="<%=basePath %>js/easyui_1_4_4/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath %>js/easyui_1_4_4/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=basePath %>/ui_widget/My97DatePicker/WdatePicker.js"></script>
