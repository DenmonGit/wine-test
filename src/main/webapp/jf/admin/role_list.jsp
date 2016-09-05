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
<title>角色管理</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<style>
#roleList {
	margin: 0;
	padding: 0;
}

.roleli {
	list-style-type: none;
	cursor: pointer;
	width: 100%;
}

.roleli:hover {
	background-color: RGB(51, 151, 255);
}

.select {
	background-color: RGB(51, 151, 255);
	width: 100%;
}
</style>
<script>
var s_index;
	$(document).ready(function(){
		<%
		if(userInfo==null){
			%>
			window.parent.location.reload();
			return ;
		<%}
		%>
		
		$("#tt").tree({
			checkbox: true,
            cascadeCheck: false,
            animate:true
		});
		$("#tt").hide();
		
		//$("#tt").hide();
		loadRole();
		
		$("#btn_add").click(function(){
			reloadTree(-1);
			$("#roleId").val(-1);
			$("#formDiv").show();
		});
		
		$("#btn_remove").click(function(){
			$.messager.confirm("确认", "确认删除？", function (r) {  
		        if (r) {  
		        	if(s_index==null){
						$.messager.show({
							title:"失败消息" ,
							msg:'请选择一个角色'
						});
					}
		        	else{
			        	$.ajax({
							type: 'post' ,
							url: '<%=basePath%>webdata/admin/roleDelete',
							data:{
								'roleId':s_index.attr('id'),
							},
							cache:false ,
							dataType:'json' ,
							success:function(result){
								if(result.errcode==0){
									 $("#formDiv").hide();
									 $("#roleName").val("");
									 $("#roleId").val(-1);
									 loadRole();
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
		            return true;  
		        }  
		    }); 
		});
		
		$("#btn_edit").click(function(){
			if(s_index==null){
				$.messager.show({
					title:"失败消息" ,
					msg:'请选择一个角色'
				});
			}
			else{
				if(s_index.attr('id')<2){
					$.messager.show({
						title:"失败消息" ,
						msg:'系统级别管理不可编辑'
					});
				}
				else{
					reloadTree(s_index.attr('id'));
					$("#roleName").val(s_index.html());
					$("#roleId").val(s_index.attr('id'));
					$("#formDiv").show();
				}
			}
		});
		
		$("#btn_save").click(function(){
			 var nodes = $("#tt").tree('getChecked');
			 var s = '';
             for (var i = 0; i < nodes.length; i++) {
                 if (s != '')
                     s += ',';
                 if(nodes[i].id!=0){
                 	s += nodes[i].id;
                 }
             }
             $.ajax({
     			type: 'post' ,
     			url: '<%=basePath%>webdata/admin/saveRole',
     			data:{
     				'roleId':$("#roleId").val(),
     				'modulIds':s,
     				'roleName':$("#roleName").val()
     			},
     			cache:false ,
     			dataType:'json' ,
     			success:function(result){
     				if(result.errcode==0){
     					loadRole();
     					$("#roleId").val(-1);
     					$("#roleName").val("");
     					$("#tt").hide();
     					$("#formDiv").hide();
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
	});
	
function reloadTree(roleId){
	$.ajax({
		type: 'post' ,
		url: '<%=basePath%>webdata/admin/roleCheckedModul',
		data:{
			'roleId':roleId,
		},
		cache:false ,
		dataType:'json' ,
		success:function(result){
			if(result.errcode==0){
				$("#tt").tree('loadData',result.object)
				$("#tt").show();
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

function select(a){
	if(s_index!=null){
		s_index.removeClass("select");
	}
	s_index = $(a);
	
	s_index.addClass("select");
}

function loadRole(){
	$.ajax({
		type: 'post' ,
		url: '<%=basePath%>webdata/admin/roleList',
		cache:false ,
		dataType:'json' ,
		success:function(result){
			if(result.errcode==0){
				$("#roleList").empty();
				for(var i=0;i<result.object.length;i++){
					$("<li onclick='select(this)' class='roleli' id='"+result.object[i].roleId+"'>"+result.object[i].roleName+"</li>").appendTo($("#roleList"));
				}
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
		<div data-options="region:'west',split:true" title="角色列表"
			style="width: 250px; height: 100%">
			<div class="easyui-panel" style="padding: 5px" fit="true">
				<ul id="roleList"></ul>
			</div>
		</div>
		<div data-options="region:'center',iconCls:'icon-ok'">
			<div class="easyui-layout" data-options="fit:true"
				style="width: 100%; overflow-y: hidden;" scroll="no">
				<div data-options="region:'west',split:true" title="模块树"
					style="width: 250px; height: 100%">
					<div class="easyui-panel" style="padding: 5px" fit="true">
						<ul id="tt" class="easyui-tree"></ul>
					</div>
				</div>
				<div data-options="region:'center',iconCls:'icon-ok'">
					<div id="formDiv" style="display: none">
						<table border="0" cellspacing="0" cellpadding="0"
							style="background: #ffffff">
							<tr>
								<td align="right"
									style="background-color: #E0EBFF; width: 100px; height: 40px">角色名:
								</td>
								<td style=""><input type="text" id="roleName"
									maxlength="30" /><input type="hidden" id="roleId" /></td>
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
		</div>
	</div>
	</div>
</body>
</html>