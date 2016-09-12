<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
	import="java.util.*,com.mao.test.webdata.vo.AdminUserInfoVo"
    pageEncoding="UTF-8"%>
<%
	String version=(String)session.getAttribute("versioninfo");
	AdminUserInfoVo userInfo=(AdminUserInfoVo)session.getAttribute("userInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>品牌管理</title>
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
		//产区改变联动出，酒庄
		$("#area_code").combotree({
			onChange:function(newValue,oldValue){
	        	//酒庄酒商
		        $("#chateau_code").combobox({
   	    			 url:'<%=basePath%>webdatav1/chateau/getChateauByAreaCode?area_code='+newValue,    
   	    			 valueField:'id',    
   	    			 textField:'text'   
   	    		});
			  }  
		});
	

		//产区改变联动出，酒庄,等级
		$("#chateau_code").combobox({
			onChange:function(newValue,oldValue){
				if(!flag) {
					return false;
				}
				$.post('<%=basePath%>webdatav1/brand/getMaxBrandCode' , {chateau_code: newValue  } , function(result){
					var result0 = eval("("+result+")");
					if(result0.object!=undefined && result0.object.maxCode!=null && typeof(result0.object.maxCode)!=undefined && result0.object.maxCode!=""){
						//FR01000000 00001 000001
						var result1 = result0.object.maxCode.substring(0,15);
						var result2 =parseInt(result0.object.maxCode.substring(15))+1;
						
						if(result2<10){
							result2 = "00000"+result2;
						}else if(result2>=10 && result2<=99){
							result2 = "0000"+result2;
						}else if(result2>=100 && result2<=999){
							result2 = "000"+result2;
						}else if(result2>=1000 && result2<=9999){
							result2 = "00"+result2;
						}else if(result2>=10000 && result2<=99999){
							result2 = "0"+result2;
						}
						//console.info(result1+"-----"+result2);
						$("#brandcode").val(result1+result2);
						$("#brandcode").attr({ disabled: true});
						
					}else{
						$("#brandcode").val(newValue+"000001");
					}
					
				});
			  }  
		});	

		var flag ;		//undefined 判断新增和修改方法 
		/**
		 *	初始化数据表格  
		 */
		$('#wine_brand').datagrid({//a.`code` id, a.name_cn ,a.name_en,a.brand_code,a.number,a.aliases,a.outSideUrl ,b.name_cn brand_name_cn
				url:'<%=basePath%>webdatav1/brand/getBrandList' ,
				fit : false,		//自适应
				fitColumns:true ,	//自适应列
				border : false,		//边框
			    singleSelect:true,	//只允许选择一行
				rownumbers:true ,
				pagination : true,	//分页
    		    idField : "id",  //创建数据表格的时候必须加上 
				pageSize : 20,
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
						title:'品牌编码' ,
						width:50 
						
					},
					{
						field:'ereir' ,
						title:'品牌代码' ,
						width:50 ,
						formatter: function(value,row,index){
							return row.id.substring(15);
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
	        			formatter:function(value , record , index){//									 c. ,c.,c.,c.,c.,d.,d.,d.,d.          
							return '<a style="color:green" onclick="update_wine_brand(\''+record.id+'\',\''+record.name_cn+'\',\''+record.name_en+'\',\''+record.number+'\',\''+record.aliases+'\',\''+record.outSideUrl+'\',\''+record.chateau_code+'\',\''+record.chateau_name_cn+'\',\''+record.area_code+'\',\''+record.area_name_cn+'\')">编辑</a>&nbsp&nbsp<a style="color:red" onclick="delete_wine_brand(\''+record.id+'\')">删除</a>';
						}
					}
				]] ,
				toolbar:[
					{
						text:'新增品牌' ,
						iconCls:'icon-add' , 
						handler:function(){
							flag = 'add';
							$('#mydialog').dialog({//设置dialog对话框的title
									title:'新增品牌' 
							});
							$('#myform').get(0).reset();//将表单重置
							$("#number").numberbox('setValue','');
							$('#mydialog').dialog('open');//打开dialog添加对话框
							
							$("#area_code").combotree('readonly',false);
							$("#chateau_code").combotree('readonly',false);
						}
						
					},{
						text:'查询品牌' , 
						iconCls:'icon-search' , 
						handler:function(){
							
							$('#wine_brand').datagrid('load',{
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
	$('#btn1').click(function(){
		var name_cn = $("#name_cn").val();
		
		var area_code=$("#area_code").combotree('getValue');//产地
		var chateau_code=$("#chateau_code").combobox('getValue');//酒庄
		
		var brandcode =$("#brandcode").val();
		
		if(name_cn==null || name_cn=='' || typeof(name_cn)==undefined){
			$.messager.show({
				title:"失败消息" ,
				msg:'品牌中文名称必填!'

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
		if(chateau_code==null || chateau_code=='' || typeof(chateau_code)==undefined){
			$.messager.show({
				title:"失败消息" ,
				msg:'酒庄/酒商必填!'
			});
			
			return;
		}
		if(brandcode==null || brandcode=='' || typeof(brandcode)==undefined){
			$.messager.show({
				title:"失败消息" ,
				msg:'代码不能为空!'
			});
			
			return;
		}
		/*

		
		*/
			if($('#myform').form('validate')){//判断表单验证是否全部通过
				var brand_code_old =null;
			//	if($('#wine_brand').datagrid("getSelected")){
			//		brand_code_old=$('#wine_brand').datagrid("getSelected").id;
			//	}
				
				$.ajax({
					type: 'post' ,
					url: flag=='add'?'<%=basePath%>webdatav1/brand/addBrandDict':'<%=basePath%>webdatav1/brand/updateBrandDict' ,
					cache:false ,
					data:{
						name_cn:$("#name_cn").val(),
						name_en:$("#name_en").val(),
						aliases:$("#aliases").val(),
						area_code:$("#area_code").combotree('getValue'),
						chateau_code:$("#chateau_code").combobox('getValue'),
						brandcode:$("#brandcode").val(),
					//	brand_code_old:brand_code_old,
						number:$("#number").val(),
						outSideUrl:$("#outSideUrl").val()
					} ,//序列化表单
					dataType:'json' ,
					success:function(result){
						flag=undefined ;
						
						$("#area_code").combotree('setValue', '');
						$("#area_code").combotree('setText', '');
						
						$("#chateau_code").combobox('setValue', '');
						$("#chateau_code").combobox('setText', '');
						//1 关闭窗口
						$('#mydialog').dialog('close');
						//2刷新datagrid 
						$('#wine_brand').datagrid('reload');
						//alert(JSON.stringify(result));
						//3 提示信息
						if(result.result==1){
							$.messager.show({
								title:"成功消息" , 
								msg:result.message
							});
						}else{
							$.messager.alert({
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
	
		/**
		 * 关闭窗口方法
		 */
		$('#btn2').click(function(){
			$('#mydialog').dialog('close');
		});

	});
function update_wine_brand(brandcode,name_cn,name_en,number,aliases,outSideUrl,chateau_code,chateau_name,area_code,area_name_cn){
	flag="edit";
	$('#mydialog').dialog({
		title:'修改品牌'	
	});
	$('#mydialog').dialog('open');//
	$('#myform').get(0).reset();//清空表单数据
	
	$('#myform').form('load',{
		brandcode:brandcode,
		name_cn:name_cn,
		name_en:name_cn,
		aliases:aliases,
		number:number,
		outSideUrl:outSideUrl
	});
	$('#area_code').combotree('setValue',area_code);
	$('#area_code').combotree('setText',area_name_cn);
	
	$('#chateau_code').combobox('setValue',chateau_code);
	$('#chateau_code').combobox('setText',chateau_name_cn);
	
	$('#area_code').combotree('readonly',true);
	$('#chateau_code').combobox('readonly',true);
}

//删除
/**
 * 
function delete_wine_brand(id){
	$.messager.confirm('提示信心','是否确认删除?',function(r){
		if(r){
			$.post('<%=basePath%>webdatav1/brand/deleteBrandDict',{id:id},function(result){
					//1,刷新数据表格
					$('#wine_brand').datagrid('reload');
					//2,清空idField
					$('#wine_brand').datagrid('unselectAll');
					//3,提示信息
					$.messager.alert({
						title:'提示信息',
						msg:'删除品牌成功'
					});
			});
		}else{
			return ;
		}
	});
}

 * 
 */

function delete_wine_brand(id){
	$.messager.confirm('提示信息','是否删除？',function(r){
		if(r){
			$.ajax({
				type:'post',
				url:'<%=basePath%>webdatav1/brand/deleteBrandDict',
				data:{id:id},
				dataType:'json',
				success:function(result){
					if(result.result==1){
						$.messager.alert('提示','品牌删除成功');
						$('#wine_brand').datagrid('reload');
					}else{
						$.messager.alert('提示',result.message);
					}
				}
			});
		}
	});
}

</script>
</head>

<body>
<div class="labelstyle">
		<label>名称：</label> <input type="text" name="name_cn_" id="name_cn_"
			style="width: 200px" /> <label>编码：</label> <input type="text"
			name="code" id="code" style="width: 200px" />
	</div>
	<table id="wine_brand"></table>

	<div id="mydialog" title="新增品牌" modal=true resizable=true
		class="easyui-dialog" closed=true
		data-options="left:600,top:100,closable:true"
		style="width: 500px; height: 450px">
		<form id="myform" action="" method="post">
			<table>
				<tr>
					<td class="style1">中文名称:</td>
					<td class="style1"><input type="text" id="name_cn"
						name="name_cn" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" required=true
						validType="midLength[1,20]" missingMessage="中文名称必填!"
						invalidMessage="中文名称必须在1到20个字符之间!" value="" /></td>
				</tr>
				<tr>
					<td class="style1">英文名称:</td>
					<td class="style1"><input type="text" id="name_en"
						name="name_en" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" validType="midLength[1,40]"
						invalidMessage="英文名称必须在1到40个字符之间!" value="" /></td>
				</tr>

				<tr>
					<td class="style1">别名:</td>
					<td class="style1"><input type="text" id="aliases"
						name="aliases" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" validType="midLength[1,100]"
						invalidMessage="英文名称必须在1到100个字符之间!" value="" /></td>
				</tr>


				<tr>
					<td class="style1">产地:</td>
					<td class="style1"><input id="area_code" name="area_code"
						class="easyui-combotree" style="width: 250px; height: 27px"
						data-options="url:'<%=basePath%>webdata/areaDict/getAreaDictTree',method:'get',required:true"
						missingMessage="产区必填!" style="height: 30px;width:300px";">
					</td>
				</tr>

				<tr>
					<td class="style1">所属酒庄/酒商:</td>
					<td class="style1"><input id="chateau_code"
						name="chateau_code" class="easyui-combobox"
						style="width: 250px; height: 27px"
						data-options="editable:false,required:true"
						style="height: 30px;width:300px" missingMessage="酒庄酒商必填!" /></td>
				</tr>
				<tr>
					<td class="style1">编码:</td>
					<td class="style1"><input type="text" id="brandcode"
						name="brandcode" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" required=true
						validType="midLength[1,64]" disabled="disabled"
						missingMessage="代码必填!" invalidMessage="代码必须在1到64个字符之间!" value="" />
					</td>
				</tr>
				<tr>
					<td class="style1">序号:</td>
					<td class="style1"><input type="text" id="number"
						name="number" class="easyui-numberbox"
						style="width: 250px; height: 27px"
						data-options="min:0,max:999,precision:0" required=true
						missingMessage="序号必填!" invalidMessage="序号必须是三位正整数!" /></td>
				</tr>
				<tr>
					<td class="style1">简介网址:</td>
					<td class="style1"><input type="text" id="outSideUrl"
						name="outSideUrl" class="easyui-validatebox textbox"
						style="width: 250px; height: 27px" validType="http"
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