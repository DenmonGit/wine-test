<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,com.mao.test.webdata.vo.AdminUserInfoVo"%>
    <%
    	String version=(String)session.getAttribute("versionInfo");
    AdminUserInfoVo userInfo=(AdminUserInfoVo)session.getAttribute("userInfo");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产区管理字典</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<script type="text/javascript">
/**
 * 对于form表单的验证
 */
 //自定义校验器
 $.extend($.fn.validatebox.defaults.rules,{
	 midLength:{
		validator:function(value,param){
			return value.length>=param[0]&&value.length<=param[1];
		},
		message:''
	 },
	 equalLength:{
		validator:function(value,param){
			return value.length==param[0];
		},
		message:'密码必须为4个字符!'
	 },
	 code:{//验证编码
			 validator:function(value){
				 return /^[A-Z][A-Z][0]{8}$/;
			 },
			 message: '产区编码必须是两个大写字母加000000'
	 },
	 http:{
		 validator:function(value){
			 return /^http:\/\/[a-zA-Z][a-zA-Z0-9_\.\&\%]*$/i.test(value);
		 },
		 message:'简介网址必须以http://开头并且在1-100个字符之间'
	 },
 });
 
 var flag;//判断走的是保存还是修改的方法
 $(function(){
	 <%
		if(userInfo==null){
			%>
			window.parent.location.reload();
			return ;
		<%}
		%>
		$('#wine_areaDict').datagrid({
			url:'<%=basePath%>webdatav1/areaDict/getAreaDict',	
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
			columns:[[
					{
						field:'name',
						title:'产地名称',
						width:100
					},
					{
						field:'id',
						title:'产地编码',
						width:100
					},{
						field:'action1',
						title:'产地代码',
						width:100,
						formatter: function(value,row,index){
							//console.info(row.id);
							var areaCode=row.id;
							//console.log(areaCode);
							var result;
							if ('root'!=row.id){
								result=areaCode.substring((row.level-1)*2, (row.level-1)*2+2);
								//console.info(result);
							} else{
								result='';
							}
							return result;
						}
					}
					,{
						field:'number',
						title:'序号',
						width:20
					},
					{
						field:'level',
						title:'产地级别',
						width:100,
						formatter: function(value,row,index){
							var result;
							if(1==value){
								result='一级产区';
							}else if(2==value){
								result='二级产区';
							}else if(3==value){
								result='三级产区';
							}else if(4==value){
								result='四级产区';
							}else if(5==value){
								result='五级产区';
							}else{
								result='';
							}
							return result;
						}
					} ,
					{
						field:'_parentId',
						title:'父级产区编码',
						width:100
					} ,{
						field:'aliases',
						title:'序号',
						width:20 ,
						hidden:true
					} ,{
						field:'action',
	        			title:'操作',
	        			width:50,
	        			align:'center',
	        			formatter:function(value , record , index){								     
							return '<a style="color:green" onclick="update_wine_area(\''+record.id+'\',\''+record.name+'\',\''+record.name_en+'\',\''+record.areaCode+'\',\''+record.number+'\',\''+record.aliases+'\',\''+record.outSideUrl+'\',\''+record.level+'\',\''+record._parentId+'\')">编辑</a>&nbsp&nbsp<a style="color:red" onclick="delete_wine_area(\''+record.id+'\')">删除</a>';
						}
					}
					]] ,
			toolbar:[
				{
					text:'新增场地',
					iconCls:'icon-add',
					handler:function(){
						flag="add";
						$('#mydialog').dialog({
							title:'新增场地'
						});
						//1、清空表单数据
						$('#myform').get(0).reset();//将表单重置
						$('#number').numberbox('setValue','');
					
						//设置新增场地的产区编码
						var node=$('#wine_areaDict').datagrid('getSelected');
						if(node==null||node==''||typeof(node)==undefined||node.level>=5){
							$.messager.show({
								title:'失败消息',
								msg:'请选择一个父级场区下新增产区(5级以下不能再添加产区)!'
							});
						}else{
							$("#level_").val(node.level+1);
							$("#_parentId").val(node.id);
							
							$('#mydialog').dialog("open");//打开dialog添加对话框
							$("#level_option[value='"+(node.level+1)+"']").attr({selected:true});
							
							if(node.id=="root"){
								$("#id").attr({disabled:false});
								$("#id").attr({validType:"code"});
							}else{
								//异步去查场地下的孩子
								//异步去查产地底下的孩子。
								$.post('<%=basePath%>jf/areaDict/getMaxChildrenCodeByParendCode' , {parent_code:node.id} , function(result){
										//alert(JSON.stringify(result));//{\"result\":1,\"message\":\"删除产区成功\",\"error_code\":null,\"object\":{\"code\":\"AR07000000\"}}
										var result0 = eval("("+result+")");
										//console.info(result0.object);
										//console.info(result0.object.code);
										//console.info(node.level);
										
										if(result0.object!=undefined && result0.object.code!=null && typeof(result0.object.code)!=undefined && result0.object.code!=""){
											var result1 = result0.object.code.substring(0, (node.level-1)*2+2);
											
											var result2 =parseInt(result0.object.code.substring((node.level-1)*2+2, (node.level-1)*2+4))+1;
											if(result2<10){
												result2 = "0"+result2;
											}
											var result3 = result0.object.code.substring((node.level-1)*2+4);
											$("#id").val(result1+result2+result3);
											$("#id").attr({ disabled: true});
										}else{
											var result1 = node.id.substring(0, (node.level-1)*2+2);
											var result2 =parseInt(node.id.substring((node.level-1)*2+2, (node.level-1)*2+4))+1;
											var result3 = node.id.substring((node.level-1)*2+4);
											$("#id").val(result1+"0"+result2+result3);
										}
									});
							}
							
						}
					}
				} ,{
					text:'查询产地' , 
					iconCls:'icon-search' , 
					handler:function(){//name_cn　code　　level　　parent_code
						$('#wine_areaDict').datagrid('load',{
							name_cn: $("#name_cn_").val(),
							code:$("#code_").val(),
							level: $("#level_").val(),
							parent_code:$("#parent_code_").val()
						});
					}
				}        
			],		
		});
		//关闭窗口
		$('#btn2').click(function(){
				$('#mydialog').dialog('close');
		});
		//保存按钮
		$('#btn1').click(function(){
			
			var name_cn = $("#name_cn").val();
			
		
			if(name_cn==null || name_cn=='' || typeof(name_cn)==undefined){
				$.messager.show({
					title:"失败消息" ,
					msg:'产地中文名称必填!'
				});
				return;
			}
		
			
			if($('#myform').form('validate')){//判断表单验证是否全部通过
				$.ajax({
					type: 'post' ,//
					url: flag=='add'?'<%=basePath%>jf/areaDict/addAreaDict':'<%=basePath%>jf/areaDict/updateAreaDict' ,
					cache:false ,
					data:{
						name_cn: $('#myform').find('input[name=name_cn]').val(),
						name_en: $("#name_en").val(),
						aliases: $("#aliases").val(),
						id: $("#id").val(),
						level: $("#level_").val(),
						parentId: $("#_parentId").val(),
						number:$("#number").val(),	
						outSideUrl: $("#outSideUrl").val()
					} ,//序列化表单
					dataType:'json' ,
					success:function(result){
						flag=undefined ;
						
						//1 关闭窗口
						$('#mydialog').dialog('close');
						//2刷新datagrid 
						$('#wine_areaDict').datagrid('reload');
						//alert(JSON.stringify(result));
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
 });
</script>
</head>
<body>
<div class="labelstyle">
		<label>名称：</label> <input type="text" name="name_cn_" id="name_cn_" />
		<label>编码：</label> <input type="text" name="code_" id="code_" /> <label>级别：</label>
		<select name="level_" id="level_" style="width: 150px">
			<option value="">全部</option>
			<option value="1">一级产区</option>
			<option value="2">二级产区</option>
			<option value="3">三级产区</option>
			<option value="4">四级产区</option>
			<option value="5">五级产区</option>
		</select> <label>父级编码：</label> <input type="text" name="parent_code_"
			id="parent_code_" />
	</div>
	<table id="wine_areaDict"></table>
</body>
</html>