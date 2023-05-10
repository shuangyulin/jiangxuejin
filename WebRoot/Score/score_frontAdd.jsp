<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Colleage" %>
<%@ page import="com.chengxusheji.po.TermInfo" %>
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
<title>学生成绩添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Score/frontlist">学生成绩列表</a></li>
			    	<li role="presentation" class="active"><a href="#scoreAdd" aria-controls="scoreAdd" role="tab" data-toggle="tab">添加学生成绩</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="scoreList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="scoreAdd"> 
				      	<form class="form-horizontal" name="scoreAddForm" id="scoreAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="score_termObj_termId" class="col-md-2 text-right">所在学期:</label>
						  	 <div class="col-md-8">
							    <select id="score_termObj_termId" name="score.termObj.termId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_userObj_user_name" class="col-md-2 text-right">学生:</label>
						  	 <div class="col-md-8">
							    <select id="score_userObj_user_name" name="score.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_colleageObj_collleageId" class="col-md-2 text-right">所在学院:</label>
						  	 <div class="col-md-8">
							    <select id="score_colleageObj_collleageId" name="score.colleageObj.collleageId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_zhcj" class="col-md-2 text-right">综合成绩:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="score_zhcj" name="score.zhcj" class="form-control" placeholder="请输入综合成绩">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_scoreDesc" class="col-md-2 text-right">详细成绩:</label>
						  	 <div class="col-md-8">
							    <textarea name="score.scoreDesc" id="score_scoreDesc" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="score_scoreMemo" class="col-md-2 text-right">成绩备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="score_scoreMemo" name="score.scoreMemo" rows="8" class="form-control" placeholder="请输入成绩备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxScoreAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#scoreAddForm .form-group {margin:10px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var score_scoreDesc_editor = UE.getEditor('score_scoreDesc'); //详细成绩编辑器
var basePath = "<%=basePath%>";
	//提交添加学生成绩信息
	function ajaxScoreAdd() { 
		//提交之前先验证表单
		$("#scoreAddForm").data('bootstrapValidator').validate();
		if(!$("#scoreAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(score_scoreDesc_editor.getContent() == "") {
			alert('详细成绩不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Score/add",
			dataType : "json" , 
			data: new FormData($("#scoreAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#scoreAddForm").find("input").val("");
					$("#scoreAddForm").find("textarea").val("");
					score_scoreDesc_editor.setContent("");
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
	//验证学生成绩添加表单字段
	$('#scoreAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"score.zhcj": {
				validators: {
					notEmpty: {
						message: "综合成绩不能为空",
					},
					numeric: {
						message: "综合成绩不正确"
					}
				}
			},
		}
	}); 
	//初始化所在学期下拉框值 
	$.ajax({
		url: basePath + "TermInfo/listAll",
		type: "get",
		success: function(termInfos,response,status) { 
			$("#score_termObj_termId").empty();
			var html="";
    		$(termInfos).each(function(i,termInfo){
    			html += "<option value='" + termInfo.termId + "'>" + termInfo.termName + "</option>";
    		});
    		$("#score_termObj_termId").html(html);
    	}
	});
	//初始化学生下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#score_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#score_userObj_user_name").html(html);
    	}
	});
	//初始化所在学院下拉框值 
	$.ajax({
		url: basePath + "Colleage/listAll",
		type: "get",
		success: function(colleages,response,status) { 
			$("#score_colleageObj_collleageId").empty();
			var html="";
    		$(colleages).each(function(i,colleage){
    			html += "<option value='" + colleage.collleageId + "'>" + colleage.colleageName + "</option>";
    		});
    		$("#score_colleageObj_collleageId").html(html);
    	}
	});
})
</script>
</body>
</html>
