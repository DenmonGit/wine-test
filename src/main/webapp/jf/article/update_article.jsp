<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String articleId=request.getParameter("id");
%>
<html>
<head>
<title>修改红酒百科</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>css/style.css" />
<script type="text/javascript" charset="utf-8"
	src="<%=basePath %>js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=basePath %>js/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8"
	src="<%=basePath %>js/ueditor/lang/zh-cn/zh-cn.js"></script>
<style type="text/css">
.text {
	display: inline-block;
	width: 10%;
	text-align: right;
}

.text span {
	margin-right: 20px;
}

.clear {
	clear: both;
	overflow: hidden;
}
</style>

<script type="text/javascript">
			$(function(){
				var ue = UE.getEditor('content');
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
					                    return /^http:\/\/[a-zA-Z][a-zA-Z0-9_\.\&\%\:]*$/i.test(value);
					                },
					                message: '简介网址必须以http://开头且在1-100个字符之间'
					            },
				            english: {// 验证网址
				                validator: function (value) {
				                    return /^[a-zA-Z]*$/i.test(value);
				                },
				                message: '等级名称必须输入英文!'
				            }
					}); 
				
				
			});
			
			
			
		   function checkoutside_url(str_outside_url){
                var strRegex = "^(http://|https://)?((?:[A-Za-z0-9]+-[A-Za-z0-9]+|[A-Za-z0-9]+)\.)+([A-Za-z]+)[/\?\:]?.*$";
                var re=new RegExp(strRegex);
                if (re.test(str_outside_url)){
                    return (true);
                }else{
                    return (false);
                }
            }

		   //异步通过articleId来获取主观题相关信息
	   		$.ajax({
					type : 'POST',
					url : '<%=basePath%>webdata/wineCyclopedia/wineDetail',
					data:{'articleId':'<%=articleId%>'},
					dataType : 'json',
					async: true,
					success : function(data) {
						//alert(JSON.stringify(data));
						if(data.errcode==0){ //设置返回的值
							
							$("#articleId").val(data.object.articleId);
							$("#title").val(data.object.title);//标题
							//封面图
							var cover_li=$("<li/>").attr("id",data.object.cover).attr("display","inline").css('float','left');//封面图
							cover_li.appendTo("#cover");
							var img=$("<img/>").attr("src",data.object.cover).css("height","50px");
							img.appendTo(cover_li);
							var span = $("<span/>").attr("class","action_d action").html("删除").css("color","red");
							span.appendTo(cover_li);
							span.click(function(){
								$(this).parent().remove();
							});
							
							
							$("#type_id").combobox('setValue',data.object.typeId);//类型
							
							$("#operatetype").val(data.object.operateType);//跳转方式
							
							if(data.object.status=='002'){//发布状态
								$("#002").prop("checked", true);//未发布
								$("#001").prop("checked", false);
							}else{
								$("#002").prop("checked", false);
								$("#001").prop("checked", true);
							}
							$("#orderNumber").numberbox('setValue',data.object.orderNumber);//年份
							$("#outside_url").val(data.object.outsideUrl);//外部网址
						    UE.getEditor('content').addListener("ready", function () {
						    	// editor准备好之后才可以使用
						    	UE.getEditor('content').setContent(data.object.content,false);
						    	});
							$.messager.show({
								title:'提示信息!', 
								msg:"获取红酒详情成功!"
							});
						}else{
							$.messager.show({
								title:'提示信息!', 
								msg:'加载失败'
							});
						}
					}
	   		});
			
			/* 保存 */
			function articleSubmit(){
				//标题
				var title = $("#title").val();//标题
				var type_id = $("#type_id").combobox('getValue')//类型
				var operatetype = $("#operatetype").val();//转换方式
				var status = $('input:radio[name="status"]:checked').val();//状态
				var orderNumber = $("#orderNumber").val();//序号
				var outside_url = $("#outside_url").val();//外部网址
				
				if(title==null || title=='' || typeof(title)==undefined || title.length>30){
					$.messager.alert({title:'警告!', msg:'标题必填且在1-30个字符之间!'});
					return;
				}
				//封面图
				if($("#cover").children().size()<=0){//大图必须填
					$.messager.alert({title:'警告!', msg:'封面图必须上传1张'});
					return;
				}

				//文章类型
				if(type_id==null || type_id=='' || typeof(type_id)==undefined){
					$.messager.alert({title:'警告!', msg:'文章类型必填!'});
					return;
				}
				//状态
				if(status==null || status=='' || typeof(status)==undefined){
					$.messager.alert({title:'警告!', msg:'状态必填'});
					return;
				}
				
				if(operatetype==null || operatetype=='' || typeof(operatetype)==undefined){
					$.messager.alert({title:'警告!', msg:'跳转方式必填!'});
					return;
				}
				
				if(operatetype=='1'){//自定义内容
					var content = UE.getEditor('content').getContent();
					if(content==null || content=='' || typeof(content)==undefined){
						$.messager.alert({title:'警告!', msg:'题目来源于自定义内容时，自定义内容必填!'});
						return;
					}
				}
				if(operatetype=='2'){//外部网址
					var outside_url = $("#outside_url").val();
					if(outside_url==null || outside_url=='' || typeof(outside_url)==undefined){
						$.messager.alert({title:'警告!', msg:'题目来源于外部网址时，外部网址必填!'});
						return;
					}
				}
				
				if(outside_url==null || outside_url =='' || typeof(outside_url)==undefined){
				}else{
					var flag1 = checkoutside_url(outside_url);
					 if(!flag1){
						 $.messager.alert({title:'警告!', msg:'外部网址不符合outside_url规则!'});
						 return ;
					 }
				}
				var cover = $("#cover li img").attr("src");
				
				if($('#articleForm').form('validate')){//判断表单验证是否全部通过
					// 做一个异步的提交 
					
					$.ajax({
						type : 'POST',
						url : '<%=basePath%>webdata/wineCyclopedia/update',
						data : {
								 'articleId':'<%=articleId%>',
								 'title':title ,
								 'cover': cover ,
								 'type_id':type_id ,
								 'operatetype':operatetype ,
								 'status':status ,
								 'orderNumber':orderNumber ,
								 'outside_url':outside_url ,
								 'content':UE.getEditor('content').getContent()
								} ,
						dataType : 'json',
						success : function(data) {
									if(data.result==1){
										$.messager.alert({
											title:'提示信息!', 
											msg:data.message
										});
										window.opener.location.reload();		
										window.close();
												
									}else{
										$.messager.alert({
											title:'提示信息！',
											msg:data.message
										});
									}
									
							}
					});
				}else {
					$.messager.alert({
						title:'提示信息!' ,
						msg:'数据验证不通过,不能保存!'
					});
				}
			}
			//取消
			function articleClear(){
				window.opener.location.reload();
				window.close();
			}
			//大图上传
			function coverUpload(){
				/*先判断大图框里有几个孩子，如果超过1个则提醒*/
				if($("#cover").children().size()<1){
						/* 将filesform1表单提交 */
		        		$('#filesform1').form('submit', { 
							 url:'<%=basePath%>webdata/imageController/fileUpload',
							 success:function(data){
								var data1=eval('('+data+')');
								// console.info(data1.object[0]);
								if(data1.errcode==1){
									var li=$("<li/>").attr("id",'').attr("display","inline");
									li.appendTo("#cover");
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
		//跳转到自定义内容网址的隐藏和显示
		function operatetypeShowAndHidden(obj){
			if($(obj).val() == '2'){//外部网址
				//$("#contentDiv").setDisabled();
				$("#outside_urlDiv").show();
			} else {					//自定义内容
				//$("#contentDiv").setEnabled();
				$("#outside_urlDiv").hide();
			}
		}
		
		
	</script>
</head>

<body>
	<div class="easyui-tabs" data-options="tabWidth:100"
		style="width: 1000px; height: 900px; margin: 0 auto;">
		<div title="文章修改" style="padding: 10px">
			<div class="easyui-panel" title=""
				style="width: 800px; padding: 10px 80px 10px 80px"
				data-options="fit:true">
				<form id="articleForm" method="post">
					<input type="hidden" id="articleId" name="articleId" />
					<div style="margin-bottom: 5px">
						<div>
							<div class="text">
								<span>标题</span>
							</div>
							<input type="text" id="title" name="title"
								class="easyui-validatebox textbox"
								style="width: 80%; height: 27px" required=true
								validType="midLength[1,30]" missingMessage="标题必填!"
								invalidMessage="标题必须在1到30个字符之间!" value="" />
						</div>
					</div>

					<div style="margin-bottom: 20px">
						<div class="text">
							<span>封面图片:</span>
						</div>
						<ul id="cover" style="list-style-type: none"></ul>
					</div>
					<br /> <br /> <br /> <br />
					<div style="margin-bottom: 5px">
						<div>
							<div class="text">
								<span>类型</span>
							</div>
							<input class="easyui-combobox" name="type_id" id="type_id"
								style="height: 30px; width: 250px" editable='false'
								data-options="url:'<%=basePath%>webdata/wineCyclopedia/getWineTypeComboBox',method: 'get',valueField:'id',textField:'text',groupField:'group',panelHeight:'auto'">
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<div class="text">
								<span>跳转方式:</span>
							</div>
							<select id="operatetype" name="operatetype"
								style="width: 80%; height: 27px"
								onchange="operatetypeShowAndHidden(this)">
								<option value="2">外部网址
								<option value="1">自定义内容
							</select>
						</div>
					</div>

					<div style="margin-bottom: 5px">
						<div>
							<div class="text">
								<span>发布状态</span>
							</div>
							<input type="radio" name="status" id="001"
								value="001" class="easyui-validatebox" checked="checked" />已发布
							<input type="radio" name="status" id="002"
								value="002" class="easyui-validatebox" />未发布
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<div class="text">
								<span>序号:</span>
							</div>
							<input type="text" id="orderNumber" name="orderNumber"
								class="easyui-numberbox" style="width: 250px; height: 27px"
								data-options="min:0,max:999,precision:0" required=true
								missingMessage="序号必填!" value="1" invalidMessage="序号必须是三位正整数!" />
						</div>
					</div>

					<div style="margin-bottom: 5px;">
						<div id="outside_urlDiv">
							<div class="text">
								<span>外部网址:</span>
							</div>
							<input type="text" id="outside_url" name="outside_url"
								class="easyui-validatebox textbox"
								style="width: 80%; height: 27px" />
						</div>
					</div>

					<div style="margin-bottom: 5px;">
						<div class="text">
							<span>自定义内容:</span>
						</div>
						<div id="contentDiv">
							<textarea id="content" name="content"
								style="width: 90%; margin-left: 10%; height: 270px"></textarea>
						</div>
					</div>


					<div
						style="margin-left: 200px; margin-bottom: 20px; padding-left: 90px; border-left-width: 100px;">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="coverUpload()">封面上传</a> <a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="articleSubmit()">保存</a> <a
							href="javascript:void(0)" class="easyui-linkbutton"
							onclick="articleClear()">取消</a>
					</div>
				</form>
				<form id="filesform1"
					action="<%=basePath%>imageController/fileUpload" method="post"
					enctype="multipart/form-data">
					<div style="margin-bottom: 5px">
						<div>
							<div class="text">
								<span>图片添加:</span>
							</div>
							<input name="uploadFile" id="uploadFile" class="easyui-filebox"
								data-options="prompt:'请选择图片'" style="width: 67%; height: 27px">
							<input type="hidden" name="imageType" id="imageType" value="9">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>
