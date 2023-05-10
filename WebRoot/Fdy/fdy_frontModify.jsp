<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Fdy" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Fdy fdy = (Fdy)request.getAttribute("fdy");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改辅导员信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">辅导员信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="fdyEditForm" id="fdyEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="fdy_fdyUserName_edit" class="col-md-3 text-right">辅导员账号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="fdy_fdyUserName_edit" name="fdy.fdyUserName" class="form-control" placeholder="请输入辅导员账号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="fdy_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fdy_password_edit" name="fdy.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fdy_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fdy_name_edit" name="fdy.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fdy_gender_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fdy_gender_edit" name="fdy.gender" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fdy_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date fdy_birthDate_edit col-md-12" data-link-field="fdy_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="fdy_birthDate_edit" name="fdy.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fdy_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fdy_telephone_edit" name="fdy.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fdy_email_edit" class="col-md-3 text-right">邮箱:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fdy_email_edit" name="fdy.email" class="form-control" placeholder="请输入邮箱">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fdy_fdyMemo_edit" class="col-md-3 text-right">辅导员备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="fdy_fdyMemo_edit" name="fdy.fdyMemo" rows="8" class="form-control" placeholder="请输入辅导员备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxFdyModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#fdyEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改辅导员界面并初始化数据*/
function fdyEdit(fdyUserName) {
	$.ajax({
		url :  basePath + "Fdy/" + fdyUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (fdy, response, status) {
			if (fdy) {
				$("#fdy_fdyUserName_edit").val(fdy.fdyUserName);
				$("#fdy_password_edit").val(fdy.password);
				$("#fdy_name_edit").val(fdy.name);
				$("#fdy_gender_edit").val(fdy.gender);
				$("#fdy_birthDate_edit").val(fdy.birthDate);
				$("#fdy_telephone_edit").val(fdy.telephone);
				$("#fdy_email_edit").val(fdy.email);
				$("#fdy_fdyMemo_edit").val(fdy.fdyMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交辅导员信息表单给服务器端修改*/
function ajaxFdyModify() {
	$.ajax({
		url :  basePath + "Fdy/" + $("#fdy_fdyUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#fdyEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#fdyQueryForm").submit();
            }else{
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
    /*出生日期组件*/
    $('.fdy_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    fdyEdit("<%=request.getParameter("fdyUserName")%>");
 })
 </script> 
</body>
</html>

