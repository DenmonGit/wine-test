<%@page import="com.mao.test.webdata.vo.AdminUserInfoVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String versionInfo=(String)session.getAttribute("versionInfo");
    	AdminUserInfoVo userInfo=(AdminUserInfoVo)session.getAttribute("userInfo");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>酒庄字典</title>
<%@include file="/jf/common/comment_easyui1.4.4.jsp" %>
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
		                    return /^http:\/\/[a-zA-Z][a-zA-Z0-9_\.\&\%]*$/i.test(value);
		                },
		                message: '简介网址必须以http://开头且在1-100个字符之间'
		            },
		}); 
	$('#area_code').combotree({
		onChange:function(newValue,oldValue){
			if(!flag){
				return false;
			}
			$.post('<%=basePath%>webdatav1/chateau/getMaxChateauCode',{area_code:newValue},function(result){
				var result0=eval("("+result+")");
				if(result0.object!=undefined&&result0.object.MaxCode!=null&&typeof(result0.object.MaxCode)!=undefined&&result0.object.MaxCode!=""){
					var result1=result0.object.MaxCode.substring(0,10);
					var result2=parseInt(result0.object.MaxCode.substring(10))+1;
					if(result2<10){
						result2="0000"+result2;
					}else if(result2>=10&&result2<=99){
						result2="000"+result2;
					}else if(rsult2>=100&&result2<999){
						result2="00"+result2;
					}else if(result2>=1000&&result2<9999){
						result2="0"+result2;
					}
					$("#chateaucode").val(result1+result2);
					$("#chateaucode").attr({disabled:true});
				}else{
					$("#chateaucode").val(newValue+"00001")
				}
			});
		}
		
	});
	

	    
		var flag ;		//undefined 判断新增和修改方法 
		/**
		 *	初始化数据表格  
		 */
		$('#wine_chateau').datagrid({
				url:'<%=basePath%>webdatav1/chateau/getChateauList' ,
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
						field:'name_cn' ,
						title:'名称' ,
						width:50 ,
						align:'center'
					},
					{
						field:'id' ,
						title:'酒庄酒商编码' ,
						width:50 
						
					},
					{
						field:'ereir' ,
						title:'酒庄酒商代码' ,
						width:50 ,
						formatter: function(value,row,index){
							return row.id.substring(10);
						}
						
					},
					{
						field:'number',
						title:'序号' ,
						width:20 
					},
					{
						field:'outSideUrl' ,
						title:'简介网址' ,
						width:100 ,
						hidden:true
					},
					{
						field:'action',
	        			title:'操作',
	        			width:50,
	        			align:'center',
	        			formatter:function(value , record , index){//chateaucode name_cn name_en aliases area_code  area_name_cn  number outSideUrl             
							return '<a style="color:green" onclick="update_wine_chaeau(\''+record.id+'\',\''+record.name_cn+'\',\''+record.name_en+'\',\''+record.aliases+'\',\''+record.area_code+'\',\''+record.area_name_cn+'\',\''+record.number+'\',\''+record.outSideUrl+'\')">编辑</a>&nbsp&nbsp<a style="color:red" onclick="delete_wine_chaeau(\''+record.id+'\')">删除</a>';
						}
					}
				]] ,
				toolbar:[
					{
						text:'新增酒庄' ,
						iconCls:'icon-add' , 
						handler:function(){
							flag = 'add';
							$("#area_code").combotree('readonly',false);
							$('#mydialog').dialog({//设置dialog对话框的title
									title:'新增酒庄' 
							});
							$('#myform').get(0).reset();//将表单重置
							$("#number").numberbox('setValue','');
							$('#mydialog').dialog('open');//打开dialog添加对话框
						}
						
					},{
						text:'查询酒庄' , 
						iconCls:'icon-search' , 
						handler:function(){
							alert("41");
							$('#wine_chateau').datagrid('load',{
								name_cn: $("#name_cn_").val(),
								code:$("#code").val(),
							});
						}
					}	
				]
		});
		/**
		 *  提交表单方法
		 */
		$('#btn1').click(function(){//name_cn  area_code  chateaucode
			var name_cn = $("#name_cn").val();
			var area_code=$("#area_code").combotree('getValue');//产地
			var chateaucode =$("#chateaucode").val();
			
			if(name_cn==null || name_cn=='' || typeof(name_cn)==undefined){
				$.messager.show({
					title:"失败消息" ,
					msg:'中文名称必填!'

				});
				
				return;
			}
			if(area_code==null || area_code=='' || typeof(area_code)==undefined){
				$.messager.show({
					title:"失败消息" ,
					msg:'产地必填!'
				});
				
				return;
			}
			
			if(chateaucode==null || chateaucode=='' || typeof(chateaucode)==undefined){
				$.messager.show({
					title:"失败消息" ,
					msg:'代码不能为空!'
				});
				
				return;
			}
			
			
				if($('#myform').form('validate')){//判断表单验证是否全部通过
				//	var chateau_code_old =null;
				//	if($('#wine_chateau').datagrid("getSelected")){
				//		chateau_code_old=$('#wine_chateau').datagrid("getSelected").id;
				//	}
					
					$.ajax({
						type: 'post' ,
						url: flag=='add'?'<%=basePath%>webdatav1/chateau/addChateauDict':'<%=basePath%>webdatav1/chateau/updateChateauDict' ,
						cache:false ,
						data:{//name_cn name_en aliases area_code chateaucode number outSideUrl  
							name_cn:$("#name_cn").val(),
							name_en:$("#name_en").val(),
							aliases:$("#aliases").val(),
							area_code:$("#area_code").combotree('getValue'),
							chateaucode:$("#chateaucode").val(),
						//	chateau_code_old:chateau_code_old,
							number:$("#number").val(),
						//	outSideUrl:$("#outSideUrl").val()
						} ,//序列化表单
						dataType:'json' ,
						success:function(result){
							flag=undefined ;
							
							$("#area_code").combotree('setValue', '');
							$("#area_code").combotree('setText', '');
							//1 关闭窗口
							$('#mydialog').dialog('close');
							//2刷新datagrid 
							$('#wine_chateau').datagrid('reload');
							//alert(JSON.stringify(result));
							//3 提示信息
							if(result.result==1){
								$.messager.show({
									title:"成功消息" , 
									msg:result.message
								});
							}else{
								$.messager.show({
									title:"失败消息" , 
									msg:result.errmsg
								});
							}
						} ,
						error:function(result){
							$.messager.show({
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
		
		//关闭窗口的方法
		$("#btn2").click(function(){
			$('#mydialog').dialog('close');
		});
	});
	//更新
	function update_wine_chaeau(chateaucode,name_cn,name_en,aliases,area_code,area_name_cn,number,outSideUrl ){
		flag="edit";
		$('#mydialog').dialog({title:'修改酒庄'});
		$('#mydialog').dialog('open');
		$('#myform').get(0).reset();//清空表单数据
		$('#myform').form('load',{//调用load方法把选中的数据load到表单中，非常方便
			chateaucode:chateaucode,
			name_cn:name_cn,
			name_en:name_en,
			aliases:aliases,
			area_code:area_code,
			number:number,
			outSideUrl:outSideUrl
		});
		$('#area_code').combotree('setValue',area_code);
		$('#area_code').combotree('setText',area_name_cn);
		//$('#area_code').combotree('readonly',true);
	}
	//删除
	function delete_wine_chaeau(id){
		$.messager.confirm('确认删除吗？','删除酒庄,将会联动删除酒庄下的所有品牌？',function(r){
			if(r){
				$.post('<%=basePath%>webdatav1/chateau/deleteChateauDict',{id:id},function(result){
					//刷新数据表格
					$('#wine_chateau').datagrid('reload');
					//清空idField
					$('#wine_chateua').datagrid('unselectAll');
					//给出提示
					$.messager.show({
						title:'提示信息！',
						msg:'删除酒庄成功！'
					});
				});
			}else{
				return;
			}
		});
	}

</script>
</head>
<body>
<div class="labelstyle">
		<label>名称：</label> <input type="text" name="name_cn_" id="name_cn_" />
		<label>编码：</label> <input type="text" name="code" id="code" />
	</div>
<table id="wine_chateau"></table>
<div id="mydialog" title="新增酒庄" modal=true resizable=true
		class="easyui-dialog" closed=true
		data-options="left:600,top:100,closable:true"
		style="width: 500px; height: 400px">
		<form id="myform" action="" method="post">
			<table>
				<tr>
					<td class="style1">中文名称:</td>
					<td class="style2"><input type="text" id="name_cn"
						name="name_cn" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" required=true
						validType="midLength[1,50]" missingMessage="中文名称必填!"
						invalidMessage="中文名称必须在1到50个字符之间!" value="" /></td>
				</tr>
				<tr>
					<td class="style1">英文名称:</td>
					<td class="style2"><input type="text" id="name_en"
						name="name_en" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" validType="midLength[1,100]"
						invalidMessage="英文名称必须在1到100个字符之间!" value="" /></td>
				</tr>

				<tr>
					<td class="style1">别名:</td>
					<td class="style2"><input type="text" id="aliases"
						name="aliases" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" validType="midLength[1,100]"
						invalidMessage="英文名称必须在1到100个字符之间!" value="" /></td>
				</tr>

				<tr>
					<td class="style1">所属产地:</td>
					<td class="style2"><input id="area_code" name="area_code"
						class="easyui-combotree" style="width: 250px; height: 27px"
						data-options="url:'<%=basePath%>webdata/areaDict/getAreaDictTree',method:'get',required:true"
						missingMessage="产区必填!" style="height: 30px;width:300px";">
					</td>
				</tr>
				<tr>
					<td class="style1">编码:</td>
					<td class="style2"><input type="text" id="chateaucode"
						name="chateaucode" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" required=true
						validType="midLength[1,64]" disabled="disabled"
						missingMessage="代码必填!" invalidMessage="代码必须在1到64个字符之间!" value="" />
					</td>
				</tr>
				<tr>
					<td class="style1">序号:</td>
					<td class="style2"><input type="text" id="number"
						name="number" class="easyui-numberbox"
						style="width: 250px; height: 27px"
						data-options="min:0,max:999,precision:0" required=true
						missingMessage="序号必填,且必须是正整数!" invalidMessage="序号必须是三位正整数!" /></td>
				</tr>
				<tr>
					<td class="style1">简介网址:</td>
					<td class="style2"><input type="text" id="outSideUrl"
						name="outSideUrl" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" validType="midLength[1,100]"
						invalidMessage="简介网址必须以http://开头并且在1到100个字符之间!" value="" /></td>
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