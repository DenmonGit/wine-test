<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String versionInfo = (String)session.getAttribute("versionInfo");
String userInfo = (String)session.getAttribute("adminInfo");
%>
<html>
<head>
<title>参数配置</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<script type="text/javascript">
			$(function(){
				<%
				if(userInfo==null){
					%>
					window.parent.location.reload();
					return ;
				<%}
				%>
				/**
				 * 	对于form表单的验证 
				 */
				// 自定义的校验器
					$.extend($.fn.validatebox.defaults.rules, {   
		    				midLength: {   
		       			 			validator: function(value, param){   
		            								return value.length >= param[0] && value.length <= param[1];    
		        					},   
		        					message: ''  
							} ,
							equalLength : {
		       			 			validator: function(value, param){   
		            								return value.length == param[0];    
		        					},   
		        					message: '密码必须为4个字符!'  
							},
							 http: {// 验证网址
					                validator: function (value) {
					                	return /^[a-zA-Z_]*$/i.test(value);
					                },
					                message: ''
					            },
					}); 
					var flag ;		//undefined 判断新增和修改方法 
					/**
					 *	初始化数据表格  
					 */
					$('#set_param').datagrid({
							url:'<%=basePath%>jf/param/getParamDataGrid' ,
							fit : false,		//自适应
							fitColumns:true ,	//自适应列
							border : false,		//边框
						    singleSelect:true,	//只允许选择一行
							rownumbers:true ,
							pagination : true,	//分页
			    		    idField : "id",  //创建数据表格的时候必须加上 
							pageSize : 10,
							pageList : [10,20,30],
							sortName : '',		//排序
							sortOrder : '',
							checkOnSelect : false,
							selectOnCheck : false,
						    striped:true,		//隔行变色
							nowrap : true,
							frozenColumns:[[				//冻结列特性 ,不要与fitColumns 特性一起使用 
								{
									field:'ck' ,
									width:50 ,
									checkbox: true
								}
							]],
							columns:[[
								{
									field:'id' ,
									title:'ID' ,
									width:100 ,
									hidden:true
								},
								{
									field:'param_type' ,
									title:'参数类型' ,
									width:100 ,
									hidden:true
								},
								{
									field:'param_name' ,
									title:'参数名称' ,
									width:100 
								},
								{
									field:'param_value' ,
									title:'参数值' ,
									width:100 ,
								},{
									field:'param_order' ,
									title:'序号' ,
									width:100 
								},{
									field:'action',
				        			title:'操作',
				        			width:50,
				        			align:'center',
				        			formatter:function(value , record , index){
										return '<a style="color:green" onclick="update_param(\''+record.id+'\',\''+record.param_type+'\',\''+record.param_name+'\',\''+record.param_value+'\',\''+record.param_order+'\')">编辑</a>&nbsp&nbsp<a style="color:red" onclick="delete_param(\''+record.id+'\')">删除</a>';
									}
								}
							]] ,
							toolbar:[
								{
									text:'新增参数' ,
									iconCls:'icon-add' , 
									handler:function(){
										flag = 'add';
										$('#mydialog').dialog({//设置dialog对话框的title
												title:'新增参数' 
										});
										$('#myform').get(0).reset();//将表单重置
										$("#number").numberbox('setValue','');
										$('#mydialog').dialog('open');//打开dialog添加对话框
									}
									
								},{
									text:'查询参数' , 
									iconCls:'icon-search' , 
									handler:function(){
										$('#set_param').datagrid('load',{
											param_type: $("#param_type_search").val(),
											param_name: $("#param_name_search").val(),
										});
									}
								}	
							]
					});
					
					
			/**
			 *  提交表单方法
			 */
			$('#btn1').click(function(){
				var id = $("#id").val();
				var param_type = $("#param_type").val();
				var param_name = $("#param_name").val();
				var param_value = $("#param_value").val();
				if(param_type==null || param_type=='' || typeof(param_type)==undefined){
					$.messager.alert({
						title:"失败消息" ,
						msg:'参数类型不能为空!'
					});
					return;
				}
				if(param_name==null || param_name=='' || typeof(param_name)==undefined){
					$.messager.alert({
						title:"失败消息" ,
						msg:'参数名称不能为空!'
					});
					return;
				}
				if(param_value==null || param_value=='' || typeof(param_value)==undefined){
					$.messager.alert({
						title:"失败消息" ,
						msg:'参数值不能为空!'
					});
					return;
				}
				if($('#myform').form('validate')){//判断表单验证是否全部通过
					$.ajax({
						type: 'post' ,
						url: flag=='add'?'<%=basePath%>jf/param/insert':'<%=basePath%>jf/param/update' ,
						data:{
							'id':id,
							'param_type':param_type,
							'param_name':param_name,
							'param_value':param_value,
							'param_order':$("#param_order").numberbox('getValue')
						} ,
						dataType:'json' ,
						success:function(result){
							flag=undefined ;
							//1 关闭窗口
							$('#mydialog').dialog('close');
							//2刷新datagrid 
							$('#set_param').datagrid('reload');
							//3 提示信息
							if(result.result==1){
								$.messager.show({
									title:"成功消息" , 
									msg:result.message
								});
							}else{
								$.messager.show({
									title:"成功消息" , 
									msg:result.errmsg
								});
							}
						} ,
						error:function(result){
							$.meesager.show({
								title:"失败消息" ,
								msg:result.message
							});
						}
					});
				}else {
					$.messager.show({
						title:'提示信息!' ,
						msg:'数据验证不通过,不能保存!'
					});
				}
			});
			
				/**
				 * 关闭窗口方法
				 */
				$('#btn2').click(function(){
					$('#mydialog').dialog('close');
				});

			});
		//编辑页面''+record.id+'\',\''+record.param_type+'\',\''+record.param_name+'\',\''+record.param_value+'\',\''+record.param_order+'\
		function update_param(id,param_type,param_name,param_value,param_order){
			flag = 'edit';
				$('#mydialog').dialog({
					title:'修改参数'
				});
				
				$('#mydialog').dialog('open'); //打开窗口
				$('#myform').get(0).reset();   //清空表单数据 
				
				$('#myform').form('load',{	   //调用load方法把所选中的数据load到表单中,非常方便
					'id':id,
					'param_type':param_type,
					'param_name':param_name,
					'param_value':param_value,
					'param_order':param_order
				});
		}
		
		//删除
		function delete_param(id){
				$.messager.confirm('提示信息' , '确认删除?' , function(r){
					if(r){	
							$.ajax({'url':'<%=basePath%>jf/param/delete' ,
								dataType:'json' ,
								data:{id:id} ,
								success:function(result){
							
									//1 刷新数据表格 
									$('#set_param').datagrid('reload');
									//2 清空idField   
									$('#set_param').datagrid('unselectAll');
								//3 给提示信息 
								$.messager.show({
									title:'提示信息!' , 
									msg:result.message
								});
								}});
					} else {
						return ;
					}
				});
		}
	</script>
</head>

<body>
	<div class="labelstyle">
		<label>参数类型：</label> <select id="param_type_search"
			name="param_type_search">
			<option value="">全部</option>
			<option value="9999">其他</option>
			<option value="2">后台版本号</option>
		</select> <label>参数名：</label> <input type="text" name="param_name_search"
			id="param_name_search" />
	</div>
	<table id="set_param"></table>

	<div id="mydialog" modal=true resizable=true class="easyui-dialog"
		closed=true data-options="left:500,top:100,closable:true"
		style="width: 500px; height: 300px">
		<form id="myform" action="" method="post">
			<input type="hidden" name="id" id="id" value="0" />
			<table>
				<tr>
					<td class="style1">参数类型:</td>
					<td class="style2"><select id="param_type" name="param_type">
							<option value="9999">其他</option>
							<option value="2">后台版本号</option>
					</select></td>
				</tr>
				<tr>
					<td class="style1">参数名称:</td>
					<td class="style2"><input type="text" id="param_name"
						name="param_name" class="easyui-validatebox textbox"
						style="width: 200px; height: 27px" required=true
						validType="midLength[1,100]" invalidMessage="参数名称必须在1到100个字符之间!"
						value="" /></td>
				</tr>
				<tr>
					<td class="style1">参数值:</td>
					<td class="style2"><input type="text" id="param_value"
						name="param_value" class="easyui-validatebox textbox"
						style="width: 200px; height: 27px" required=true
						validType="midLength[1,1000]" invalidMessage="参数值必须在1到1000个字符之间!"
						value="" /></td>
				</tr>

				<tr>
					<td class="style1">序号:</td>
					<td class="style2"><input type="text" id="param_order"
						name="param_order" class="easyui-numberbox"
						style="width: 200px; height: 27px"
						data-options="min:0,max:999,precision:0" required=true
						missingMessage="序号必填!" invalidMessage="序号必须是三位正整数!" /></td>
				</tr>
				<tr align="center">
					<td colspan="2"><a id="btn1" class="easyui-linkbutton">确定</a>
						<a id="btn2" class="easyui-linkbutton">关闭</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
