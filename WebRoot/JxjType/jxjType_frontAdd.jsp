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
<title>奖学金类型添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>JxjType/frontlist">奖学金类型列表</a></li>
			    	<li role="presentation" class="active"><a href="#jxjTypeAdd" aria-controls="jxjTypeAdd" role="tab" data-toggle="tab">添加奖学金类型</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="jxjTypeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="jxjTypeAdd"> 
				      	<form class="form-horizontal" name="jxjTypeAddForm" id="jxjTypeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="jxjType_typeName" class="col-md-2 text-right">类别名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jxjType_typeName" name="jxjType.typeName" class="form-control" placeholder="请输入类别名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxjType_jxjMoney" class="col-md-2 text-right">奖学金金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jxjType_jxjMoney" name="jxjType.jxjMoney" class="form-control" placeholder="请输入奖学金金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxjType_pdbz" class="col-md-2 text-right">评定标准:</label>
						  	 <div class="col-md-8">
							    <textarea id="jxjType_pdbz" name="jxjType.pdbz" rows="8" class="form-control" placeholder="请输入评定标准"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jxjType_addTimeDiv" class="col-md-2 text-right">添加时间:</label>
						  	 <div class="col-md-8">
				                <div id="jxjType_addTimeDiv" class="input-group date jxjType_addTime col-md-12" data-link-field="jxjType_addTime">
				                    <input class="form-control" id="jxjType_addTime" name="jxjType.addTime" size="16" type="text" value="" placeholder="请选择添加时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxJxjTypeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#jxjTypeAddForm .form-group {margin:10px;}  </style>
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
	//提交添加奖学金类型信息
	function ajaxJxjTypeAdd() { 
		//提交之前先验证表单
		$("#jxjTypeAddForm").data('bootstrapValidator').validate();
		if(!$("#jxjTypeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "JxjType/add",
			dataType : "json" , 
			data: new FormData($("#jxjTypeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#jxjTypeAddForm").find("input").val("");
					$("#jxjTypeAddForm").find("textarea").val("");
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
	//验证奖学金类型添加表单字段
	$('#jxjTypeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"jxjType.typeName": {
				validators: {
					notEmpty: {
						message: "类别名称不能为空",
					}
				}
			},
			"jxjType.jxjMoney": {
				validators: {
					notEmpty: {
						message: "奖学金金额不能为空",
					},
					numeric: {
						message: "奖学金金额不正确"
					}
				}
			},
			"jxjType.pdbz": {
				validators: {
					notEmpty: {
						message: "评定标准不能为空",
					}
				}
			},
			"jxjType.addTime": {
				validators: {
					notEmpty: {
						message: "添加时间不能为空",
					}
				}
			},
		}
	}); 
	//添加时间组件
	$('#jxjType_addTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#jxjTypeAddForm').data('bootstrapValidator').updateStatus('jxjType.addTime', 'NOT_VALIDATED',null).validateField('jxjType.addTime');
	});
})
</script>
</body>
</html>
