<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Jxj" %>
<%@ page import="com.chengxusheji.po.JxjType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Jxj> jxjList = (List<Jxj>)request.getAttribute("jxjList");
    //获取所有的jxjTypeObj信息
    List<JxjType> jxjTypeList = (List<JxjType>)request.getAttribute("jxjTypeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    JxjType jxjTypeObj = (JxjType)request.getAttribute("jxjTypeObj");
    String title = (String)request.getAttribute("title"); //申请标题查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String fdyState = (String)request.getAttribute("fdyState"); //辅导员审核状态查询关键字
    String fdyUserName = (String)request.getAttribute("fdyUserName"); //审核的辅导员查询关键字
    String glState = (String)request.getAttribute("glState"); //管理员审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>奖学金申请查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#jxjListPanel" aria-controls="jxjListPanel" role="tab" data-toggle="tab">奖学金申请列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Jxj/jxj_frontAdd.jsp" style="display:none;">添加奖学金申请</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="jxjListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录id</td><td>奖学金类型</td><td>申请标题</td><td>申请描述</td><td>申请材料</td><td>申请学生</td><td>辅导员审核状态</td><td>审核的辅导员</td><td>管理员审核状态</td><td>管理员审核结果</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<jxjList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Jxj jxj = jxjList.get(i); //获取到奖学金申请对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=jxj.getJxjId() %></td>
 											<td><%=jxj.getJxjTypeObj().getTypeName() %></td>
 											<td><%=jxj.getTitle() %></td>
 											<td><%=jxj.getContent() %></td>
 											<td><%=jxj.getSqcl().equals("")?"暂无文件":"<a href='" + basePath + jxj.getSqcl() + "' target='_blank'>" + jxj.getSqcl() + "</a>"%>
 											<td><%=jxj.getUserObj().getName() %></td>
 											<td><%=jxj.getFdyState() %></td>
 											<td><%=jxj.getFdyUserName() %></td>
 											<td><%=jxj.getGlState() %></td>
 											<td><%=jxj.getGlResult() %></td>
 											<td>
 												<a href="<%=basePath  %>Jxj/<%=jxj.getJxjId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="jxjEdit('<%=jxj.getJxjId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="jxjDelete('<%=jxj.getJxjId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>奖学金申请查询</h1>
		</div>
		<form name="jxjQueryForm" id="jxjQueryForm" action="<%=basePath %>Jxj/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="jxjTypeObj_typeId">奖学金类型：</label>
                <select id="jxjTypeObj_typeId" name="jxjTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(JxjType jxjTypeTemp:jxjTypeList) {
	 					String selected = "";
 					if(jxjTypeObj!=null && jxjTypeObj.getTypeId()!=null && jxjTypeObj.getTypeId().intValue()==jxjTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=jxjTypeTemp.getTypeId() %>" <%=selected %>><%=jxjTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="title">申请标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入申请标题">
			</div>






            <div class="form-group">
            	<label for="userObj_user_name">申请学生：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="fdyState">辅导员审核状态:</label>
				<input type="text" id="fdyState" name="fdyState" value="<%=fdyState %>" class="form-control" placeholder="请输入辅导员审核状态">
			</div>






			<div class="form-group">
				<label for="fdyUserName">审核的辅导员:</label>
				<input type="text" id="fdyUserName" name="fdyUserName" value="<%=fdyUserName %>" class="form-control" placeholder="请输入审核的辅导员">
			</div>






			<div class="form-group">
				<label for="glState">管理员审核状态:</label>
				<input type="text" id="glState" name="glState" value="<%=glState %>" class="form-control" placeholder="请输入管理员审核状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="jxjEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;奖学金申请信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			    <a id="jxj_sqclA" target="_blank"></a><br/>
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
		</form> 
	    <style>#jxjEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxJxjModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.jxjQueryForm.currentPage.value = currentPage;
    document.jxjQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.jxjQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.jxjQueryForm.currentPage.value = pageValue;
    documentjxjQueryForm.submit();
}

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
				$("#jxj_sqcl").val(jxj.sqcl);
				$("#jxj_sqclA").text(jxj.sqcl);
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
				$('#jxjEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除奖学金申请信息*/
function jxjDelete(jxjId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Jxj/deletes",
			data : {
				jxjIds : jxjId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#jxjQueryForm").submit();
					//location.href= basePath + "Jxj/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

