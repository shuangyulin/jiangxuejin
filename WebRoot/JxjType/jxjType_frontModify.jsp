<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.JxjType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    JxjType jxjType = (JxjType)request.getAttribute("jxjType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改奖学金类型信息</TITLE>
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
  		<li class="active">奖学金类型信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="jxjTypeEditForm" id="jxjTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="jxjType_typeId_edit" class="col-md-3 text-right">类别id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="jxjType_typeId_edit" name="jxjType.typeId" class="form-control" placeholder="请输入类别id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="jxjType_typeName_edit" class="col-md-3 text-right">类别名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jxjType_typeName_edit" name="jxjType.typeName" class="form-control" placeholder="请输入类别名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxjType_jxjMoney_edit" class="col-md-3 text-right">奖学金金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jxjType_jxjMoney_edit" name="jxjType.jxjMoney" class="form-control" placeholder="请输入奖学金金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxjType_pdbz_edit" class="col-md-3 text-right">评定标准:</label>
		  	 <div class="col-md-9">
			    <textarea id="jxjType_pdbz_edit" name="jxjType.pdbz" rows="8" class="form-control" placeholder="请输入评定标准"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxjType_addTime_edit" class="col-md-3 text-right">添加时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date jxjType_addTime_edit col-md-12" data-link-field="jxjType_addTime_edit">
                    <input class="form-control" id="jxjType_addTime_edit" name="jxjType.addTime" size="16" type="text" value="" placeholder="请选择添加时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxJxjTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#jxjTypeEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改奖学金类型界面并初始化数据*/
function jxjTypeEdit(typeId) {
	$.ajax({
		url :  basePath + "JxjType/" + typeId + "/update",
		type : "get",
		dataType: "json",
		success : function (jxjType, response, status) {
			if (jxjType) {
				$("#jxjType_typeId_edit").val(jxjType.typeId);
				$("#jxjType_typeName_edit").val(jxjType.typeName);
				$("#jxjType_jxjMoney_edit").val(jxjType.jxjMoney);
				$("#jxjType_pdbz_edit").val(jxjType.pdbz);
				$("#jxjType_addTime_edit").val(jxjType.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交奖学金类型信息表单给服务器端修改*/
function ajaxJxjTypeModify() {
	$.ajax({
		url :  basePath + "JxjType/" + $("#jxjType_typeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#jxjTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#jxjTypeQueryForm").submit();
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
    /*添加时间组件*/
    $('.jxjType_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    jxjTypeEdit("<%=request.getParameter("typeId")%>");
 })
 </script> 
</body>
</html>

