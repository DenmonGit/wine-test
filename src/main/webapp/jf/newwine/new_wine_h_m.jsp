<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String versionInfo = (String)session.getAttribute("versionInfo");
String userInfo = (String)session.getAttribute("adminInfo");
%>
<html>
<head>
<title>官方酒款列表</title>
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
			//加载数据表格
			$('#new_wine').datagrid({
				url : '<%=basePath%>webdata/newWine/getNewWineList',
				fit : false,		//自适应
				fitColumns:true ,	//自适应列
				border : false,		//边框
			    singleSelect:true,	//只允许选择一行
				rownumbers:true ,
				pagination : true,	//分页
    		    idField : "wine_id",  //创建数据表格的时候必须加上 
				pageSize : 10,
				pageList : [10,20,30],
				sortName : '',		//排序
				sortOrder : '',
				checkOnSelect : false,
				selectOnCheck : false,
			    striped:true,		//隔行变色
				nowrap : true,
				toolbar: [{
								iconCls: 'icon-add',
								text : "添加", 
								handler: function(){
									window.open('<%=basePath%>jf/newwine/new_wine_add.jsp');
									}
							},'-',{
								iconCls: 'icon-search',
								text : "查询", 
								handler: function(){
										$('#new_wine').datagrid('load',{
										    wine_name_cn: $("#wine_name_cn").val(),//中文名
										    wine_code: $("#wine_code").val(),//酒款编码
											state: $("#state").val(),//数据状态
											source: $("#source").combobox("getValue"),//数据来源
										});
								}
							}],
				columns : [[
				            //"wine_id","area_code","vintages","wine_code","wine_name_cn"],"columnValues":["0006b3258cc0485381ce42f9e8a541d6","卡瓦","1982","ES0000000000008000000ArrrVQAt198200","菲斯奈特杜布瓦绝干卡瓦起泡酒"],"columns":{"wine_id":"0006b3258cc0485381ce42f9e8a541d6","area_code":"卡瓦","vintages":"1982","wine_code":"ES0000000000008000000ArrrVQAt198200","wine_name_cn":"菲斯奈特杜布瓦绝干卡瓦起泡酒"}}],"total":1}
							{
								align : 'center',
								title : '酒id',
								field : 'wine_id',
								hidden : true
							},
							{
								align : 'center',
								title : '名称',
								field : 'wine_name_cn',
								width : 50
							},{
								align : 'center',
								title : '酒款编码',
								field : 'wine_code',
								width : 40
							},{
								align : 'center',
								title : '年份',
								field : 'vintages',
								width : 10
							},{
								align : 'center',
								title : '产地',
								field : 'area1',
								width : 50,
								formatter: function(value,row,index){
									var area='';
									if( row.area_1!=null && typeof( row.area_1)!=undefined){
										area=area+row.area_1;
									}
									if(row.area_2!=null && typeof( row.area_2)!=undefined && row.area_2!=""){
										area=area+"-->"+row.area_2;
									}
									if(row.area_3!=null && typeof( row.area_3)!=undefined && row.area_3!=""){
										area=area+"-->"+row.area_3;
									}
									if(row.area_4!=null && typeof( row.area_4)!=undefined && row.area_4!=""){
										area=area+"-->"+row.area_4;
									} 
									if(row.area_5!=null && typeof( row.area_5)!=undefined && row.area_5!=""){
										area=area+"-->"+row.area_5;
									}
									//return "<span title="+area+">"+area+"</span>";
									return area;
								}
							},{
								align : 'center',
								title : '数据状态',
								field : 'state',
								width : 10,
								formatter: function(value,row,index){
									//0为已处理1为未处理
									if('Y'==value){
										return '已发布';
									}else{
										return '未发布';
									}
								}
							},{
								align : 'center',
								title : '修改时间',
								field : 'update_time',
								width : 20
							},{   
								align : 'center',
								field : 'action',
								title : '操作',
								formatter : function(value, row, index) {
									return '<a style="color:green" onclick="update_new_wine(\''+row.wine_id+'\')">修改</a>&nbsp&nbsp<a style="color:red" onclick="delete_new_wine(\''+row.wine_id+'\')">删除</a>';
								
								}
							}]]
				});
			});
		//编辑页面
		function update_new_wine(wine_id){
			//console.info(wine_id);
			//打开编辑新官方酒的页面  /ajbwine/WebRoot/jf/newwine/new_wine_update.jsp
			window.open('<%=basePath%>jf/newwine/new_wine_update.jsp?wine_id='+wine_id);
		}
		//删除
		function delete_new_wine(wine_id){
				//console.info(wine_id);
				$.messager.confirm('提示信息' , '确认删除?' , function(r){
					if(r){
							$.post('<%=basePath%>webdata/newWine/deleteNewWine' , {wine_id:wine_id} , function(result){
								//1 刷新数据表格 
								$('#new_wine').datagrid('reload');
								//2 清空idField   
								$('#new_wine').datagrid('unselectAll');
								//3 给提示信息 
								$.messager.show({
									title:'提示信息!' , 
									msg:"删除酒款成功!"
								});
							});
					} else {
						return ;
					}
				});
		}
		
		
	</script>
</head>
<body>
	<!-- 搜索条件 -->
	<form id="searchForm" method="post">
		<div class="labelstyle">
			<label>中文名:</label> <input id="wine_name_cn" name="wine_name_cn"
				style="width: 200px" /> <label>酒款编码:</label> <input id="wine_code"
				name="wine_code" style="width: 200px; margin-right: 150px;" /> <label>数据状态：</label>
			<select style="width: 100px; margin-right: 50px;" name="state"
				id="state">
				<option value="">全部</option>
				<option value="Y">已发布</option>
				<option value="N">未发布</option>
			</select> <label>数据来源：</label> 
			<input class="easyui-combobox" id="source" name="source"
				data-options="url:'<%=basePath%>/jf/website/getWebSiteCombobox',method:'get',valueField:'id',textField:'text',panelHeight:'auto'">
		</div>

	</form>
	<!-- 数据表格 -->
	<table id="new_wine"></table>
</body>
</html>
