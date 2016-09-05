<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="changePassword_div" class="datagrid-toolbar"
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
			<td align="right" style="border: 1px solid #AEAEAE;">旧密码:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><input
				id="old_password" name="old_password" type="password" /></td>
		</tr>
		<tr>
			<td align="right" style="border: 1px solid #AEAEAE;">新密码:</td>
			<td style="border: 1px solid #AEAEAE; border-left: none;"><input
				id="new_password" name="new-password" type="password" /></td>
		</tr>
	</table>
</div>

