<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Jxj" %>
<%@ page import="com.chengxusheji.po.JxjType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的jxjTypeObj信息
    List<JxjType> jxjTypeList = (List<JxjType>)request.getAttribute("jxjTypeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Jxj jxj = (Jxj)request.getAttribute("jxj");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改奖学金申请信息</TITLE>
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
  		<li class="active">奖学金申请信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="jxjEditForm" id="jxjEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="jxj_jxjId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="jxj_jxjId_edit" name="jxj.jxjId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="jxj_jxjTypeObj_typeId_edit" class="col-md-3 text-right">奖学金类型:</label>
		  	 <div class="col-md-9">
			    <select id="jxj_jxjTypeObj_typeId_edit" name="jxj.jxjTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_title_edit" class="col-md-3 text-right">申请标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jxj_title_edit" name="jxj.title" class="form-control" placeholder="请输入申请标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_content_edit" class="col-md-3 text-right">申请描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="jxj_content_edit" name="jxj.content" rows="8" class="form-control" placeholder="请输入申请描述"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_sqcl_edit" class="col-md-3 text-right">申请材料:</label>
		  	 <div class="col-md-9">
			    <a id="jxj_sqclImg" width="200px" border="0px"></a><br/>
			    <input type="hidden" id="jxj_sqcl" name="jxj.sqcl"/>
			    <input id="sqclFile" name="sqclFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_userObj_user_name_edit" class="col-md-3 text-right">申请学生:</label>
		  	 <div class="col-md-9">
			    <select id="jxj_userObj_user_name_edit" name="jxj.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_fdyState_edit" class="col-md-3 text-right">辅导员审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jxj_fdyState_edit" name="jxj.fdyState" class="form-control" placeholder="请输入辅导员审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_fdyUserName_edit" class="col-md-3 text-right">审核的辅导员:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jxj_fdyUserName_edit" name="jxj.fdyUserName" class="form-control" placeholder="请输入审核的辅导员">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_glState_edit" class="col-md-3 text-right">管理员审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jxj_glState_edit" name="jxj.glState" class="form-control" placeholder="请输入管理员审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jxj_glResult_edit" class="col-md-3 text-right">管理员审核结果:</label>
		  	 <div class="col-md-9">
			    <textarea id="jxj_glResult_edit" name="jxj.glResult" rows="8" class="form-control" placeholder="请输入管理员审核结果"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxJxjModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#jxjEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改奖学金申请界面并初始化数据*/
function jxjEdit(jxjId) {
	$.ajax({
		url :  basePath + "Jxj/" + jxjId + "/update",
		type : "get",
		dataType: "json",
		success : function (jxj, response, status) {
			if (jxj) {
				$("#jxj_jxjId_edit").val(jxj.jxjId);
				$.ajax({
					url: basePath + "JxjType/listAll",
					type: "get",
					success: function(jxjTypes,response,status) { 
						$("#jxj_jxjTypeObj_typeId_edit").empty();
						var html="";
		        		$(jxjTypes).each(function(i,jxjType){
		        			html += "<option value='" + jxjType.typeId + "'>" + jxjType.typeName + "</option>";
		        		});
		        		$("#jxj_jxjTypeObj_typeId_edit").html(html);
		        		$("#jxj_jxjTypeObj_typeId_edit").val(jxj.jxjTypeObjPri);
					}
				});
				$("#jxj_title_edit").val(jxj.title);
				$("#jxj_content_edit").val(jxj.content);
				$("#jxj_sqclA").val(jxj.sqcl);
				$("#jxj_sqclA").attr("href", basePath +　jxj.sqcl);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#jxj_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#jxj_userObj_user_name_edit").html(html);
		        		$("#jxj_userObj_user_name_edit").val(jxj.userObjPri);
					}
				});
				$("#jxj_fdyState_edit").val(jxj.fdyState);
				$("#jxj_fdyUserName_edit").val(jxj.fdyUserName);
				$("#jxj_glState_edit").val(jxj.glState);
				$("#jxj_glResult_edit").val(jxj.glResult);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交奖学金申请信息表单给服务器端修改*/
function ajaxJxjModify() {
	$.ajax({
		url :  basePath + "Jxj/" + $("#jxj_jxjId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#jxjEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#jxjQueryForm").submit();
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
    jxjEdit("<%=request.getParameter("jxjId")%>");
 })
 </script> 
</body>
</html>

