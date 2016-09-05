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
<title>用户管理</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<style>
a:hover {
	cursor: pointer;
	text-decoration: none;
	font-weight: bold;
}
</style>
<script>
	$(document).ready(function(){
		<%
		if(userInfo==null){
			%>
			window.parent.location.reload();
			return ;
		<%}
		%>
		$('#admin_user').datagrid({
			url : '<%=basePath%>webdata/admin/adminList',
			fit : false,		//自适应
			fitColumns:true ,	//自适应列
			border : false,		//边框
		    singleSelect:true,	//只允许选择一行
			rownumbers:true ,
			pagination : true,	//分页
		    idField : "id",  //创建数据表格的时候必须加上 
			pageSize : 15,
			pageList : [15,30,45,60],
			sortName : '',		//排序
			sortOrder : '',
			checkOnSelect : false,
			selectOnCheck : false,
		    striped:true,		//隔行变色
			nowrap : true,
			toolbar:'#tb_u',
			/*toolbar: [{
							iconCls: 'icon-add',
							text : "添加", 
							handler: function(){
									alert("添加功能无效，请联系开发人员");
								}
						},'-',{
							iconCls: 'icon-search',
							text : "查询", 
							handler: function(){
									alert("查询功能无效");
							}
						}],*/
			columns : [[
			            
						{
							align : 'center',
							title : '管理员ID',
							field : 'id',
							hidden : true
						},
						{
							align : 'center',
							title : '登录名',
							field : 'loginName',
							width : 40
						},{
							align : 'center',
							title : '用户名',
							field : 'nickName',
							width : 40
						},{
							align : 'center',
							title : '角色编号',
							field : 'roleId',
							hidden : true
						},{
							align : 'center',
							title : '角色名称',
							field : 'roleName',
							width : 40
						},{
							align : 'center',
							title : '状态',
							field : 'state',
							width : 10,
							formatter : function(value, row, index) {
								if(row.state==1){
									return '正常';
								}
								else{
									return '冻结';
								}
							
							}
						},{   
							align : 'center',
							field : 'action',
							title : '操作',
							width : 10,
							formatter : function(value, row, index) {
								var id=row.id;
								if(row.state==1){
									return '<a style="color:red" onclick="action('+ row.id+')">冻结</a> ';
								}
								else{
									return '<a style="color:green" onclick="action('+ row.id+')">解冻</a>';
									
								}
								
							}
							
						}]]
			});
		 $("#btn_add_admin").click(function(){
				$('<div id="add_admin_div"/>').dialog({
				href : '<%=basePath%>jf/admin/admin_add.jsp',
				width : 700,
				height : 450,
				modal : true,
				title : '添加运营账号',
				buttons:[{
					text:"添加",
					iconCls:"icon-add",
					handler:function(){
						var login_name = $("#login_name").val();
						var password = $("#password").val();
						var role_id=$("#role_id").combobox('getValue');
						//re = /^[1][0-9]{10}$/;
						if(login_name==null || login_name == '' || typeof(login_name) == undefined ){
							$.messager.alert({title:'警告!', msg:'登录名必须填写!'});
							return;
						}
						if(password==null || password == '' || typeof(nickName) == undefined){
							$.messager.alert({title:'警告!', msg:'密码必须填写!'});
							return;
						}
						if(role_id==null||role_id==''||typeof(role_id)==undefined){
							$.messager.alert({title:'警告！',msg:'角色不能为空！'});
						}
							$.ajax({
								type : 'POST',
								url : '<%=basePath%>webdata/admin/addAdminUser',
								data : {'loginName':$("#login_name").val(),'password':$("#password").val(),'nickName':$("#nick_name").val(),'roleId':$("#role_id").combobox('getValue'),'state':$("#state").val()},
								dataType : 'json',
								success : function(data) {
									if(data.errcode==0){
										$("#admin_user").datagrid('reload');
										$("#add_admin_div").dialog('destroy');
									}
									else{
										alert(data.errmsg);
									}
								}
							});
					}
				}],
				onClose : function() {
					$(this).dialog('destroy');
				}
			});//dialog
		});


	$("#btn_search_admin").click(function(){
		$('#admin_user').datagrid('load',{
			loginName: $("#loginName").val(),
			roleId: $("#roleId").combobox('getValue')
		});
	});
});
	


function action(id){
	$.ajax({
		type : 'POST',
		url : '<%=basePath%>webdata/admin/action',
		data:{
			'id':id,
		},
		dataType : 'json',
		success : function(data) {	
				if(data.errcode==0){
					$.messager.alert('提示', '成功');
					$('#admin_user').datagrid('reload');
				}
				else{
					$.messager.alert('提示', data.errmsg);
				}
		}
		
	});
}


function deleteAdmin(id){
	$.messager.confirm('消息','是否确认删除？',function(r){
		if(r){
			//删除管理人员 
			$.ajax({
				type : 'POST',
				url : '<%=basePath%>admin/deleteAdmin',
				data : {'id':id},
				dataType:'json',
				success : function(data){
					if(data.errcode==0){
						$.messager.alter('提示','删除成功');
						$('#admin_user').datagrid("reload");
					}else{
						$.message.alert('提示',data.errmsg);
					}
				}
			});
		}
		
	});
}
</script>
</head>
<body>
	<div style="height: 80%">
		<div id="tb_u" class="datagrid-toolbar"
			style="height: 60px; background: #ffffff;">
			<table class="FormView" border="0" cellspacing="0" cellpadding="0"
				style="background: #ffffff">
				<col class="Label" />
				<col class="Data" />
				<col class="Label" />
				<col class="Data" />
				<col class="Label" />
				<col class="Data" />
				<col class="Label" />
				<col class="Data" />
				<tr>
					<td align="right" style="border: 1px solid #AEAEAE;">登录名:</td>
					<td style="border: 1px solid #AEAEAE; border-left: none;"><input
						id="loginName" type="text" /></td>
					<td align="right" style="border: 1px solid #AEAEAE;">角色:</td>
					<td style="border: 1px solid #AEAEAE; border-left: none;"><input
						class="easyui-combobox" name="roleId" id="roleId" editable='false'
						data-options="url:'<%=basePath%>webdata/admin/getRoleComboBox',method: 'get',valueField:'id',textField:'text',groupField:'group',panelHeight:'auto'">
					</td>
				</tr>

			</table>
			<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
				id="btn_add_admin">添加</a> <a class="easyui-linkbutton"
				iconCls="icon-search" plain="true" id="btn_search_admin">查询</a>
		</div>
		<table id="admin_user"></table>
	</div>
</body>
</html>