<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.JxjType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>奖学金申请添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Jxj/frontlist">奖学金申请列表</a></li>
			    	<li role="presentation" class="active"><a href="#jxjAdd" aria-controls="jxjAdd" role="tab" data-toggle="tab">添加奖学金申请</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="jxjList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="jxjAdd"> 
				      	<form class="form-horizontal" name="jxjAddForm" id="jxjAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="jxj_jxjTypeObj_typeId" class="col-md-2 text-right">奖学金类型:</label>
						  	 <div class="col-md-8">
							    <select id="jxj_jxjTypeObj_typeId" name="jxj.jxjTypeObj.typeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_title" class="col-md-2 text-right">申请标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jxj_title" name="jxj.title" class="form-control" placeholder="请输入申请标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_content" class="col-md-2 text-right">申请描述:</label>
						  	 <div class="col-md-8">
							    <textarea id="jxj_content" name="jxj.content" rows="8" class="form-control" placeholder="请输入申请描述"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_sqcl" class="col-md-2 text-right">申请材料:</label>
						  	 <div class="col-md-8">
							    <a id="jxj_sqclImg" border="0px"></a><br/>
							    <input type="hidden" id="jxj_sqcl" name="jxj.sqcl"/>
							    <input id="sqclFile" name="sqclFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_userObj_user_name" class="col-md-2 text-right">申请学生:</label>
						  	 <div class="col-md-8">
							    <select id="jxj_userObj_user_name" name="jxj.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_fdyState" class="col-md-2 text-right">辅导员审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jxj_fdyState" name="jxj.fdyState" class="form-control" placeholder="请输入辅导员审核状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_fdyUserName" class="col-md-2 text-right">审核的辅导员:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jxj_fdyUserName" name="jxj.fdyUserName" class="form-control" placeholder="请输入审核的辅导员">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_glState" class="col-md-2 text-right">管理员审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jxj_glState" name="jxj.glState" class="form-control" placeholder="请输入管理员审核状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxj_glResult" class="col-md-2 text-right">管理员审核结果:</label>
						  	 <div class="col-md-8">
							    <textarea id="jxj_glResult" name="jxj.glResult" rows="8" class="form-control" placeholder="请输入管理员审核结果"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxJxjAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#jxjAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加奖学金申请信息
	function ajaxJxjAdd() { 
		//提交之前先验证表单
		$("#jxjAddForm").data('bootstrapValidator').validate();
		if(!$("#jxjAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Jxj/add",
			dataType : "json" , 
			data: new FormData($("#jxjAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#jxjAddForm").find("input").val("");
					$("#jxjAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证奖学金申请添加表单字段
	$('#jxjAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"jxj.title": {
				validators: {
					notEmpty: {
						message: "申请标题不能为空",
					}
				}
			},
			"jxj.content": {
				validators: {
					notEmpty: {
						message: "申请描述不能为空",
					}
				}
			},
			"jxj.fdyState": {
				validators: {
					notEmpty: {
						message: "辅导员审核状态不能为空",
					}
				}
			},
			"jxj.fdyUserName": {
				validators: {
					notEmpty: {
						message: "审核的辅导员不能为空",
					}
				}
			},
			"jxj.glState": {
				validators: {
					notEmpty: {
						message: "管理员审核状态不能为空",
					}
				}
			},
			"jxj.glResult": {
				validators: {
					notEmpty: {
						message: "管理员审核结果不能为空",
					}
				}
			},
		}
	}); 
	//初始化奖学金类型下拉框值 
	$.ajax({
		url: basePath + "JxjType/listAll",
		type: "get",
		success: function(jxjTypes,response,status) { 
			$("#jxj_jxjTypeObj_typeId").empty();
			var html="";
    		$(jxjTypes).each(function(i,jxjType){
    			html += "<option value='" + jxjType.typeId + "'>" + jxjType.typeName + "</option>";
    		});
    		$("#jxj_jxjTypeObj_typeId").html(html);
    	}
	});
	//初始化申请学生下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#jxj_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#jxj_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
