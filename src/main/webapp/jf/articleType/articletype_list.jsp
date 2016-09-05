<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String versionInfo=(String)session.getAttribute("versionInfo");
 	String userInfo=(String)session.getAttribute("adminInfo");
 	//String id=request.getParameter("articleTypeId");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/jf/common/comment_easyui1.4.4.jsp" %>
<title>红酒百科目录</title>
<style type="text/css">
.img-t{
	height:50px;
	width:50px;
}
</style>
<script type="text/javascript">
//webdata/wineType/getWineTypeDataGrid
			$(function(){
			<%
			if(userInfo==null){
				%>
				window.parent.location.reload();
				return ;
			<%}
			%>
				/* 渲染数据表格 */
				$('#wine_articletype').datagrid({
							url:'<%=basePath%>webdata/wineType/getWineTypeDataGrid' ,
							fit:false ,
							fitColumns:true ,  
							border : false,		//边框
							singleSelect:true ,				//单选模式 
							idField:'id' ,		//只要创建数据表格 就必须要加 ifField
							
							striped: true ,					//隔行变色特性 
							//nowrap: false ,				//折行显示 为true 显示在一会 
							loadMsg: '数据正在加载,请耐心的等待...' ,
							rownumbers:true ,
							sortName : '',		//排序
							sortOrder : '',
							checkOnSelect : false,
							selectOnCheck : false,
							frozenColumns:[[				//冻结列特性 ,不要与fitColumns 特性一起使用 
								{
									field:'ck' ,
									width:50 ,
									checkbox: true
								}
							]],
							columns:[[
								{
									 field:'id',
					        		 title:'id',
					        		 width:50,
					        		 hidden:true
								},
								{
									 field:'name',
					        		 title:'名称',
					        		 width:50
								},
								{
									field:'orderIndex',
				        			title:'排序',
				        			width:50
								},{
									field:'image',
				        			title:'图标',
				        			width:200,
				        			align:'center',
				        			formatter:function(value , record , index){
										//return '<img src="\'"+value+"\'" alt="\'"+value+"\'" class="img-t"></img>';
										  return '<img class="img-t" alt="'+value+'" src="'+value+'">';
									}
								},{
									field:'action',
				        			title:'操作',
				        			width:50,
				        			align:'center',
				        			formatter:function(value , record , index){
										return '<a style="color:green" onclick="updateWineType(\''+record.id+'\')">编辑</a>&nbsp&nbsp<a style="color:red" onclick="deleteWineType(\''+record.id+'\')">删除</a>';
									}
								}
							]] ,
							pagination: true , 
							pageSize:5 ,
							pageList:[5,10,20] ,
							toolbar:[
							     	{
										text:'新增红酒百科' ,
										iconCls:'icon-add' , 
										handler:function(){
											flag = 'add';
											$('#mydialog').dialog({//设置dialog对话框的title
													title:'新增红酒目录' 
											});
											$('#myform').get(0).reset();//将表单重置
											$('#mydialog').dialog('open');//打开dialog添加对话框
										}
									} ,
									{
										text:'搜索' , 
										iconCls:'icon-search' , 
										handler:function(){
											$('#wine_articletype').datagrid('load',{
												name: $("#name_search").val(),
											});
										}
									}	
							]
					});	
				
		//提交表单的方法
		//webdata/wineType/addWineType
		//webdata/wineType/updateWineType
		$('#btn1').click(function(){
						var articleTypeId=$("#articleTypeId_").val();
						
						var orderIndex=$("#orderIndex").val();
						if(orderIndex<0 ||typeof(orderIndex) ==undefined || orderIndex=="" || orderIndex>999){
								$.messager.alert('警告','序号必须在0和999之间!');
								return;  
						}
						
						var name_=$("#name_").val();
						if(name_==null || name_=='' || typeof(name_)==undefined){
							$.messager.show({title:'提示!', msg:'目录名称必填!'}); 
							return;
						}
						if(orderIndex<0 ||typeof(orderIndex) ==undefined || orderIndex=="" || orderIndex>999){
								$.messager.alert('警告','类型名必填!');
								return;  
						}
						//封面图
						if($("#file").children().size()<=0){//大图必须填
							$.messager.show({title:'警告!', msg:'图标必须上传1张'});
							return;
						}
						var file = $("#file li img").attr("src");
						
						if($('#myform').form('validate')){//判断表单验证是否全部通过
							
							$.ajax({
								type: 'post' ,
								url: flag=='add'?'<%=basePath%>webdata/wineType/addWineType':'<%=basePath%>webdata/wineType/updateWineType' ,
								cache:false ,
								data:{
									'articleTypeId':$("#articleTypeId_").val(),
									'name':$("#name_").val(),
									'orderIndex':$("#orderIndex").val(),
									'type_image':file
									
								} ,//序列化表单
								dataType:'json' ,
								success:function(result){
									flag=undefined ;
									//1 关闭窗口
									$('#mydialog').dialog('close');
									//2刷新datagrid 
									$('#wine_articletype').datagrid('reload');
									//3 提示信息
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
		
		//关闭窗口
		$('#btn2').click(function(){
			$('#mydialog').dialog('close');
		});
	});
	//修改
	//webdata/wineType/wineTypeDetail
	//修改
			function updateWineType(id){
				flag = 'edit';
					$('#mydialog').dialog({
						title:'修改文章类型'
					});
					
					$('#mydialog').dialog('open'); //打开窗口
					$('#myform').get(0).reset();   //清空表单数据 
					$("#file li").remove();
					
					$.ajax({
						type : 'POST',
						url : '<%=basePath%>webdata/wineType/wineTypeDetail',
						data : {
							'id':id
							} ,
						dataType: "json",
						success : function(data) {	
							
							if(data.errcode==0){
								
								$("#articleTypeId_").val(data.object.id);
								$("#name_").val(data.object.name);
								$("#orderIndex").numberbox('setValue',data.object.orderIndex);//酒精度alcohol
								
								//封面图
								var file_li=$("<li/>").attr("id",data.object.image).attr("display","inline").css('float','left');//封面图
								file_li.appendTo("#file");
								var img=$("<img/>").attr("src",data.object.image).css("height","50px");
								img.appendTo(file_li);
								var span = $("<span/>").attr("class","action_d action").html("删除").css("color","red");
								span.appendTo(file_li);
								span.click(function(){
									$(this).parent().remove();
								});
								
							} 
							else{
								$.messager.alert('提示', '加载失败');
							}
						}
					});
					
			}
	
	//大图上传
	function fileUpload(){
		/*先判断大图框里有几个孩子，如果超过1个则提醒*/
		if($("#file").children().size()<1){
				/* 将filesform1表单提交 */
        		$('#filesform1').form('submit', { 
					 url:'<%=basePath%>webdata/imageController/fileUpload',
					 success:function(data){
						// console.info(data);
						var data1=eval('('+data+')');
						// console.info(data1.object[0]);
						if(data1.errcode==1){
							var li=$("<li/>").attr("id",'').attr("display","inline");
							li.appendTo("#file");
							var img=$("<img/>").attr("src",data1.object).css("height","30px");
							img.appendTo(li);
							var span = $("<span/>").attr("class","action_d action").html("删除");
							span.appendTo(li);
							span.click(function(){
								$(this).parent().remove();
								console.info($(this).parent());
							});
							$.messager.alert('提示', data1.errmsg);
						}else{
							$.messager.alert('提示', data1.errmsg);
						};
					}
				});
		}else{
			$.messager.show({title:'提示!', msg:'封面最多上传1张'}); 
			return;
		}
	} 
	//删除
	//webdata/wineType/deleteWine
	function deleteWineType(id){
				$.messager.confirm('删除红酒百科目录', '将删除该类型下的所有文章，是否确定删除?', function(r){
				if (r){
					$.ajax({
						type : 'POST',
						url : '<%=basePath%>webdata/wineType/deleteWineType',
						data : {'id':id} ,
						dataType : 'json',
						success : function(data) {	
							if(data.result==1){
								$.messager.alert('提示', '删除成功');
								$(".pagination-load").eq(0).click();
							} 
							else{
								$.messager.alert('提示', '删除失败');
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
		<label>名称：</label> <input type="text" name="name_search"
			id="name_search" />
	</div>
	<table id="wine_articletype"></table>

	<div id="mydialog" title="新增红酒百科" modal=true resizable=true
		class="easyui-dialog" closed=true
		data-options="left:600,top:100,closable:true"
		style="width: 500px; height: 400px">
		<form id="myform" action="" method="post">
			<table>
				<tr>
					<td class="style1">名称:</td>
					<td class="style2"><input type="hidden" id="articleTypeId_"
						name="articleTypeId_" /> <input type="text" name="name_"
						id="name_" maxlength="100" size="50"
						style="width: 200px; height: 25px" /></td>
				</tr>
				<tr>
					<td class="style1">排序:</td>
					<td class="style2"><input type="text" name="orderIndex"
						id="orderIndex" class="easyui-numberbox"
						style="width: 200px; height: 25px" /></td>
				</tr>

				<tr>
					<td class="style1">图片:</td>
					<td class="style2">
						<ul id="file" style="list-style-type: none"></ul>
					</td>
				</tr>

				<tr align="center">
					<td colspan="2"><a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="fileUpload()">图片上传</a> <a
						id="btn1" class="easyui-linkbutton">确定</a> <a id="btn2"
						class="easyui-linkbutton">关闭</a></td>
				</tr>
			</table>
		</form>

		图片上传:
		<form action="<%=basePath%>imageController/fileUpload" method="post"
			enctype="multipart/form-data" id="filesform1">
			<input name="uploadFile" id="uploadFile" class="easyui-filebox"
				data-options="prompt:'请选择图片'" style="width: 67%"> <input
				name="imageType" id="imageType" value="9" type="hidden" />
		</form>
	</div>


</body>
</html>