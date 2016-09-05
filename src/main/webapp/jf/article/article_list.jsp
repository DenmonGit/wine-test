<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String versionInfo = (String)session.getAttribute("versionInfo");
String userInfo = (String)session.getAttribute("adminInfo");
%>
<html>
<head>
<title>红酒百科</title>
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
    		/* 渲染红酒百科表格 */
    		$("#wine_articleList").datagrid({ 
			    //title : "红酒百科列表", 
			    //width:1300,
			    //height:450,
			    //nowrap:false,		//折行显示
			    url : '<%=basePath%>webdata/wineCyclopedia/getWineDataGrid',//访问的地址
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
				pagination: true , 
				pageSize: 10 ,
				pageList:[10,20,30] ,
				toolbar: [{
								iconCls: 'icon-add',
								text : "添加", 
								handler: function(){
									window.open('<%=basePath%>jf/article/add_article.jsp');
									}
							},'-',{
								iconCls: 'icon-search',
								text : "查询", 
								handler: function(){
										$('#wine_articleList').datagrid('load',{
											title: $("#title_").val(),
											type_id: $("#type_").combobox('getValue')//类型
										});
								}
							}],
				frozenColumns:[[{		//冻结列
						field : 'ck',
						width : 50,
						checkbox : true
				}]],
				columns : [[ {	//列
					title : 'ID',
					field : 'id',
					width : 100,
					//checkbox : true
					hidden:true
				},{
					title : "标题",
					field : 'title',
					
					
				},{
					title : '序号',
					field : 'orderNumber',
					//width : 100,
				},{
					title : '发表状态',
					field : 'status',
					formatter: function(value,row,index){
						if (row.status=='001'){
							return "已发布";
						} else {
							return "未发布";
						}
					}
				},{
					field : 'action',
					title : '操作',
					formatter : function(value, row, index) {
						return '<a style="color:green" onclick="updateArticle(\''+row.id+'\')">修改</a>&nbsp&nbsp<a style="color:red" onclick="deleteArticle(\''+row.id+'\')">删除</a>';
					}
				}]]    
			});
			
    	});
		/* 修改页面 */
		function updateArticle(id){
			window.open('<%=basePath%>jf/article/update_article.jsp?id='+id);
		}
		/* 异步删除 */
		function deleteArticle(id){
			$.messager.confirm('文章删除', '确定删除吗?', function(r){
				if (r){
					$.ajax({
							type : 'POST',
							url : '<%=basePath%>webdata/wineCyclopedia/deleteWine',
							data : {'id':id},
							dataType : 'json',
							success : function(data) {	
							if(data.result==1){
								$.messager.alert('提示', '删除成功');
								/* 删除成功后重新加载当前页面 */
								$('#wine_articleList').datagrid('reload'); 
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
	<div id="tb" class="labelstyle">
		<label>标题：</label> <input name="title_" id="title_" type="text" />
		 <label>目录：</label>
		<input class="easyui-combobox" name="type_" id="type_"
			editable='false'
			data-options="url:'<%=basePath%>webdata/wineCyclopedia/getWineTypeComboBox',method: 'get',valueField:'id',textField:'text',groupField:'group',panelHeight:'auto'">
	</div>
	<table id="wine_articleList"></table>
</body>
</html>
