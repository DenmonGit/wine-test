<%@ page language="java" 
	import="java.util.*,com.mao.test.webdata.vo.AdminUserInfoVo"
    pageEncoding="UTF-8"%>
 <%
String versionInfo = (String)session.getAttribute("versionInfo");
AdminUserInfoVo userInfo = (AdminUserInfoVo)session.getAttribute("userInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>品牌添加和修改页面</title>
<%@ include file="/jf/common/comment_easyui1.4.4.jsp"%>
<script type="text/javascript">
$.support.cors = true;
$(function(){
	<%
	if(userInfo==null){
		%>
		window.parent.location.reload();
		return ;
	<%}
	%>
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
					url: flag=='add'?'<%=basePath%>jf/brand/addBrandDict':'<%=basePath%>jf/brand/updateBrandDict' ,
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
	
		/**
		 * 关闭窗口方法
		 */
		$('#btn2').click(function(){
			$('#mydialog').dialog('close');
		});

	});
</script>
</head>
<body>
<div class="easyui-tabs" data-options="tabWidth:100"
		style="width: 710px; height: 830px; margin: 0 auto;">
	<div title="基本信息" style="padding: 10px">
		<div class="easyui-panel" title=""
				style="width: 660px; padding: 20px 100px 80px 130px"
				data-options="fit:true">
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
						data-options="url:'<%=basePath%>jf/areaDict/getAreaDictTree',method:'get',required:true"
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
						style="width: 250px; height: 27px" validType="validator"
						invalidMessage="简介网址必须以http://开头并且在1到100个字符之间!" value="" /></td>
				</tr>

				<tr align="center">
					<td colspan="2"><a id="btn1" class="easyui-linkbutton">确定</a>
						<a id="btn2" class="easyui-linkbutton">关闭</a></td>
				</tr>
			</table>
		</form>
		</div>
	</div>		
</div>
</body>
</html>