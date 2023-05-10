<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Score" %>
<%@ page import="com.chengxusheji.po.Colleage" %>
<%@ page import="com.chengxusheji.po.TermInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的colleageObj信息
    List<Colleage> colleageList = (List<Colleage>)request.getAttribute("colleageList");
    //获取所有的termObj信息
    List<TermInfo> termInfoList = (List<TermInfo>)request.getAttribute("termInfoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Score score = (Score)request.getAttribute("score");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学生成绩信息</TITLE>
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
  		<li class="active">学生成绩信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="scoreEditForm" id="scoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="score_scoreId_edit" class="col-md-3 text-right">成绩id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="score_scoreId_edit" name="score.scoreId" class="form-control" placeholder="请输入成绩id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="score_termObj_termId_edit" class="col-md-3 text-right">所在学期:</label>
		  	 <div class="col-md-9">
			    <select id="score_termObj_termId_edit" name="score.termObj.termId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_userObj_user_name_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="score_userObj_user_name_edit" name="score.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_colleageObj_collleageId_edit" class="col-md-3 text-right">所在学院:</label>
		  	 <div class="col-md-9">
			    <select id="score_colleageObj_collleageId_edit" name="score.colleageObj.collleageId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_zhcj_edit" class="col-md-3 text-right">综合成绩:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="score_zhcj_edit" name="score.zhcj" class="form-control" placeholder="请输入综合成绩">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_scoreDesc_edit" class="col-md-3 text-right">详细成绩:</label>
		  	 <div class="col-md-9">
			    <script name="score.scoreDesc" id="score_scoreDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_scoreMemo_edit" class="col-md-3 text-right">成绩备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="score_scoreMemo_edit" name="score.scoreMemo" rows="8" class="form-control" placeholder="请输入成绩备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxScoreModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#scoreEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var score_scoreDesc_editor = UE.getEditor('score_scoreDesc_edit'); //详细成绩编辑框
var basePath = "<%=basePath%>";
/*弹出修改学生成绩界面并初始化数据*/
function scoreEdit(scoreId) {
  score_scoreDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(scoreId);
  });
}
 function ajaxModifyQuery(scoreId) {
	$.ajax({
		url :  basePath + "Score/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (score, response, status) {
			if (score) {
				$("#score_scoreId_edit").val(score.scoreId);
				$.ajax({
					url: basePath + "TermInfo/listAll",
					type: "get",
					success: function(termInfos,response,status) { 
						$("#score_termObj_termId_edit").empty();
						var html="";
		        		$(termInfos).each(function(i,termInfo){
		        			html += "<option value='" + termInfo.termId + "'>" + termInfo.termName + "</option>";
		        		});
		        		$("#score_termObj_termId_edit").html(html);
		        		$("#score_termObj_termId_edit").val(score.termObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#score_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#score_userObj_user_name_edit").html(html);
		        		$("#score_userObj_user_name_edit").val(score.userObjPri);
					}
				});
				$.ajax({
					url: basePath + "Colleage/listAll",
					type: "get",
					success: function(colleages,response,status) { 
						$("#score_colleageObj_collleageId_edit").empty();
						var html="";
		        		$(colleages).each(function(i,colleage){
		        			html += "<option value='" + colleage.collleageId + "'>" + colleage.colleageName + "</option>";
		        		});
		        		$("#score_colleageObj_collleageId_edit").html(html);
		        		$("#score_colleageObj_collleageId_edit").val(score.colleageObjPri);
					}
				});
				$("#score_zhcj_edit").val(score.zhcj);
				score_scoreDesc_editor.setContent(score.scoreDesc, false);
				$("#score_scoreMemo_edit").val(score.scoreMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学生成绩信息表单给服务器端修改*/
function ajaxScoreModify() {
	$.ajax({
		url :  basePath + "Score/" + $("#score_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#scoreQueryForm").submit();
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
    scoreEdit("<%=request.getParameter("scoreId")%>");
 })
 </script> 
</body>
</html>

