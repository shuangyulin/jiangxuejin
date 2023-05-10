<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/score.css" /> 

<div id="score_manage"></div>
<div id="score_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="score_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="score_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="score_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="score_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="score_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="scoreQueryForm" method="post">
			所在学期：<input class="textbox" type="text" id="termObj_termId_query" name="termObj.termId" style="width: auto"/>
			学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			所在学院：<input class="textbox" type="text" id="colleageObj_collleageId_query" name="colleageObj.collleageId" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="score_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="scoreEditDiv">
	<form id="scoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_scoreId_edit" name="score.scoreId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">所在学期:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_termObj_termId_edit" name="score.termObj.termId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_userObj_user_name_edit" name="score.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_colleageObj_collleageId_edit" name="score.colleageObj.collleageId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">综合成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_zhcj_edit" name="score.zhcj" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">详细成绩:</span>
			<span class="inputControl">
				<script name="score.scoreDesc" id="score_scoreDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">成绩备注:</span>
			<span class="inputControl">
				<textarea id="score_scoreMemo_edit" name="score.scoreMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var score_scoreDesc_editor = UE.getEditor('score_scoreDesc_edit'); //详细成绩编辑器
</script>
<script type="text/javascript" src="Score/js/score_manage.js"></script> 
