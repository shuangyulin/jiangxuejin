<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>辅导员添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Fdy/frontlist">辅导员列表</a></li>
			    	<li role="presentation" class="active"><a href="#fdyAdd" aria-controls="fdyAdd" role="tab" data-toggle="tab">添加辅导员</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="fdyList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="fdyAdd"> 
				      	<form class="form-horizontal" name="fdyAddForm" id="fdyAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="fdy_fdyUserName" class="col-md-2 text-right">辅导员账号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="fdy_fdyUserName" name="fdy.fdyUserName" class="form-control" placeholder="请输入辅导员账号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="fdy_password" class="col-md-2 text-right">登录密码:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fdy_password" name="fdy.password" class="form-control" placeholder="请输入登录密码">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fdy_name" class="col-md-2 text-right">姓名:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fdy_name" name="fdy.name" class="form-control" placeholder="请输入姓名">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fdy_gender" class="col-md-2 text-right">性别:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fdy_gender" name="fdy.gender" class="form-control" placeholder="请输入性别">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fdy_birthDateDiv" class="col-md-2 text-right">出生日期:</label>
						  	 <div class="col-md-8">
				                <div id="fdy_birthDateDiv" class="input-group date fdy_birthDate col-md-12" data-link-field="fdy_birthDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="fdy_birthDate" name="fdy.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fdy_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fdy_telephone" name="fdy.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fdy_email" class="col-md-2 text-right">邮箱:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fdy_email" name="fdy.email" class="form-control" placeholder="请输入邮箱">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fdy_fdyMemo" class="col-md-2 text-right">辅导员备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="fdy_fdyMemo" name="fdy.fdyMemo" rows="8" class="form-control" placeholder="请输入辅导员备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxFdyAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#fdyAddForm .form-group {margin:10px;}  </style>
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
	//提交添加辅导员信息
	function ajaxFdyAdd() { 
		//提交之前先验证表单
		$("#fdyAddForm").data('bootstrapValidator').validate();
		if(!$("#fdyAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Fdy/add",
			dataType : "json" , 
			data: new FormData($("#fdyAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#fdyAddForm").find("input").val("");
					$("#fdyAddForm").find("textarea").val("");
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
	//验证辅导员添加表单字段
	$('#fdyAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"fdy.fdyUserName": {
				validators: {
					notEmpty: {
						message: "辅导员账号不能为空",
					}
				}
			},
			"fdy.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"fdy.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"fdy.gender": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"fdy.birthDate": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"fdy.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"fdy.email": {
				validators: {
					notEmpty: {
						message: "邮箱不能为空",
					}
				}
			},
		}
	}); 
	//出生日期组件
	$('#fdy_birthDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#fdyAddForm').data('bootstrapValidator').updateStatus('fdy.birthDate', 'NOT_VALIDATED',null).validateField('fdy.birthDate');
	});
})
</script>
</body>
</html>
