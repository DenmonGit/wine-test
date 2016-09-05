<%@ page language="java"
	import="java.util.*,com.mao.test.webdata.vo.AdminUserInfoVo"
	pageEncoding="UTF-8"%>
<%
String versionInfo = (String)session.getAttribute("versionInfo");
AdminUserInfoVo userInfo = (AdminUserInfoVo)session.getAttribute("userInfo");
System.out.print(userInfo);
%>
<html>
<head>
<title>个人酒库列表</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<style>
.img-t {
	height: 50px;
	width: 50px;
}

.ul_list {
	overflow: auto;
	width: 330px;
	height: 100px;
	border: 1px solid gray;
	margin-bottom: 10px;
	margin-top: 10px;
}

#words {
	margin: 0;
	padding: 0;
}

li {
	list-style-type: none;
	cursor: pointer;
	width: 100%;
}

li:hover {
	background-color: RGB(51, 151, 255);
}

.select {
	background-color: RGB(51, 151, 255);
	width: 100%;
}
</style>

<script type="text/javascript">
   		 var s_index;
    	$(function(){
    		<%
    		if(userInfo==null){
    			%>
    			window.parent.location.reload();
    			return ;
    		<%}
    		%>
	    		/* 酒标人工识别列表 */
	    		$("#user_wine_datagrid").datagrid({ 
				    //nowrap:false,		//折行显示
				    url : "<%=basePath%>webdata/userWine/list",//访问的地址
					fit : false,		
					fitColumns:true ,	
					border : false,		
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
					toolbar: [{
								iconCls: 'icon-search',
								text : "查询", 
								handler: function(){
									$('#user_wine_datagrid').datagrid('load',{
										phone: $("#phone_search").val(),
										nickName: $("#nickName_search").val(),
										wineName: $("#wineName_search").val(),
										state: $("#state_search").val()
									});
								}
							}],
					columns : [[ {	
						title : 'ID',
						field : 'id',
						hidden:true
					},{
						title : '网友上传时间',
						field : 'addTime',
						width:100	
					},{
						title : 'App用户',
						width:100 ,
						field : 'action1',
						formatter: function(value,row,index){
							return row.userName+" ( "+row.nickName+" )";
						}	
					},{
						title : '酒名',
						width:100 ,
						field : 'wineName'
					},{
						title : '处理状态',
						width:100 ,
						field : 'state',
						formatter: function(value,row,index){
							if(row.state=="dealFinshed"){
								return "已处理";
							}else if(row.state=="waitDeal"){
								return "待处理";
							}
						}
					},{
						title : '处理人',
						width:100 ,
						field : 'admin'
					},{
						field : 'action',
						title : '操作',
						formatter : function(value, record, index) {
							if(record.state=='dealFinshed'){//已处理
								return '<a style="color:green" onclick="show_userWine(\''+record.id+'\')">查看详情</a>';
							}else{
								return '<a style="color:red" onclick="edit_userWine(\''+record.id+'\')">处理</a>';
							}
						}
					}]]    
				});
    	
		   		//删除酒款编码
				$("#btn_remove").click(function(){
					if(s_index!=null){
						s_index.remove();
						s_index=null;
					}
					else{
						alert("请先选择一条记录");
					}
				});
				//添加酒款编码
				$("#btn_add").click(function(){
					var haveLi = $("#wineCode li").get(0);
					if(haveLi==null || haveLi=='' || typeof(haveLi)==undefined){
					}else{
						$.messager.show({
							title:"失败消息" ,
							msg:'只允许添加一条酒款编码!'
						});
						return;
					}
					var wineCode_input = $("#wineCode_input").val();//获取输入框的框
					if(wineCode_input==null || wineCode_input=='' || typeof(wineCode_input)==undefined){
						$.messager.show({
							title:"失败消息" ,
							msg:'酒款编码输入框不能为空!'
						});
						return;
					}
					var re = /^[A-Za-z0-9]{35}$/i; //+号表示字符至少要出现1次,\s表示空白字符,\d表示一个数字  
					if(!re.test(wineCode_input)){
						$.messager.show({
							title:"失败消息" ,
							msg:'请输入正确的酒款编码进行添加!'
						});
						return;
					}else{
						var children = $("#wineCode").children();
						for(var i=0;i<children.size();i++){ 
							if(children.eq(i).html()==wineCode_input){
								alert("酒款编码已存在");
								$("#wineCode_input").val("");
								return;
							}
						} 
						$.ajax({
							type: 'GET' ,
							url: '<%=basePath%>jf/newWine/checkWineCode' ,
							data:{wineCode:wineCode_input},//序列化表单
							dataType: "json",
							success:function(result){
								//3 提示信息
								if(result.errcode==0){
									$.messager.show({
										title:"成功消息" , 
										msg:result.errmsg
									});
										///酒款编码
									var tmp = $("<li onclick='select(this)' style='margin-left: -30px;'>"+wineCode_input+"</li>");  
									tmp.appendTo($("#wineCode"));
									$("#wineCode_input").val("");
								}else{
									$.messager.show({
										title:"成功消息" , 
										msg:result.errmsg
									});
								};
							} ,
							error:function(result){
								$.messager.show({
									title:"失败消息" ,
									msg:result.message
								});
							}
						});
					}
				});
		    	/**
				 * 关闭窗口方法
				 */
				$('#btn2').click(function(){
					$('#mydialog').dialog('close');
				});
    		/**
			 *  提交表单方法
			 */
			$('#btn1').click(function(){
				var id = $("#id").val();
				var wineCode = $("#wineCode li").html();//酒款编码
				var admin = $("#admin").val();//操作员
				if(admin==null || admin=='' || typeof(admin)==undefined){
					parent.location.reload();
					$.messager.show({
						title:"失败消息" ,
						msg:'操作员不能为空,请重新登录!'
					});
					return;
				}
				if(wineCode==null || wineCode=='' || typeof(wineCode)==undefined){
					$.messager.alert({
						title:"失败消息" ,
						msg:'请输入酒款编码!'
					});
					return;
				}
				if($('#myform').form('validate')){//判断表单验证是否全部通过
					$.ajax({
						type: 'post' ,
						url:'<%=basePath%>webdata/userWine/deal',
						data:{
							id:id,
							wineCode:wineCode 
							//admin:$("#admin").val() 
						} ,
						dataType:'json' ,
						success:function(data){
							//1 关闭窗口
							$('#mydialog').dialog('close');
							//2刷新datagrid 
							$('#user_wine_datagrid').datagrid('reload');
							//3 提示信息
							if(data.errcode==0){
								$.messager.show({
									title:"成功消息" , 
									msg:"处理个人酒款成功!"
								});
								
							}else{
								$.messager.show({
									title:"成功消息" , 
									msg:data.errmsg
								});
							};
						} ,
						error:function(result){
							$.messager.show({
								title:"失败消息" ,
								msg:"处理失败!"
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
	 	/* 处理  */
		function edit_userWine(id){
			$("#wineCode").children().remove();
			$("#btn1").show();
			$('#mydialog').dialog({
				title:'处理个人上传酒款!'
			});
			$('#mydialog').dialog('open'); //打开窗口
			$('#myform').get(0).reset();   //清空表单数据 
			$("#wineCode li").remove();
			//隐藏
			$("#wineCode_input").attr({disabled: false});
			
			if(id==null && typeof id==undefined && id==''){
				$.messager.show({
					title:"失败消息" ,
					msg:"获取个人酒款详情失败!"
				});
			}else{
				$.ajax({
					type: 'GET' ,
					url: '<%=basePath%>webdata/userWine/detail' ,
					data:{id:id},//序列化表单
					dataType: "json",
					success:function(data){
						$("#id").val(data.object.id);
						$("#phone_nickName").val(data.object.userName+"("+data.object.nickName+")");
						$("#addTime").val(data.object.addTime);
						//图片
						$("#img").attr({ src:""+data.object.img[0]+""});
						//酒名
						$("#wineName").val(data.object.wineName);
						//备注
						$("#remark").val(data.object.remark);
						
					} ,
					error:function(data){
						$.messager.show({
							title:"失败消息" ,
							msg:data.message
						});
					}
				});
			}
		}
		/* 查看的dialog对话框 */
		function show_userWine(id){
			$("#btn1").hide();
			$("#wineCode").children().remove();
			$('#mydialog').dialog({
				title:'查看个人上传酒款!'
			});
			$('#mydialog').dialog('open'); //打开窗口
			$('#myform').get(0).reset();   //清空表单数据 
			$("#wineCode li").remove();
			//隐藏
			$("#wineCode_input").attr({disabled: false});
			
			if(id==null && typeof id==undefined && id==''){
				$.messager.show({
					title:"失败消息" ,
					msg:"获取个人酒款详情失败!"
				});
			}else{
				$.ajax({
					type: 'GET' ,
					url: '<%=basePath%>webdata/userWine/detail' ,
					data:{id:id},//序列化表单
					dataType: "json",
					success:function(data){
						$("#id").val(data.object.id);
						$("#phone_nickName").val(data.object.userName+"("+data.object.nickName+")");
						$("#addTime").val(data.object.addTime);
						//图片
						$("#img").attr({ src:""+data.object.img[0]+""});
						//酒名
						$("#wineName").val(data.object.wineName);
						
						var tmp = $("<li onclick='select(this)' style='margin-left: -30px;'>"+data.object.wineCode+"</li>");  
						tmp.appendTo($("#wineCode"));
						$("#wineCode_input").val("");
						
						//备注
						$("#remark").val(data.object.remark);
						
					} ,
					error:function(data){
						$.messager.show({
							title:"失败消息" ,
							msg:data.message
						});
					}
				});
			}
		}
	
	function select(a){
		if(s_index!=null){
			s_index.removeClass("select");
		}
		s_index = $(a);
		
		s_index.addClass("select");
	}
	/*图片放大*/
	function fangda(){
		//获取图片的地址
		var src=$("#img").attr("src");
		console.log(src);
		window.open(src);
	}
		
	
    </script>
</head>
<body>
	<!-- 搜索条件 -->
	<div class="labelstyle">
		<label>手机号：</label> <input name="phone_search" id="phone_search"
			class="easyui-validatebox" /> <label>名字:</label> <input
			name="nickName_search" id="nickName_search"
			class="easyui-validatebox" /> <label>酒名：</label> <input
			name="wineName_search" id="wineName_search"
			class="easyui-validatebox" /> <label>处理状态：</label> <select
			name="state_search" id="state_search" style="width: 100px">
			<option value="">全部</option>
			<option value="dealFinshed">已处理</option>
			<option value="waitDeal">待处理</option>
		</select>
	</div>
	<!-- 数据表格 -->
	<table id="user_wine_datagrid"></table>

	<!-- 编辑的dialog对话框 -->
	<div id="mydialog" title="酒标人式识别处理" modal=true resizable=true
		class="easyui-dialog" closed=true
		data-options="left:600,top:100,closable:true"
		style="width: 650px; height: 560px">
		<form id="myform" action="" method="post">
			<input type="hidden" id="id" name="id" />
			<table class="" cellspacing="0" cellpadding="0">
				<tr>
					<td class="style1">网友上传时间:</td>
					<td class="style2"><input type="text" id="addTime"
						name="addTime" style="width: 270px; height: 27px"
						disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="style1">App用户:</td>
					<td class="style2"><input type="text" id="phone_nickName"
						name="phone_nickName" style="width: 270px; height: 27px"
						disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="style1">酒标:</td>
					<td class="style2"><img id="img" class="img-t" alt="" src="">
						<a id="fangda" onclick="fangda()" class="easyui-linkbutton"
						data-options="iconCls:'icon-ok'">放大</a></td>
				</tr>
				<tr>
					<td class="style1">酒名:</td>
					<td class="style2"><input type="text" id="wineName"
						name="wineName" style="width: 270px; height: 27px"
						disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="style1">备注:</td>
					<td class="style2"><input type="text" id="remark"
						name="remark" style="width: 270px; height: 27px"
						disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="style1">酒款编码:</td>
					<td class="style2">
						<div class="ul_list" id="container">
							<ul id="wineCode"></ul>
						</div> <a class="easyui-linkbutton" iconCls="icon-add" plain="true"
						id="btn_add">添加</a> <input id="wineCode_input"
						name="wineCode_input" style="width: 270px; height: 27px" /> <br />
						<a class="easyui-linkbutton" iconCls="icon-remove" plain="true"
						id="btn_remove">删除</a>
					</td>
				<tr>
				</tr>
				<tr>
					<td class="style1">处理人:</td>
					<td class="style2"><input type="text" name="admin" id="admin"
						disabled="disabled" value="<%=userInfo.getLoginName() %>"
						style="width: 270px; height: 27px"></td>
				</tr>
				<tr align="center" height="auto">
					<td colspan="2" style="width: 500px; padding: 3px"><a
						id="btn1" class="easyui-linkbutton"
						data-options="iconCls:'icon-ok'">提交</a> <a id="btn2"
						class="easyui-linkbutton" data-options="iconCls:'icon-no'"
						taxt-valign="center">取消</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
