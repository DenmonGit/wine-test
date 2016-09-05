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
<title>广告管理</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<script type="text/javascript">


		$(document).ready(function(){
			<%
			if(userInfo==null){
				%>
				window.parent.location.reload();
				return ;
			<%}
			%>
			$('#ad_list').datagrid({
				url : '<%=basePath%>webdata/ad/adList',
				fit : false,
				fitColumns : true,
				border : true,
				singleSelect:true,
				pagination : true,
				idField : 'adId',
				pageSize : 15,
				pageList : [ 15, 30 ],
			 	sortName : '',
				sortOrder : '',
				checkOnSelect : false,
				selectOnCheck : false,
				nowrap : true,
				toolbar:'#ad_table_tb', 
				columns : [[
				{
					align : 'center',
					title : '标题',
					field : 'title',
					width : 120	
				},{
					align : 'center',
					title : '创建人',
					field : 'author',
					width : 100

				},{
					align : 'center',
					title : '创建时间',
					field : 'addTime',
					width : 100

				},{
					align : 'center',
					title : '发布状态',
					field : 'status',
					width : 100,
				},
				{   
					align : 'center',
					field : 'action',
					title : '操作',
					width : 100,
					formatter : function(value, row, index) {
						 var adId = row.adId;
						 return '<a style="color:green" class="action" onclick="update(\''+adId+'\')">修改</a> <a style="color:red" class="action" onclick="deleteAd(\''+adId+'\')">删除</a>'; 
					}
				} ]]
			});
			
			$("#btn_add").click(function(){
				window.open('<%=basePath%>jf/ad/ad_add.jsp');
			});
			
		});
		
function update(adId){
			window.open('<%=basePath%>jf/ad/ad_edit.jsp?id='+adId);
}
		
function deleteAd(adId){
			$.messager.confirm('消息', '是否确定删除?', function(r){
				if (r){
					//删除广告	
					$.ajax({
						type : 'POST',
						url : '<%=basePath%>webdata/ad/delete',
						data : {'adId':adId},
						dataType : 'json',
						success : function(data) {	
							if(data.errcode==0){
								$.messager.alert('提示', '删除成功');
								$('#ad_list').datagrid("reload");
							}else{
								$.messager.alert('提示', data.errmsg);
							}
						},
						error:function(data){
							$.messager.show({
								title:"失败消息" ,
								msg:data.errmsg
							});
						}
					});
				}
			});
}
	 </script>
<style>
.action {
	cursor: pointer;
}

.action:hover {
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="datagrid-toolbar" id="ad_table_tb"
		style="height: 25px; background: #ffffff;" border="false">
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
			id="btn_add">添加</a>
	</div>
	<table id="ad_list"></table>
</body>
</html>