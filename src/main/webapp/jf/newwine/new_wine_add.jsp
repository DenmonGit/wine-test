<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE>
<html>
<head>
<title>新官方酒款修改页面</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
</head>
<body>
	<div class="easyui-tabs" data-options="tabWidth:100"
		style="width: 710px; height: 830px; margin: 0 auto;">
		<div title="基本信息" style="padding: 10px">
			<div class="easyui-panel" title=""
				style="width: 660px; padding: 20px 100px 80px 130px"
				data-options="fit:true">
				<form id="jbxxForm" method="post">
					<div style="margin-bottom: 5px">
						<div>
							<span>酒款编码:</span> <input type="hidden" id="wine_id"
								name="wine_id" /> <input type="text" id="wine_code"
								name="wine_code" disabled="disabled"
								style="height: 30px; width: 300px" />
							<!-- <input type="button" id="markWine_id" value="自动生成"></input> -->
							<a class="easyui-linkbutton" iconCls="icon-ok" plain="true"
								id="markWine_id"><span style="background: red">自动生成</span></a>
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>中文名称:</span> <input id="wine_name_cn" name="wine_name_cn"
								type="text" class="easyui-textbox"
								style="height: 30px; width: 300px" required=true
								validType="midLength[1,60]" missingMessage="中文名称必填!"
								invalidMessage="中文名称必填且在1-60个字符之间!" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>英文名称:</span> <input id="wine_name_en" name="wine_name_en"
								type="text" class="easyui-textbox"
								style="height: 30px; width: 300px" required=true
								validType="midLength[1,120]" missingMessage="英文名称必填!"
								invalidMessage="英文名必须在1到60个字符之间!" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 5px">酒 类 型:</span> <input
								class="easyui-combobox" id="wine_type_code"
								name="wine_type_code" missingMessage="酒类型必填!"
								style="height: 30px; width: 300px"
								data-options="url:'<%=basePath %>webdata/wineType/getWineType',method:'get',valueField:'id',textField:'text',required:true">
							<img id="bottle_type_img" alt="" src=""
								style="height: 60px; width: 20px">
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 20px">产 区:</span> <input
								id="area_code" name="area_code" class="easyui-combotree"
								data-options="url:'<%=basePath %>webdata/areaDict/getAreaDictTree',method:'get',required:true"
								missingMessage="产区必填!" style="height: 30px; width: 300px;">
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>酒庄酒商:</span> <input id="chateau_code" name="chateau_code"
								class="easyui-combobox"
								data-options="editable:false,required:true"
								style="height: 30px; width: 300px" missingMessage="酒庄酒商必填!" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 20px">品 牌:</span> <input
								id="brand_code" name="brand_code" class="easyui-combobox"
								data-options="editable:false,required:true"
								style="height: 30px; width: 300px" missingMessage="品牌必填!" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 20px">等 级:</span> <input
								id="level_code" name="level_code" class="easyui-combobox"
								data-options="editable:false,required:true,panelHeight:'auto'"
								style="height: 30px; width: 300px" missingMessage="等级必填!" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 20px">年 份:</span> <input id="vintages"
								name="vintages" type="text"
								data-options="min:0,max:9999,precision:0"
								class="easyui-numberbox" required=true
								style="height: 30px; width: 300px" missingMessage="年份必填!"
								style="height: 30px" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 5px">酒 精 度:</span> <input id="alcohol"
								name="alcohol" type="text" class="easyui-numberbox"
								data-options="min:0,max:99.9,precision:1"
								style="height: 30px; width: 300px"></input>
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>葡萄品种:</span> <input class="easyui-combobox"
								name="grape_varieties" id="grape_varieties"
								style="height: 30px; width: 300px"
								data-options="url:'<%=basePath %>jf/varieties/getVarietiesComboBox',method: 'get',valueField:'id',textField:'text',multiple:true,groupField:'group'">
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 20px">容 量:</span> <input
								class="easyui-combobox" id="capacity" name="capacity"
								style="height: 30px; width: 300px"
								data-options="url:'<%=basePath %>jf/capacity/getcapacityDict',method:'get',valueField:'id',textField:'text'">
						</div>
					</div>
					<!-- <div style="margin-bottom:5px">
						<div>
						<span>数据来源:</span>
						<input class="easyui-combobox" id="web_code" name="web_code"  data-options="url:'${ctx }/jf/website/getWebSiteCombobox',method:'get',valueField:'id',textField:'text',panelHeight:'auto'">
						</div>
					</div>
					 -->

					<div style="margin-bottom: 20px">
						<span style="margin-right: 20px">正 标:</span>
						<ul id="zhengbiao" style="list-style-type: none"></ul>
					</div>
					<br /> <br /> <br /> <br />
					<div style="margin-bottom: 20px">
						<span style="margin-right: 20px">配 图:</span>
						<ul id="peiTu" style="list-style-type: none">
						</ul>
					</div>
					<br /> <br /> <br />
					<div style="margin-bottom: 20px; padding-left: 85px;">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="zhengBiaoUpload()">正标上传</a> <a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="peiTuUpload()">配图上传</a> <a
							href="javascript:void(0)" class="easyui-linkbutton"
							onclick="jbxxSubmit()">保存</a> <a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="jbxxChongZhi()">重置</a> <a
							href="javascript:void(0)" class="easyui-linkbutton"
							onclick="jbxxClear()">取消</a>
					</div>
				</form>
				<form id="filesform1"
					action="<%=basePath%>imageController/fileUpload" method="post"
					enctype="multipart/form-data">
					<div style="margin-bottom: 5px">
						<div>
							<span>图片添加:</span> <input name="uploadFile" id="uploadFile"
								class="easyui-filebox" data-options="prompt:'请选择图片'"
								style="width: 67%; height: 27px"> <input type="hidden"
								name="imageType" id="imageType" value="1">
						</div>
					</div>
				</form>
			</div>
		</div>
		<div title="品酒信息" style="padding: 10px">
			<div class="easyui-panel" title=""
				style="width: 660px; padding: 50px 100px 80px 100px"
				data-options="fit:true">
				<form action="" method="post">
					<div style="margin-bottom: 5px">
						<div>
							<span>酒款综述(中文):</span>
							<textarea id="comment_cn" name="comment_cn"
								style="height: 100px; width: 400px" class="easyui-validatebox"
								validType="midLength[1,500]" invalidMessage="酒款综述必须在1到500个字符之间!"></textarea>
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>酒款综述(英文):</span>
							<textarea id="comment_en" name="comment_en"
								style="height: 100px; width: 400px" class="easyui-validatebox"
								validType="midLength[1,500]" invalidMessage="酒款综述必须在1到500个字符之间!"></textarea>
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span id="foodscheckbox">搭配美食:</span> <input
								class="easyui-combobox" name="foods" id="foods"
								style="height: 30px; width: 300px"
								data-options="url:'<%=basePath %>jf/food/getFoodsComboBox',method: 'get',valueField:'id',textField:'text',multiple:true,groupField:'group'">
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span id="occasioncheckbox">适用场景:</span> <input
								class="easyui-combobox" name="occasion" id="occasion"
								style="height: 30px; width: 300px"
								data-options="url:'<%=basePath %>jf/occasion/getOccasionComboBox',method: 'get',valueField:'id',textField:'text',multiple:true,groupField:'group'">
						</div>
					</div>

					<div style="margin-bottom: 5px">
						<div>
							<span>建议醒酒时间:</span> <input name="awake_time" id="awake_time"
								type="text" style="height: 30px; width: 280px"
								class="easyui-numberbox"
								data-options="min:0,max:999,precision:0" />(分 钟)
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>最佳品尝温度:</span> <input type="text" name="temperature"
								id="temperature" style="height: 30px; width: 280px"
								class="easyui-numberbox" data-options="min:0,max:99,precision:0" />(摄氏度)
						</div>
					</div>
					<div style="padding: 5px 5px 5px 170px">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="pjxxSubmit()">保存</a> <a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="pjxxClear()">取消</a>
					</div>
				</form>
			</div>
		</div>
		<div title="运营信息" style="padding: 10px">
			<div class="easyui-panel" title=""
				style="width: 660px; padding: 50px 100px 80px 100px"
				data-options="fit:true">
				<form action="" method="post">
					<div style="margin-bottom: 5px">
						<div>
							<span>发布状态:</span> <input type="radio" name="state" id="state1"
								value="Y" class="easyui-validatebox" />已发布 <input type="radio"
								name="state" id="state2" value="N" class="easyui-validatebox"
								checked="checked" />未发布
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>中文简称:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <input
								id="short_for_cn" name="short_for_cn" type="text"
								class="easyui-textbox" validType="midLength[1,4]"
								missingMessage="中文简称必填!" invalidMessage="中文简称必须在1到4个字符之间!"
								style="height: 30px; width: 280px" />
						</div>
					</div>
					<div style="margin-bottom: 5px">
						<div>
							<span>英文简称:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <input
								type="text" name="short_for_en" id="short_for_en"
								class="easyui-textbox" validType="midLength[0,4]"
								missingMessage="英文简称必填!" invalidMessage="英文简称必须在1到4个字符之间!"
								style="height: 30px; width: 280px" />
						</div>
					</div>

					<%-- <div style="margin-bottom:5px">
						<div>
						<span>瓶子图片:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input class="easyui-combobox" name="bottle_type" id="bottle_type"  style="height: 30px;width:280px"  data-options="url:'<%=basePath%>jf/bottletype/getBottleType',method: 'get',valueField:'id',textField:'text',groupField:'group',panelHeight:'auto'">
							<img id="bottle_type_img" alt="" src="">
						</div>
					</div> --%>
					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 5px">条 形
								码:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <input id="bar_code"
								name="bar_code" type="text" class="easyui-textbox"
								validType="midLength[0,30]" invalidMessage="条形码最长为30个字符!"
								style="height: 30px; width: 280px" />
						</div>
					</div>

					<div style="margin-bottom: 5px">
						<div>
							<span style="margin-right: 5px">酒淘淘商品ID</span> <input
								id="wine_jtt_id" name="wine_jtt_id" type="text"
								class="easyui-numberbox" style="height: 30px; width: 280px" />
						</div>
					</div>

					<%--<div style="margin-bottom:5px">
							<div>
							<span>专家评分:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input type="text" name="zhuangJiaPingFeng" class="easyui-numberbox" data-options="min:0,max:9.9,precision:1" style="width:300px"/>
							</div>
						</div>
						<div style="margin-bottom:5px">
							<div>
							<span>网友评分:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input type="text" name="wangYouPingFeng" class="easyui-numberbox" data-options="min:0,max:9.9,precision:1" style="width:300px" />
							</div>
						</div>
						--%>
					<div style="padding: 5px 5px 5px 170px">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="yyxxSubmit()">保存</a> <a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="yyxxclear()">取消</a>
					</div>
			</div>
			</form>
		</div>
	</div>
	</div>
</body>
<script type="text/javascript">
   $.support.cors = true;
    	$(function(){
    		//产区改变联动出，酒庄,等级
			$("#area_code").combotree({
				onChange:function(newValue,oldValue){
		        	//酒庄酒商
			        $("#chateau_code").combobox({
       	    			 url:'<%=basePath%>jf/chateau/getChateauByAreaCode?area_code='+newValue,    
       	    			 valueField:'id',    
       	    			 textField:'text'   
       	    		});
		        	//等级
			       $("#level_code").combobox({
			    	     url:'<%=basePath%>jf/level/getLavelCombox?area_code='+newValue, 
       	    			 valueField:'id',    
       	    			 textField:'text'    
       	    		});
				  }  
			});	
			//酒庄酒商，改变联动出品牌
    		$('#chateau_code').combobox({ 
    			onChange:function(newValue,oldValue){
    				$("#brand_code").combobox({
	   	    			 url:'<%=basePath%>jf/brand/getBrandByChateauCode?chateauCode='+newValue,    
	   	    			 valueField:'id',    
	   	    			 textField:'text'   
	   	    		});
    			} 
			});
    		//瓶子图片改变的时候，对应的图片僧也变
    		/*$('#bottle_type').combobox({ 
    			onChange:function(newValue,oldValue){
    				//获取图片的代码，找图片的路径，渲染到img上
    				$.ajax({
    					type:"POST",
    					url:"jf/bottletype/getBottleImgByCode",
    					data:{code:newValue},
    					success:function(data){
    						console.info(data);
    						var data1 = eval("("+data+")");
    						$("#bottle_type_img").attr({ src: ""+data1.object+"", alt: ""+data1.object+"" }).css("height","50px");
    					}
    				});
    			} 
			});  
    		*/
    		//酒类型改变的时候，对应的瓶子图片也会变
    		$('#wine_type_code').combobox({ 
    			onChange:function(newValue,oldValue){
    				//获取图片的代码，找图片的路径，渲染到img上
    				$.ajax({
    					type:"POST",
    					url:"<%=basePath%>jf/wineType/wineTypeImg",
    					data:{code:newValue},
    					success:function(data){
    						var data1 = eval("("+data+")");
    						$("#bottle_type_img").attr({ src: ""+data1.object+"", alt: ""+data1.object+"" });
    					}
    				});
    			} 
			});  
   			/*自动生成酒款编码*/
			$("#markWine_id").click( function () { 
				//获取产地，酒庄酒商，
				var area_code=$("#area_code").combotree('getValue');//产地
				var chateau_code=$("#chateau_code").combobox('getValue');//酒庄/酒商编码
				var brand_code=$("#brand_code").combobox('getText');//品牌
				var wine_type_code=$("#wine_type_code").combobox('getValue');//酒类型
				var level_code=$("#level_code").combobox('getText');//等级编码
				var vintages=$("#vintages").val();//年份
				var grape_varieties=$("#grape_varieties").combobox('getText');//葡萄品种文本值
				//酒类型
				if(wine_type_code==null || wine_type_code=='' || typeof(wine_type_code)==undefined){
					$.messager.show({title:'提示!', msg:'酒类型不能为空'}); 
					return;
				}
				//产地
				if(area_code==null || area_code=='' || typeof(area_code)==undefined){
					$.messager.show({title:'提示!', msg:'产地不能为空'}); 
					return;
				}
				//酒庄/酒商编码
				if(chateau_code==null || chateau_code=='' || typeof(chateau_code)==undefined){
					$.messager.show({title:'提示!', msg:'酒庄酒商不能为空'}); 
					return;
				}
				//品牌
				if(brand_code==null || brand_code=='' || typeof(brand_code)==undefined){
					$("#brand_code").combobox('setValue',chateau_code+'000000');
					$("#brand_code").combobox('setText','其他酒庄/酒商');
				}
				//等级
				if(level_code==null || level_code=='' || typeof(level_code)==undefined){
					$("#level_code").combobox('setValue','tttt');
					$("#level_code").combobox('setText','无等级');
				}
				//年份
				if(vintages==null || vintages=='' || typeof(vintages)==undefined){
					$.messager.show({title:'提示!', msg:'年份必填'}); 
					return;
				}
				if(vintages.length==1){
					vintages='000'+vintages;
				}else if(vintages.length==2){
					vintages='00'+vintages;
				}else if(vintages.length==3){
					vintages='0'+vintages;
				}
				//葡萄
				if(grape_varieties==null || grape_varieties=='' || typeof(grape_varieties)==undefined){
					$("#grape_varieties").combobox('setText','');
				}
				//wine_area   wine_chateau   brand_name_cn   wine_type  wine_level  wine_year
				//var wine_code=$("#chateau_code").combobox('getValue')+$("#brand_code").combobox('getValue')+$("#wine_type_code").combobox('getValue')+$("#level_code").combobox('getValue')+vintages;
				
				var wine_code=$("#brand_code").combobox('getValue')+$("#wine_type_code").combobox('getValue')+$("#level_code").combobox('getValue')+vintages;
				
				
				//console.info(wine_code);
					//做一个异步提交到后台，酒款编码wine_code[33]位+葡萄品种
					$.ajax({
						type:'POST',
						url:'<%=basePath%>jf/newWine/makeWineCode',
						data:{'wine_code33':wine_code,'grape_varieties':grape_varieties},
						success:function(data){
							var data1=eval('('+data+')');
							
							if(data1.result==1){
								
								if(data1.object!=null && typeof(data1.object)!=undefined && data1.object!=""){
									//alert(JSON.stringify(result));
									//var result1 = result.object.substring(0,33);
									//var result2 =parseInt(result.object.substring(33))+1;
									//if(result2<10){
									//	result2 = "0"+result2;
									//}
									console.info(data.object);
									console.info($("#wine_code"));
									$("#wine_code").val(data1.object);
									
								}else{
									$("#wine_code").val(wine_code+"00");
								}
								//设置酒款编码
								$.messager.alert({
									title:'提示信息!', 
									msg:data1.message//{"errcode":1,"object":null,"errmsg":"已经添加过该款酒"}
								});
							}else {
								$.messager.alert({
									title:'提示信息!', 
									msg:data1.errmsg//{"errcode":1,"object":null,"errmsg":"已经添加过该款酒"}
								});
							}
							
							
						},
						error:function(){
							$.messager.alert({
								title:'提示信息!', 
								msg:'自动生成酒码失败!'
							});
						}
					});
				
				
			});	
    	});
			
    	//正标上传
		function zhengBiaoUpload(){
			/*先判断正标框里有几个孩子，如果超过1个则提醒*/
			if($("#zhengbiao").children().size()<1){
					/* 将filesform1表单提交 */
	        		$('#filesform1').form('submit', { 
	        			 url:'<%=basePath%>imageController/fileUpload',
						 success:function(data){
							var data1=eval('('+data+')');
							//console.info(data1);
							if(data1.errcode==1){
								var li=$("<li/>").attr("id",'').attr("display","inline");
								li.appendTo("#zhengbiao");
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
				$.messager.show({title:'提示!', msg:'正标最多上传1张'}); 
				return;
			}
		} 
		/* 配图上传 */
		function peiTuUpload(){
			if($("#peiTu").children().size()<4){
				
        		$('#filesform1').form('submit',{
        			url:'<%=basePath%>imageController/fileUpload',
					success:function(data){
						var data1=eval('('+data+')');
						if(data1.errcode==1){
							var li=$("<li/>").attr("id",'').attr("style","float:left");
							li.appendTo("#peiTu");
							var img=$("<img/>").attr("src",data1.object).css("height","30px");
							img.appendTo(li);
							var span = $("<span/>").attr("class","action_d action").html("删除");
							span.appendTo(li);
							span.click(function(){
								$(this).parent().remove();
							});
							$.messager.alert('提示', data1.errmsg);
						}
						else{
							$.messager.alert('提示', data1.errmsg); 
						}
					}
				});
			}else{
					$.messager.show({title:'警告!', msg:'配图最多上传4张'});
				}
		}
		
		/* 基本信息保存 */
		function jbxxSubmit(){
			
			//中文名称
			var wine_name_cn= $("#wine_name_cn").textbox('getValue');//中文名称
			if(wine_name_cn==null || wine_name_cn=='' || typeof(wine_name_cn)==undefined || wine_name_cn.length>30){
				$.messager.show({title:'警告!', msg:'酒款中文名称必填且在1-30个字之间!'});
				return;
			}
			//英文名称
			var wine_name_en= $("#wine_name_en").textbox('getValue');//中文名称
			if(wine_name_en==null || wine_name_en=='' || typeof(wine_name_en)=="undefined" || wine_name_en.length>120){
				$.messager.show({title:'警告!', msg:'酒款英文名称必填且在1-120个字符之间!'});
				return;
			}
			//酒类型
			var wine_type_code=$("#wine_type_code").combobox('getValue');
			if(wine_type_code==null || wine_type_code=='' || typeof(wine_type_code)==undefined){
				$.messager.show({title:'警告!', msg:'酒类型必填!'});
				return;
			}
			//产区
			var area_code=$("#area_code").combotree('getValue');//产地
			if(area_code==null || area_code=='' || typeof(area_code)==undefined){
				$.messager.show({title:'警告!', msg:'产区必填!'});
				return;
			}
			//酒庄/酒商编码
			var chateau_code=$("#chateau_code").combobox('getValue');//酒庄/酒商编码
			if(chateau_code==null || chateau_code=='' || typeof(chateau_code)==undefined){
				$.messager.show({title:'警告!', msg:'酒庄酒商必填!'});
				return;
			}
			//品牌
			var brand_code=$("#brand_code").combobox('getValue');//品牌
			if(brand_code==null || brand_code=='' || typeof(brand_code)==undefined){
				$("#brand_code").combobox('setValue','000000');
				$("#brand_code").combobox('setText','其他酒庄/酒商');
			}
			//等级
			var level_code=$("#level_code").combobox('getValue');//品牌
			if(level_code==null || level_code=='' || typeof(level_code)==undefined){
				$("#level_code").combobox('setValue','tttt');
				$("#level_code").combobox('setText','无等级');
			}
			//年份
			var vintages=$("#vintages").val();//年份
			if(vintages==null || vintages=='' || typeof(vintages)==undefined){
				$.messager.show({title:'警告!', msg:'年份必填'});
				return;
			}
			if(vintages.length==1){
				vintages='000'+vintages;
			}else if(vintages.length==2){
				vintages='00'+vintages;
			}else if(vintages.length==3){
				vintages='0'+vintages;
			}
			//判断酒款编码是否为空，如果为空则提醒
			var wine_code=$("#wine_code").val();//酒款编码
			if(wine_code==null || wine_code=='' || typeof(wine_code)==undefined){
				$.messager.alert({title:'警告!', msg:'请生成酒款编码后方可保存!'});
				return;
			}
			//酒精度
			var alcohol=$("#alcohol").val();
			//葡萄品种
			var grape_varieties=$("#grape_varieties").combobox('getText');
			if(grape_varieties==null || grape_varieties=='' || typeof(grape_varieties)==undefined){
				$("#grape_varieties").combobox('setValue','00');//葡萄品种
				$("#grape_varieties").combobox('setText','其他葡萄');
			}
			//容量
			var capacity=$("#capacity").combobox('getValue');//容量
			//正标
			if($("#zhengbiao").children().size()>1){//正标只允许1张，如果上传大于1张提示用户
				$.messager.show({title:'警告!', msg:'正标只允许一张'});
				return;
			}
			//配图
			if($("#peiTu").children().size()>4){//配图只允许有4张，如果上传大于4张提示用户
				$.messager.show({title:'警告!', msg:'配图不能大于4张'});
				return;
			}
			//拼图标地址  
			var images="{'images':[";
			if($("#zhengbiao").children().eq(0).length>0){
				var zhengbiao_img_id = $("#zhengbiao").children().eq(0).attr("id");//正标id
				var zhengbiao_img_url = $("#zhengbiao li img").attr("src");
				images+="{'img_id':'"+zhengbiao_img_id+"','img_url':'"+zhengbiao_img_url+"','type':'1'}";
			}
			var lis = $("#peiTu li");
			if( $("#peiTu li").length>0){
				if($("#zhengbiao").children().eq(0).length>0){
					images += ",";
				}
			}
			for(var i=0;i<lis.length;i++){
				var peiTu_img_id=$(lis[i]).attr("id");
				var peiTu_img_url=$(lis[i]).children('img').attr('src');
				images+="{'img_id':'"+peiTu_img_id+"','img_url':'"+peiTu_img_url+"','type':'0'}";
				if (i != lis.length-1) {
					images += ",";
				}
			}
			images+="]}";
			// 做一个异步的提交 
			if($("#wine_id").val()){
				$.messager.alert({
					title:'提示信息!', 
					msg:'该酒款已经保存 ，不可重复提交保存!'
				});
				return ;
			};
			
			$.ajax({
				type : 'POST',
				url : '<%=basePath%>jf/newWine/insertNewWine',
				data : {
						'wine_code':$("#wine_code").val(),//酒款编码
						'wine_name_cn':$("#wine_name_cn").textbox('getValue'),//中文名称
						'wine_name_en':$("#wine_name_en").textbox('getValue'),//英文名称
						
						'wine_type_code':$("#wine_type_code").combobox('getValue'),//酒类型编码
						'wine_type':$("#wine_type_code").combobox('getText'),//酒类型编码
						
						'area_code':$("#area_code").combotree('getValue'),//产地
						'area':$("#area_code").combotree('getText'),//产地
						
						'area_6':$("#chateau_code").combobox('getText'),//酒庄/酒商编码
						'chateau_code':$("#chateau_code").combobox('getValue'),//酒庄/酒商编码
						
						'brand_code':$("#brand_code").combobox('getValue'),//品牌
						'brand':$("#brand_code").combobox('getText'),//品牌
						
						'level':$("#level_code").combobox('getText'),//等级编码
						'level_code':$("#level_code").combobox('getValue'),//等级编码
						
						'vintages':$("#vintages").numberbox('getValue'),//年份
						'alcohol':$("#alcohol").numberbox('getValue'),//酒精度alcohol
						
						'grape_varieties':$("#grape_varieties").combobox('getText'),//葡萄品种文本值
						'capacity':$("#capacity").combobox('getText'),//容量
						'images':images,
						} ,
				dataType : 'json',
				success : function(data) {
							if(data.result==1){
								$.messager.alert({
									title:'提示信息!', 
									msg:data.message
								});
								//设置酒款主键
								$("#wine_id").val(data.object);
								
								
							}else{
								$.messager.alert({
									title:'提示信息!', 
									msg:data.errmsg
								});
							}
						}
			});
		}
		/* 基本信息重置 */
		function jbxxChongZhi(){
			$("#jbxxForm").form('clear');
		}
		function jbxxClear(){
			window.opener.location.reload();
			window.close();
		}
		//品酒信息
		function pjxxClear(){
			window.opener.location.reload();
			window.close();
		}
		/* 品酒信息保存 */
		function pjxxSubmit(){
			var comment_cn=$("#comment_cn").val();//酒款综述中文
			var comment_en=$("#comment_en").val();//酒款综述英文
			
			var foods=$("#foods").combobox('getText');//搭配美食
			var occasion=$("#occasion").combobox('getText');//适用场景
				
			var awake_time=$("#awake_time").numberbox('getValue');//建议醒酒时间
			var temperature=$("#temperature").numberbox('getValue');//最佳品尝温度
			if(comment_cn.length>500){//正标只允许1张，如果上传大于1张提示用户
				$.messager.show({title:'警告!', msg:'酒款综述(中文)，最长为500个字符'});
				return;
			}
			if(comment_en.length>500){//正标只允许1张，如果上传大于1张提示用户
				$.messager.show({title:'警告!', msg:'酒款综述(英文)，最长为500个字符'}); 
				return;
			}
			var wine_id = $("#wine_id").val();
			if(wine_id ==null || wine_id=='' || typeof(wine_id)==undefined){
				$('#tabs').tabs('select',"基本信息");
				$.messager.alert({title:'警告!', msg:'请先添加酒款的基本信息才可添加品酒信息!'}); 
				return;
			}
			
			
			/* 做一个异步的提交 */
			$.ajax({
				type : 'POST',
				url : '<%=basePath%>jf/newWine/updateNewWine_sample',
				data : {
						'wine_id':$("#wine_id").val(),
						'comment_cn':comment_cn,//酒款综述中文
						'comment_en':comment_en,//酒款综述英文
						'foods':foods,//搭配美食
						'occasion':occasion,//适用场景
						'awake_time':awake_time,//建议醒酒时间
						'temperature':temperature//最佳品尝温度
						} ,
				dataType : 'json',
				success : function(data) {
						//console.info('修改回来的信息');
							$.messager.alert({
								title:'提示信息!', 
								msg:data.message
							});
						}
			});
		}
		function yyxxClear(){
			$("#yyxxForm").form('clear');
		}
		//运营信息提交
		function yyxxSubmit(){
			//state,short_for_cn,short_for_en,bottle_type,bar_code
			var state=$('input:radio[name="state"]:checked').val();//状态
			var short_for_cn=$("#short_for_cn").val();//中文简称
			var short_for_en=$("#short_for_en").val();//英文简称
			
			//var bottle_type_Text=$("#bottle_type").combobox('getText');//瓶子图片
			//var bottle_type_Value=$("#bottle_type").combobox('getValue');
			
			//bottle_type=bottle_type_Text+","+bottle_type_Value;
			var bar_code=$("#bar_code").val();//条形码
			
			if(short_for_cn.length>4){
				$.messager.show({title:'警告!', msg:'中文简称，最长为4个字符'}); 
				return;
			}
			if(short_for_en.length>4){
				$.messager.show({title:'警告!', msg:'英文简称，最长为4个字符'}); 
				return;
			}
			re = /^[0-9]*$/;
			if(bar_code.length>30 || !re.test(bar_code)){
				$.messager.show({title:'警告!', msg:'条形码为数字且最长30位!'}); 
				return;
			}
			var wine_id = $("#wine_id").val();
			if(wine_id ==null || wine_id=='' || typeof(wine_id)==undefined){
				$('#tabs').tabs('select',"基本信息");

				$.messager.alert({title:'警告!', msg:'请先添加酒款的基本信息才可添加运营信息!'}); 
				return;
			}
			var wine_jtt_id = $("#wine_jtt_id").numberbox('getValue');//酒淘淘id
			// 做一个异步的提交 
			$.ajax({
				type : 'POST',
				url : '<%=basePath%>jf/newWine/updateNewWine_operation',
				data : {
						'wine_id':$("#wine_id").val(),
						'state':state,
						'short_for_cn':short_for_cn,//中文简称
						'short_for_en':short_for_en,//中文简称
						//'bottle_type':bottle_type,//瓶子图片
						'bar_code':bar_code ,//条形码
						'wine_jtt_id':wine_jtt_id
						} ,
				dataType : 'json',
				success : function(data) {
							window.opener.location.reload();
							window.close();
							//$('#dg').datagrid('reload'); 
							$.messager.alert({
								title:'提示信息!', 
								msg:data.message
							});
						}
			});
			
		}
		
		//运营取消按钮
		function yyxxclear(){
			window.close();
		}
		
		
    </script>
</html>
