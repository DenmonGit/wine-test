<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="tb_add_u" class="datagrid-toolbar"
	style="height: 60px; background: #ffffff;">
	<table class="FormView" border="0" cellspacing="0" cellpadding="0"
		align="center" style="background: #ffffff">
		<col class="Label" />
		<col class="Data" />
		<col class="Label" />
		<col class="Data" />
		<col class="Label" />
		<col class="Data" />
		<col class="Label" />
		<col class="Data" />
		<tr>
			<td align="center" style="border: 1px solid #AEAEAE;">登录名:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><input
				id="login_name" type="text" /></td>
		</tr>
		<tr>
			<td align="center" style="border: 1px solid #AEAEAE;">密码:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><input
				id="password" type="password" /></td>
		</tr>
		<tr>
			<td align="center" style="border: 1px solid #AEAEAE;">昵称:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><input
				id="nick_name" type="text" style="color: grey"
				onfocus='if(this.value==document.getElementById("login_name").value){this.value="";} ; '
				onblur='if(this.value==""){this.value=document.getElementById("login_name").value;};' /></td>
		</tr>
		<tr>
			<td align="center" style="border: 1px solid #AEAEAE;">角色:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><input
				class="easyui-combobox" name="role_id" id="role_id" editable='false'
				data-options="url:'<%=basePath%>webdata/admin/getAddRoleComboBox',method: 'get',valueField:'id',textField:'text',groupField:'group',panelHeight:'auto'">

			</td>
		</tr>
		<tr>
			<td align="center" style="border: 1px solid #AEAEAE;">状态:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><select
				style="width: 100px; height: 25px" name="state" id="state">
					<option value="1">正常</option>
					<option value="0">冻结</option>
			</select></td>
		</tr>
	</table>
</div>

