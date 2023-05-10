<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/score.css" />
<div id="scoreAddDiv">
	<form id="scoreAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">所在学期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_termObj_termId" name="score.termObj.termId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_userObj_user_name" name="score.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_colleageObj_collleageId" name="score.colleageObj.collleageId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">综合成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_zhcj" name="score.zhcj" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">详细成绩:</span>
			<span class="inputControl">
				<script name="score.scoreDesc" id="score_scoreDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">成绩备注:</span>
			<span class="inputControl">
				<textarea id="score_scoreMemo" name="score.scoreMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="scoreAddButton" class="easyui-linkbutton">添加</a>
			<a id="scoreClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Score/js/score_add.js"></script> 
