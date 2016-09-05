<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String versionInfo=(String)session.getAttribute("versionInfo");
	String userInfo=(String)session.getAttribute("adminInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>酒柜模块管理</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp" %>
<style>
	.action{
		cursor:pointer;
	}
	.action:hover{
		font-weight:bold;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		<% if(userInfo==null){%>
			window.parent.location.reload();		
		
		<%}%>
		$('#cab_templete_list').datagrid({
			url:'<%=basePath%>webdatav1/cabTemplete/list',
			fit:false,
			fitColums:true,
			border:true,
			singleSelect:true,
			pagination:true,
			idField:"templeteId",
			pageSize:15,
			pageList:[15,30],
			sortName:'',
			sortOrder:'',
			checkOnSelect:false,
			selectOnCheck:false,
			nowrap:true,
			toolbar:'#cab_templete_table_tb',
			columns:[[
			      {
			    	  align:'center',
			    	  title:'酒柜模板名称',
			    	  field:'cabName',
			    	  width:120,
			      },{
			    	  align:'center',
			    	  field:'action',
			    	  title:'操作',
			    	  width:100,
			    	  formatter:function(value,row,index){
			    		  var templeteId=row.templeteId;
			    		  return '<a style="color:green" class="action" onclick="updateCab(\''+templeteId+'\')">修改</a> <a style="color:red" class="action" onclick="deleteCab(\''+templeteId+'\')">删除</a>';
			    	  }
			      }
			          
			          ]]
		});
		//webdatav1/cabTemplete/save
		//webdata/imageController/fileUpload
		$("#btn_add").click(function(){
			$('<div id="addCab"/>').dialog({
				href : '<%=basePath%>jf/cabTemplete/templete_add.jsp',
				width : 700,
				height : 450,
				modal : true,
				title : '添加模版',
				buttons:[{
					text:"新增",
					iconCls:"icon-add",
					handler:function(){
						if($('#addform').form('validate')){
							$("#addform").form('submit',{
								url:"<%=basePath%>webdatav1/cabTemplete/save",
								onSubmit:function(){
									if($("#img_image").attr("src")=="" || $("#img_image").attr("src") ==null || $("#img_image").attr("src")==undefined){
										$.messager.alert('提示', '请上传图片');
										return false;
									}
								},
								success:function(data){
									//alert(data);
									var data1=eval('('+data+')');
									if(data1.errcode==0){
										$.messager.alert('提示', '新增成功');
										$("#cab_templete_list").datagrid('reload');
										$("#addCab").dialog('destroy');
									} 
									else{
										$.messager.alert('提示', '新增失败');
									}
								//$.messager.alert('提示', data1.obj);
								},
								});
						}else {
							$.messager.show({
								title:'提示信息!' ,
								msg:'数据验证不通过,不能保存!'
							});
						}
					}
				},{
					text:"图片上传",
					iconCls:"icon-add",
					handler:function(){
		        		$("#filesform").form('submit',{
						url:"<%=basePath %>webdata/imageController/fileUpload",
						onSubmit:function(){
					
						},
						success:function(data){
							
							var data1=eval('('+data+')');
							if(data1.errcode==1){
								//alert(data1.object[0]);
								$("#image_url").val(data1.object);
								$("#img_image").attr("src",data1.object);
								$.messager.alert('提示', data1.errmsg);
							}
							else{
								$.messager.alert('提示', data1.errmsg);
							}
						//$.messager.alert('提示', data1.obj);
						},
						});
						
					}
				}],
				onClose : function() {
					$(this).dialog('destroy');
				}
			});//dialog
		});
		
		
	});
	
function deleteCab(templeteId){
	$.messager.confirm('删除','是否确认删除？',function(r){
		if(r){
			$.ajax({
				type:'post',
				url:'<%=basePath%>webdatav1/cabTemplete/deleteCab',
				data:{'templeteId':templeteId},
				dataType:'json',
				success:function(data){
					if(data.errcode==0){
						$.messager.alert({
							title:'删除成功',
							msg:'删除酒柜模板成功！'
						});
						$('#cab_templete_list').datagrid("reload");
					}else{
						$.messager.show("提示",data.errmsg);
					}
				}
			});
		}
		
	});
}

//wedatav1/cabTemplete/updateCab
//webdata/imageController/fileUpload
function updateCab(templeteId){
	$('<div id="updateCab"/>').dialog({
		href : '<%=basePath%>jf/cabTemplete/templete_edit.jsp?id='+templeteId,
		width : 700,
		height : 450,
		modal : true,
		title : '修改模版',
		buttons:[{
			text:"保存",
			iconCls:"icon-add",
			handler:function(){
				if($('#updateform').form('validate')){
					
					$("#updateform").form('submit',{
						url:"<%=basePath%>webdatav1/cabTemplete/updateCab",
						onSubmit:function(){
							if($("#img_image").attr("src")=="" || $("#img_image").attr("src") ==null || $("#img_image").attr("src")==undefined){
								$.messager.alert('提示', '请上传图片');
								return false;
							}
						},
						success:function(data){
							//alert(data);
							var data1=eval('('+data+')');
							if(data1.errcode==0){
								$.messager.alert('提示', '修改成功');
								$("#cab_templete_list").datagrid('reload');
								$("#updateCab").dialog('destroy');
							} 
							else{
								$.messager.alert('提示', '修改失败');
							}
						//$.messager.alert('提示', data1.obj);
						},
						});
				}else {
					$.messager.show({
						title:'提示信息!' ,
						msg:'数据验证不通过,不能保存!'
					});
				}
        		
			}
		},{
			text:"图片上传",
			iconCls:"icon-add",
			handler:function(){
        		$("#filesform").form('submit',{
				url:"<%=basePath %>webdata/imageController/fileUpload",
				onSubmit:function(){
			
				},
				success:function(data){
					
					var data1=eval('('+data+')');
					if(data1.errcode==1){
						//alert(data1.object[0]);
						$("#image_url").val(data1.object);
						$("#img_image").attr("src",data1.object);
						$.messager.alert('提示', data1.errmsg);
					}
					else{
						$.messager.alert('提示', data1.errmsg);
					}
				//$.messager.alert('提示', data1.obj);
				},
				});
				
			}
		}],
		onClose : function() {
			$(this).dialog('destroy');
		}
	});//dialog
}
</script>
</head>
<body>
	<div class="datagrid-toolbar" id="cab_templete_table_tb" 
	style="height:25px;backgroud:#ffffff;" border="false">
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true" id="btn_add">添加</a>
	</div>
	<table id="cab_templete_list"></table>
</body>
</html>