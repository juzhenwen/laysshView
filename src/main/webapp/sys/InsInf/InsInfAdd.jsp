<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>新增</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<jsp:include page="../../inc.jsp"></jsp:include>
</head>
<body>
	<form class="layui-form " style="margin-top: 20px;" method="post" action="">
		<div class="layui-form-item">
				<label class="layui-form-label" style="color:#F00">机构编号</label>
				<div class="layui-input-inline">
					<input type="text" name="insCd"  lay-verify="required" autocomplete="off" class="layui-input" />
				</div>
				<label class="layui-form-label" style="color:#F00">机构名称</label>
				<div class="layui-input-inline">
					<input type="text" name="insNm" lay-verify="required" autocomplete="off" class="layui-input" />
				</div>
		</div>
		<div class="layui-form-item">
				<label class="layui-form-label">机构联系人</label>
				<div class="layui-input-inline">
					<input type="text" name="insOper" maxlength="36" autocomplete="off" class="layui-input" />
				</div>
				<label class="layui-form-label">联系电话</label>
				<div class="layui-input-inline">
					<input type="text" name="insPhone" maxlength="36" autocomplete="off" class="layui-input" />
				</div>
		</div>
		<div class="layui-form-item">
				<label class="layui-form-label" style="color:#F00">上级机构</label>
				<div class="layui-input-inline">
					<input type="hidden" name="parentInsCd" id="parentInsCd" /> 
					<input type="text" name="parentInsCdNm" lay-verify="required" id="parentInsCdNm"  readOnly="readOnly" placeholder="请选择" autocomplete="off" class="layui-input"/>
				</div>
				<div class="layui-input-inline">
					<button class="layui-btn layui-btn-normal" type="button" id="treeSelect">请选择</button>
				</div>
		</div>
		<div class="layui-form-item">
				<label class="layui-form-label">机构地址</label>
				<div class="layui-input-block">
					<input type="text" name="insAddres"  maxlength="50" autocomplete="off" class="layui-input" />
				</div>
		</div>
		<div class="layui-form-item">
				<label class="layui-form-label">备注</label>
				<div class="layui-input-block">
					<input type="text" name="mark" maxlength="50"  autocomplete="off" class="layui-input" />
				</div>
		</div>
		
		          
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit="" lay-filter="btnSubmit">立即提交</button>
			<button class="layui-btn layui-btn-primary" id="close">关闭</button>
		</div>
	</div>
	</form>
<script>
layui.use(['form', 'layedit', 'laydate','jquery'], function(){
  var form = layui.form;
  var $ = layui.jquery;
  
  
   //监听提交
   form.on('submit(btnSubmit)', function(data){
   // layer.msg(JSON.stringify(data.field));
   var index = layer.load(1);//开启进度条
      $.ajax({
		url : '<%=request.getContextPath()%>/insInf/add',
		data :data.field,
		type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
		dataType : 'json',
		success : function(obj) {
			layer.close(index);//关闭   
			if (obj.success) {
				pubUtil.msg(obj.msg,layer,1,function(){
					$("#close").click();
				},500);
			} else {
				pubUtil.msg(obj.msg,layer,2,function(){
					
				},5*1000);
			}
		}
	});
    return false;
  });
    
});


//按钮的点击事件
$('button#treeSelect').on('click', function() {
	parent.layer.open({
	      type: 2,
	      title : '选择<span style="color:red">[请单击选中]</span>',
	      shadeClose: false,//点击遮罩关闭
	      anim: public_anim,
	      btnAlign: 'c',
	      shade: public_shade,//是否有遮罩，可以设置成false
	      maxmin: true, //开启最大化最小化按钮
	      area: ['600px', '300px'],
	      //area: ['100%', '100%'],
	      boolean:true,
		  content: ['InsInfoTree.jsp', 'yes'], //iframe的url，no代表不显示滚动条
		  btn: ['选择', '关闭']
		  ,yes: function(index,layero) {
			  var body=$(layero).find("iframe")[0].contentWindow.document;
			  var pid = body.getElementById("id").value;
			  var pidNm = body.getElementById("name").value;
			  $("#parentInsCdNm").val(pidNm);
			  $("#parentInsCd").val(pid);
			  parent.layer.close(index); //关闭当前弹层
		  }
		  ,btn2: function(index, layero){
			  
		  }
	    });
});


</script>