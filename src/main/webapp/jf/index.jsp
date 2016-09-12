<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<%@ include file="/jf/common/title.jsp"%>
<link href="<%=basePath %>app/login/css/style.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath %>app/login/css/message.css" rel="stylesheet"
	type="text/css" />

<style type="text/css">
#panel {
	width: 100%;
	height: 100%;
	margin: auto;
	position: relative;
}

#wjl {
	width: 222px;
	height: 139px;
	position: absolute;
	min-width: 200px;
	margin-left: -40px;
	margin-top: -50px;
	top: 19%;
	left: 43%;
}

form {
	display: block;
	margin-top: 0em;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
    $("#submit").click(function(){
    	if (!$("#userName").val()) {
			alert('用户名不能为空！');
			return ;
		} else if (!$("#password").val()) {
			alert('密码不能为空！');
			return ;
		}
      $.ajax({
			type: 'post' ,
			url: '<%=basePath%>webdata/admin/login',
			cache:false ,
			data:{
				userName:$("#userName").val(),
				password:$("#password").val()
			} ,//序列化表单
			dataType:'json' ,
			success:function(result){
				if(result.errcode!=0){
					$.messager.alert('提示', result.errmsg);
				}else{
					window.location.href='<%=basePath%>jf/main.jsp';
				}
			} ,
			error:function(result){
				$.messager.alert('提示', result.errmsg);
			}
		});
    	
    });
});
$(document).keydown(function(event){

	if(event.keyCode==13){
		$("#submit").click();
	}
}); 
</script>
</head>
<body>
	<div id="alertMessage"></div>
	<div id="successLogin"></div>
	<div class="text_success">
		<img src="<%=basePath %>app/login/images/loader_green.gif"
			alt="Please wait" /> <span>页面加载中!请稍后....</span>
	</div>
	<div id="panel">
		<div id="wjl">
			<img id="wlogo" alt="" src="#" style="display: none">
		</div>
		<div id="login">
			<div class="inner">
				<div class="logo">
					<font color="#023C69" size="25">红酒窝运营平台</font>
				</div>
				<div class="formLogin">
					<form action="${ctx}/tsysLoginController.do" method="post"
						id="loginForm">
						<div>
							<input class="userName" name="u" type="text" id="userName"
								title="用户名" nullmsg="请输入用户名!" onfocus="this.select();" />
						</div>
						<div>
							<input class="password" name="p" type="password" id="password"
								title="密码" nullmsg="请输入密码!" onfocus="this.select();" />
						</div>

						<div>
							<a class="btn btn-info" id="submit">登录</a>
							<a href="<%=basePath%>jf/Thrid_login.jsp" class="btn btn-info_third" >第三方登录</a>
						</div>

					</form>
				</div>
			</div>

		</div>
	</div>
	<!--Login div-->
	<div class="clear"></div>


</body>
</html>