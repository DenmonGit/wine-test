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
<title>模块管理</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<script>
$(document).ready(function(){
	<%
	if(userInfo==null){
		%>
		window.parent.location.reload();
		return ;
	<%}
	%>
	$("#btn_add").click(function(){
		var treeNode = $("#tt").tree('getSelected');
		if(treeNode==null){
			$.messager.alert('提示', '请选择要在哪个节点下添加');
		}
		else{
			var lv =  $("#tt").tree("getLevel",treeNode.target);
			if(lv>2){
				$.messager.alert('提示', '第三级节点下不可添加');
			}
			else{
				$("#formDiv").show();
				$("#parentId").val(treeNode.id);
				$("#id").val(-1);
				$("#modulName").val("");
				$("#url").val("");
				$("#index").val("");
			}
		}
	});
	
	$("#btn_edit").click(function(){
		var treeNode = $("#tt").tree('getSelected');
		if(treeNode==null){
			$.messager.alert('提示', '请选择要编辑的节点');
		}
		else{
			if(treeNode.id==0){
				$.messager.alert('提示', '根节点不可编辑');
			}
			else{
				//异步加载
				$.ajax({
					type: 'post' ,
					url: '<%=basePath%>webdata/admin/modulDetail',
					data:{
						'id':treeNode.id,
					},
					cache:false ,
					dataType:'json' ,
					success:function(result){
						if(result.errcode==0){
							$("#modulName").val(result.object.modulName);
							$("#url").val(result.object.url);
							$("#index").val(result.object.index);
							$("#formDiv").show();
							$("#parentId").val(-1);
							$("#id").val(treeNode.id);
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
				

			}
		}
	});
	
	$("#btn_remove").click(function(){
		$.messager.confirm("确认", "确认删除？", function (r) {  
	        if (r) {  
	        	var treeNode = $("#tt").tree('getSelected');
	        	
	        	$.ajax({
					type: 'post' ,
					url: '<%=basePath%>webdata/admin/deleteModul',
					data:{
						'id':treeNode.id,
					},
					cache:false ,
					dataType:'json' ,
					success:function(result){
						if(result.errcode==0){
							 $("#formDiv").hide();
							 $("#parentId").val(-1);
							 $("#id").val(-1);
							 $("#tt").tree("reload");
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
	            return true;  
	        }  
	    }); 
	});
	
	$("#btn_save").click(function(){
		$.ajax({
			type: 'post' ,
			url: '<%=basePath%>webdata/admin/saveModul',
			data:{
				'id':$("#id").val(),
				'parentId':$("#parentId").val(),
				'modulName':$("#modulName").val(),
				'url':$("#url").val(),
				'index':$("#index").val()
			},
			cache:false ,
			dataType:'json' ,
			success:function(result){
				if(result.errcode==0){
					 $("#formDiv").hide();
					 $("#parentId").val(-1);
					 $("#id").val(-1);
					 $("#tt").tree("reload");
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
	});
	
	$.extend($.fn.tree.methods, {
		
			    getLevel:function(jq,target){
		
			        var l = $(target).parentsUntil("ul.tree","ul");
		
			        return l.length+1;
		
			    }
		
	});
});
</script>

</head>
<body>
	<div class="easyui-layout" data-options="fit:true"
		style="width: 100%; overflow-y: hidden;" scroll="no">
		<div data-options="region:'north'" style="height: 43px">
			<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
				id="btn_add">新建</a> <a class="easyui-linkbutton" iconCls="icon-edit"
				plain="true" id="btn_edit">编辑</a> <a class="easyui-linkbutton"
				iconCls="icon-remove" plain="true" id="btn_remove">删除</a>
		</div>
		<div data-options="region:'west',split:true" title="模块树"
			style="width: 250px; height: 100%">
			<div class="easyui-panel" style="padding: 5px" fit="true">
				<ul id="tt" class="easyui-tree"
					data-options="url:'<%=basePath%>webdata/admin/modulTree',method:'get',animate:true"></ul>
			</div>
		</div>
		<div data-options="region:'center',iconCls:'icon-ok'">
			<div id="formDiv" style="display: none">
				<table border="0" cellspacing="0" cellpadding="0"
					style="background: #ffffff">
					<tr>
						<td align="right"
							style="border: 1px solid #AEAEAE; border-top: none; background-color: #E0EBFF; width: 100px; height: 40px">模块名:
						</td>
						<td
							style="border: 1px solid #AEAEAE; border-left: none; border-top: none"><input
							type="text" id="modulName" maxlength="30" /></td>
					</tr>
					<tr>
						<td align="right"
							style="border: 1px solid #AEAEAE; background-color: #E0EBFF; border-top: none; width: 100px; height: 40px">url:</td>
						<td
							style="border: 1px solid #AEAEAE; width: 100px; border-top: none; border-left: none">
							<input id="url" name="url" type="text" size="60" />
						</td>
					</tr>
					<tr>
						<td align="right"
							style="border: 1px solid #AEAEAE; width: 100px; border-top: none; background-color: #E0EBFF; height: 40px">排序号:
						</td>
						<td
							style="border: 1px solid #AEAEAE; border-left: none; border-top: none;">
							<input id="index" name="index" type="text" /><input id="id"
							name="id" type="hidden" /><input id="parentId" name="parentId"
							type="hidden" />
						</td>
					</tr>
				</table>
				<div style="width: 100%">
					<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
						id="btn_save"
						style="margin-left: 150px; margin-right: auto; width: 56px">保存</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>