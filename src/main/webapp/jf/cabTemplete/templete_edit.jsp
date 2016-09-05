<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=request.getParameter("id");
%>
<script>
	$(document).ready(function(){
		$.ajax({
			type : 'POST',
			url : '<%=basePath%>webdatav1/cabTemplete/detail',
			data:{'templeteId':'<%=id%>'},
			dataType : 'json',
			success : function(data) {
					if(data.errcode==0){
						//alert(data.object.cabRow);
						$("#templete_id").val(data.object.templeteId);
						$("#templete_name").val(data.object.cabName);
						//$("#row").val(data.object.cabRow);
						$("#row").numberbox('setValue',data.object.cabRow);
						$("#img_image").attr("src",data.object.image);
						$("#image_url").val(data.object.image);
						//$("#column").val(data.object.cabColumn);
						$("#column").numberbox('setValue',data.object.cabColumn);
					}
					else{
						$.messager.alert('提示', data.errmsg);
					}
			}
	});
	});
</script>
<style>
#img_table {
	margin-top: -13;
	padding: 0
}
</style>
<div>
	<div id="search" style="border-bottom: 1px solid #AEAEAE">
		<form method="post" id="updateform" action="upload">
			<table class="FormView" border="0" cellspacing="0" cellpadding="0"
				style="background: #ffffff">
				<col class="Label" />
				<col class="Data" />


				<tr>
					<td align="right"
						style="border: 1px solid #AEAEAE; border-bottom: none">模版名:
					</td>
					<td
						style="border: 1px solid #AEAEAE; border-left: none; border-bottom: none;">
						<input type="text" name="templeteName" id="templete_name"
						maxlength="15" class="easyui-validatebox textbox" required=true
						validType="midLength[1,20]" invalidMessage="模板名称必须在1-20个字符之间!"
						style="width: 200px; height: 27px" value="" /><input type="hidden"
						name="templeteId" id="templete_id" maxlength="15" size="20"
						value="" />
					</td>
				</tr>
				<tr>
					<td align="right"
						style="border: 1px solid #AEAEAE; border-bottom: none">行数:</td>
					<td
						style="border: 1px solid #AEAEAE; border-left: none; border-bottom: none;">
						<input type="text" name="row" id="row" class="easyui-numberbox"
						data-options="min:1,max:999,precision:0" required=true
						style="width: 200px; height: 27px" value="" />
					</td>
				</tr>
				<tr>
					<td align="right"
						style="border: 1px solid #AEAEAE; border-bottom: none">列数:</td>
					<td
						style="border: 1px solid #AEAEAE; border-left: none; border-bottom: none;">
						<input type="text" name="column" id="column"
						class="easyui-numberbox" data-options="min:1,max:999,precision:0"
						required=true style="width: 200px; height: 27px" value="" /><input
						type="hidden" name="imageUrl" id="image_url" value="" /><input
						type="hidden" name="background" id="background" value=""} />
					</td>
				</tr>

			</table>
		</form>
		<table id="img_table" class="FormView" border="0" cellspacing="0"
			cellpadding="0" style="background: #ffffff">
			<col class="Label" />
			<col class="Data" />



			<tr>
				<td align="right"
					style="border: 1px solid #AEAEAE; border-bottom: none">图片:</td>

				<td
					style="border: 1px solid #AEAEAE; border-left: none; border-bottom: none;">
					<form action="upload" method="post" enctype="multipart/form-data"
						id="filesform">
						<input type="file" name="uploadFile" id="image" maxlength="15"
							size="20" /><img id="img_image" src="" style="height: 60px" /> <input
							type="hidden" name="imageType" id="imageType" value="6">
					</form>
				</td>
			</tr>

		</table>
	</div>
</div>
