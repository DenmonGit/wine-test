<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String versionInfo = (String)session.getAttribute("versionInfo");
String userInfo = (String)session.getAttribute("adminInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>运营后台主页</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<script type="text/javascript">
	var clickNum=0;
	$(document).ready(function(){
		<%
		if(userInfo==null){
			%>
			window.location.href='<%=basePath%>jf/index.jsp';
			return ;
		<%}
		%>
		//加载模块
		$.ajax({
			type: 'post' ,
			url: '<%=basePath%>webdata/admin/modulList',
			cache:false ,
			dataType:'json' ,
			success:function(result){
				if(result.errcode==0){
					$('#aa').empty();
					for(var i=0;i<result.object.length;i++){
						$('#aa').accordion('add',{
							title:result.object[i].modulName,
							//content:'<div id="'+result.object[i].id+'" class="menu14"></div>'
						});
						for(var j=0;j<result.object[i].children.length;j++){
							//alert("1");
							//alert($('#aa').accordion('getPanel',result.object[i].modulName));
							$('#aa').accordion('getPanel',result.object[i].modulName).append('<div class="menu13" onclick="addTab(this)" data="'+result.object[i].children[j].url+'">'+result.object[i].children[j].modulName+'</div>');
						}
					}
					$('#aa').accordion({ border: false, fit: true });
				}else{
					if(result.errcode==996){
						window.location.href='<%=basePath%>jf/main.jsp';
					}
					else{
						$.messager.show({
							title:"失败消息" , 
							msg:result.errmsg
						});
					}
				}
			} ,
			error:function(result){
				$.messager.show({
					title:"失败消息" ,
					msg:result.errmsg
				});
			}
		});
		
		$("#logout").click(function(){
			window.location.href='<%=basePath%>webdata/admin/logout';
		});
		
		$("#changePwd").click(function(){
			$('<div id="changePassword_div"/>').dialog({
				href : '<%=basePath%>jf/changePassword.jsp',
				width : 400,
				height : 250,
				modal : true,
				title : '修改密码',
				buttons:[{
					text:"确定",
					iconCls:"icon-add",
					handler:function(){
						var newPassword = $("#new_password").val();
						var oldPassword = $("#old_password").val();
						if(newPassword==null || newPassword == '' || typeof(newPassword) == undefined){
							$.messager.alert({title:'警告!', msg:'新密码必填!'});
							return;
						}
						if(oldPassword==null || oldPassword == '' || typeof(oldPassword) == undefined){
							$.messager.alert({title:'警告!', msg:'旧密码必填!'});
							return;
						}
							$.ajax({
								type : 'POST',
								url : '<%=basePath%>webdata/admin/modifyPassword',
								data : {
									'password':newPassword,
									'oldPassword':oldPassword
									},
								dataType : 'json',
								success : function(data) {
									if(data.errcode==0){
										window.location.href="<%=basePath%>jf/index.jsp"; 
										$("#changePassword_div").dialog('destroy');
									}else{
										alert(data.errmsg);
									}
									
										
								}
							});
					}
				},{
					text:"取消",
					iconCls:"icon-no",
					handler:function(){
						$("#changePassword_div").dialog('destroy');
					}
				}],
				onClose : function() {
					$(this).dialog('destroy');
				}
			});//dialog
		});
		
		$("#helper").click(function(){
			$.messager.show({
				title:"警告" , 
				msg:"└(^o^)┘需要帮助请联系开发人员，谢谢!"
			});
		});
		
		$("#title13").click(function(){
			clickNum++;
			if(clickNum%5==0){
				$.messager.show({
					title:"提示" , 
					msg:"恭喜你获得了隐藏奖励，再次点击领取奖励"
				});
			}
			else{
				$.messager.show({
					title:"提示" , 
					msg:"你点击了："+clickNum+"次"
				});
			}
		});
		
		$(".menu13").click(function(){
			$(".menu13").removeClass("click-menu");
			$(this).addClass("click-menu")
			var title = $(this).html();
			//var tab = $('#tt').tabs("getTab","New Tab");
			if(tab==null){
				$('#tt').tabs('add',{  
					     title:title,  
					     content:'<iframe scrolling="auto" src="<%=basePath%>'+$(this).attr('data')+'" style="height:100%;width:100%" frameborder="0"></iframe>',  
					     closable:true 
				});
			}
			else{
				$('#tt').tabs("select",tab.panel("options").title);
			}
		});
		
	});
function addTab(a){

	$(".menu13").removeClass("click-menu");
	$(a).addClass("click-menu")
	var title = $(a).html();
	var url = $(a).attr('data');
	var tab = $('#tt').tabs("getTab",title);
	if(tab==null){
		$('#tt').tabs('add',{  
			     title:title,  
			     content:'<iframe scrolling="auto" src="<%=basePath%>'+url+'" style="height:100%;width:100%" frameborder="0"></iframe>',  
			     closable:true 
		});
	}
	else{
		$('#tt').tabs("select",tab.panel("options").title);
	}
}
</script>
<style>
.menu13 {
	cursor: pointer;
	text-align: left;
	font-size: 15px;
	padding-top: 5px;
	padding-left: 25px;
	background-color: #ebf2fe;
	margin-bottom: 2px;
	padding-right: 20px;
}

.menu13:hover {
	background-color: #FFE66F;
}

.click-menu {
	background-color: #FFE66F;
}

.menu14 {
	overflow: auto;
	padding: 10px;
	height: auto;
}

#title13 {
	text-align: right;
	width: 100%;
	margin-left: 200px;
	font-size: 25px;
	font-family: 黑体;
	font-weight: bold;
	text-shadow: 2px 3px 2px #000;
	color: #fff
}

.overimg {
	position: relative;
	display: block;
}

.light {
	cursor: pointer;
	position: absolute;
	left: -100px;
	top: 0;
	width: 50px;
	height: 29px;
	background-image: -moz-linear-gradient(0deg, rgba(255, 255, 255, 0),
		rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0));
	background-image: -webkit-linear-gradient(0deg, rgba(255, 255, 255, 0),
		rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0));
	transform: skewx(-25deg);
	-o-transform: skewx(-25deg);
	-moz-transform: skewx(-25deg);
	-webkit-transform: skewx(-25deg);
}

.overimg:hover .light {
	left: 2000px;
	-moz-transition: 1s;
	-o-transition: 1s;
	-webkit-transition: 1s;
	transition: 1s;
}
</style>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true"
		style="width: 100%; overflow-y: hidden;" scroll="no">
		<div data-options="region:'north'"
			style="height: 78px; overflow-x: hidden">
			<div class="maintop2" style="width: 100%;">
				<div class="maintop1">
					<p class="overimg">
						<span id="title13" style="cursor: pointer" title="点我(＞﹏＜)">红酒窝运营平台</span><i
							class="light"></i>
					</p>
				</div>
				<div style="width: 393px; height: 45px; margin: 0; float: right;">
					<div class="bs" style="width: 50px">
						<a class="styleswitch a3" style="CURSOR: pointer" title="天蓝色"
							rel="blue"></a> <a class="styleswitch a2" style="CURSOR: pointer"
							title="竹绿色" rel="green"></a> <a class="styleswitch a4"
							style="CURSOR: pointer" title="黑灰色" rel="gray"></a> <a
							class="styleswitch a5" style="CURSOR: pointer" title="艳红色"
							rel="pink"></a>
					</div>
					<div class="maintop3"></div>
					<div class="maintop4">
						<a href="#1" style="text-decoration: none;"><b>控制面板</b></a> | <a
							href="#2" id="helper" style="text-decoration: none;"><b>帮助</b></a>
						| <a id="changePwd" href="#4" style="text-decoration: none;"><b>修改密码</b></a>
						| <a id="logout" href="javascript:void(0)"
							style="text-decoration: none;"><b>退出</b></a>
					</div>
					<div class="maintop5"></div>
				</div>
			</div>
			<div class="maintop6">
				<div
					style="float: right; margin-top: 10px; font-weight: bold; margin-right: 35px">
					<span id="versionInfo"><%=versionInfo %></span> 【当前登录用户】：<span
						id="userInfo"><%=userInfo %></span>
				</div>
			</div>
		</div>
		<div data-options="region:'west',split:true" title="导航菜单"
			style="width: 200px; height: 100%">
			<div id="aa" class="easyui-accordion"
				style="width: auto; height: auto;" fit="true"></div>
		</div>
		<div data-options="region:'center',iconCls:'icon-ok'">
			<div id="tt" class="easyui-tabs" style="width: 100%; height: auto;"
				fit="true"></div>
		</div>
	</div>
</body>
</html>