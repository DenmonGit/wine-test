<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>广告添加</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<style>
.label {
	font-weight: bold;
}
</style>
<script type="text/javascript"
	src="<%=basePath %>ui_widget/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

		CKEDITOR.replace('editor01');
		$("#btn_add").click(function(){
			$("#filesform").form('submit',{
						url:"<%=basePath %>webdata/imageController/fileUpload",
						onSubmit:function(){

						},
						success:function(data){
							
							var data1=eval('('+data+')');
							if(data1.errcode==1){	
								$.messager.alert('请复制图片连接', data1.object);
							}
							else{
								$.messager.alert('提示', '上传失败');
							}
						//$.messager.alert('提示', data1.obj);
						},
				});
		});
		
		$("#cover_add").click(function(){
			$("#filesform").form('submit',{
						url:"<%=basePath %>webdata/imageController/fileUpload",
						onSubmit:function(){

						},
						success:function(data){
							
							var data1=eval('('+data+')');
							if(data1.errcode==1){	
								$("#cover").val(data1.object);
								$("#ad_img").attr("src",data1.object);
							}
							else{
								$.messager.alert('提示', data1.errmsg);
							}
						//$.messager.alert('提示', data1.obj);
						},
				});
		});
		
		$("#btn_sub").click(function(){
			var operateType = $("#operate_type").val();
			var winestoreaddr = $("#winestoreaddr").val();
			if(operateType == ""){
				$.messager.alert('提示', '请输入操作类型');
				return;
			}
			if(operateType == 2&&winestoreaddr==""){
				$.messager.alert('提示', '请输入酒淘淘地址');
				return;
			}
			$.ajax({
				type : 'POST',
				url : '<%=basePath%>webdata/ad/save',
				data:{
					'title':$("#title").val(),
					'cover':$("#cover").val(),
					'content':CKEDITOR.instances.editor01.getData(),
					'type':$("#ad_type").val(),
					'operate':operateType,
					'winestoreaddr':winestoreaddr
				},
				dataType : 'json',
				success : function(data) {	
						if(data.errcode==0){
							window.opener.location.reload();
							$.messager.alert('提示', '成功');
							window.close();
						}
						else{
							$.messager.alert('提示', data.errmsg);
						}
				}
		});
		});
		
	});
	function isshowaddr(obj){
		if($(obj).val() == 2){
			$("#tr1").show();
		} else {
			$("#tr1").hide();
		}
	}
	</script>
</head>
<body>
	<table>
		<tr>
			<td><span class="label">&nbsp&nbsp广告标题：</span></td>
			<td><input id="title" type="text" maxlength="200" name="title"
				size="150" /></td>
		</tr>
		<tr height="10px">
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td><span class="label">&nbsp&nbsp封面图片：</span></td>
			<td><img style="height: 100px" id="ad_img" /><input id="cover"
				type="hidden" maxlength="200" name="cover" size="130" /></td>
		</tr>
		<tr>
			<td><span class="label">&nbsp&nbsp封面操作类型：</span></td>
			<td><select id="operate_type" name="operate_type"
				onchange="isshowaddr(this)">
					<option selected="selected" value="0">不跳转</option>
					<option value="1">跳转自定义页面</option>
					<option value="2">跳转到网址</option>
			</select></td>
		</tr>
		<tr id="tr1" style="display: none">
			<td><span class="label">&nbsp&nbsp网址：</span></td>
			<td><img style="height: 100px" /><input id="winestoreaddr"
				maxlength="200" name="winestoreaddr" size="130" /></td>
		</tr>
		<tr>
			<td><span class="label">&nbsp&nbsp类型：</span></td>
			<td><select id="ad_type" name="type"><option value="1">已发布</option>
					<option value="2">未发布</option></select></td>
		</tr>
		<tr height="10px">
			<td></td>
			<td></td>
		</tr>
	</table>
	<div class="datagrid-toolbar"
		style="height: 25px; filter: alpha(opacity = 50); background: rgba(225, 225, 225, 0) none repeat scroll 0 0;"
		border="false">
		<form action="upload" method="post" enctype="multipart/form-data"
			id="filesform" style="display: inline-block">
			<input type="file" name="uploadFile" id="image" maxlength="15"
				size="20" style="display: inline-block; position: relative;" /> <input
				type="hidden" name="imageType" id="imageType" value="8"> <input
				type="hidden" name="imageType" id="flag" value="3" maxlength="15"
				size="20" style="display: inline-block; position: relative;" />

		</form>
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
			id="btn_add" style="display: inline-block; position: relative;">图片上传</a>
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
			id="cover_add" style="display: inline-block; position: relative;">封面上传</a>
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
			id="btn_sub" style="display: inline-block; position: relative;">发表</a>
	</div>
	<textarea rows="30" cols="50" name="content" id="editor01"></textarea>
</body>
</html>